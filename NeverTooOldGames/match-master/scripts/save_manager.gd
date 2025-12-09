extends Node

## Save and load game state

const SAVE_PATH = "user://match_master_save.json"

func save_game(game_data: Dictionary) -> void:
	"""Save game state to file"""
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(game_data)
		file.store_string(json_string)
		file.close()
		print("Game saved successfully")
	else:
		print("Error: Could not save game")

func load_game() -> Dictionary:
	"""Load game state from file"""
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found")
		return {}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		
		if parse_result == OK:
			print("Game loaded successfully")
			return json.data
		else:
			print("Error parsing save file")
			return {}
	else:
		print("Error: Could not open save file")
		return {}

func has_save() -> bool:
	"""Check if a save file exists"""
	return FileAccess.file_exists(SAVE_PATH)

func delete_save() -> void:
	"""Delete the save file"""
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
		print("Save file deleted")
