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
	title.position = Vector2(850, 30)
	title.text = "SHOP"
	title.add_theme_font_size_override("font_size", 60)
	add_child(title)
	
	var points_label = Label.new()
	points_label.name = "PointsLabel"
	points_label.position = Vector2(800, 110)
	points_label.text = "Points: %d" % unlock_manager.total_points
	points_label.add_theme_font_size_override("font_size", 32)
	points_label.modulate = Color(0.3, 0.8, 0.8)
	add_child(points_label)
	
	create_shop_section("SKINS", skin_names, unlock_manager.SKIN_COSTS, unlock_manager.unlocked_skins, "skin", Vector2(100, 200))
	create_shop_section("TRAILS", trail_names, unlock_manager.TRAIL_COSTS, unlock_manager.unlocked_trails, "trail", Vector2(700, 200))
	create_shop_section("BACKGROUNDS", background_names, unlock_manager.BACKGROUND_COSTS, unlock_manager.unlocked_backgrounds, "background", Vector2(1300, 200))
	
	var back_btn = create_button("BACK", Vector2(810, 950))
	back_btn.pressed.connect(_on_back_pressed)
	add_child(back_btn)

func create_shop_section(title: String, item_names: Array, costs: Array, unlocked: Array, category: String, pos: Vector2) -> void:
	var section_title = Label.new()
	section_title.position = pos
	section_title.text = title
	section_title.add_theme_font_size_override("font_size", 28)
	add_child(section_title)
	
	var item_y = pos.y + 50
	for i in range(item_names.size()):
		var container = VBoxContainer.new()
		container.position = Vector2(pos.x, item_y)
		
		var name_label = Label.new()
		name_label.text = item_names[i]
		name_label.add_theme_font_size_override("font_size", 20)
		container.add_child(name_label)
		
		if i in unlocked:
			var owned_label = Label.new()
			owned_label.text = "OWNED"
			owned_label.modulate = Color(0.3, 1.0, 0.3)
			owned_label.add_theme_font_size_override("font_size", 18)
			container.add_child(owned_label)
		else:
			var buy_btn = Button.new()
			buy_btn.text = "Buy: %d pts" % costs[i]
			buy_btn.size = Vector2(120, 30)
			buy_btn.add_theme_font_size_override("font_size", 16)
			buy_btn.pressed.connect(_on_buy_pressed.bind(category, i))
			if unlock_manager.total_points < costs[i]:
				buy_btn.disabled = true
			container.add_child(buy_btn)
		
		add_child(container)
		item_y += 80

func create_button(text: String, pos: Vector2) -> Button:
	var btn = Button.new()
	btn.text = text
	btn.position = pos
	btn.size = Vector2(300, 60)
	btn.add_theme_font_size_override("font_size", 24)
	return btn

func _on_buy_pressed(category: String, item_id: int) -> void:
	if unlock_manager.unlock_item(category, item_id):
		refresh_ui()

func refresh_ui() -> void:
	for child in get_children():
		if child != unlock_manager:
			child.queue_free()
	await get_tree().process_frame
	create_ui()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
