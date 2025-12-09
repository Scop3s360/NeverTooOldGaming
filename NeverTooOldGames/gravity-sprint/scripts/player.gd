class_name Player
extends CharacterBody2D

## Player with gravity flip mechanic

signal gravity_flipped
signal player_died

enum GravityState { FLOOR, CEILING }

const PLAYER_SIZE = 40.0
const GRAVITY = 980.0
const FLIP_TRANSITION_TIME = 0.2
const SCREEN_HEIGHT = 1080.0
const FLOOR_Y = 950.0  # Y position when on floor
const CEILING_Y = 130.0  # Y position when on ceiling

var current_state: GravityState = GravityState.FLOOR
var is_flipping: bool = false
var flip_progress: float = 0.0
var is_alive: bool = true

func _ready() -> void:
	# Set up collision
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(PLAYER_SIZE, PLAYER_SIZE)
	collision.shape = shape
	add_child(collision)
	
	# Set up visual
	var visual = ColorRect.new()
	visual.size = Vector2(PLAYER_SIZE, PLAYER_SIZE)
	visual.position = Vector2(-PLAYER_SIZE / 2, -PLAYER_SIZE / 2)
	visual.color = Color.CYAN
	add_child(visual)
	
	# Start on floor
	position = Vector2(200, FLOOR_Y)

func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	# Handle gravity flip input
	if Input.is_action_just_pressed("flip_gravity") and not is_flipping:
		flip_gravity()
	
	# Handle flipping transition
	if is_flipping:
		flip_progress += delta / FLIP_TRANSITION_TIME
		
		if flip_progress >= 1.0:
			flip_progress = 1.0
			is_flipping = false
		
		# Lerp between positions
		if current_state == GravityState.CEILING:
			position.y = lerp(FLOOR_Y, CEILING_Y, flip_progress)
		else:
			position.y = lerp(CEILING_Y, FLOOR_Y, flip_progress)
	else:
		# Apply gravity when not flipping
		if current_state == GravityState.FLOOR:
			velocity.y = GRAVITY * delta
			position.y = min(position.y + velocity.y, FLOOR_Y)
		else:
			velocity.y = -GRAVITY * delta
			position.y = max(position.y + velocity.y, CEILING_Y)
	
	# Move and check collisions
	var collision = move_and_collide(Vector2.ZERO)  # Just for collision detection
	if collision:
		die()

func flip_gravity() -> void:
	"""Flip between floor and ceiling"""
	if current_state == GravityState.FLOOR:
		current_state = GravityState.CEILING
	else:
		current_state = GravityState.FLOOR
	
	is_flipping = true
	flip_progress = 0.0
	gravity_flipped.emit()
	print("Gravity flipped to: ", "CEILING" if current_state == GravityState.CEILING else "FLOOR")

func die() -> void:
	"""Handle player death"""
	if not is_alive:
		return
	
	is_alive = false
	player_died.emit()
	print("Player died!")

func reset() -> void:
	"""Reset player to starting state"""
	is_alive = true
	current_state = GravityState.FLOOR
	is_flipping = false
	flip_progress = 0.0
	position = Vector2(200, FLOOR_Y)
	velocity = Vector2.ZERO
