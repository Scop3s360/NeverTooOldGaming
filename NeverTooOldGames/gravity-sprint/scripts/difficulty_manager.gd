class_name DifficultyManager
extends Node

## Manages speed and difficulty progression

signal speed_changed(new_speed: float)
signal difficulty_increased

const BASE_SPEED = 400.0  # Starting speed in px/s
const MAX_SPEED = 800.0  # Maximum speed (2x base)
const SPEED_INCREASE = 20.0  # Speed increase per interval
const INCREASE_INTERVAL = 10.0  # Seconds between increases

var current_speed: float = BASE_SPEED
var time_elapsed: float = 0.0
var is_endless_mode: bool = true
var challenge_level: int = 0

# Challenge level speeds
var challenge_speeds = {
	0: 400.0,  # Levels 1-3
	1: 400.0,
	2: 400.0,
	3: 500.0,  # Levels 4-6
	4: 500.0,
	5: 500.0,
	6: 650.0,  # Levels 7-9
	7: 650.0,
	8: 650.0,
	9: 800.0   # Level 10
}

func initialize(endless: bool, level: int = 0) -> void:
	"""Initialize difficulty manager"""
	is_endless_mode = endless
	challenge_level = level
	
	if endless:
		current_speed = BASE_SPEED
	else:
		current_speed = challenge_speeds.get(level, BASE_SPEED)
	
	time_elapsed = 0.0
	speed_changed.emit(current_speed)

func _process(delta: float) -> void:
	if not is_endless_mode:
		return  # Challenge mode has fixed speed
	
	time_elapsed += delta
	
	# Check if it's time to increase speed
	var intervals_passed = int(time_elapsed / INCREASE_INTERVAL)
	var target_speed = BASE_SPEED + (intervals_passed * SPEED_INCREASE)
	target_speed = min(target_speed, MAX_SPEED)
	
	if target_speed > current_speed:
		current_speed = target_speed
		speed_changed.emit(current_speed)
		difficulty_increased.emit()
		print("Speed increased to: ", current_speed)

func get_current_speed() -> float:
	return current_speed

func get_speed_multiplier() -> float:
	"""Get speed as multiplier of base speed (for scoring)"""
	return current_speed / BASE_SPEED

func get_obstacle_spawn_interval() -> float:
	"""Get time between obstacle spawns based on difficulty"""
	if is_endless_mode:
		# Start at 3 seconds, decrease to 1 second
		var intervals_passed = int(time_elapsed / INCREASE_INTERVAL)
		var spawn_time = 3.0 - (intervals_passed * 0.2)
		return max(spawn_time, 1.0)
	else:
		# Challenge mode spawn rates
		if challenge_level < 3:
			return 2.5
		elif challenge_level < 6:
			return 2.0
		elif challenge_level < 9:
			return 1.5
		else:
			return 1.0
