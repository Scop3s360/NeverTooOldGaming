extends Control

## How to Play / Tutorial screen

func _ready() -> void:
	create_ui()

func create_ui() -> void:
	"""Create tutorial UI"""
	# Background
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.1, 0.1, 0.15)
	add_child(bg)
	
	# Title
	var title = Label.new()
	title.position = Vector2(750, 50)
	title.text = "HOW TO PLAY"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	# Instructions
	var instructions = [
		"OBJECTIVE:",
		"Be the first to score 11 points (must win by 2)",
		"",
		"CONTROLS:",
		"Mouse: Move paddle to follow cursor",
		"Keyboard: W/S or Arrow Keys to move paddle",
		"Player 2 (Local Multiplayer): I/K keys",
		"ESC: Pause game",
		"",
		"THE MOMENTUM MECHANIC:",
		"• Moving your paddle builds WEIGHT",
		"• More weight = SLOWER paddle speed",
		"• Staying still reduces weight over time",
		"• Light paddle = FASTER movement",
		"",
		"STRATEGY:",
		"• Anticipate ball trajectory",
		"• Position early to avoid heavy paddle",
		"• Balance reactive play with strategic positioning",
		"• Watch your weight bar!",
		"",
		"GAME MODES:",
		"• Single Player: Face AI opponents (4 difficulty levels)",
		"• Two Player: Local multiplayer on same keyboard",
		"• Practice: No scoring, just practice the mechanics"
	]
	
	var y_pos = 150
	for line in instructions:
		var label = Label.new()
		label.position = Vector2(200, y_pos)
		label.text = line
		
		if line.ends_with(":"):
			label.add_theme_font_size_override("font_size", 28)
			label.modulate = Color(1.0, 0.8, 0.3)
		elif line.begins_with("•"):
			label.add_theme_font_size_override("font_size", 22)
			label.position.x = 250
		else:
			label.add_theme_font_size_override("font_size", 24)
		
		add_child(label)
		y_pos += 35
	
	# Back button
	var back_btn = create_button("BACK", Vector2(810, 950))
	back_btn.pressed.connect(_on_back_pressed)
	add_child(back_btn)

func create_button(text: String, pos: Vector2) -> Button:
	"""Create a styled button"""
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(300, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
