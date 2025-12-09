extends Control

## Mode selection screen for Match Master

enum GameMode {
	EASY,    # 8 cards (4 pairs)
	MEDIUM,  # 16 cards (8 pairs)
	HARD     # 24 cards (12 pairs)
}

signal mode_selected(mode: GameMode)

@onready var easy_button: Button = $VBoxContainer/EasyButton
@onready var medium_button: Button = $VBoxContainer/MediumButton
@onready var hard_button: Button = $VBoxContainer/HardButton
@onready var back_button: Button = $BackButton

func _ready() -> void:
	easy_button.pressed.connect(_on_easy_pressed)
	medium_button.pressed.connect(_on_medium_pressed)
	hard_button.pressed.connect(_on_hard_pressed)
	back_button.pressed.connect(_on_back_pressed)

func _on_easy_pressed() -> void:
	print("Easy mode selected (8 cards)")
	start_game(GameMode.EASY, 4)

func _on_medium_pressed() -> void:
	print("Medium mode selected (16 cards)")
	start_game(GameMode.MEDIUM, 8)

func _on_hard_pressed() -> void:
	print("Hard mode selected (24 cards)")
	start_game(GameMode.HARD, 12)

func start_game(mode: GameMode, num_pairs: int) -> void:
	mode_selected.emit(mode)
	
	# Store mode for the game scene (as int for easier handling)
	get_tree().root.set_meta("game_mode", int(mode))
	get_tree().root.set_meta("num_pairs", num_pairs)
	
	# Load game scene
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
