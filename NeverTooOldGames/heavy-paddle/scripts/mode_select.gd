extends Control

## Mode selection screen

func _ready() -> void:
	create_ui()

func create_ui() -> void:
	"""Create mode selection UI"""
	# Background
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.1, 0.1, 0.15)
	add_child(bg)
	
	# Title
	var title = Label.new()
	title.position = Vector2(750, 100)
	title.text = "SELECT MODE"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	# Single Player section
	var sp_label = Label.new()
	sp_label.position = Vector2(400, 250)
	sp_label.text = "SINGLE PLAYER VS AI"
	sp_label.add_theme_font_size_override("font_size", 36)
	add_child(sp_label)
	
	var diff_y = 320
	var diff_spacing = 80
	
	# Difficulty buttons
	var easy_btn = create_button("EASY", Vector2(400, diff_y), Color(0.3, 0.8, 0.3))
	easy_btn.pressed.connect(_on_difficulty_selected.bind("easy"))
	add_child(easy_btn)
	diff_y += diff_spacing
	
	var medium_btn = create_button("MEDIUM", Vector2(400, diff_y), Color(0.8, 0.8, 0.3))
	medium_btn.pressed.connect(_on_difficulty_selected.bind("medium"))
	add_child(medium_btn)
	diff_y += diff_spacing
	
	var hard_btn = create_button("HARD", Vector2(400, diff_y), Color(0.8, 0.5, 0.3))
	hard_btn.pressed.connect(_on_difficulty_selected.bind("hard"))
	add_child(hard_btn)
	diff_y += diff_spacing
	
	var expert_btn = create_button("EXPERT", Vector2(400, diff_y), Color(0.8, 0.3, 0.3))
	expert_btn.pressed.connect(_on_difficulty_selected.bind("expert"))
	add_child(expert_btn)
	
	# Two Player section
	var tp_label = Label.new()
	tp_label.position = Vector2(1100, 250)
	tp_label.text = "LOCAL MULTIPLAYER"
	tp_label.add_theme_font_size_override("font_size", 36)
	add_child(tp_label)
	
	var two_player_btn = create_button("2 PLAYER", Vector2(1100, 320), Color(0.3, 0.5, 0.8))
	two_player_btn.pressed.connect(_on_two_player_pressed)
	add_child(two_player_btn)
	
	# Practice mode
	var practice_btn = create_button("PRACTICE MODE", Vector2(1100, 400), Color(0.5, 0.5, 0.5))
	practice_btn.pressed.connect(_on_practice_pressed)
	add_child(practice_btn)
	
	# Back button
	var back_btn = create_button("BACK", Vector2(810, 850), Color(0.4, 0.4, 0.4))
	back_btn.pressed.connect(_on_back_pressed)
	add_child(back_btn)

func create_button(text: String, pos: Vector2, color: Color = Color.WHITE) -> Button:
	"""Create a styled button"""
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(300, 60)
	btn.add_theme_font_size_override("font_size", 24)
	btn.modulate = color
	return btn

func _on_difficulty_selected(difficulty: String) -> void:
	"""Start single player game with selected difficulty"""
	get_tree().root.set_meta("game_mode", "single_player")
	get_tree().root.set_meta("difficulty", difficulty)
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_two_player_pressed() -> void:
	"""Start two player game"""
	get_tree().root.set_meta("game_mode", "two_player")
	get_tree().root.set_meta("difficulty", "medium")
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_practice_pressed() -> void:
	"""Start practice mode"""
	get_tree().root.set_meta("game_mode", "practice")
	get_tree().root.set_meta("difficulty", "easy")
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
