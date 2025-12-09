class_name ScoreManager
extends Node

## Manages scoring and win conditions for Heavy Paddle

signal score_changed(player_score: int, opponent_score: int)
signal game_won(winner: String, player_score: int, opponent_score: int)

const WINNING_SCORE = 11
const WIN_BY_MARGIN = 2

# Points awarded for winning based on difficulty
const DIFFICULTY_POINTS = {
	"easy": 10,
	"medium": 25,
	"hard": 50,
	"expert": 100,
	"practice": 0
}

var player_score: int = 0
var opponent_score: int = 0
var current_difficulty: String = "medium"

func initialize(difficulty: String) -> void:
	"""Initialize score manager with difficulty"""
	current_difficulty = difficulty
	player_score = 0
	opponent_score = 0
	score_changed.emit(player_score, opponent_score)

func add_player_point() -> void:
	"""Player scores a point"""
	player_score += 1
	score_changed.emit(player_score, opponent_score)
	check_win_condition()
	print("Player scores! %d - %d" % [player_score, opponent_score])

func add_opponent_point() -> void:
	"""Opponent scores a point"""
	opponent_score += 1
	score_changed.emit(player_score, opponent_score)
	check_win_condition()
	print("Opponent scores! %d - %d" % [player_score, opponent_score])

func check_win_condition() -> void:
	"""Check if someone has won the match"""
	# Must reach winning score
	if player_score < WINNING_SCORE and opponent_score < WINNING_SCORE:
		return
	
	# Must win by at least 2 points (deuce rule)
	var score_diff = abs(player_score - opponent_score)
	if score_diff < WIN_BY_MARGIN:
		print("Deuce! Must win by 2")
		return
	
	# Determine winner
	var winner = "Player" if player_score > opponent_score else "Opponent"
	game_won.emit(winner, player_score, opponent_score)
	print("🎉 %s wins! Final score: %d - %d" % [winner, player_score, opponent_score])

func get_reward_points() -> int:
	"""Get points to award for winning this match"""
	if current_difficulty in DIFFICULTY_POINTS:
		return DIFFICULTY_POINTS[current_difficulty]
	return 0

func reset_scores() -> void:
	"""Reset scores to 0"""
	player_score = 0
	opponent_score = 0
	score_changed.emit(player_score, opponent_score)
