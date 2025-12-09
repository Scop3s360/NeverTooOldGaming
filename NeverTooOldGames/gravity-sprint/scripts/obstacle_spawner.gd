class_name ObstacleSpawner
extends Node

## Spawns obstacles procedurally

const Obstacle = preload("res://scripts/obstacle.gd")

const SPAWN_X = 2000.0  # Spawn off-screen right
const FLOOR_Y = 950.0
const CEILING_Y = 130.0

var spawn_timer: float = 0.0
var spawn_interval: float = 3.0
var current_speed: float = 400.0
var game_node: Node = null

# Spawn patterns
enum Pattern { SINGLE_FLOOR, SINGLE_CEILING, ALTERNATING, COMBO }
var current_pattern: Pattern = Pattern.SINGLE_FLOOR
var pattern_count: int = 0

func initialize(game: Node) -> void:
	"""Initialize spawner with game reference"""
	game_node = game

func _process(delta: float) -> void:
	if not game_node:
		return
	
	spawn_timer += delta
	
	if spawn_timer >= spawn_interval:
		spawn_obstacle()
		spawn_timer = 0.0

func spawn_obstacle() -> void:
	"""Spawn an obstacle based on current pattern"""
	var obstacle = create_obstacle()
	
	match current_pattern:
		Pattern.SINGLE_FLOOR:
			obstacle.set_obstacle_type(Obstacle.ObstacleType.FLOOR_BLOCK)
			obstacle.position = Vector2(SPAWN_X, FLOOR_Y)
			next_pattern()
		
		Pattern.SINGLE_CEILING:
			obstacle.set_obstacle_type(Obstacle.ObstacleType.CEILING_BLOCK)
			obstacle.position = Vector2(SPAWN_X, CEILING_Y)
			next_pattern()
		
		Pattern.ALTERNATING:
			if pattern_count % 2 == 0:
				obstacle.set_obstacle_type(Obstacle.ObstacleType.FLOOR_BLOCK)
				obstacle.position = Vector2(SPAWN_X, FLOOR_Y)
			else:
				obstacle.set_obstacle_type(Obstacle.ObstacleType.CEILING_BLOCK)
				obstacle.position = Vector2(SPAWN_X, CEILING_Y)
			
			pattern_count += 1
			if pattern_count >= 4:
				next_pattern()
		
		Pattern.COMBO:
			# Spawn both floor and ceiling
			var floor_obs = create_obstacle()
			floor_obs.set_obstacle_type(Obstacle.ObstacleType.FLOOR_BLOCK)
			floor_obs.position = Vector2(SPAWN_X, FLOOR_Y)
			floor_obs.set_scroll_speed(current_speed)
			game_node.add_child(floor_obs)
			
			obstacle.set_obstacle_type(Obstacle.ObstacleType.CEILING_BLOCK)
			obstacle.position = Vector2(SPAWN_X + 150, CEILING_Y)
			next_pattern()
	
	obstacle.set_scroll_speed(current_speed)
	game_node.add_child(obstacle)

func create_obstacle() -> Obstacle:
	"""Create a new obstacle instance"""
	var obs = Obstacle.new()
	return obs

func next_pattern() -> void:
	"""Move to next spawn pattern"""
	current_pattern = (current_pattern + 1) % 4
	pattern_count = 0

func set_spawn_interval(interval: float) -> void:
	"""Set time between spawns"""
	spawn_interval = interval

func set_scroll_speed(speed: float) -> void:
	"""Set obstacle scroll speed"""
	current_speed = speed

func clear_obstacles() -> void:
	"""Remove all obstacles"""
	if game_node:
		for child in game_node.get_children():
			if child is Obstacle:
				child.queue_free()
