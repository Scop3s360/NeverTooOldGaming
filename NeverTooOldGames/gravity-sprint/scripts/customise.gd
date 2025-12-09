extends Control

const UnlockManager = preload("res://scripts/unlock_manager.gd")
var unlock_manager: UnlockManager

var skin_names = ["Classic", "Neon", "Pixel", "Plasma", "Gold"]
var trail_names = ["None", "Basic", "Particle", "Rainbow"]
var background_names = ["Classic", "Grid", "Starfield", "Abstract", "Void"]

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
	title.position = Vector2(750, 30)
	title.text = "CUSTOMISE"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	create_custom_section("SKIN", skin_names, unlock_manager.unlocked_skins, unlock_manager.selected_skin, "skin", Vector2(200, 200))
	create_custom_section("TRAIL", trail_names, unlock_manager.unlocked_trails, unlock_manager.selected_trail, "trail", Vector2(700, 200))
	create_custom_section("BACKGROUND", background_names, unlock_manager.unlocked_backgrounds, unlock_manager.selected_background, "background", Vector2(1200, 200))
	
	var apply_btn = create_button("APPLY", Vector2(710, 850))
	apply_btn.pressed.connect(_on_apply_pressed)
	add_child(apply_btn)
	
	var back_btn = create_button("BACK", Vector2(1010, 850))
	back_btn.pressed.connect(_on_back_pressed)
	add_child(back_btn)

func create_custom_section(title: String, item_names: Array, unlocked: Array, selected: int, category: String, pos: Vector2) -> void:
	var section_title = Label.new()
	section_title.position = pos
	section_title.text = title
	section_title.add_theme_font_size_override("font_size", 28)
	add_child(section_title)
	
	var item_y = pos.y + 50
	for i in range(item_names.size()):
		if i in unlocked:
			var select_btn = Button.new()
			select_btn.position = Vector2(pos.x, item_y)
			select_btn.size = Vector2(180, 40)
			select_btn.text = item_names[i]
			select_btn.add_theme_font_size_override("font_size", 18)
			select_btn.pressed.connect(_on_select_pressed.bind(category, i))
			
			if i == selected:
				select_btn.modulate = Color(0.3, 1.0, 0.3)
			
			add_child(select_btn)
			item_y += 50

func create_button(text: String, pos: Vector2) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(280, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func _on_select_pressed(category: String, item_id: int) -> void:
	unlock_manager.select_item(category, item_id)
	refresh_ui()

func _on_apply_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func refresh_ui() -> void:
	for child in get_children():
		if child != unlock_manager:
			child.queue_free()
	await get_tree().process_frame
	create_ui()
