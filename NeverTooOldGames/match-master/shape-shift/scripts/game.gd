extends Node2D

## Main game controller for Shape Shift

@onready var container: StaticBody2D = $Container
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var next_shape_preview: Control = $CanvasLayer/NextShapePreview
@onready var gravity_button: Button = $CanvasLayer/GravityButton
@onready var pause_button: Button = $CanvasLayer/PauseButton
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
@onready var game_over_screen: Control = $CanvasLayer/GameOverScreen
@onready var death_line: Line2D = $DeathLine
@onready var next_shape_display: Polygon2D = $CanvasLayer/NextShapePreview/ShapeDisplay
@onready var gravity_indicator: Label = $CanvasLayer/GravityIndicator

const Shape = preload("res://scenes/shape.tscn")
const SAVE_PATH = "user://shape_shift_save.json"

var score: int = 0
var high_score: int = 0
var next_shape_type: int = 0
var current_shape: RigidBody2D = null
var gravity_rotation: int = 0
var is_paused: bool = false
var is_game_over: bool = false
var drop_pointer: Line2D
var drop_position: Vector2
var mouse_held: bool = false
var drop_timer: float = 0.0
const DROP_RATE: float = 0.15

func _ready() -> void:
	randomize()
	load_high_score()
	
	# Increase gravity for faster drops
	PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY, 3000.0)
	
	# Create drop pointer
	create_drop_pointer()
	
	generate_next_shape()
	update_score_display()
	update_gravity_indicator()
	
	# Connect buttons
	gravity_button.pressed.connect(_on_gravity_flip_pressed)
	pause_button.pressed.connect(_on_pause_pressed)
	
	# Hide menus
	pause_menu.visible = false
	game_over_screen.visible = false
	
	# Spawn first shape
	spawn_shape()

func _input(event: InputEvent) -> void:
	if is_game_over or is_paused:
		return
	
	# Update drop position based on mouse
	if event is InputEventMouseMotion:
		update_drop_position(get_global_mouse_position())
	
	# Handle mouse clicks
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			mouse_held = true
			drop_timer = 0.0
			try_drop()
		else:
			mouse_held = false

func update_drop_position(mouse_pos: Vector2) -> void:
	match gravity_rotation:
		0:  # Down
			drop_position.x = clamp(mouse_pos.x, 100, 620)
			drop_position.y = 150
		1:  # Right
			drop_position.x = 100
			drop_position.y = clamp(mouse_pos.y, 200, 1100)
		2:  # Left
			drop_position.x = 620
			drop_position.y = clamp(mouse_pos.y, 200, 1100)
	
	if current_shape and is_instance_valid(current_shape):
		current_shape.global_position = drop_position
	
	update_drop_pointer()

func generate_next_shape() -> void:
	"""Generate the next shape type (weighted towards smaller shapes)"""
	var rand = randf()
	if rand < 0.4:
		next_shape_type = 0  # Circle (40%)
	elif rand < 0.7:
		next_shape_type = 1  # Triangle (30%)
	elif rand < 0.9:
		next_shape_type = 2  # Square (20%)
	else:
		next_shape_type = 3  # Pentagon (10%)

func create_drop_pointer() -> void:
	"""Create visual pointer for drop location"""
	drop_pointer = Line2D.new()
	drop_pointer.width = 3.0
	drop_pointer.default_color = Color(1, 1, 1, 0.8)
	add_child(drop_pointer)
	
	# Initialize drop position
	match gravity_rotation:
		0:  # Down
			drop_position = Vector2(360, 150)
		1:  # Right
			drop_position = Vector2(100, 640)
		2:  # Left
			drop_position = Vector2(620, 640)
	
	update_drop_pointer()

func update_drop_pointer() -> void:
	"""Update the drop pointer visual"""
	if not drop_pointer:
		return
	
	drop_pointer.clear_points()
	
	match gravity_rotation:
		0:  # Down - vertical line
			drop_pointer.add_point(Vector2(drop_position.x, 100))
			drop_pointer.add_point(Vector2(drop_position.x, 200))
		1:  # Right - horizontal line
			drop_pointer.add_point(Vector2(50, drop_position.y))
			drop_pointer.add_point(Vector2(150, drop_position.y))
		2:  # Left - horizontal line
			drop_pointer.add_point(Vector2(570, drop_position.y))
			drop_pointer.add_point(Vector2(670, drop_position.y))

func try_drop() -> void:
	if not current_shape or is_game_over:
		return
	
	# Release the shape
	current_shape.freeze = false
	current_shape = null
	
	# Spawn next immediately
	call_deferred("spawn_shape")

func spawn_shape() -> void:
	if current_shape or is_game_over:
		return
	
	current_shape = Shape.instantiate()
	current_shape.shape_type = next_shape_type
	current_shape.global_position = drop_position
	current_shape.freeze = true
	add_child(current_shape)
	current_shape.merged.connect(_on_shape_merged)
	
	generate_next_shape()
	update_next_shape_preview()

func _on_shape_merged(shape_type: int, position: Vector2) -> void:
	"""Handle shape merge"""
	var points = (shape_type + 1) * 10
	
	# Bonus for Supernova explosion
	if shape_type == 7:
		points = 500  # Massive bonus for Supernova explosion!
		print("💥 SUPERNOVA EXPLOSION! +", points, " points!")
	
	score += points
	update_score_display()
	
	print("Shape merged! Type: ", shape_type, " Points: ", points)

func update_score_display() -> void:
	score_label.text = "Score: " + str(score)

func _on_gravity_flip_pressed() -> void:
	"""Rotate gravity direction (skip up)"""
	if is_game_over or score < 50:  # Costs 50 points
		return
	
	score -= 50
	update_score_display()
	
	# Cycle through: 0 (down) -> 1 (right) -> 2 (left) -> 0 (down)
	gravity_rotation = (gravity_rotation + 1) % 3
	
	match gravity_rotation:
		0:  # Down
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
		1:  # Right
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.RIGHT)
		2:  # Left
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.LEFT)
	
	# Respawn current shape at new position
	if current_shape:
		var old_type = current_shape.shape_type
		current_shape.queue_free()
		current_shape = null
		
		current_shape = Shape.instantiate()
		current_shape.shape_type = old_type
		current_shape.global_position = drop_position
		current_shape.freeze = true
		add_child(current_shape)
		current_shape.merged.connect(_on_shape_merged)
	
	update_gravity_indicator()
	print("Gravity rotated to: ", gravity_rotation)

func update_next_shape_preview() -> void:
	"""Update the preview of the next shape"""
	if not next_shape_display:
		return
	
	# Generate shape points for preview
	var points = generate_preview_shape_points(next_shape_type)
	next_shape_display.polygon = points
	
	# Set color based on shape type
	var colors = [
		Color(0, 1, 1),      # Cyan
		Color(1, 0, 1),      # Magenta
		Color(0, 1, 0.5),    # Neon Green
		Color(1, 0.5, 0),    # Orange
	]
	next_shape_display.color = colors[next_shape_type]

func generate_preview_shape_points(type: int) -> PackedVector2Array:
	"""Generate polygon points for preview shape"""
	var points = PackedVector2Array()
	var radius = 30.0
	
	match type:
		0:  # Circle
			for i in range(8):
				var angle = (PI * 2 / 8) * i
				points.append(Vector2(cos(angle), sin(angle)) * radius)
		1:  # Triangle
			for i in range(3):
				var angle = (PI * 2 / 3) * i - PI/2
				points.append(Vector2(cos(angle), sin(angle)) * radius)
		2:  # Square
			points.append(Vector2(-radius, -radius))
			points.append(Vector2(radius, -radius))
			points.append(Vector2(radius, radius))
			points.append(Vector2(-radius, radius))
		3:  # Pentagon
			for i in range(5):
				var angle = (PI * 2 / 5) * i - PI/2
				points.append(Vector2(cos(angle), sin(angle)) * radius)
	
	return points

func update_gravity_indicator() -> void:
	"""Update the gravity direction indicator"""
	if not gravity_indicator:
		return
	
	match gravity_rotation:
		0:  # Down
			gravity_indicator.text = "⬇"
		1:  # Right
			gravity_indicator.text = "➡"
		2:  # Left
			gravity_indicator.text = "⬅"

func _on_pause_pressed() -> void:
	"""Toggle pause"""
	is_paused = !is_paused
	pause_menu.visible = is_paused
	get_tree().paused = is_paused

func check_game_over() -> void:
	"""Check if any shapes are above the death line"""
	if is_game_over:
		return
	
	for child in get_children():
		if child is RigidBody2D:
			if child.global_position.y < death_line.global_position.y:
				trigger_game_over()
				return

func trigger_game_over() -> void:
	is_game_over = true
	mouse_held = false
	
	if score > high_score:
		high_score = score
		save_high_score()
	
	game_over_screen.show_game_over(score, high_score)

func load_high_score() -> void:
	"""Load high score from file"""
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var json = JSON.new()
			var parse_result = json.parse(file.get_as_text())
			file.close()
			
			if parse_result == OK:
				var data = json.data
				high_score = data.get("high_score", 0)

func save_high_score() -> void:
	"""Save high score to file"""
	var data = {
		"high_score": high_score
	}
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func _process(delta: float) -> void:
	if is_game_over or is_paused:
		return
	
	check_game_over()
	
	# Auto-drop when holding mouse
	if mouse_held and current_shape:
		drop_timer += delta
		if drop_timer >= DROP_RATE:
			drop_timer = 0.0
			try_drop()
