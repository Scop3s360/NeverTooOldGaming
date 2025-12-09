class_name Paddle
extends CharacterBody2D

## Paddle with momentum-based movement

signal scored_on  # Emitted when ball passes this paddle

@export var is_player: bool = true
@export var is_player_two: bool = false  # For local multiplayer
@export var paddle_side: String = "left"  # "left" or "right"

const PADDLE_HEIGHT = 100.0
const PADDLE_WIDTH = 20.0
const SCREEN_HEIGHT = 1080.0
const PADDLE_OFFSET = 50.0  # Distance from screen edge

var momentum_manager: MomentumManager
var control_type: String = "mouse"  # "mouse" or "keyboard"
var target_y: float = 0.0

func _ready() -> void:
	# Create momentum manager
	momentum_manager = MomentumManager.new()
	add_child(momentum_manager)
	
	# Set up collision shape
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(PADDLE_WIDTH, PADDLE_HEIGHT)
	collision.shape = shape
	add_child(collision)
	
	# Set up visual (simple rectangle for now)
	var visual = ColorRect.new()
	visual.size = Vector2(PADDLE_WIDTH, PADDLE_HEIGHT)
	visual.position = Vector2(-PADDLE_WIDTH / 2, -PADDLE_HEIGHT / 2)
	visual.color = Color.WHITE
	add_child(visual)
	
	# Position paddle
	if paddle_side == "left":
		position.x = PADDLE_OFFSET
	else:
		position.x = 1920 - PADDLE_OFFSET
	
	position.y = SCREEN_HEIGHT / 2
	target_y = position.y

func _physics_process(delta: float) -> void:
	if is_player and not is_player_two:
		handle_player_input(delta)
	elif is_player_two:
		handle_player_two_input(delta)
	
	# Update momentum based on movement
	momentum_manager.update_movement(position.y, delta)
	
	# Move paddle
	move_paddle(delta)

func handle_player_input(delta: float) -> void:
	"""Handle player 1 input (mouse or keyboard)"""
	if control_type == "mouse":
		target_y = get_viewport().get_mouse_position().y
	else:  # keyboard
		if Input.is_action_pressed("move_up"):
			target_y -= momentum_manager.get_current_speed() * delta
		if Input.is_action_pressed("move_down"):
			target_y += momentum_manager.get_current_speed() * delta

func handle_player_two_input(delta: float) -> void:
	"""Handle player 2 input (keyboard only)"""
	if Input.is_action_pressed("p2_move_up"):
		target_y -= momentum_manager.get_current_speed() * delta
	if Input.is_action_pressed("p2_move_down"):
		target_y += momentum_manager.get_current_speed() * delta

func move_paddle(delta: float) -> void:
	"""Move paddle towards target position"""
	var speed = momentum_manager.get_current_speed()
	
	# Move towards target
	var direction = sign(target_y - position.y)
	var distance = abs(target_y - position.y)
	
	if distance > 1.0:  # Only move if not at target
		var move_amount = min(speed * delta, distance)
		position.y += direction * move_amount
	
	# Clamp to screen bounds
	position.y = clamp(position.y, PADDLE_HEIGHT / 2, SCREEN_HEIGHT - PADDLE_HEIGHT / 2)
	target_y = clamp(target_y, PADDLE_HEIGHT / 2, SCREEN_HEIGHT - PADDLE_HEIGHT / 2)

func set_ai_target(y_position: float) -> void:
	"""Set target position for AI control"""
	target_y = y_position

func get_weight_percentage() -> float:
	"""Get current weight as percentage"""
	return momentum_manager.get_weight_percentage()

func reset_momentum() -> void:
	"""Reset paddle momentum"""
	momentum_manager.reset_weight()

func set_control_type(type: String) -> void:
	"""Set control type (mouse or keyboard)"""
	control_type = type
