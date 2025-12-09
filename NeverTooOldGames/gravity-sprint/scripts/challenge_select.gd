extends Control

const UnlockManager = preload("res://scripts/unlock_manager.gd")
var unlock_manager: UnlockManager

func _ready() -> void:
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)
	create_ui()

func create_ui() -> void:
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.05, 0.05, 0.1)
	add_child(bg)
	
	var title = Label.new()
	title.position = Vector2(650, 50)
	title.text = "CHALLENGE LEVELS"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	# Create level buttons in grid
	for i in range(10):
		var row = i / 5
		var col = i % 5
		var x = 400 + (col * 250)
		var y = 200 + (row * 200)
		
		var btn = Button.new()
		btn.position = Vector2(x, y)
		btn.size = Vector2(200, 150)
		btn.text = "LEVEL %d" % (i + 1)
		btn.add_theme_font_size_override("font_size", 28)
		
		if i in unlock_manager.unlocked_challenge_levels:
			btn.pressed.connect(_on_level_pressed.bind(i))
		else:
			btn.disabled = true
			btn.modulate = Color(0.3, 0.3, 0.3)
		
		add_child(btn)
	
	var back_btn = create_button("BACK", Vector2(810, 900))
	back_btn.pressed.connect(_on_back_pressed)
	add_child(back_btn)

func create_button(text: String, pos: Vector2) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(300, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func _on_level_pressed(level: int) -> void:
	get_tree().root.set_meta("game_mode", "challenge")
	get_tree().root.set_meta("challenge_level", level)
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mode_select.tscn")
