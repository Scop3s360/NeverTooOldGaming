extends Node

## Helper script to create placeholder textures for testing

# Deck theme color schemes
static var deck_themes = {
	0: {  # Retro Pixel Art - bright primary colors
		"back": Color(0.1, 0.1, 0.3),
		"colors": [
			Color(1.0, 0.0, 0.0), Color(0.0, 1.0, 0.0), Color(0.0, 0.0, 1.0),
			Color(1.0, 1.0, 0.0), Color(1.0, 0.0, 1.0), Color(0.0, 1.0, 1.0),
			Color(1.0, 0.5, 0.0), Color(0.5, 0.0, 1.0)
		]
	},
	1: {  # Minimalist Neon - neon colors
		"back": Color(0.05, 0.05, 0.05),
		"colors": [
			Color(0.0, 1.0, 0.5), Color(1.0, 0.0, 0.5), Color(0.5, 0.0, 1.0),
			Color(1.0, 1.0, 0.0), Color(0.0, 1.0, 1.0), Color(1.0, 0.5, 0.0),
			Color(0.5, 1.0, 0.0), Color(1.0, 0.0, 1.0)
		]
	},
	2: {  # Nature Botanical - earth tones
		"back": Color(0.3, 0.2, 0.1),
		"colors": [
			Color(0.2, 0.6, 0.2), Color(0.6, 0.4, 0.2), Color(0.4, 0.3, 0.1),
			Color(0.8, 0.7, 0.3), Color(0.3, 0.5, 0.3), Color(0.5, 0.3, 0.2),
			Color(0.7, 0.5, 0.3), Color(0.4, 0.6, 0.3)
		]
	},
	3: {  # Hand-Drawn Doodle - pastel colors
		"back": Color(0.9, 0.9, 0.8),
		"colors": [
			Color(1.0, 0.7, 0.7), Color(0.7, 1.0, 0.7), Color(0.7, 0.7, 1.0),
			Color(1.0, 1.0, 0.7), Color(1.0, 0.7, 1.0), Color(0.7, 1.0, 1.0),
			Color(1.0, 0.8, 0.6), Color(0.8, 0.7, 1.0)
		]
	},
	4: {  # Dark Fantasy - dark purples and reds
		"back": Color(0.1, 0.0, 0.1),
		"colors": [
			Color(0.5, 0.0, 0.2), Color(0.3, 0.0, 0.4), Color(0.6, 0.1, 0.1),
			Color(0.4, 0.0, 0.3), Color(0.2, 0.0, 0.3), Color(0.5, 0.0, 0.0),
			Color(0.3, 0.1, 0.4), Color(0.4, 0.0, 0.2)
		]
	}
}

static func create_colored_card(color: Color, size: Vector2i = Vector2i(64, 64)) -> ImageTexture:
	"""Create a simple colored rectangle texture"""
	var image = Image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
	image.fill(color)
	return ImageTexture.create_from_image(image)

static func create_card_back(deck_theme: int = 0) -> ImageTexture:
	"""Create a card back texture based on deck theme"""
	var theme = deck_themes.get(deck_theme, deck_themes[0])
	return create_colored_card(theme["back"])

static func create_card_face(card_id: int, deck_theme: int = 0) -> ImageTexture:
	"""Create a card face texture based on ID and deck theme"""
	var theme = deck_themes.get(deck_theme, deck_themes[0])
	var colors = theme["colors"]
	
	var color_index = card_id % colors.size()
	return create_colored_card(colors[color_index])
