class_name UnlockManager
extends Node

## Manages progression and unlockables

signal points_changed(new_total: int)
signal item_unlocked(category: String, item_id: int)
signal level_unlocked(level: int)

const SaveManager = preload("res://scripts/save_manager.gd")

# Unlock costs
const SKIN_COSTS = [0, 100, 200, 400, 800]  # 5 skins
const TRAIL_COSTS = [0, 150, 300, 600]  # 4 trails
const BACKGROUND_COSTS = [0, 100, 200, 400, 800]  # 5 backgrounds

var save_manager: SaveManager
var total_points: int = 0
var unlocked_challenge_levels: Array = [0]
var unlocked_skins: Array = [0]
var unlocked_trails: Array = [0]
var unlocked_backgrounds: Array = [0]

var selected_skin: int = 0
var selected_trail: int = 0
var selected_background: int = 0

func _ready() -> void:
	save_manager = SaveManager.new()
	load_progress()

func load_progress() -> void:
	var data = save_manager.load_game()
	total_points = data["unlocks"]["total_points"]
	unlocked_challenge_levels = data["unlocks"]["unlocked_challenge_levels"].duplicate()
	unlocked_skins = data["unlocks"]["unlocked_skins"].duplicate()
	unlocked_trails = data["unlocks"]["unlocked_trails"].duplicate()
	unlocked_backgrounds = data["unlocks"]["unlocked_backgrounds"].duplicate()
	
	selected_skin = data["customization"]["selected_skin"]
	selected_trail = data["customization"]["selected_trail"]
	selected_background = data["customization"]["selected_background"]

func save_progress() -> void:
	var data = save_manager.load_game()
	data["unlocks"]["total_points"] = total_points
	data["unlocks"]["unlocked_challenge_levels"] = unlocked_challenge_levels.duplicate()
	data["unlocks"]["unlocked_skins"] = unlocked_skins.duplicate()
	data["unlocks"]["unlocked_trails"] = unlocked_trails.duplicate()
	data["unlocks"]["unlocked_backgrounds"] = unlocked_backgrounds.duplicate()
	
	data["customization"]["selected_skin"] = selected_skin
	data["customization"]["selected_trail"] = selected_trail
	data["customization"]["selected_background"] = selected_background
	
	save_manager.save_game(data)

func add_points(points: int) -> void:
	total_points += points
	points_changed.emit(total_points)
	save_progress()

func unlock_challenge_level(level: int) -> void:
	if level not in unlocked_challenge_levels and level >= 0 and level < 10:
		unlocked_challenge_levels.append(level)
		level_unlocked.emit(level)
		save_progress()

func can_unlock(category: String, item_id: int) -> bool:
	var cost = get_unlock_cost(category, item_id)
	if cost < 0:
		return false
	if is_unlocked(category, item_id):
		return false
	return total_points >= cost

func unlock_item(category: String, item_id: int) -> bool:
	if not can_unlock(category, item_id):
		return false
	
	var cost = get_unlock_cost(category, item_id)
	total_points -= cost
	
	match category:
		"skin":
			unlocked_skins.append(item_id)
		"trail":
			unlocked_trails.append(item_id)
		"background":
			unlocked_backgrounds.append(item_id)
	
	save_progress()
	item_unlocked.emit(category, item_id)
	points_changed.emit(total_points)
	return true

func is_unlocked(category: String, item_id: int) -> bool:
	match category:
		"skin":
			return item_id in unlocked_skins
		"trail":
			return item_id in unlocked_trails
		"background":
			return item_id in unlocked_backgrounds
	return false

func get_unlock_cost(category: String, item_id: int) -> int:
	match category:
		"skin":
			if item_id >= 0 and item_id < SKIN_COSTS.size():
				return SKIN_COSTS[item_id]
		"trail":
			if item_id >= 0 and item_id < TRAIL_COSTS.size():
				return TRAIL_COSTS[item_id]
		"background":
			if item_id >= 0 and item_id < BACKGROUND_COSTS.size():
				return BACKGROUND_COSTS[item_id]
	return -1

func select_item(category: String, item_id: int) -> void:
	if not is_unlocked(category, item_id):
		return
	
	match category:
		"skin":
			selected_skin = item_id
		"trail":
			selected_trail = item_id
		"background":
			selected_background = item_id
	
	save_progress()
