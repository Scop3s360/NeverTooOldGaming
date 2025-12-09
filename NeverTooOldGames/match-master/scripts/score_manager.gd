extends Node
class_name ScoreManager

## Manages scoring and attempts for Match Master

signal score_changed(new_score: int)
signal attempts_changed(remaining: int, max_attempts: int)
signal game_over()

const STARTING_POINTS = 1000
const MATCH_BONUS = 200
const MISS_PENALTY = 100

var current_score: int = STARTING_POINTS
var max_attempts: int = 10
var failed_attempts: int = 0

func initialize(mode: int) -> void:
	"""Initialize score manager for the selected mode"""
	current_score = STARTING_POINTS
	failed_attempts = 0
	
	# Set max attempts based on difficulty
	match mode:
		0:  # Easy (4 pairs)
			max_attempts = 10
		1:  # Medium (8 pairs)
			max_attempts = 12
		2:  # Hard (12 pairs)
			max_attempts = 15
		_:
			max_attempts = 10
	
	score_changed.emit(current_score)
	attempts_changed.emit(get_remaining_attempts(), max_attempts)
	print("Score initialized: ", current_score, " | Max attempts: ", max_attempts)

func add_match_bonus() -> void:
	"""Award points for a successful match"""
	current_score += MATCH_BONUS
	score_changed.emit(current_score)
	print("Match! +", MATCH_BONUS, " points. Score: ", current_score)

func add_miss_penalty() -> void:
	"""Deduct points for a failed match attempt"""
	failed_attempts += 1
	current_score -= MISS_PENALTY
	
	# Don't let score go negative
	if current_score < 0:
		current_score = 0
	
	score_changed.emit(current_score)
	attempts_changed.emit(get_remaining_attempts(), max_attempts)
	
	print("Miss! -", MISS_PENALTY, " points. Score: ", current_score, " | Attempts left: ", get_remaining_attempts())
	
	# Check for game over
	if get_remaining_attempts() <= 0:
		game_over.emit()
		print("Game Over! No attempts remaining.")

func get_remaining_attempts() -> int:
	"""Get number of attempts remaining"""
	return max_attempts - failed_attempts

func get_score() -> int:
	"""Get current score"""
	return current_score

func get_failed_attempts() -> int:
	"""Get number of failed attempts"""
	return failed_attempts

func reset() -> void:
	"""Reset score manager"""
	current_score = STARTING_POINTS
	failed_attempts = 0
	score_changed.emit(current_score)
	attempts_changed.emit(get_remaining_attempts(), max_attempts)
