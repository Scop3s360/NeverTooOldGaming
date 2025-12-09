extends Control

func _ready() -> void:
	create_ui()

func create_ui() -> void:
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.05, 0.05, 0.1)
	add_child(bg)
	
	var title = Label.new()
	title.position = Vector2(650, 200)
	title.text = "GRAVITY SPRINT"
	title.add_theme_font_size_override("font_size", 80)
	add_child(title)
	
	var subtitle = Label.new()
	subtitle.position = Vector2(750, 300)
	subtitle.text = "Flip to Survive"
	subtitle.add_theme_font_size_override("font_size", 36)
	subtitle.modulate = Color(0.7, 0.7, 0.7)
	add_child(subtitle)
	
	var play_btn = create_button("PLAY", Vector2(810, 450))
	play_btn.pressed.connect(_on_play_pressed)
	add_child(play_btn)
	
	var how_btn = create_button("HOW TO PLAY", Vector2(760, 530))
	how_btn.pressed.connect(_on_how_to_play_pressed)
	add_child(how_btn)
	
	var custom_btn = create_button("CUSTOMISE", Vector2(780, 610))
	custom_btn.pressed.connect(_on_customise_pressed)
	add_child(custom_btn)
	
	var shop_btn = create_button("SHOP", Vector2(820, 690))
	shop_btn.pressed.connect(_on_shop_pressed)
	add_child(shop_btn)
	
	var quit_btn = create_button("QUIT", Vector2(820, 770))
	quit_btn.pressed.connect(_on_quit_pressed)
	add_child(quit_btn)

func create_button(text: String, pos: Vector2) -> Button:
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
