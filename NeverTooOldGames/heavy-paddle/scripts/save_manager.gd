class_name SaveManager
extends Node

## Handles all save/load operations for Heavy Paddle

const SAVE_PATH = "user://heavy_paddle_save.json"

# Default save data structure
var default_data = {
	"high_scores": {
		"easy": 0,
		"medium": 0,
		"hard": 0,
		"expert": 0
	},
	"stats": {
		"total_matches": 0,
		"total_wins": 0,
		"total_losses": 0,
		"total_points_scored": 0
	},
	"settings": {
		"master_volume": 0.8,
		"music_volume": 0.7,
		"sfx_volume": 0.8,
		"preferred_difficulty": "medium",
		"control_type": "mouse"  # mouse or keyboard
	},
	"unlocks": {
		"total_points": 0,
		"unlocked_paddles": [0],  # 0 is always unlocked
		"unlocked_balls": [0],
		"unlocked_backgrounds": [0],
		"unlocked_trails": [0]
	},
	"customization": {
		"selected_paddle": 0,
		"selected_ball": 0,
		"selected_background": 0,
		"selected_trail": 0
	}
}

func save_game(data: Dictionary) -> void:
	"""Save game data to file"""
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()
		print("Game saved successfully")
	else:
		push_error("Failed to save game")

func load_game() -> Dictionary:
	"""Load game data from file, return default if doesn't exist"""
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var json_string = file.get_as_text()
			file.close()
			
			var json = JSON.new()
			var parse_result = json.parse(json_string)
			
			if parse_result == OK:
				var data = json.data
				# Merge with default data to ensure all keys exist
				return merge_with_defaults(data)
			else:
				push_error("Failed to parse save file")
				return default_data.duplicate(true)
		else:
			push_error("Failed to open save file")
			return default_data.duplicate(true)
	else:
		print("No save file found, using defaults")
		return default_data.duplicate(true)

func merge_with_defaults(loaded_data: Dictionary) -> Dictionary:
	"""Merge loaded data with defaults to handle new keys"""
	var merged = default_data.duplicate(true)
	
	for key in loaded_data:
		if key in merged and typeof(merged[key]) == TYPE_DICTIONARY:
			for subkey in loaded_data[key]:
				merged[key][subkey] = loaded_data[key][subkey]
		else:
			merged[key] = loaded_data[key]
	
	return merged

func update_high_score(difficulty: String, score: int) -> bool:
	"""Update high score for difficulty if new score is higher. Returns true if new high score."""
	var data = load_game()
	
	if score > data["high_scores"][difficulty]:
		data["high_scores"][difficulty] = score
		save_game(data)
		return true
	
	return false

func add_match_result(won: bool, points_scored: int) -> void:
	"""Record match statistics"""
	var data = load_game()
	
	data["stats"]["total_matches"] += 1
	if won:
		data["stats"]["total_wins"] += 1
	else:
		data["stats"]["total_losses"] += 1
	data["stats"]["total_points_scored"] += points_scored
	
	save_game(data)

func get_stats() -> Dictionary:
	"""Get player statistics"""
	var data = load_game()
	return data["stats"]

func get_settings() -> Dictionary:
	"""Get game settings"""
	var data = load_game()
	return data["settings"]

func update_settings(new_settings: Dictionary) -> void:
	"""Update game settings"""
	var data = load_game()
	for key in new_settings:
		data["settings"][key] = new_settings[key]
	save_game(data)
