extends RigidBody2D

## Individual shape object with merge logic

signal merged(shape_type: int, position: Vector2)

@export var shape_type: int = 0  # 0=Circle, 1=Triangle, 2=Square, etc.

@onready var sprite: Polygon2D = $Polygon2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

var points_label: Label

# Shape progression
const SHAPE_NAMES = ["Circle", "Triangle", "Square", "Pentagon", "Hexagon", "Octagon", "Star", "Supernova"]
const SHAPE_COLORS = [
	Color(0, 1, 1),      # Cyan
	Color(1, 0, 1),      # Magenta
	Color(0, 1, 0.5),    # Neon Green
	Color(1, 0.5, 0),    # Orange
	Color(0.5, 0, 1),    # Purple
	Color(1, 1, 0),      # Yellow
	Color(1, 0.2, 0.5),  # Pink
	Color(1, 1, 1),      # White (Supernova)
]

var can_merge: bool = true
var merge_cooldown: float = 0.5

func _ready() -> void:
	setup_shape()
	body_entered.connect(_on_body_entered)
	contact_monitor = true
	max_contacts_reported = 10
	print("Shape created: Type ", shape_type, " at ", global_position)

func setup_shape() -> void:
	"""Setup the shape's appearance and collision"""
	var points = generate_shape_points(shape_type)
	sprite.polygon = points
	collision.polygon = points
	sprite.color = SHAPE_COLORS[shape_type]
	
	# Add glow effect
	sprite.modulate = Color(1, 1, 1, 1)
	
	# Set mass based on shape type with randomization (heavier shapes have more impact)
	# Base mass increases with evolution, but with random variation
	var base_mass = 1.0 + (shape_type * shape_type * 0.5)
	var random_factor = randf_range(0.7, 1.3)  # ±30% variation
	mass = base_mass * random_factor
	
	print("Shape type ", shape_type, " mass: ", mass)
	
	# Add points label
	create_points_label()

func generate_shape_points(type: int) -> PackedVector2Array:
	"""Generate polygon points for shape type"""
	var points = PackedVector2Array()
	var radius = 35.0 + (type * 8.0)  # Shapes get bigger as they evolve (INCREASED SIZE)
	
	match type:
		0:  # Circle (approximated with octagon)
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
		4:  # Hexagon
			for i in range(6):
				var angle = (PI * 2 / 6) * i
				points.append(Vector2(cos(angle), sin(angle)) * radius)
		5:  # Octagon
			for i in range(8):
				var angle = (PI * 2 / 8) * i
				points.append(Vector2(cos(angle), sin(angle)) * radius)
		6:  # Star
			for i in range(10):
				var angle = (PI * 2 / 10) * i
				var r = radius if i % 2 == 0 else radius * 0.5
				points.append(Vector2(cos(angle), sin(angle)) * r)
		7:  # Supernova (complex star)
			for i in range(16):
				var angle = (PI * 2 / 16) * i
				var r = radius if i % 2 == 0 else radius * 0.6
				points.append(Vector2(cos(angle), sin(angle)) * r)
	
	return points

func _on_body_entered(body: Node) -> void:
	"""Handle collision with another shape"""
	print("Collision detected! This: ", shape_type, " Other: ", body.name)
	
	if not can_merge:
		print("Cannot merge - cooldown active")
		return
	
	if body is RigidBody2D and body.has_method("get_shape_type"):
		var other_shape_type = body.get_shape_type()
		print("Other shape type: ", other_shape_type, " My type: ", shape_type)
		
		# Can only merge with same type
		if other_shape_type == shape_type:
			if shape_type == 7:  # Two Supernovas colliding!
				print("SUPERNOVA EXPLOSION!")
				await get_tree().create_timer(0.1).timeout
				if is_instance_valid(body) and is_instance_valid(self):
					supernova_explosion(body)
			elif shape_type < 7:  # Normal merge
				print("MERGING!")
				await get_tree().create_timer(0.1).timeout
				if is_instance_valid(body) and is_instance_valid(self):
					merge_with(body)
		else:
			print("Types don't match")

func get_shape_type() -> int:
	return shape_type

func create_points_label() -> void:
	"""Create label showing point value inside shape"""
	points_label = Label.new()
	add_child(points_label)
	
	# Calculate points (same as game.gd logic)
	var point_value = (shape_type + 1) * 10
	if shape_type == 7:  # Supernova explosion
		point_value = 500
	
	points_label.text = str(point_value)
	points_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	points_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
	# Style the label
	points_label.add_theme_font_size_override("font_size", 20 + (shape_type * 2))
	points_label.add_theme_color_override("font_color", Color(0, 0, 0, 0.8))
	points_label.add_theme_color_override("font_outline_color", Color(1, 1, 1, 1))
	points_label.add_theme_constant_override("outline_size", 2)
	
	# Center the label
	var radius = 35.0 + (shape_type * 8.0)
	points_label.position = Vector2(-radius/2, -radius/2)
	points_label.size = Vector2(radius, radius)

func merge_with(other: RigidBody2D) -> void:
	"""Merge with another shape"""
	if not can_merge or not other.has_method("can_merge_check"):
		return
	
	if not other.can_merge_check():
		return
	
	# Prevent both from merging again
	can_merge = false
	other.set("can_merge", false)
	
	# Calculate merge position (midpoint)
	var merge_pos = (global_position + other.global_position) / 2
	
	# Create merge effect first
	create_merge_effect(merge_pos)
	
	# Create new evolved shape
	var new_shape = load("res://scenes/shape.tscn").instantiate()
	new_shape.shape_type = shape_type + 1
	new_shape.global_position = merge_pos
	
	# Connect the merged signal to the game
	if get_parent().has_method("_on_shape_merged"):
		new_shape.merged.connect(get_parent()._on_shape_merged)
	
	get_parent().call_deferred("add_child", new_shape)
	
	# Emit signal for scoring
	merged.emit(shape_type + 1, merge_pos)
	
	print("Merging shapes! Type: ", shape_type, " -> ", shape_type + 1)
	
	# Remove both shapes
	other.queue_free()
	queue_free()

func can_merge_check() -> bool:
	return can_merge

func create_merge_effect(pos: Vector2) -> void:
	"""Create neon shockwave effect"""
	var shockwave = create_shockwave(pos)
	get_parent().add_child(shockwave)
	
	# Check for nearby shapes to trigger chain reactions
	trigger_nearby_merges(pos)

func create_shockwave(pos: Vector2) -> Node2D:
	"""Create visual shockwave effect"""
	var wave = Node2D.new()
	wave.global_position = pos
	
	# Create expanding circle
	var circle = Line2D.new()
	circle.width = 3.0
	circle.default_color = SHAPE_COLORS[shape_type]
	circle.default_color.a = 0.8
	
	# Generate circle points
	var points = PackedVector2Array()
	for i in range(32):
		var angle = (PI * 2 / 32) * i
		points.append(Vector2(cos(angle), sin(angle)) * 10)
	points.append(points[0])  # Close the circle
	circle.points = points
	
	wave.add_child(circle)
	
	# Animate expansion and fade
	var tween = wave.create_tween()
	tween.set_parallel(true)
	tween.tween_property(circle, "width", 1.0, 0.5)
	tween.tween_property(circle, "default_color:a", 0.0, 0.5)
	tween.tween_method(func(scale_val):
		var scaled_points = PackedVector2Array()
		for point in points:
			scaled_points.append(point * scale_val)
		if circle:
			circle.points = scaled_points
	, 1.0, 5.0, 0.5)
	
	tween.tween_callback(func(): wave.queue_free())
	
	return wave

func trigger_nearby_merges(pos: Vector2) -> void:
	"""Check for shapes near the merge position and nudge them"""
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsShapeQueryParameters2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 100.0
	query.shape = circle_shape
	query.transform = Transform2D(0, pos)
	query.collide_with_bodies = true
	
	var results = space_state.intersect_shape(query, 10)
	
	for result in results:
		var body = result.collider
		if body is RigidBody2D and body != self:
			# Apply impulse towards merge point (creates clustering effect)
			var direction = (pos - body.global_position).normalized()
			body.apply_central_impulse(direction * 50)

func supernova_explosion(other: RigidBody2D) -> void:
	"""Create massive explosion when two Supernovas collide"""
	if not can_merge or not other.has_method("can_merge_check"):
		return
	
	if not other.can_merge_check():
		return
	
	# Prevent both from exploding again
	can_merge = false
	other.set("can_merge", false)
	
	# Calculate explosion center
	var explosion_pos = (global_position + other.global_position) / 2
	
	# Create massive visual explosion effect
	create_supernova_explosion_effect(explosion_pos)
	
	# Apply massive impulse to ALL shapes in the container
	launch_all_shapes(explosion_pos)
	
	# Award bonus points
	merged.emit(7, explosion_pos)  # Supernova explosion bonus
	
	print("💥 SUPERNOVA EXPLOSION! All shapes launched!")
	
	# Remove both supernovas
	other.queue_free()
	queue_free()

func create_supernova_explosion_effect(pos: Vector2) -> void:
	"""Create massive visual explosion with multiple shockwaves"""
	# Create multiple expanding shockwaves
	for i in range(5):
		await get_tree().create_timer(i * 0.1).timeout
		var wave = create_explosion_wave(pos, i)
		get_parent().add_child(wave)
	
	# Create particle burst
	create_explosion_particles(pos)

func create_explosion_wave(pos: Vector2, wave_index: int) -> Node2D:
	"""Create a single explosion shockwave"""
	var wave = Node2D.new()
	wave.global_position = pos
	
	var circle = Line2D.new()
	circle.width = 5.0 - wave_index
	circle.default_color = Color(1, 1, 1, 0.9)
	
	# Generate circle points
	var points = PackedVector2Array()
	for i in range(32):
		var angle = (PI * 2 / 32) * i
		points.append(Vector2(cos(angle), sin(angle)) * 20)
	points.append(points[0])
	circle.points = points
	
	wave.add_child(circle)
	
	# Animate expansion
	var tween = wave.create_tween()
	tween.set_parallel(true)
	tween.tween_property(circle, "width", 1.0, 0.8)
	tween.tween_property(circle, "default_color:a", 0.0, 0.8)
	tween.tween_method(func(scale_val):
		var scaled_points = PackedVector2Array()
		for point in points:
			scaled_points.append(point * scale_val)
		if circle:
			circle.points = scaled_points
	, 1.0, 15.0, 0.8)
	
	tween.tween_callback(func(): wave.queue_free())
	
	return wave

func create_explosion_particles(pos: Vector2) -> void:
	"""Create particle burst at explosion center"""
	var particles = CPUParticles2D.new()
	particles.global_position = pos
	get_parent().add_child(particles)
	
	particles.amount = 100
	particles.lifetime = 1.5
	particles.one_shot = true
	particles.explosiveness = 1.0
	particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	particles.emission_sphere_radius = 50.0
	particles.direction = Vector2(0, -1)
	particles.spread = 180.0
	particles.gravity = Vector2(0, 300)
	particles.initial_velocity_min = 300.0
	particles.initial_velocity_max = 600.0
	particles.scale_amount_min = 8.0
	particles.scale_amount_max = 20.0
	
	# Rainbow colors
	var gradient = Gradient.new()
	gradient.add_point(0.0, Color(1, 1, 1))
	gradient.add_point(0.3, Color(1, 0, 1))
	gradient.add_point(0.6, Color(0, 1, 1))
	gradient.add_point(1.0, Color(1, 1, 0, 0))
	particles.color_ramp = gradient
	
	particles.emitting = true
	
	await get_tree().create_timer(2.0).timeout
	particles.queue_free()

func launch_all_shapes(explosion_pos: Vector2) -> void:
	"""Launch all shapes in the container away from explosion"""
	for child in get_parent().get_children():
		if child is RigidBody2D and child != self:
			# Calculate direction away from explosion
			var direction = (child.global_position - explosion_pos).normalized()
			
			# Calculate distance-based force (closer = stronger)
			var distance = child.global_position.distance_to(explosion_pos)
			var force_multiplier = clamp(1000.0 / max(distance, 50.0), 5.0, 30.0)
			
			# Apply massive impulse
			var impulse = direction * force_multiplier * 100
			child.apply_central_impulse(impulse)
			
			# Add random spin
			child.apply_torque_impulse(randf_range(-5000, 5000))
