extends Control

## Victory screen shown when all pairs are matched

signal new_game_pressed
signal retry_pressed
signal quit_pressed

@onready var score_label: Label = $Panel/VBoxContainer/ScoreLabel
@onready var points_earned_label: Label = $Panel/VBoxContainer/PointsEarnedLabel
@onready var attempts_label: Label = $Panel/VBoxContainer/AttemptsLabel
@onready var new_game_button: Button = $Panel/VBoxContainer/NewGameButton
@onready var retry_button: Button = $Panel/VBoxContainer/RetryButton
@onready var quit_button: Button = $Panel/VBoxContainer/QuitButton

func _ready() -> void:
	new_game_button.pressed.connect(_on_new_game_pressed)
	retry_button.pressed.connect(_on_retry_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	# Hide by default
	visible = false

func show_victory(final_score: int = 0, attempts_remaining: int = 0, max_attempts: int = 0) -> void:
	"""Show victory screen with stats"""
	visible = true
	
	score_label.text = "Final Score: " + str(final_score)
	points_earned_label.text = "+" + str(final_score) + " Points Earned!"
	
	if max_attempts > 0:
		attempts_label.text = "Attempts Used: " + str(max_attempts - attempts_remaining) + "/" + str(max_attempts)
	else:
		attempts_label.text = "Perfect! No mistakes!"
	
	# Start fireworks animation
	start_fireworks()

func start_fireworks() -> void:
	"""Create continuous celebration effect based on theme"""
	# Check theme (you'll need to pass this or get it from game)
	var theme_id = 0  # Default to pixel
	if get_tree().root.has_meta("current_theme"):
		theme_id = get_tree().root.get_meta("current_theme")
	
	if theme_id == 1:  # Neon theme - use lasers
		start_neon_lasers()
	else:  # Default - use fireworks
		# Create multiple firework bursts
		for i in range(5):
			await get_tree().create_timer(0.3 * i).timeout
			create_firework_burst(Vector2(randf_range(100, 620), randf_range(200, 400)))
		
		# Continue with random fireworks
		while visible:
			await get_tree().create_timer(randf_range(0.5, 1.0)).timeout
			if visible:
				create_firework_burst(Vector2(randf_range(100, 620), randf_range(200, 500)))

func create_firework_burst(pos: Vector2) -> void:
	"""Create a single pixel firework burst at position"""
	var particles = CPUParticles2D.new()
	add_child(particles)
	particles.position = pos
	particles.z_index = -1  # Behind UI
	
	# Particle settings - BIGGER pixel firework
	particles.amount = 60
	particles.lifetime = 1.5
	particles.one_shot = true
	particles.explosiveness = 1.0
	
	# Emission - burst from center
	particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	particles.emission_sphere_radius = 10.0
	
	# Movement - explode outward BIGGER
	particles.direction = Vector2(0, -1)
	particles.spread = 180.0
	particles.gravity = Vector2(0, 150)
	particles.initial_velocity_min = 250.0
	particles.initial_velocity_max = 400.0
	particles.damping_min = 50.0
	particles.damping_max = 100.0
	
	# Appearance - VARIED pixel sizes
	particles.scale_amount_min = 6.0
	particles.scale_amount_max = 25.0
	particles.scale_amount_curve = create_random_scale_curve()
	
	# MORE varied retro colors with gradients
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
		Color(0.2, 1, 0.5),   # Mint
		Color(1, 1, 1),       # White
	]
	var color1 = colors[randi() % colors.size()]
	var color2 = colors[randi() % colors.size()]
	
	var gradient = Gradient.new()
	gradient.add_point(0.0, color1)
	gradient.add_point(0.5, color2)
	gradient.add_point(1.0, Color(color2.r, color2.g, color2.b, 0))  # Fade out
	particles.color_ramp = gradient
	
	# Start emitting
	particles.emitting = true
	
	# Clean up
	await get_tree().create_timer(1.5).timeout
	particles.queue_free()

func create_random_scale_curve() -> Curve:
	"""Create varied particle sizes"""
	var curve = Curve.new()
	curve.add_point(Vector2(0, randf_range(0.5, 1.0)))
	curve.add_point(Vector2(0.5, randf_range(0.8, 1.3)))
	curve.add_point(Vector2(1, randf_range(0.2, 0.6)))
	return curve

func start_neon_lasers() -> void:
	"""Create continuous neon laser show"""
	# Create initial burst of lasers
	for i in range(10):
		await get_tree().create_timer(0.1 * i).timeout
		create_neon_laser_beam()
	
	# Continue with random lasers
	while visible:
		await get_tree().create_timer(randf_range(0.2, 0.5)).timeout
		if visible:
			create_neon_laser_beam()

func create_neon_laser_beam() -> void:
	"""Create a single neon laser beam across screen"""
	var laser = Line2D.new()
	add_child(laser)
	laser.z_index = -1
	
	# Random laser properties
	laser.width = randf_range(3, 8)
	laser.default_color = get_random_neon_color()
	laser.default_color.a = 0.8
	
	# Random start and end points
	var start_pos = Vector2(randf_range(0, 720), randf_range(0, 1280))
	var end_pos = Vector2(randf_range(0, 720), randf_range(0, 1280))
	
	laser.add_point(start_pos)
	laser.add_point(start_pos)  # Start at same point
	
	# Animate laser
	var tween = create_tween()
	tween.set_parallel(true)
	
	# Extend to end point
	tween.tween_method(func(progress):
		if laser and laser.get_point_count() > 1:
			laser.set_point_position(1, start_pos.lerp(end_pos, progress))
	, 0.0, 1.0, 0.15)
	
	# Pulse width
	tween.tween_property(laser, "width", laser.width * 1.5, 0.1).set_trans(Tween.TRANS_SINE)
	tween.chain().tween_property(laser, "width", laser.width * 0.5, 0.2)
	
	# Fade out
	await get_tree().create_timer(0.3).timeout
	if laser:
		var fade_tween = create_tween()
		fade_tween.tween_property(laser, "default_color:a", 0.0, 0.3)
		fade_tween.tween_callback(func(): 
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
		Color(1, 1, 1),      # White
	]
	return colors[randi() % colors.size()]

func _on_new_game_pressed() -> void:
	new_game_pressed.emit()
	get_tree().change_scene_to_file("res://scenes/mode_select.tscn")

func _on_retry_pressed() -> void:
	retry_pressed.emit()
	# Reload current scene
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	quit_pressed.emit()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
