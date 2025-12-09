extends Control

## Game over screen (when player loses)

var player_score: int = 0
var opponent_score: int = 0
var difficulty: String = "medium"

func _ready() -> void:
	# Get game data from meta
	player_score = get_tree().root.get_meta("final_player_score", 9)
	opponent_score = get_tree().root.get_meta("final_opponent_score", 11)
	difficulty = get_tree().root.get_meta("difficulty", "medium")
	
	create_ui()

func create_ui() -> void:
	"""Create game over screen UI"""
	# Background
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.3, 0.1, 0.1)  # Red tint for loss
	add_child(bg)
	
	# Game Over title
	var title = Label.new()
	title.position = Vector2(650, 150)
	title.text = "GAME OVER"
	title.add_theme_font_size_override("font_size", 80)
	title.modulate = Color(1.0, 0.3, 0.3)
	add_child(title)
	
	# Final score
	var score_label = Label.new()
	score_label.position = Vector2(750, 300)
	score_label.text = "Final Score: %d - %d" % [player_score, opponent_score]
	score_label.add_theme_font_size_override("font_size", 48)
	add_child(score_label)
	
	# Difficulty
	var diff_label = Label.new()
	diff_label.position = Vector2(780, 380)
	diff_label.text = "Difficulty: %s" % difficulty.capitalize()
	diff_label.add_theme_font_size_override("font_size", 32)
	add_child(diff_label)
	
	# Encouragement message
	var msg_label = Label.new()
	msg_label.position = Vector2(700, 480)
	msg_label.text = "Try again!"
	msg_label.add_theme_font_size_override("font_size", 36)
	msg_label.modulate = Color(0.7, 0.7, 0.7)
	add_child(msg_label)
	
	# Buttons
	var retry_btn = create_button("RETRY", Vector2(560, 650))
	retry_btn.pressed.connect(_on_retry_pressed)
	add_child(retry_btn)
	
	var change_diff_btn = create_button("CHANGE DIFFICULTY", Vector2(860, 650))
	change_diff_btn.pressed.connect(_on_change_difficulty_pressed)
	add_child(change_diff_btn)
	
	var menu_btn = create_button("MAIN MENU", Vector2(760, 750))
	menu_btn.pressed.connect(_on_menu_pressed)
	add_child(menu_btn)

func create_button(text: String, pos: Vector2) -> Button:
	"""Create a styled button"""
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(280, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func _on_retry_pressed() -> void:
	"""Retry with same difficulty"""
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_change_difficulty_pressed() -> void:
	"""Go back to mode select"""
	get_tree().change_scene_to_file("res://scenes/mode_select.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
