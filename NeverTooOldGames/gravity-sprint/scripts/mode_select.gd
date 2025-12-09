extends Control

func _ready() -> void:
	create_ui()

func create_ui() -> void:
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.05, 0.05, 0.1)
	add_child(bg)
	
	var title = Label.new()
	title.position = Vector2(750, 100)
	title.text = "SELECT MODE"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	var endless_btn = create_button("ENDLESS MODE", Vector2(660, 350), Color(0.3, 0.8, 0.8))
	endless_btn.pressed.connect(_on_endless_pressed)
	add_child(endless_btn)
	
	var endless_desc = Label.new()
	endless_desc.position = Vector2(680, 430)
	endless_desc.text = "Survive as long as possible"
	endless_desc.add_theme_font_size_override("font_size", 20)
	endless_desc.modulate = Color(0.7, 0.7, 0.7)
	add_child(endless_desc)
	
	var challenge_btn = create_button("CHALLENGE MODE", Vector2(660, 550), Color(0.8, 0.5, 0.3))
	challenge_btn.pressed.connect(_on_challenge_pressed)
	add_child(challenge_btn)
	
	var challenge_desc = Label.new()
	challenge_desc.position = Vector2(680, 630)
	challenge_desc.text = "Complete 10 designed levels"
	challenge_desc.add_theme_font_size_override("font_size", 20)
	challenge_desc.modulate = Color(0.7, 0.7, 0.7)
	add_child(challenge_desc)
	
	var back_btn = create_button("BACK", Vector2(810, 800), Color(0.4, 0.4, 0.4))
	back_btn.pressed.connect(_on_back_pressed)
	add_child(back_btn)

func create_button(text: String, pos: Vector2, color: Color = Color.WHITE) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(600, 60)
	btn.add_theme_font_size_override("font_size", 28)
	btn.modulate = color
	return btn

func _on_endless_pressed() -> void:
	get_tree().root.set_meta("game_mode", "endless")
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_challenge_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/challenge_select.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
