extends Control

## Game Over screen

@onready var score_label: Label = $Panel/VBoxContainer/ScoreLabel
@onready var high_score_label: Label = $Panel/VBoxContainer/HighScoreLabel
@onready var retry_button: Button = $Panel/VBoxContainer/RetryButton
@onready var menu_button: Button = $Panel/VBoxContainer/MenuButton

func _ready() -> void:
	retry_button.pressed.connect(_on_retry_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

func show_game_over(final_score: int, best_score: int) -> void:
	"""Display game over screen with scores"""
	visible = true
	score_label.text = "Final Score: " + str(final_score)
	
	if final_score >= best_score:
		high_score_label.text = "NEW HIGH SCORE!"
		high_score_label.modulate = Color(0, 1, 1)
	else:
		high_score_label.text = "High Score: " + str(best_score)
		high_score_label.modulate = Color(1, 1, 1)

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
