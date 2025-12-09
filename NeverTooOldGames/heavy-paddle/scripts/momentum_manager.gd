class_name MomentumManager
extends Node

## Manages paddle weight/momentum system

signal weight_changed(new_weight: float, speed_multiplier: float)

const MAX_WEIGHT = 100.0
const MIN_WEIGHT = 0.0
const WEIGHT_GAIN_PER_UNIT = 5.0  # Weight gained per pixel moved
const WEIGHT_DECAY_PER_SECOND = 10.0  # Weight lost per second when still
const BASE_SPEED = 600.0  # Base paddle speed in pixels/second

var current_weight: float = 0.0
var last_position: float = 0.0
var is_moving: bool = false

func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	# Decay weight when not moving
	if not is_moving:
		update_weight_decay(delta)

func update_movement(current_position: float, delta: float) -> void:
	"""Called each frame with paddle's current position"""
	var distance_moved = abs(current_position - last_position)
	
	if distance_moved > 0.1:  # Threshold to detect movement
		is_moving = true
		add_movement_weight(distance_moved)
	else:
		is_moving = false
	
	last_position = current_position

func add_movement_weight(distance: float) -> void:
	"""Add weight based on distance moved"""
	var weight_gain = distance * WEIGHT_GAIN_PER_UNIT
	current_weight = min(current_weight + weight_gain, MAX_WEIGHT)
	weight_changed.emit(current_weight, get_speed_multiplier())

func update_weight_decay(delta: float) -> void:
	"""Reduce weight when paddle is still"""
	if current_weight > MIN_WEIGHT:
		current_weight = max(current_weight - (WEIGHT_DECAY_PER_SECOND * delta), MIN_WEIGHT)
		weight_changed.emit(current_weight, get_speed_multiplier())

func get_speed_multiplier() -> float:
	"""Get current speed multiplier based on weight (0.0 to 1.0)"""
	return 1.0 - (current_weight / MAX_WEIGHT)

func get_current_speed() -> float:
	"""Get actual paddle speed in pixels/second"""
	return BASE_SPEED * get_speed_multiplier()

func get_weight_percentage() -> float:
	"""Get weight as percentage (0-100)"""
	return (current_weight / MAX_WEIGHT) * 100.0

func reset_weight() -> void:
	"""Reset weight to 0"""
	current_weight = 0.0
	weight_changed.emit(current_weight, get_speed_multiplier())
