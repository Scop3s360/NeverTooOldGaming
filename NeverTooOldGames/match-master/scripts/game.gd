extends Node2D

## Main game scene with grid and matching

const SaveManager = preload("res://scripts/save_manager.gd")
const UnlockManager = preload("res://scripts/unlock_manager.gd")

@onready var grid_manager: GridManager = $GridManager
@onready var card_manager: CardManager = $CardManager
@onready var score_manager: ScoreManager = $ScoreManager
@onready var victory_screen: Control = $CanvasLayer/VictoryScreen
@onready var game_over_screen: Control = $CanvasLayer/GameOverScreen
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
@onready var pause_button: Button = $CanvasLayer/PauseButton
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var attempts_label: Label = $CanvasLayer/AttemptsLabel

var save_manager: SaveManager
var unlock_manager: UnlockManager
var num_pairs: int = 4
var game_mode: int = 0

func _ready() -> void:
	save_manager = SaveManager.new()
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)
	
	# Get selected mode from meta
	num_pairs = get_tree().root.get_meta("num_pairs", 4)
	game_mode = get_tree().root.get_meta("game_mode", 0)
	
	# Load theme background
	load_background(unlock_manager.selected_background)
	
	# Initialize score manager
	score_manager.initialize(game_mode)
	score_manager.score_changed.connect(_on_score_changed)
	score_manager.attempts_changed.connect(_on_attempts_changed)
	score_manager.game_over.connect(_on_game_over)
	
	# Create grid based on selected mode
	grid_manager.create_grid(num_pairs)
	
	# Connect all cards to the card manager
	for card in grid_manager.cards:
		card.card_tapped.connect(card_manager.on_card_tapped.bind(card))
	
	# Connect match signals
	card_manager.match_found.connect(_on_match_found)
	card_manager.no_match.connect(_on_no_match)
	grid_manager.all_pairs_matched.connect(_on_all_matched)
	
	# Connect pause button
	pause_button.pressed.connect(_on_pause_pressed)
	
	print("Game ready! Find the matching pairs!")

func _input(event: InputEvent) -> void:
	# ESC key to pause
	if event.is_action_pressed("ui_cancel"):
		_on_pause_pressed()

func _on_match_found(card_a: Card, card_b: Card) -> void:
	print("✓ Match! Cards ", card_a.card_id, " matched!")
	score_manager.add_match_bonus()
	grid_manager.check_all_matched()
	save_game()

func _on_no_match(card_a: Card, card_b: Card) -> void:
	print("✗ No match. Try again!")
	score_manager.add_miss_penalty()

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)

func _on_attempts_changed(remaining: int, max_attempts: int) -> void:
	attempts_label.text = "Attempts: " + str(remaining) + "/" + str(max_attempts)

func _on_game_over() -> void:
	print("Game Over! Out of attempts!")
	
	# Show game over screen with stats
	var final_score = score_manager.get_score()
	var matches_made = card_manager.matched_pairs
	var total_pairs = num_pairs
	
	game_over_screen.show_game_over(final_score, matches_made, total_pairs)

func _on_all_matched() -> void:
	print("🎉 YOU WIN! All pairs matched!")
	
	# Add final score to total points
	var final_score = score_manager.get_score()
	unlock_manager.add_points(final_score)
	print("Added ", final_score, " points. Total: ", unlock_manager.total_points)
	
	# Store current theme for victory screen
	get_tree().root.set_meta("current_theme", unlock_manager.selected_deck)
	
	# Show victory screen with stats
	var attempts_remaining = score_manager.get_remaining_attempts()
	var max_attempts = score_manager.max_attempts
	victory_screen.show_victory(final_score, attempts_remaining, max_attempts)
	
	# Delete save since game is complete
	save_manager.delete_save()

func _on_pause_pressed() -> void:
	pause_menu.show_pause()
	save_game()

func save_game() -> void:
	"""Save current game state"""
	var game_data = {
		"num_pairs": num_pairs,
		"matched_pairs": card_manager.matched_pairs,
		"card_states": []
	}
	
	# Save each card's state
	for card in grid_manager.cards:
		game_data["card_states"].append({
			"card_id": card.card_id,
			"is_matched": card.is_matched,
			"is_face_up": card.is_face_up
		})
	
	save_manager.save_game(game_data)

func load_background(theme_id: int) -> void:
	"""Load and display background for selected theme"""
	var background_texture: Texture2D = null
	
	match theme_id:
		0:  # Retro Pixel Art
			background_texture = load("res://assets/00_retro_pixel_art/background/pixlebackground.jpg")
		1:  # Minimalist Neon
			background_texture = load("res://assets/01_minimalist_neon/background/background.jpg")
		_:  # Default background color
			return
	
	if background_texture:
		# Create a Sprite2D for the background
		var background_sprite = Sprite2D.new()
		background_sprite.texture = background_texture
		background_sprite.z_index = -100  # Behind everything
		background_sprite.centered = true
		background_sprite.position = Vector2(360, 640)  # Center of screen (720x1280)
		
		# Scale to cover screen
		var texture_size = background_texture.get_size()
		var screen_size = Vector2(720, 1280)
		var scale_x = screen_size.x / texture_size.x
		var scale_y = screen_size.y / texture_size.y
		var scale_factor = max(scale_x, scale_y)  # Cover entire screen
		background_sprite.scale = Vector2(scale_factor, scale_factor)
		
		add_child(background_sprite)
