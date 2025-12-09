extends Control

## Main menu screen

func _ready() -> void:
	create_ui()

func create_ui() -> void:
	"""Create main menu UI"""
	# Background
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.1, 0.1, 0.15)
	add_child(bg)
	
	# Title
	var title = Label.new()
	title.position = Vector2(660, 200)
	title.text = "HEAVY PADDLE"
	title.add_theme_font_size_override("font_size", 80)
	add_child(title)
	
	# Subtitle
	var subtitle = Label.new()
	subtitle.position = Vector2(700, 300)
	subtitle.text = "Master the Weight"
	subtitle.add_theme_font_size_override("font_size", 32)
	subtitle.modulate = Color(0.7, 0.7, 0.7)
	add_child(subtitle)
	
	# Buttons
	var button_y = 450
	var button_spacing = 80
	
	# Play button
	var play_btn = create_button("PLAY", Vector2(810, button_y))
	play_btn.pressed.connect(_on_play_pressed)
	add_child(play_btn)
	button_y += button_spacing
	
	# How to Play button
	var how_btn = create_button("HOW TO PLAY", Vector2(760, button_y))
	how_btn.pressed.connect(_on_how_to_play_pressed)
	add_child(how_btn)
	button_y += button_spacing
	
	# Customise button
	var custom_btn = create_button("CUSTOMISE", Vector2(780, button_y))
	custom_btn.pressed.connect(_on_customise_pressed)
	add_child(custom_btn)
	button_y += button_spacing
	
	# Shop button
	var shop_btn = create_button("SHOP", Vector2(820, button_y))
	shop_btn.pressed.connect(_on_shop_pressed)
	add_child(shop_btn)
	button_y += button_spacing
	
	# Quit button
	var quit_btn = create_button("QUIT", Vector2(820, button_y))
	quit_btn.pressed.connect(_on_quit_pressed)
	add_child(quit_btn)

func create_button(text: String, pos: Vector2) -> Button:
	"""Create a styled button"""
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(300, 60)
	btn.add_theme_font_size_override("font_size", 28)
	return btn

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mode_select.tscn")

func _on_how_to_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")

func _on_customise_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/customise.tscn")

func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
