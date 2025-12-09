class_name AIController
extends Node

## AI controller for opponent paddle

const Paddle = preload("res://scripts/paddle.gd")
const Ball = preload("res://scripts/ball.gd")

@export var difficulty: String = "medium"  # easy, medium, hard, expert

var controlled_paddle: Paddle
var ball: Ball
var target_y: float = 540.0  # Center of screen

# AI parameters by difficulty
var ai_params = {
	"easy": {
		"reaction_time": 0.5,
		"prediction_accuracy": 0.0,
		"weight_management": false,
		"error_margin": 100.0
	},
	"medium": {
		"reaction_time": 0.3,
		"prediction_accuracy": 0.3,
		"weight_management": false,
		"error_margin": 50.0
	},
	"hard": {
		"reaction_time": 0.15,
		"prediction_accuracy": 0.6,
		"weight_management": true,
		"error_margin": 20.0
	},
	"expert": {
		"reaction_time": 0.05,
		"prediction_accuracy": 0.9,
		"weight_management": true,
		"error_margin": 5.0
	}
}

var reaction_timer: float = 0.0
var current_params: Dictionary

func _ready() -> void:
	set_difficulty(difficulty)

func initialize(paddle: Paddle, ball_ref: Ball) -> void:
	"""Initialize AI with paddle and ball references"""
	controlled_paddle = paddle
	ball = ball_ref
	set_difficulty(difficulty)

func set_difficulty(new_difficulty: String) -> void:
	"""Set AI difficulty level"""
	difficulty = new_difficulty
	if difficulty in ai_params:
		current_params = ai_params[difficulty]
	else:
		current_params = ai_params["medium"]
	print("AI difficulty set to: ", difficulty)

func _process(delta: float) -> void:
	if not controlled_paddle or not ball:
		return
	
	# Update reaction timer
	reaction_timer -= delta
	
	# Only update target when reaction timer expires
	if reaction_timer <= 0.0:
		update_target_position()
		reaction_timer = current_params["reaction_time"]
	
	# Apply weight management strategy
	if current_params["weight_management"]:
		apply_weight_management()
	
	# Move paddle towards target
	controlled_paddle.set_ai_target(target_y)

func update_target_position() -> void:
	"""Calculate where AI should move paddle"""
	# Check if ball is moving towards AI paddle
	var ball_moving_towards_ai = false
	if controlled_paddle.paddle_side == "right":
		ball_moving_towards_ai = ball.direction.x > 0
	else:
		ball_moving_towards_ai = ball.direction.x < 0
	
	if not ball_moving_towards_ai:
		# Return to center when ball is moving away
		target_y = 540.0  # Screen center
		return
	
	# Predict ball position
	var predicted_y = predict_ball_position()
	
	# Add error margin based on difficulty
	var error = randf_range(-current_params["error_margin"], current_params["error_margin"])
	target_y = predicted_y + error
	
	# Clamp to screen bounds
	target_y = clamp(target_y, 50.0, 1030.0)

func predict_ball_position() -> float:
	"""Predict where ball will be when it reaches paddle"""
	if not ball:
		return 540.0
	
	# Simple prediction: current position
	var predicted_y = ball.position.y
	
	# Better prediction based on accuracy
	if current_params["prediction_accuracy"] > 0.0:
		# Calculate time until ball reaches paddle
		var paddle_x = controlled_paddle.position.x
		var distance_to_paddle = abs(ball.position.x - paddle_x)
		var time_to_reach = distance_to_paddle / ball.current_speed
		
		# Predict future Y position
		var future_y = ball.position.y + (ball.direction.y * ball.current_speed * time_to_reach)
		
		# Account for wall bounces (simplified)
		while future_y < 0 or future_y > 1080:
			if future_y < 0:
				future_y = abs(future_y)
			elif future_y > 1080:
				future_y = 1080 - (future_y - 1080)
		
		# Blend between current and predicted based on accuracy
		predicted_y = lerp(ball.position.y, future_y, current_params["prediction_accuracy"])
	
	return predicted_y

func apply_weight_management() -> void:
	"""Strategic weight management for higher difficulties"""
	if not controlled_paddle:
		return
	
	var current_weight = controlled_paddle.get_weight_percentage()
	
	# If weight is high and ball is far, stay still to reduce weight
	if current_weight > 60.0:
		var distance_to_ball = abs(ball.position.x - controlled_paddle.position.x)
		if distance_to_ball > 500.0:
			# Stay at current position to reduce weight
			target_y = controlled_paddle.position.y
