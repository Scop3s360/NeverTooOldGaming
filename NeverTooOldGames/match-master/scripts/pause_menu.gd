extends Control

## Pause menu overlay

signal resume_pressed
signal new_game_pressed
signal quit_pressed

@onready var resume_button: Button = $Panel/VBoxContainer/ResumeButton
@onready var new_game_button: Button = $Panel/VBoxContainer/NewGameButton
@onready var quit_button: Button = $Panel/VBoxContainer/QuitButton

func _ready() -> void:
	resume_button.pressed.connect(_on_resume_pressed)
	new_game_button.pressed.connect(_on_new_game_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Hide by default
	visible = false

func show_pause() -> void:
	visible = true
	get_tree().paused = true

func hide_pause() -> void:
	visible = false
	get_tree().paused = false

func _on_resume_pressed() -> void:
	resume_pressed.emit()
	hide_pause()

func _on_new_game_pressed() -> void:
	new_game_pressed.emit()
	hide_pause()
	get_tree().change_scene_to_file("res://scenes/mode_select.tscn")

func _on_quit_pressed() -> void:
	quit_pressed.emit()
	hide_pause()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
