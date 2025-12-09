class_name ScoreManager
extends Node

## Manages scoring for Gravity Sprint

signal score_changed(new_score: int)
signal distance_changed(new_distance: int)

const DISTANCE_POINTS = 1  # Points per unit traveled
const TIME_BONUS = 10  # Points per second

var current_score: int = 0
var distance_traveled: int = 0
var time_survived: float = 0.0
var flip_count: int = 0
var speed_multiplier: float = 1.0

func _ready() -> void:
	reset_score()

func _process(delta: float) -> void:
	time_survived += delta

func add_distance(distance: float) -> void:
	"""Add distance traveled and update score"""
	distance_traveled += int(distance)
	update_score()
	distance_changed.emit(distance_traveled)

func add_flip() -> void:
	"""Count a gravity flip"""
	flip_count += 1

func set_speed_multiplier(multiplier: float) -> void:
	"""Set current speed multiplier for scoring"""
	speed_multiplier = multiplier
	update_score()

func update_score() -> void:
	"""Calculate current score"""
	var distance_score = distance_traveled * DISTANCE_POINTS
	var time_score = int(time_survived) * TIME_BONUS
	current_score = int((distance_score + time_score) * speed_multiplier)
	score_changed.emit(current_score)

func get_score() -> int:
	return current_score

func get_distance() -> int:
	return distance_traveled

func get_time() -> float:
	return time_survived

func get_flips() -> int:
	return flip_count

func reset_score() -> void:
	"""Reset all scoring variables"""
	current_score = 0
	distance_traveled = 0
	time_survived = 0.0
	flip_count = 0
	speed_multiplier = 1.0
	score_changed.emit(current_score)
	distance_changed.emit(distance_traveled)
