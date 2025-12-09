class_name UnlockManager
extends Node

## Manages progression, points, and unlockables

signal points_changed(new_total: int)
signal item_unlocked(category: String, item_id: int)

const SaveManager = preload("res://scripts/save_manager.gd")

# Unlock costs for each category
const PADDLE_COSTS = [0, 50, 100, 200, 400]  # 5 paddles
const BALL_COSTS = [0, 50, 100, 200, 400]    # 5 balls
const BACKGROUND_COSTS = [0, 75, 150, 300, 500]  # 5 backgrounds
const TRAIL_COSTS = [0, 100, 250, 500]  # 4 trails

var save_manager: SaveManager
var total_points: int = 0
var unlocked_paddles: Array = [0]
var unlocked_balls: Array = [0]
var unlocked_backgrounds: Array = [0]
var unlocked_trails: Array = [0]

# Currently selected items
var selected_paddle: int = 0
var selected_ball: int = 0
var selected_background: int = 0
var selected_trail: int = 0

func _ready() -> void:
	save_manager = SaveManager.new()
	load_progress()

func load_progress() -> void:
	"""Load unlock progress from save file"""
	var data = save_manager.load_game()
	
	total_points = data["unlocks"]["total_points"]
	unlocked_paddles = data["unlocks"]["unlocked_paddles"].duplicate()
	unlocked_balls = data["unlocks"]["unlocked_balls"].duplicate()
	unlocked_backgrounds = data["unlocks"]["unlocked_backgrounds"].duplicate()
	unlocked_trails = data["unlocks"]["unlocked_trails"].duplicate()
	
	selected_paddle = data["customization"]["selected_paddle"]
	selected_ball = data["customization"]["selected_ball"]
	selected_background = data["customization"]["selected_background"]
	selected_trail = data["customization"]["selected_trail"]

func save_progress() -> void:
	"""Save unlock progress to file"""
	var data = save_manager.load_game()
	
	data["unlocks"]["total_points"] = total_points
	data["unlocks"]["unlocked_paddles"] = unlocked_paddles.duplicate()
	data["unlocks"]["unlocked_balls"] = unlocked_balls.duplicate()
	data["unlocks"]["unlocked_backgrounds"] = unlocked_backgrounds.duplicate()
	data["unlocks"]["unlocked_trails"] = unlocked_trails.duplicate()
	
	data["customization"]["selected_paddle"] = selected_paddle
	data["customization"]["selected_ball"] = selected_ball
	data["customization"]["selected_background"] = selected_background
	data["customization"]["selected_trail"] = selected_trail
	
	save_manager.save_game(data)

func add_points(points: int) -> void:
	"""Add points to total"""
	total_points += points
	points_changed.emit(total_points)
	save_progress()
	print("Added %d points. Total: %d" % [points, total_points])

func can_unlock(category: String, item_id: int) -> bool:
	"""Check if item can be unlocked"""
	var cost = get_unlock_cost(category, item_id)
	if cost < 0:
		return false  # Invalid item
	
	if is_unlocked(category, item_id):
		return false  # Already unlocked
	
	return total_points >= cost

func unlock_item(category: String, item_id: int) -> bool:
	"""Attempt to unlock an item. Returns true if successful."""
	if not can_unlock(category, item_id):
		return false
	
	var cost = get_unlock_cost(category, item_id)
	total_points -= cost
	
	match category:
		"paddle":
			unlocked_paddles.append(item_id)
		"ball":
			unlocked_balls.append(item_id)
		"background":
			unlocked_backgrounds.append(item_id)
		"trail":
			unlocked_trails.append(item_id)
	
	save_progress()
	item_unlocked.emit(category, item_id)
	points_changed.emit(total_points)
	print("Unlocked %s %d for %d points" % [category, item_id, cost])
	return true

func is_unlocked(category: String, item_id: int) -> bool:
	"""Check if an item is unlocked"""
	match category:
		"paddle":
			return item_id in unlocked_paddles
		"ball":
			return item_id in unlocked_balls
		"background":
			return item_id in unlocked_backgrounds
		"trail":
			return item_id in unlocked_trails
	return false

func get_unlock_cost(category: String, item_id: int) -> int:
	"""Get the cost to unlock an item. Returns -1 if invalid."""
	match category:
		"paddle":
			if item_id >= 0 and item_id < PADDLE_COSTS.size():
				return PADDLE_COSTS[item_id]
		"ball":
			if item_id >= 0 and item_id < BALL_COSTS.size():
				return BALL_COSTS[item_id]
		"background":
			if item_id >= 0 and item_id < BACKGROUND_COSTS.size():
				return BACKGROUND_COSTS[item_id]
		"trail":
			if item_id >= 0 and item_id < TRAIL_COSTS.size():
				return TRAIL_COSTS[item_id]
	return -1

func select_item(category: String, item_id: int) -> void:
	"""Select an item for use (must be unlocked)"""
	if not is_unlocked(category, item_id):
		push_error("Cannot select locked item")
		return
	
	match category:
		"paddle":
			selected_paddle = item_id
		"ball":
			selected_ball = item_id
		"background":
			selected_background = item_id
		"trail":
			selected_trail = item_id
	
	save_progress()
	print("Selected %s %d" % [category, item_id])
