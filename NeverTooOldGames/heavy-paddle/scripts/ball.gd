class_name Ball
extends CharacterBody2D

## Ball with physics and collision

signal ball_hit_paddle(paddle: Paddle, hit_position: float)
signal ball_out_of_bounds(side: String)  # "left" or "right"

const BALL_SIZE = 20.0
const INITIAL_SPEED = 400.0
const MAX_SPEED = 700.0
const SPEED_INCREASE = 30.0  # Speed increase per hit
const MAX_BOUNCE_ANGLE = 60.0  # Maximum bounce angle in degrees

const SCREEN_WIDTH = 1920.0
const SCREEN_HEIGHT = 1080.0

var current_speed: float = INITIAL_SPEED
var direction: Vector2 = Vector2.ZERO
var hit_count: int = 0

func _ready() -> void:
	# Set up collision shape
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	shape.radius = BALL_SIZE / 2
	collision.shape = shape
	add_child(collision)
	
	# Set up visual
	var visual = ColorRect.new()
	visual.size = Vector2(BALL_SIZE, BALL_SIZE)
	visual.position = Vector2(-BALL_SIZE / 2, -BALL_SIZE / 2)
	visual.color = Color.WHITE
	add_child(visual)
	
	# Start in center
	reset_ball()

func _physics_process(delta: float) -> void:
	# Move ball
	velocity = direction * current_speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		handle_collision(collision)

func handle_collision(collision: KinematicCollision2D) -> void:
	"""Handle ball collision with paddles or walls"""
	var collider = collision.get_collider()
	
	if collider is Paddle:
		# Hit paddle
		bounce_off_paddle(collider, collision.get_position().y)
		hit_count += 1
		
		# Increase speed every few hits
		if hit_count % 3 == 0:
			current_speed = min(current_speed + SPEED_INCREASE, MAX_SPEED)
			print("Ball speed increased to: ", current_speed)
	else:
		# Hit wall (top or bottom)
		direction = direction.bounce(collision.get_normal())

func bounce_off_paddle(paddle: Paddle, hit_y: float) -> void:
	"""Bounce ball off paddle with angle based on hit position"""
	# Calculate hit position relative to paddle center (-1 to 1)
	var paddle_center_y = paddle.position.y
	var relative_hit = (hit_y - paddle_center_y) / (paddle.PADDLE_HEIGHT / 2)
	relative_hit = clamp(relative_hit, -1.0, 1.0)
	
	# Calculate bounce angle
	var bounce_angle = relative_hit * MAX_BOUNCE_ANGLE
	var angle_rad = deg_to_rad(bounce_angle)
	
	# Determine horizontal direction based on which paddle was hit
	var horizontal_dir = 1.0 if paddle.paddle_side == "left" else -1.0
	
	# Set new direction
	direction = Vector2(horizontal_dir * cos(angle_rad), sin(angle_rad)).normalized()
	
	ball_hit_paddle.emit(paddle, relative_hit)
	print("Ball hit paddle at position: ", relative_hit)

func _process(_delta: float) -> void:
	# Check if ball went out of bounds
	if position.x < -BALL_SIZE:
		ball_out_of_bounds.emit("left")
		reset_ball()
	elif position.x > SCREEN_WIDTH + BALL_SIZE:
		ball_out_of_bounds.emit("right")
		reset_ball()

func reset_ball(serve_to_left: bool = true) -> void:
	"""Reset ball to center with random direction"""
	position = Vector2(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
	current_speed = INITIAL_SPEED
	hit_count = 0
	
	# Random vertical angle
	var angle = randf_range(-30.0, 30.0)
	var angle_rad = deg_to_rad(angle)
	
	# Serve in specified direction
	var horizontal_dir = 1.0 if serve_to_left else -1.0
	direction = Vector2(horizontal_dir * cos(angle_rad), sin(angle_rad)).normalized()
	
	print("Ball reset, serving ", "left" if serve_to_left else "right")

func pause_ball() -> void:
	"""Stop ball movement"""
	set_physics_process(false)

func resume_ball() -> void:
	"""Resume ball movement"""
	set_physics_process(true)
