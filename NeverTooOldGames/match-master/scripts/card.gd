extends Area2D
class_name Card

## Card class for Match Master
## Handles card flipping, matching, and visual states

signal card_tapped
signal flip_complete

@export var card_id: int = 0  # ID for matching (same ID = matching pair)
@export var card_design: Texture2D  # Face artwork
@export var card_back: Texture2D  # Back design

var is_face_up: bool = false
var is_matched: bool = false
var is_animating: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Start face-down
	if card_back:
		sprite.texture = card_back
		scale_sprite_to_fit()
	
	# Connect input
	input_event.connect(_on_input_event)

func scale_sprite_to_fit() -> void:
	"""Scale sprite to fit card size (100x140 pixels)"""
	if not sprite.texture:
		return
	
	var texture_size = sprite.texture.get_size()
	var target_size = Vector2(100, 140)
	
	# Calculate scale to fit within target size while maintaining aspect ratio
	var scale_x = target_size.x / texture_size.x
	var scale_y = target_size.y / texture_size.y
	var scale_factor = min(scale_x, scale_y)
	
	sprite.scale = Vector2(scale_factor, scale_factor)

func can_interact() -> bool:
	"""Check if card can be tapped"""
	return not is_face_up and not is_matched and not is_animating

func flip_up() -> void:
	"""Flip card to show face"""
	if is_animating or is_face_up:
		return
	
	is_animating = true
	is_face_up = true
	
	# Animate flip using tween
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	# Shrink horizontally to 0
	tween.tween_property(sprite, "scale:x", 0.0, 0.15)
	
	# Swap texture at midpoint
	tween.tween_callback(func():
		sprite.texture = card_design
		scale_sprite_to_fit()
	)
	
	# Expand back to normal
	tween.tween_property(sprite, "scale:x", sprite.scale.x, 0.15)
	
	# Finish
	tween.tween_callback(func():
		is_animating = false
		flip_complete.emit()
	)

func flip_down() -> void:
	"""Flip card to show back"""
	if is_animating or not is_face_up or is_matched:
		return
	
	is_animating = true
	is_face_up = false
	
	# Animate flip using tween
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	# Shrink horizontally to 0
	tween.tween_property(sprite, "scale:x", 0.0, 0.15)
	
	# Swap texture at midpoint
	tween.tween_callback(func():
		sprite.texture = card_back
		scale_sprite_to_fit()
	)
	
	# Expand back to normal
	tween.tween_property(sprite, "scale:x", sprite.scale.x, 0.15)
	
	# Finish
	tween.tween_callback(func():
		is_animating = false
		flip_complete.emit()
	)

func mark_as_matched() -> void:
	"""Mark card as successfully matched"""
	is_matched = true
	is_face_up = true
	
	# Get the selected theme to determine effect
	var theme_id = get_parent().unlock_manager.selected_deck if get_parent().has_node("unlock_manager") else 0
	
	if theme_id == 1:  # Neon theme - use lasers
		create_neon_laser_effect()
	else:  # Default - use pixel diffuse
		create_pixel_diffuse_effect()
	
	# Fade out and disappear
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.tween_callback(func(): visible = false)

func create_pixel_diffuse_effect() -> void:
	"""Create retro pixel diffuse particle effect"""
	var particles = CPUParticles2D.new()
	add_child(particles)
	
	# Particle appearance - BIGGER pixel squares
	particles.amount = 40
	particles.lifetime = 1.0
	particles.one_shot = true
	particles.explosiveness = 1.0
	
	# Emission shape - from card center
	particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	particles.emission_sphere_radius = 30.0
	
	# Movement - scatter outward FASTER
	particles.direction = Vector2(0, -1)
	particles.spread = 180.0
	particles.gravity = Vector2(0, 250)
	particles.initial_velocity_min = 200.0
	particles.initial_velocity_max = 350.0
	
	# Appearance - VARIED pixel sizes
	particles.scale_amount_min = 4.0
	particles.scale_amount_max = 20.0
	particles.scale_amount_curve = create_random_scale_curve()
	
	# Color - MORE varied retro colors
	var gradient = Gradient.new()
	var start_color = get_random_retro_color()
	var mid_color = get_random_retro_color()
	var end_color = get_random_retro_color()
	gradient.add_point(0.0, start_color)
	gradient.add_point(0.5, mid_color)
	gradient.add_point(1.0, Color(end_color.r, end_color.g, end_color.b, 0))  # Fade out
	particles.color_ramp = gradient
	
	# Start emitting
	particles.emitting = true
	
	# Clean up after animation
	await get_tree().create_timer(1.0).timeout
	particles.queue_free()

func get_random_retro_color() -> Color:
	"""Get a random bright retro color"""
	var colors = [
		Color(1, 0.2, 0.2),   # Red
		Color(1, 0.5, 0.2),   # Orange
		Color(1, 1, 0.2),     # Yellow
		Color(0.2, 1, 0.2),   # Green
		Color(0.2, 0.5, 1),   # Blue
		Color(0.5, 0.2, 1),   # Purple
		Color(1, 0.2, 1),     # Magenta
		Color(0.2, 1, 1),     # Cyan
		Color(1, 0.7, 0.2),   # Gold
		Color(1, 0.2, 0.5),   # Pink
	]
	return colors[randi() % colors.size()]

func create_random_scale_curve() -> Curve:
	"""Create varied particle sizes"""
	var curve = Curve.new()
	curve.add_point(Vector2(0, randf_range(0.5, 1.0)))
	curve.add_point(Vector2(0.5, randf_range(0.8, 1.2)))
	curve.add_point(Vector2(1, randf_range(0.3, 0.7)))
	return curve

func create_neon_laser_effect() -> void:
	"""Create neon laser beam effect for matches"""
	# Create multiple laser beams shooting out
	for i in range(8):
		var laser = Line2D.new()
		add_child(laser)
		
		# Laser appearance
		laser.width = randf_range(2, 5)
		laser.default_color = get_random_neon_color()
		laser.default_color.a = 0.8
		
		# Laser direction (radial from card)
		var angle = (PI * 2 / 8) * i
		var direction = Vector2(cos(angle), sin(angle))
		var length = randf_range(100, 200)
		
		laser.add_point(Vector2.ZERO)
		laser.add_point(direction * length)
		
		# Animate laser
		var tween = create_tween()
		tween.set_parallel(true)
		
		# Fade out
		tween.tween_property(laser, "default_color:a", 0.0, 0.3)
		
		# Extend length
		tween.tween_method(func(val): 
			if laser and laser.get_point_count() > 1:
				laser.set_point_position(1, direction * val)
		, 0.0, length, 0.2)
		
		# Clean up
		tween.tween_callback(func(): 
			if laser:
				laser.queue_free()
		)

func get_random_neon_color() -> Color:
	"""Get a random neon color"""
	var colors = [
		Color(0, 1, 1),      # Cyan
		Color(1, 0, 1),      # Magenta
		Color(0, 1, 0.5),    # Neon green
		Color(1, 0.5, 0),    # Neon orange
		Color(0.5, 0, 1),    # Purple
		Color(1, 1, 0),      # Yellow
	]
	return colors[randi() % colors.size()]

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	"""Handle tap/click on card"""
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if can_interact():
				card_tapped.emit()

func _on_animation_finished(anim_name: String) -> void:
	"""Called when animation completes"""
	is_animating = false
	
	# Update texture based on final state
	if is_face_up:
		sprite.texture = card_design
	else:
		sprite.texture = card_back
	
	scale_sprite_to_fit()
	flip_complete.emit()
