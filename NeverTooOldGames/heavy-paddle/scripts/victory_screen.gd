extends Control

## Victory screen

const SaveManager = preload("res://scripts/save_manager.gd")
const UnlockManager = preload("res://scripts/unlock_manager.gd")

var save_manager: SaveManager
var unlock_manager: UnlockManager

var player_score: int = 0
var opponent_score: int = 0
var difficulty: String = "medium"
var points_earned: int = 0

func _ready() -> void:
	save_manager = SaveManager.new()
	add_child(save_manager)
	
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)
	
	# Get game data from meta
	player_score = get_tree().root.get_meta("final_player_score", 11)
	opponent_score = get_tree().root.get_meta("final_opponent_score", 9)
	difficulty = get_tree().root.get_meta("difficulty", "medium")
	points_earned = get_tree().root.get_meta("points_earned", 0)
	
	create_ui()

func create_ui() -> void:
	"""Create victory screen UI"""
	# Background
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.1, 0.3, 0.1)  # Green tint for victory
	add_child(bg)
	
	# Victory title
	var title = Label.new()
	title.position = Vector2(700, 150)
	title.text = "VICTORY!"
	title.add_theme_font_size_override("font_size", 80)
	title.modulate = Color(0.3, 1.0, 0.3)
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
	
	# Points earned
	var points_label = Label.new()
	points_label.position = Vector2(750, 450)
	points_label.text = "Points Earned: +%d" % points_earned
	points_label.add_theme_font_size_override("font_size", 36)
	points_label.modulate = Color(1.0, 0.8, 0.3)
	add_child(points_label)
	
	# Total points
	var total_label = Label.new()
	total_label.position = Vector2(750, 510)
	total_label.text = "Total Points: %d" % unlock_manager.total_points
	total_label.add_theme_font_size_override("font_size", 28)
	add_child(total_label)
	
	# Buttons
	var rematch_btn = create_button("REMATCH", Vector2(660, 650))
	rematch_btn.pressed.connect(_on_rematch_pressed)
	add_child(rematch_btn)
	
	var menu_btn = create_button("MAIN MENU", Vector2(960, 650))
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

func _on_rematch_pressed() -> void:
	"""Restart game with same settings"""
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
