extends Control

## Main Menu for Match Master

const SaveManager = preload("res://scripts/save_manager.gd")
const UnlockManager = preload("res://scripts/unlock_manager.gd")

signal new_game_pressed
signal continue_pressed
signal shop_pressed
signal how_to_play_pressed
signal audio_options_pressed
signal quit_pressed

@onready var new_game_button: Button = $VBoxContainer/NewGameButton
@onready var continue_button: Button = $VBoxContainer/ContinueButton
@onready var shop_button: Button = $VBoxContainer/ShopButton
@onready var how_to_play_button: Button = $VBoxContainer/HowToPlayButton
@onready var audio_options_button: Button = $VBoxContainer/AudioOptionsButton
@onready var quit_button: Button = $VBoxContainer/QuitButton
@onready var points_label: Label = $VBoxContainer/PointsLabel

var save_manager: SaveManager
var unlock_manager: UnlockManager

func _ready() -> void:
	print("Main Menu _ready() called")
	
	save_manager = SaveManager.new()
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)
	
	# Debug: Check if nodes exist
	print("shop_button exists: ", shop_button != null)
	print("points_label exists: ", points_label != null)
	
	# Connect button signals
	new_game_button.pressed.connect(_on_new_game_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	
	if shop_button:
		shop_button.pressed.connect(_on_shop_pressed)
		print("Shop button connected")
	else:
		print("ERROR: shop_button is null!")
	
	how_to_play_button.pressed.connect(_on_how_to_play_pressed)
	audio_options_button.pressed.connect(_on_audio_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Check if there's a saved game
	check_continue_available()
	
	# Update points display
	update_points_display()

func check_continue_available() -> void:
	"""Check if continue button should be enabled"""
	continue_button.disabled = not save_manager.has_save()

func update_points_display() -> void:
	"""Update the points display"""
	var points = unlock_manager.total_points
	points_label.text = "Points: " + str(points)
	print("Main Menu - Points display updated: ", points)

func _on_new_game_pressed() -> void:
	print("New Game pressed")
	new_game_pressed.emit()
	get_tree().change_scene_to_file("res://scenes/mode_select.tscn")

func _on_continue_pressed() -> void:
	print("Continue pressed")
	continue_pressed.emit()
	
	# Load saved game
	var save_data = save_manager.load_game()
	if save_data.is_empty():
		print("Error loading save")
		return
	
	# Store data for game scene
	get_tree().root.set_meta("num_pairs", save_data.get("num_pairs", 4))
	get_tree().root.set_meta("load_save", true)
	get_tree().root.set_meta("save_data", save_data)
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_shop_pressed() -> void:
	print("=== SHOP BUTTON PRESSED ===")
	shop_pressed.emit()
	print("Changing to shop scene...")
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
	print("Scene change requested")

func _on_how_to_play_pressed() -> void:
	print("How to Play pressed")
	how_to_play_pressed.emit()
	get_tree().change_scene_to_file("res://scenes/how_to_play.tscn")

func _on_audio_options_pressed() -> void:
	print("Audio Options pressed")
	audio_options_pressed.emit()
	# Open audio settings

func _on_quit_pressed() -> void:
	print("Quit pressed")
	quit_pressed.emit()
	get_tree().quit()
