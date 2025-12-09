class_name SaveManager
extends Node

## Handles all save/load operations for Gravity Sprint

const SAVE_PATH = "user://gravity_sprint_save.json"

# Default save data structure
var default_data = {
	"high_score_endless": 0,
	"best_times_challenge": [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],  # 10 levels
	"stats": {
		"total_runs": 0,
		"total_distance": 0,
		"total_flips": 0,
		"longest_run": 0
	},
	"settings": {
		"master_volume": 0.8,
		"music_volume": 0.7,
		"sfx_volume": 0.8
	},
	"unlocks": {
		"total_points": 0,
		"unlocked_challenge_levels": [0],  # Level 0 always unlocked
		"unlocked_skins": [0],
		"unlocked_trails": [0],
		"unlocked_backgrounds": [0]
	},
	"customization": {
		"selected_skin": 0,
		"selected_trail": 0,
		"selected_background": 0
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

func update_high_score(score: int) -> bool:
	"""Update endless mode high score if new score is higher. Returns true if new high score."""
	var data = load_game()
	
	if score > data["high_score_endless"]:
		data["high_score_endless"] = score
		save_game(data)
		return true
	
	return false

func update_challenge_time(level: int, time: float) -> bool:
	"""Update best time for challenge level if faster. Returns true if new best."""
	var data = load_game()
	
	if level < 0 or level >= 10:
		return false
	
	# If no time recorded (0.0) or new time is faster
	if data["best_times_challenge"][level] == 0.0 or time < data["best_times_challenge"][level]:
		data["best_times_challenge"][level] = time
		save_game(data)
		return true
	
	return false

func add_run_stats(distance: int, flips: int) -> void:
	"""Record run statistics"""
	var data = load_game()
	
	data["stats"]["total_runs"] += 1
	data["stats"]["total_distance"] += distance
	data["stats"]["total_flips"] += flips
	
	if distance > data["stats"]["longest_run"]:
		data["stats"]["longest_run"] = distance
	
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
