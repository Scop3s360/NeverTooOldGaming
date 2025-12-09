class_name Obstacle
extends StaticBody2D

## Base obstacle class

enum ObstacleType { FLOOR_BLOCK, CEILING_BLOCK, SPIKE_FLOOR, SPIKE_CEILING }

var obstacle_type: ObstacleType = ObstacleType.FLOOR_BLOCK
var scroll_speed: float = 400.0

const OBSTACLE_WIDTH = 60.0
const OBSTACLE_HEIGHT = 60.0

func _ready() -> void:
	# Set up collision
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(OBSTACLE_WIDTH, OBSTACLE_HEIGHT)
	collision.shape = shape
	add_child(collision)
	
	# Set up visual based on type
	create_visual()

func create_visual() -> void:
	"""Create visual representation"""
	var visual = ColorRect.new()
	visual.size = Vector2(OBSTACLE_WIDTH, OBSTACLE_HEIGHT)
	visual.position = Vector2(-OBSTACLE_WIDTH / 2, -OBSTACLE_HEIGHT / 2)
	
	match obstacle_type:
		ObstacleType.FLOOR_BLOCK:
			visual.color = Color.RED
		ObstacleType.CEILING_BLOCK:
			visual.color = Color.ORANGE_RED
		ObstacleType.SPIKE_FLOOR:
			visual.color = Color.DARK_RED
		ObstacleType.SPIKE_CEILING:
			visual.color = Color.DARK_ORANGE
	
	add_child(visual)

func _process(delta: float) -> void:
	# Move left
	position.x -= scroll_speed * delta
	
	# Remove if off screen
	if position.x < -100:
		queue_free()

func set_scroll_speed(speed: float) -> void:
	"""Set the scrolling speed"""
	scroll_speed = speed

func set_obstacle_type(type: ObstacleType) -> void:
	"""Set obstacle type"""
	obstacle_type = type
