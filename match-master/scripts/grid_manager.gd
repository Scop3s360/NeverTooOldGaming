extends Node2D
class_name GridManager

## Manages the grid of cards for Match Master

signal grid_created
signal all_pairs_matched

const Card = preload("res://scenes/card.tscn")
const PlaceholderTexture = preload("res://scripts/placeholder_texture.gd")
const UnlockManager = preload("res://scripts/unlock_manager.gd")

@export var grid_rows: int = 4
@export var grid_cols: int = 4
@export var card_spacing: float = 160.0  # Increased spacing
@export var grid_offset: Vector2 = Vector2(100, 150)  # Adjusted offset

var cards: Array[Card] = []
var grid_size: Vector2i
var unlock_manager: UnlockManager

func _ready() -> void:
	grid_size = Vector2i(grid_cols, grid_rows)
	unlock_manager = UnlockManager.new()
	add_child(unlock_manager)

func create_grid(num_pairs: int) -> void:
	"""Create a grid with the specified number of pairs"""
	clear_grid()
	
	# Calculate grid dimensions
	var total_cards = num_pairs * 2
	grid_rows = ceili(sqrt(total_cards))
	grid_cols = ceili(float(total_cards) / grid_rows)
	
	# Calculate centering offset
	var grid_width = (grid_cols - 1) * card_spacing
	var grid_height = (grid_rows - 1) * card_spacing
	var center_offset = Vector2(
		(720 - grid_width) / 2,  # Center horizontally (720 = screen width)
		(1280 - grid_height) / 2  # Center vertically (1280 = screen height)
	)
	
	# Create card pairs
	var card_ids: Array[int] = []
	for i in range(num_pairs):
		card_ids.append(i)
		card_ids.append(i)  # Add pair
	
	print("Created card IDs for ", num_pairs, " pairs: ", card_ids)
	
	# Shuffle
	card_ids.shuffle()
	
	print("After shuffle: ", card_ids)
	
	# Create and position cards
	var card_index = 0
	for row in range(grid_rows):
		for col in range(grid_cols):
			if card_index >= total_cards:
				break
			
			var card = Card.instantiate()
			card.card_id = card_ids[card_index]
			
			# Load card textures based on selected deck theme
			var selected_deck = unlock_manager.selected_deck
			card.card_back = load_card_back(selected_deck)
			card.card_design = load_card_face(card.card_id, selected_deck)
			
			# Position card (centered)
			var pos = Vector2(
				center_offset.x + col * card_spacing,
				center_offset.y + row * card_spacing
			)
			card.position = pos
			
			add_child(card)
			cards.append(card)
			
			card_index += 1
	
	grid_created.emit()
	print("Grid created with ", cards.size(), " cards (", num_pairs, " pairs)")

func clear_grid() -> void:
	"""Remove all cards from the grid"""
	for card in cards:
		card.queue_free()
	cards.clear()

func get_card_at_position(grid_pos: Vector2i) -> Card:
	"""Get card at grid position"""
	var index = grid_pos.y * grid_cols + grid_pos.x
	if index >= 0 and index < cards.size():
		return cards[index]
	return null

func is_grid_complete() -> bool:
	"""Check if all cards are matched"""
	for card in cards:
		if not card.is_matched:
			return false
	return true

func check_all_matched() -> void:
	"""Check if all pairs are matched and emit signal"""
	if is_grid_complete():
		all_pairs_matched.emit()
		print("All pairs matched!")

func load_card_back(deck_theme: int) -> Texture2D:
	"""Load card back texture for the selected deck theme"""
	var texture: Texture2D = null
	
	match deck_theme:
		0:  # Retro Pixel Art
			texture = load("res://assets/00_retro_pixel_art/cards/pixleheartback.jpg")
		1:  # Minimalist Neon
			texture = load("res://assets/01_minimalist_neon/cards/neonback.jpg")
		_:  # Fallback to placeholder
			texture = PlaceholderTexture.create_card_back(deck_theme)
	
	return texture

func load_card_face(card_id: int, deck_theme: int) -> Texture2D:
	"""Load card face texture based on card ID and deck theme"""
	var texture: Texture2D = null
	
	match deck_theme:
		0:  # Retro Pixel Art
			var card_names = [
				"pixleheart",    # 0
				"pixlestar",     # 1
				"pixleshroom",   # 2
				"pixlecoin",     # 3
				"pixlesword",    # 4
				"pixleshield",   # 5
				"pixlepotion",   # 6
				"pixlekey"       # 7
			]
			var card_index = card_id % card_names.size()
			var path = "res://assets/00_retro_pixel_art/cards/" + card_names[card_index] + ".jpg"
			texture = load(path)
		1:  # Minimalist Neon
			var card_names = [
				"neoncircle",    # 0
				"neontriangle",  # 1
				"neonsquare",    # 2
				"neonhex",       # 3
				"neondiamond",   # 4
				"neonpent",      # 5
				"neonstar",      # 6
				"neoncross"      # 7
			]
			var card_index = card_id % card_names.size()
			var path = "res://assets/01_minimalist_neon/cards/" + card_names[card_index] + ".jpg"
			texture = load(path)
		_:  # Fallback to placeholder
			texture = PlaceholderTexture.create_card_face(card_id, deck_theme)
	
	return texture
