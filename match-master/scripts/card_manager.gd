extends Node
class_name CardManager

## Manages card flipping and matching logic

signal match_found(card_a: Card, card_b: Card)
signal no_match(card_a: Card, card_b: Card)
signal all_pairs_matched

var first_flipped_card: Card = null
var second_flipped_card: Card = null
var matched_pairs: int = 0
var is_processing: bool = false

func on_card_tapped(card: Card) -> void:
	"""Handle card tap"""
	if is_processing:
		return
	
	if not card.can_interact():
		return
	
	# Flip the card
	card.flip_up()
	
	# Track flipped cards
	if first_flipped_card == null:
		first_flipped_card = card
		print("First card flipped: ID ", card.card_id)
	elif second_flipped_card == null and card != first_flipped_card:
		second_flipped_card = card
		print("Second card flipped: ID ", card.card_id)
		
		# Check for match after a short delay
		is_processing = true
		await get_tree().create_timer(0.5).timeout
		check_for_match()

func check_for_match() -> bool:
	"""Check if the two flipped cards match"""
	if first_flipped_card == null or second_flipped_card == null:
		return false
	
	var is_match = first_flipped_card.card_id == second_flipped_card.card_id
	
	if is_match:
		process_match()
	else:
		process_no_match()
	
	return is_match

func process_match() -> void:
	"""Handle successful match"""
	print("Match found!")
	
	first_flipped_card.mark_as_matched()
	second_flipped_card.mark_as_matched()
	
	match_found.emit(first_flipped_card, second_flipped_card)
	matched_pairs += 1
	
	reset_flipped_cards()

func process_no_match() -> void:
	"""Handle no match - flip cards back"""
	print("No match - flipping back")
	
	no_match.emit(first_flipped_card, second_flipped_card)
	
	# Flip both cards back
	await get_tree().create_timer(0.5).timeout
	first_flipped_card.flip_down()
	second_flipped_card.flip_down()
	
	reset_flipped_cards()

func reset_flipped_cards() -> void:
	"""Reset the flipped card tracking"""
	first_flipped_card = null
	second_flipped_card = null
	is_processing = false

func reset() -> void:
	"""Reset the card manager for a new game"""
	first_flipped_card = null
	second_flipped_card = null
	matched_pairs = 0
	is_processing = false
