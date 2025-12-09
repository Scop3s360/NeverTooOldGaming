extends Control

## Shop screen for purchasing unlocks

const UnlockManager = preload("res://scripts/unlock_manager.gd")

@onready var points_label: Label = $TopBar/PointsLabel
@onready var tab_container: TabContainer = $TabContainer
@onready var back_button: Button = $TopBar/BackButton

var unlock_manager: UnlockManager

# Theme names for each category
var deck_names = [
	"Retro Pixel Art", "Minimalist Neon", "Nature Botanical", "Hand-Drawn Doodle",
	"Dark Fantasy", "Casino Cards", "Halloween", "Guy Fawkes", "Christmas",
	"Train Railway", "Numbers/Math", "Dinosaurs", "Ocean", "Space Sci-Fi", "Japanese Zen"
]

var background_names = [
	"Arcade Dark", "Soft Gradient", "Notebook Paper", "Forest Garden",
	"Gothic Castle", "Casino Table", "Haunted House", "Bonfire Night", "Winter Wonderland",
	"Train Station", "Chalkboard", "Prehistoric Jungle", "Underwater", "Space Station", "Zen Garden"
]

var music_names = [
	"Chiptune 8-bit", "Peaceful Nature", "Ambient Electronic", "Upbeat Indie",
	"Mysterious Orchestral", "Jazz Lounge", "Spooky Sounds", "Explosive Brass", "Christmas Carols",
	"Train Sounds", "Counting Song", "Tribal Drums", "Ocean Waves", "Space Synth", "Koto & Shakuhachi"
]

var animation_names = [
	"Simple Fade", "Dark Smoke", "Petal Scatter", "Geometric Particles",
	"Sketch Erase", "Card Flip", "Ghostly Vanish", "Firework Explosion", "Snowflake Burst",
	"Steam Puff", "Number Pop", "Fossil Crumble", "Water Splash", "Teleport", "Cherry Blossom"
]

func _ready() -> void:
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)
	
	unlock_manager.points_changed.connect(_on_points_changed)
	unlock_manager.item_purchased.connect(_on_item_purchased)
	
	back_button.pressed.connect(_on_back_pressed)
	
	# Build shop UI
	build_shop()
	update_points_display()

func build_shop() -> void:
	"""Build the shop interface with all items"""
	# Add current selections panel at the top of each tab
	build_category_tab("Decks", deck_names, unlock_manager.deck_costs, "deck", unlock_manager.selected_deck)
	build_category_tab("Backgrounds", background_names, unlock_manager.background_costs, "background", unlock_manager.selected_background)
	build_category_tab("Music", music_names, unlock_manager.music_costs, "music", unlock_manager.selected_music)
	build_category_tab("Animations", animation_names, unlock_manager.animation_costs, "animation", unlock_manager.selected_animation)

func build_category_tab(tab_name: String, item_names: Array, costs: Array, category: String, selected_id: int) -> void:
	"""Build a tab for a category"""
	var scroll = ScrollContainer.new()
	
	var vbox = VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	scroll.add_child(vbox)
	
	# Add current selection panel at top
	var current_panel = Panel.new()
	current_panel.custom_minimum_size = Vector2(0, 80)
	var current_hbox = HBoxContainer.new()
	current_hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	current_hbox.add_theme_constant_override("separation", 20)
	current_panel.add_child(current_hbox)
	
	var current_label = Label.new()
	current_label.text = "CURRENTLY SELECTED: " + item_names[selected_id]
	current_label.add_theme_font_size_override("font_size", 20)
	current_label.modulate = Color(0.5, 1.0, 0.5)
	current_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	current_hbox.add_child(current_label)
	
	vbox.add_child(current_panel)
	
	# Add separator
	var separator = HSeparator.new()
	separator.custom_minimum_size = Vector2(0, 20)
	vbox.add_child(separator)
	
	# Add all items
	for i in range(item_names.size()):
		var item_panel = create_shop_item(item_names[i], costs[i], category, i)
		vbox.add_child(item_panel)
	
	tab_container.add_child(scroll)
	tab_container.set_tab_title(tab_container.get_tab_count() - 1, tab_name)

func create_shop_item(item_name: String, cost: int, category: String, item_id: int) -> Panel:
	"""Create a shop item panel"""
	var panel = Panel.new()
	panel.custom_minimum_size = Vector2(0, 80)
	
	var hbox = HBoxContainer.new()
	hbox.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hbox.add_theme_constant_override("separation", 20)
	panel.add_child(hbox)
	
	# Item name
	var name_label = Label.new()
	name_label.text = item_name
	name_label.custom_minimum_size = Vector2(300, 0)
	hbox.add_child(name_label)
	
	# Cost/Status
	var status_label = Label.new()
	var is_unlocked = unlock_manager.is_unlocked(category, item_id)
	
	if is_unlocked:
		status_label.text = "UNLOCKED"
		status_label.modulate = Color(0.2, 1.0, 0.2)
	else:
		status_label.text = str(cost) + " pts"
	
	status_label.custom_minimum_size = Vector2(150, 0)
	hbox.add_child(status_label)
	
	# Purchase button
	var button = Button.new()
	if is_unlocked:
		# Check if this item is currently selected
		var is_selected = false
		match category:
			"deck": is_selected = (unlock_manager.selected_deck == item_id)
			"background": is_selected = (unlock_manager.selected_background == item_id)
			"music": is_selected = (unlock_manager.selected_music == item_id)
			"animation": is_selected = (unlock_manager.selected_animation == item_id)
		
		if is_selected:
			button.text = "SELECTED"
			button.disabled = true
			button.modulate = Color(0.5, 1.0, 0.5)
		else:
			button.text = "SELECT"
			button.pressed.connect(func(): select_item(category, item_id))
	else:
		button.text = "BUY"
		button.disabled = not unlock_manager.can_afford(cost)
		button.pressed.connect(func(): purchase_item(category, item_id, button, status_label))
	
	hbox.add_child(button)
	
	return panel

func purchase_item(category: String, item_id: int, button: Button, status_label: Label) -> void:
	"""Purchase an item"""
	var success = false
	
	match category:
		"deck": success = unlock_manager.purchase_deck(item_id)
		"background": success = unlock_manager.purchase_background(item_id)
		"music": success = unlock_manager.purchase_music(item_id)
		"animation": success = unlock_manager.purchase_animation(item_id)
	
	if success:
		# Update UI
		status_label.text = "UNLOCKED"
		status_label.modulate = Color(0.2, 1.0, 0.2)
		button.text = "SELECT"
		button.disabled = false
		
		# Rebuild shop to update all button states
		refresh_shop()

func select_item(category: String, item_id: int) -> void:
	"""Select an unlocked item to use"""
	match category:
		"deck": unlock_manager.selected_deck = item_id
		"background": unlock_manager.selected_background = item_id
		"music": unlock_manager.selected_music = item_id
		"animation": unlock_manager.selected_animation = item_id
	
	unlock_manager.save_data()
	print("Selected ", category, ": ", item_id)
	
	# Refresh to show which item is selected
	refresh_shop()

func refresh_shop() -> void:
	"""Rebuild the shop UI"""
	# Save current tab
	var current_tab = tab_container.current_tab
	
	# Clear existing tabs
	for child in tab_container.get_children():
		child.queue_free()
	
	# Rebuild
	build_shop()
	
	# Restore tab selection
	await get_tree().process_frame  # Wait for tabs to be created
	tab_container.current_tab = current_tab

func update_points_display() -> void:
	"""Update the points display"""
	points_label.text = "Points: " + str(unlock_manager.total_points)

func _on_points_changed(_new_total: int) -> void:
	update_points_display()

func _on_item_purchased(category: String, item_id: int) -> void:
	print("Item purchased: ", category, " #", item_id)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
