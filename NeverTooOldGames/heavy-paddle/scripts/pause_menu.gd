extends Control

## Pause menu overlay

signal resume_game
signal restart_game
signal quit_to_menu

func _ready() -> void:
	create_ui()
	hide()  # Start hidden

func create_ui() -> void:
	"""Create pause menu UI"""
	# Semi-transparent background
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0, 0, 0, 0.7)
	add_child(bg)
	
	# Pause title
	var title = Label.new()
	title.position = Vector2(820, 250)
	title.text = "PAUSED"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	# Buttons
	var button_y = 400
	var button_spacing = 80
	
	var resume_btn = create_button("RESUME", Vector2(810, button_y))
	resume_btn.pressed.connect(_on_resume_pressed)
	add_child(resume_btn)
	button_y += button_spacing
	
	var restart_btn = create_button("RESTART", Vector2(810, button_y))
	restart_btn.pressed.connect(_on_restart_pressed)
	add_child(restart_btn)
	button_y += button_spacing
	
	var menu_btn = create_button("MAIN MENU", Vector2(810, button_y))
	menu_btn.pressed.connect(_on_menu_pressed)
	add_child(menu_btn)

func create_button(text: String, pos: Vector2) -> Button:
	"""Create a styled button"""
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(300, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func show_pause() -> void:
	"""Show pause menu"""
	show()
	get_tree().paused = true

func hide_pause() -> void:
	"""Hide pause menu"""
	hide()
	get_tree().paused = false

func _on_resume_pressed() -> void:
	hide_pause()
	resume_game.emit()

func _on_restart_pressed() -> void:
	hide_pause()
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	hide_pause()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
