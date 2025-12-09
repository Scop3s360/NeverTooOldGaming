extends Node

## Manages unlocks and persistent points across games

const SAVE_PATH = "user://match_master_unlocks.json"

signal points_changed(new_total: int)
signal item_purchased(category: String, item_id: int)

var total_points: int = 0
var unlocked_decks: Array[int] = [0]  # Start with first deck unlocked
var unlocked_backgrounds: Array[int] = [0]
var unlocked_music: Array[int] = [0]
var unlocked_animations: Array[int] = [0]

# Current selections
var selected_deck: int = 0
var selected_background: int = 0
var selected_music: int = 0
var selected_animation: int = 0

# Item costs (reduced for testing)
var deck_costs: Array[int] = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400]
var background_costs: Array[int] = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400]
var music_costs: Array[int] = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400]
var animation_costs: Array[int] = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400]

func _ready() -> void:
	load_data()

func add_points(amount: int) -> void:
	"""Add points to total (called after completing a game)"""
	total_points += amount
	points_changed.emit(total_points)
	save_data()
	print("Points added: +", amount, " | Total: ", total_points)

func can_afford(cost: int) -> bool:
	"""Check if player has enough points"""
	return total_points >= cost

func purchase_deck(deck_id: int) -> bool:
	"""Purchase a card deck"""
	if deck_id in unlocked_decks:
		print("Deck already unlocked")
		return false
	
	var cost = deck_costs[deck_id]
	if not can_afford(cost):
		print("Not enough points. Need: ", cost, " | Have: ", total_points)
		return false
	
	total_points -= cost
	unlocked_decks.append(deck_id)
	points_changed.emit(total_points)
	item_purchased.emit("deck", deck_id)
	save_data()
	print("Deck ", deck_id, " purchased for ", cost, " points")
	return true

func purchase_background(bg_id: int) -> bool:
	"""Purchase a background"""
	if bg_id in unlocked_backgrounds:
		return false
	
	var cost = background_costs[bg_id]
	if not can_afford(cost):
		return false
	
	total_points -= cost
	unlocked_backgrounds.append(bg_id)
	points_changed.emit(total_points)
	item_purchased.emit("background", bg_id)
	save_data()
	return true

func purchase_music(music_id: int) -> bool:
	"""Purchase a music track"""
	if music_id in unlocked_music:
		return false
	
	var cost = music_costs[music_id]
	if not can_afford(cost):
		return false
	
	total_points -= cost
	unlocked_music.append(music_id)
	points_changed.emit(total_points)
	item_purchased.emit("music", music_id)
	save_data()
	return true

func purchase_animation(anim_id: int) -> bool:
	"""Purchase a disappear animation"""
	if anim_id in unlocked_animations:
		return false
	
	var cost = animation_costs[anim_id]
	if not can_afford(cost):
		return false
	
	total_points -= cost
	unlocked_animations.append(anim_id)
	points_changed.emit(total_points)
	item_purchased.emit("animation", anim_id)
	save_data()
	return true

func is_unlocked(category: String, item_id: int) -> bool:
	"""Check if an item is unlocked"""
	match category:
		"deck": return item_id in unlocked_decks
		"background": return item_id in unlocked_backgrounds
		"music": return item_id in unlocked_music
		"animation": return item_id in unlocked_animations
	return false

func get_cost(category: String, item_id: int) -> int:
	"""Get the cost of an item"""
	match category:
		"deck": return deck_costs[item_id] if item_id < deck_costs.size() else 0
		"background": return background_costs[item_id] if item_id < background_costs.size() else 0
		"music": return music_costs[item_id] if item_id < music_costs.size() else 0
		"animation": return animation_costs[item_id] if item_id < animation_costs.size() else 0
	return 0

func save_data() -> void:
	"""Save unlock data to file"""
	var data = {
		"total_points": total_points,
		"unlocked_decks": unlocked_decks,
		"unlocked_backgrounds": unlocked_backgrounds,
		"unlocked_music": unlocked_music,
		"unlocked_animations": unlocked_animations,
		"selected_deck": selected_deck,
		"selected_background": selected_background,
		"selected_music": selected_music,
		"selected_animation": selected_animation
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_data() -> void:
	"""Load unlock data from file"""
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json = JSON.new()
		var parse_result = json.parse(file.get_as_text())
		file.close()
		
		if parse_result == OK:
			var data = json.data
			total_points = data.get("total_points", 0)
			
			# Convert arrays to typed arrays
			var temp_decks = data.get("unlocked_decks", [0])
			unlocked_decks.clear()
			for item in temp_decks:
				unlocked_decks.append(item)
			
			var temp_backgrounds = data.get("unlocked_backgrounds", [0])
			unlocked_backgrounds.clear()
			for item in temp_backgrounds:
				unlocked_backgrounds.append(item)
			
			var temp_music = data.get("unlocked_music", [0])
			unlocked_music.clear()
			for item in temp_music:
				unlocked_music.append(item)
			
			var temp_animations = data.get("unlocked_animations", [0])
			unlocked_animations.clear()
			for item in temp_animations:
				unlocked_animations.append(item)
			
			selected_deck = data.get("selected_deck", 0)
			selected_background = data.get("selected_background", 0)
			selected_music = data.get("selected_music", 0)
			selected_animation = data.get("selected_animation", 0)
			
			points_changed.emit(total_points)
			print("Unlocks loaded. Total points: ", total_points)
