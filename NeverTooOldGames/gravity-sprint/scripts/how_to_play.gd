extends Control

func _ready() -> void:
	create_ui()

func create_ui() -> void:
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.05, 0.05, 0.1)
	add_child(bg)
	
	var title = Label.new()
	title.position = Vector2(750, 50)
	title.text = "HOW TO PLAY"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	var instructions = [
		"OBJECTIVE:",
		"Survive as long as possible by avoiding obstacles",
		"",
		"CONTROLS:",
		"SPACE or LEFT CLICK: Flip gravity",
		"ESC: Pause game",
		"R: Quick restart (when dead)",
		"",
		"THE GRAVITY FLIP:",
		"• Press to switch between floor and ceiling",
		"• Time your flips to avoid obstacles",
		"• Obstacles appear on both surfaces",
		"",
		"GAME MODES:",
		"• Endless: Survive as long as possible, speed increases",
		"• Challenge: Complete 10 designed levels",
		"",
		"SCORING:",
		"• Distance traveled = points",
		"• Higher speed = score multiplier",
		"• Beat your high score!"
	]
	
	var y_pos = 150
	for line in instructions:
		var label = Label.new()
		label.position = Vector2(200, y_pos)
		label.text = line
		
		if line.ends_with(":"):
			label.add_theme_font_size_override("font_size", 28)
			label.modulate = Color(0.3, 0.8, 0.8)
		elif line.begins_with("•"):
			label.add_theme_font_size_override("font_size", 22)
			label.position.x = 250
		else:
			label.add_theme_font_size_override("font_size", 24)
		
		add_child(label)
		y_pos += 35
	
	var back_btn = create_button("BACK", Vector2(810, 950))
	back_btn.pressed.connect(_on_back_pressed)
	add_child(back_btn)

func create_button(text: String, pos: Vector2) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(300, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
