extends Node2D

## Main game scene controller

const Paddle = preload("res://scripts/paddle.gd")
const Ball = preload("res://scripts/ball.gd")
const AIController = preload("res://scripts/ai_controller.gd")
const ScoreManager = preload("res://scripts/score_manager.gd")
const SaveManager = preload("res://scripts/save_manager.gd")
const UnlockManager = preload("res://scripts/unlock_manager.gd")

# Game mode settings
var game_mode: String = "single_player"  # single_player, two_player, practice
var difficulty: String = "medium"  # easy, medium, hard, expert

# Game objects
var player_paddle: Paddle
var opponent_paddle: Paddle
var ball: Ball
var ai_controller: AIController

# Managers
var score_manager: ScoreManager
var save_manager: SaveManager
var unlock_manager: UnlockManager

# UI References (will be set up in scene)
var score_label: Label
var player_weight_bar: ProgressBar
var opponent_weight_bar: ProgressBar
var pause_overlay: Control

var is_paused: bool = false

func _ready() -> void:
	# Get game settings from meta
	game_mode = get_tree().root.get_meta("game_mode", "single_player")
	difficulty = get_tree().root.get_meta("difficulty", "medium")
	
	# Initialize managers
	score_manager = ScoreManager.new()
	add_child(score_manager)
	score_manager.initialize(difficulty)
	score_manager.score_changed.connect(_on_score_changed)
	score_manager.game_won.connect(_on_game_won)
	
	save_manager = SaveManager.new()
	add_child(save_manager)
	
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)
	
	# Create game objects
	create_paddles()
	create_ball()
	create_walls()
	
	# Set up AI if single player
	if game_mode == "single_player":
		setup_ai()
	
	# Create UI
	create_ui()
	
	print("Heavy Paddle - Game Start!")
	print("Mode: %s, Difficulty: %s" % [game_mode, difficulty])

func create_paddles() -> void:
	"""Create player and opponent paddles"""
	# Player paddle (left)
	player_paddle = Paddle.new()
	player_paddle.is_player = true
	player_paddle.is_player_two = false
	player_paddle.paddle_side = "left"
	add_child(player_paddle)
	
	# Load control preference
	var settings = save_manager.get_settings()
	player_paddle.set_control_type(settings.get("control_type", "mouse"))
	
	# Opponent paddle (right)
	opponent_paddle = Paddle.new()
	opponent_paddle.paddle_side = "right"
	
	if game_mode == "two_player":
		opponent_paddle.is_player = true
		opponent_paddle.is_player_two = true
		opponent_paddle.set_control_type("keyboard")
	else:
		opponent_paddle.is_player = false
	
	add_child(opponent_paddle)

func create_ball() -> void:
	"""Create the ball"""
	ball = Ball.new()
	add_child(ball)
	
	# Connect signals
	ball.ball_out_of_bounds.connect(_on_ball_out_of_bounds)
	ball.ball_hit_paddle.connect(_on_ball_hit_paddle)

func create_walls() -> void:
	"""Create top and bottom walls"""
	# Top wall
	var top_wall = StaticBody2D.new()
	var top_collision = CollisionShape2D.new()
	var top_shape = RectangleShape2D.new()
	top_shape.size = Vector2(1920, 20)
	top_collision.shape = top_shape
	top_collision.position = Vector2(960, 10)
	top_wall.add_child(top_collision)
	add_child(top_wall)
	
	# Bottom wall
	var bottom_wall = StaticBody2D.new()
	var bottom_collision = CollisionShape2D.new()
	var bottom_shape = RectangleShape2D.new()
	bottom_shape.size = Vector2(1920, 20)
	bottom_collision.shape = bottom_shape
	bottom_collision.position = Vector2(960, 1070)
	bottom_wall.add_child(bottom_collision)
	add_child(bottom_wall)

func setup_ai() -> void:
	"""Set up AI controller for single player"""
	ai_controller = AIController.new()
	ai_controller.difficulty = difficulty
	add_child(ai_controller)
	ai_controller.initialize(opponent_paddle, ball)

func create_ui() -> void:
	"""Create game UI"""
	var canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)
	
	# Score label
	score_label = Label.new()
	score_label.position = Vector2(860, 20)
	score_label.add_theme_font_size_override("font_size", 48)
	score_label.text = "0 - 0"
	canvas_layer.add_child(score_label)
	
	# Player weight bar
	player_weight_bar = ProgressBar.new()
	player_weight_bar.position = Vector2(50, 950)
	player_weight_bar.size = Vector2(200, 30)
	player_weight_bar.max_value = 100
	player_weight_bar.value = 0
	canvas_layer.add_child(player_weight_bar)
	
	var player_label = Label.new()
	player_label.position = Vector2(50, 920)
	player_label.text = "Player Weight"
	canvas_layer.add_child(player_label)
	
	# Opponent weight bar
	opponent_weight_bar = ProgressBar.new()
	opponent_weight_bar.position = Vector2(1670, 950)
	opponent_weight_bar.size = Vector2(200, 30)
	opponent_weight_bar.max_value = 100
	opponent_weight_bar.value = 0
	canvas_layer.add_child(opponent_weight_bar)
	
	var opponent_label = Label.new()
	opponent_label.position = Vector2(1670, 920)
	opponent_label.text = "Opponent Weight"
	canvas_layer.add_child(opponent_label)
	
	# Center line
	var center_line = ColorRect.new()
	center_line.position = Vector2(958, 0)
	center_line.size = Vector2(4, 1080)
	center_line.color = Color(1, 1, 1, 0.3)
	canvas_layer.add_child(center_line)

func _process(_delta: float) -> void:
	# Update weight bars
	if player_paddle:
		player_weight_bar.value = player_paddle.get_weight_percentage()
	if opponent_paddle:
		opponent_weight_bar.value = opponent_paddle.get_weight_percentage()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	"""Toggle pause state"""
	is_paused = not is_paused
	get_tree().paused = is_paused
	
	if is_paused:
		# Show pause menu (will implement pause menu scene later)
		print("Game Paused")
	else:
		print("Game Resumed")

func _on_ball_out_of_bounds(side: String) -> void:
	"""Handle ball going out of bounds"""
	if side == "left":
		# Player missed, opponent scores
		score_manager.add_opponent_point()
		ball.reset_ball(false)  # Serve to player
	else:
		# Opponent missed, player scores
		score_manager.add_player_point()
		ball.reset_ball(true)  # Serve to opponent

func _on_ball_hit_paddle(paddle: Paddle, hit_position: float) -> void:
	"""Handle ball hitting paddle"""
	# Could add sound effects here
	pass

func _on_score_changed(player_score: int, opponent_score: int) -> void:
	"""Update score display"""
	score_label.text = "%d - %d" % [player_score, opponent_score]

func _on_game_won(winner: String, player_score: int, opponent_score: int) -> void:
	"""Handle game end"""
	print("Game Over! %s wins! %d - %d" % [winner, player_score, opponent_score])
	
	# Pause game
	ball.pause_ball()
	
	# Award points if player won
	if winner == "Player":
		var reward_points = score_manager.get_reward_points()
		unlock_manager.add_points(reward_points)
		
		# Update high score
		save_manager.update_high_score(difficulty, player_score)
	
	# Record match result
	save_manager.add_match_result(winner == "Player", player_score)
	
	# Show victory/game over screen (will implement later)
	await get_tree().create_timer(2.0).timeout
	
	if winner == "Player":
		get_tree().change_scene_to_file("res://scenes/victory_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
