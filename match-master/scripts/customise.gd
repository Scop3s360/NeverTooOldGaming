extends Control

## Customization screen to view and change selected themes

const UnlockManager = preload("res://scripts/unlock_manager.gd")

@onready var back_button: Button = $TopBar/BackButton
@onready var deck_label: Label = $VBoxContainer/DeckPanel/HBoxContainer/NameLabel
@onready var deck_button: Button = $VBoxContainer/DeckPanel/HBoxContainer/ChangeButton
@onready var background_label: Label = $VBoxContainer/BackgroundPanel/HBoxContainer/NameLabel
@onready var background_button: Button = $VBoxContainer/BackgroundPanel/HBoxContainer/ChangeButton
@onready var music_label: Label = $VBoxContainer/MusicPanel/HBoxContainer/NameLabel
@onready var music_button: Button = $VBoxContainer/MusicPanel/HBoxContainer/ChangeButton
@onready var animation_label: Label = $VBoxContainer/AnimationPanel/HBoxContainer/NameLabel
@onready var animation_button: Button = $VBoxContainer/AnimationPanel/HBoxContainer/ChangeButton

var unlock_manager: UnlockManager

# Theme names (same as shop)
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
	
	back_button.pressed.connect(_on_back_pressed)
	deck_button.pressed.connect(_on_change_deck)
	background_button.pressed.connect(_on_change_background)
	music_button.pressed.connect(_on_change_music)
	animation_button.pressed.connect(_on_change_animation)
	
	update_display()

func update_display() -> void:
	"""Update all labels with current selections"""
	deck_label.text = "Deck: " + deck_names[unlock_manager.selected_deck]
	background_label.text = "Background: " + background_names[unlock_manager.selected_background]
	music_label.text = "Music: " + music_names[unlock_manager.selected_music]
	animation_label.text = "Animation: " + animation_names[unlock_manager.selected_animation]

func _on_change_deck() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_change_background() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_change_music() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_change_animation() -> void:
	get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
