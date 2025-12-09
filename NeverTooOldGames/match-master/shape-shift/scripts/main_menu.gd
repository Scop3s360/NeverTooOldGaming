extends Control

## Main menu for Shape Shift

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var how_to_play_button: Button = $VBoxContainer/HowToPlayButton
@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel
@onready var quit_button: Button = $VBoxContainer/QuitButton

const SAVE_PATH = "user://shape_shift_save.json"

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	how_to_play_button.pressed.connect(_on_how_to_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	load_high_score()

func load_high_score() -> void:
	"""Load and display high score"""
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var json = JSON.new()
			var parse_result = json.parse(file.get_as_text())
			file.close()
			
			if parse_result == OK:
				var data = json.data
				var high_score = data.get("high_score", 0)
				high_score_label.text = "High Score: " + str(high_score)
				return
	
	high_score_label.text = "High Score: 0"

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
