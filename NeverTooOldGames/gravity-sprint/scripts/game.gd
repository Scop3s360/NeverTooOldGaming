extends Node2D

## Main game controller for Gravity Sprint

const Player = preload("res://scripts/player.gd")
const ObstacleSpawner = preload("res://scripts/obstacle_spawner.gd")
const DifficultyManager = preload("res://scripts/difficulty_manager.gd")
const ScoreManager = preload("res://scripts/score_manager.gd")
const SaveManager = preload("res://scripts/save_manager.gd")
const UnlockManager = preload("res://scripts/unlock_manager.gd")

var player: Player
var obstacle_spawner: ObstacleSpawner
var difficulty_manager: DifficultyManager
var score_manager: ScoreManager
var save_manager: SaveManager
var unlock_manager: UnlockManager

var game_mode: String = "endless"  # endless or challenge
var challenge_level: int = 0

var score_label: Label
var distance_label: Label
var is_paused: bool = false

func _ready() -> void:
	# Get game settings
	game_mode = get_tree().root.get_meta("game_mode", "endless")
	challenge_level = get_tree().root.get_meta("challenge_level", 0)
	
	# Initialize managers
	difficulty_manager = DifficultyManager.new()
	add_child(difficulty_manager)
	difficulty_manager.initialize(game_mode == "endless", challenge_level)
	difficulty_manager.speed_changed.connect(_on_speed_changed)
	
	score_manager = ScoreManager.new()
	add_child(score_manager)
	score_manager.score_changed.connect(_on_score_changed)
	score_manager.distance_changed.connect(_on_distance_changed)
	
	save_manager = SaveManager.new()
	add_child(save_manager)
	
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)
	
	# Create player
	player = Player.new()
	add_child(player)
	player.gravity_flipped.connect(_on_gravity_flipped)
	player.player_died.connect(_on_player_died)
	
	# Create obstacle spawner
	obstacle_spawner = ObstacleSpawner.new()
	add_child(obstacle_spawner)
	obstacle_spawner.initialize(self)
	obstacle_spawner.set_scroll_speed(difficulty_manager.get_current_speed())
	obstacle_spawner.set_spawn_interval(difficulty_manager.get_obstacle_spawn_interval())
	
	# Create boundaries
	create_boundaries()
	
	# Create UI
	create_ui()
	
	print("Gravity Sprint - Game Start! Mode: %s" % game_mode)

func create_boundaries() -> void:
	"""Create floor and ceiling boundaries"""
	# Floor
	var floor = StaticBody2D.new()
	var floor_collision = CollisionShape2D.new()
	var floor_shape = RectangleShape2D.new()
	floor_shape.size = Vector2(2000, 20)
	floor_collision.shape = floor_shape
	floor_collision.position = Vector2(1000, 1070)
	floor.add_child(floor_collision)
	
	var floor_visual = ColorRect.new()
	floor_visual.size = Vector2(2000, 20)
	floor_visual.position = Vector2(0, 1060)
	floor_visual.color = Color.WHITE
	floor.add_child(floor_visual)
	add_child(floor)
	
	# Ceiling
	var ceiling = StaticBody2D.new()
	var ceiling_collision = CollisionShape2D.new()
	var ceiling_shape = RectangleShape2D.new()
	ceiling_shape.size = Vector2(2000, 20)
	ceiling_collision.shape = ceiling_shape
	ceiling_collision.position = Vector2(1000, 10)
	ceiling.add_child(ceiling_collision)
	
	var ceiling_visual = ColorRect.new()
	ceiling_visual.size = Vector2(2000, 20)
	ceiling_visual.position = Vector2(0, 0)
	ceiling_visual.color = Color.WHITE
	ceiling.add_child(ceiling_visual)
	add_child(ceiling)

func create_ui() -> void:
	"""Create game UI"""
	var canvas = CanvasLayer.new()
	add_child(canvas)
	
	# Score
	score_label = Label.new()
	score_label.position = Vector2(1700, 20)
	score_label.add_theme_font_size_override("font_size", 36)
	score_label.text = "Score: 0"
	canvas.add_child(score_label)
	
	# Distance
	distance_label = Label.new()
	distance_label.position = Vector2(50, 20)
	distance_label.add_theme_font_size_override("font_size", 36)
	distance_label.text = "Distance: 0m"
	canvas.add_child(distance_label)

func _process(delta: float) -> void:
	if is_paused or not player.is_alive:
		return
	
	# Add distance based on speed
	var distance_delta = difficulty_manager.get_current_speed() * delta
	score_manager.add_distance(distance_delta)
	
	# Update score multiplier
	score_manager.set_speed_multiplier(difficulty_manager.get_speed_multiplier())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
	elif event.is_action_pressed("quick_restart") and not player.is_alive:
		restart_game()

func toggle_pause() -> void:
	is_paused = not is_paused
	get_tree().paused = is_paused
	print("Paused" if is_paused else "Resumed")

func restart_game() -> void:
	get_tree().reload_current_scene()

func _on_gravity_flipped() -> void:
	score_manager.add_flip()

func _on_player_died() -> void:
	print("Game Over! Final Score: %d, Distance: %dm" % [score_manager.get_score(), score_manager.get_distance()])
	
	# Save stats
	save_manager.add_run_stats(score_manager.get_distance(), score_manager.get_flips())
	
	# Check high score
	if game_mode == "endless":
		var is_new_high = save_manager.update_high_score(score_manager.get_score())
		if is_new_high:
			print("New High Score!")
		
		# Award points (distance / 10)
		var points = score_manager.get_distance() / 10
		unlock_manager.add_points(points)
	else:
		# Challenge mode - record time
		save_manager.update_challenge_time(challenge_level, score_manager.get_time())
		
		# Unlock next level
		if challenge_level < 9:
			unlock_manager.unlock_challenge_level(challenge_level + 1)
	
	# Store final stats for game over screen
	get_tree().root.set_meta("final_score", score_manager.get_score())
	get_tree().root.set_meta("final_distance", score_manager.get_distance())
	get_tree().root.set_meta("final_time", score_manager.get_time())
	
	# Go to game over screen
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_speed_changed(new_speed: float) -> void:
	obstacle_spawner.set_scroll_speed(new_speed)
	obstacle_spawner.set_spawn_interval(difficulty_manager.get_obstacle_spawn_interval())

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: %d" % new_score

func _on_distance_changed(new_distance: int) -> void:
	distance_label.text = "Distance: %dm" % new_distance
