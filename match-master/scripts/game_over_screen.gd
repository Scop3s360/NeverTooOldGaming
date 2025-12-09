extends Control

## Game Over screen shown when player runs out of attempts

signal retry_pressed
signal quit_pressed

@onready var score_label: Label = $Panel/VBoxContainer/ScoreLabel
@onready var attempts_label: Label = $Panel/VBoxContainer/AttemptsLabel
@onready var matches_label: Label = $Panel/VBoxContainer/MatchesLabel
@onready var retry_button: Button = $Panel/VBoxContainer/RetryButton
@onready var quit_button: Button = $Panel/VBoxContainer/QuitButton

func _ready() -> void:
	retry_button.pressed.connect(_on_retry_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Hide by default
	visible = false

func show_game_over(final_score: int, matches_made: int, total_pairs: int) -> void:
	"""Show game over screen with stats"""
	visible = true
	
	score_label.text = "Final Score: " + str(final_score)
	matches_label.text = "Matches: " + str(matches_made) + "/" + str(total_pairs)
	attempts_label.text = "You ran out of attempts!"

func _on_retry_pressed() -> void:
	retry_pressed.emit()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	quit_pressed.emit()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
