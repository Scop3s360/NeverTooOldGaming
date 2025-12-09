extends Control

var final_score: int = 0
var final_distance: int = 0
var final_time: float = 0.0

func _ready() -> void:
	final_score = get_tree().root.get_meta("final_score", 0)
	final_distance = get_tree().root.get_meta("final_distance", 0)
	final_time = get_tree().root.get_meta("final_time", 0.0)
	create_ui()

func create_ui() -> void:
	var bg = ColorRect.new()
	bg.size = Vector2(1920, 1080)
	bg.color = Color(0.15, 0.05, 0.05)
	add_child(bg)
	
	var title = Label.new()
	title.position = Vector2(650, 150)
	title.text = "GAME OVER"
	title.add_theme_font_size_override("font_size", 80)
	title.modulate = Color(1.0, 0.3, 0.3)
	add_child(title)
	
	var score_label = Label.new()
	score_label.position = Vector2(750, 300)
	score_label.text = "Score: %d" % final_score
	score_label.add_theme_font_size_override("font_size", 48)
	add_child(score_label)
	
	var distance_label = Label.new()
	distance_label.position = Vector2(720, 370)
	distance_label.text = "Distance: %dm" % final_distance
	distance_label.add_theme_font_size_override("font_size", 36)
	add_child(distance_label)
	
	var time_label = Label.new()
	time_label.position = Vector2(740, 430)
	time_label.text = "Time: %.1fs" % final_time
	time_label.add_theme_font_size_override("font_size", 36)
	add_child(time_label)
	
	var retry_btn = create_button("RETRY", Vector2(660, 600))
	retry_btn.pressed.connect(_on_retry_pressed)
	add_child(retry_btn)
	
	var menu_btn = create_button("MAIN MENU", Vector2(960, 600))
	menu_btn.pressed.connect(_on_menu_pressed)
	add_child(menu_btn)

func create_button(text: String, pos: Vector2) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(280, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
