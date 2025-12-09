# Match Master

A memory matching card game built with Godot 4.5.1

## About
Match Master is a classic memory card matching game with multiple difficulty levels, unlockable themes, and a progression system.

## Features
- 🎮 **3 Difficulty Modes**: Easy (4 pairs), Medium (8 pairs), Hard (12 pairs)
- 🎨 **15 Unlockable Themes**: Retro Pixel Art, Neon, Nature, and more
- 💰 **Points System**: Earn points by completing games
- 🛒 **Shop**: Unlock new card decks, backgrounds, music, and animations
- 💾 **Save System**: Auto-save progress and continue games
- 📊 **Score Tracking**: Different scoring for each difficulty
- 🎯 **Game Modes**: Unlimited attempts (Easy) or limited attempts (Normal/Hard)

## How to Play
1. Click on cards to flip them over
2. Find matching pairs
3. Match all pairs to win
4. Earn points to unlock new themes in the shop

## Controls
- **Mouse**: Click cards to flip
- **ESC**: Pause game
- **UI Buttons**: Navigate menus

## Installation

### Playing the Game
1. Download the latest release
2. Extract the zip file
3. Run `Match Master.exe`

### Development Setup
1. Install [Godot 4.5.1](https://godotengine.org/download)
2. Clone this repository
3. Open the project in Godot
4. Press F5 to run

## Project Structure
```
match-master/
├── assets/           # Game assets organized by theme
│   ├── 00_retro_pixel_art/
│   │   ├── cards/
│   │   ├── background/
│   │   ├── music/
│   │   └── animations/
│   ├── 01_minimalist_neon/
│   └── ... (15 themes total)
├── scenes/           # Godot scene files
│   ├── main_menu.tscn
│   ├── mode_select.tscn
│   ├── game.tscn
│   ├── card.tscn
│   ├── shop.tscn
│   ├── victory_screen.tscn
│   ├── game_over_screen.tscn
│   └── how_to_play.tscn
├── scripts/          # GDScript files
│   ├── game.gd
│   ├── card.gd
│   ├── grid_manager.gd
│   ├── card_manager.gd
│   ├── score_manager.gd
│   ├── save_manager.gd
│   ├── unlock_manager.gd
│   ├── shop.gd
│   └── ...
├── resources/        # Custom resources
├── ASSETS_NEEDED.md  # Asset specifications
├── AI_PROMPTS.md     # AI generation prompts
└── README.md
```

## Asset Requirements
See `ASSETS_NEEDED.md` for detailed asset specifications and `AI_PROMPTS.md` for AI generation prompts for creating theme assets.

## Technologies
- **Engine**: Godot 4.5.1
- **Language**: GDScript
- **Platform**: Windows (exportable to Linux, macOS, Web, Mobile)

## Development Status
🚧 In active development

### Completed ✅
- Core gameplay mechanics
- Card flipping and matching
- Save/load system
- Points and progression system
- Shop system with unlockables
- Multiple difficulty modes (Easy/Medium/Hard)
- Theme system (1/15 themes with assets)
- Game over and victory screens
- Tutorial/How to Play screen
- Pause menu
- Score tracking
- Attempt counter

### In Progress 🚧
- Additional theme assets (14 more themes)
- Sound effects and music
- Match animations

### Planned 📋
- Statistics tracking
- Achievement system
- More game modes (Time Attack, etc.)
- Card flip animations
- Particle effects
- Mobile support

## Game Modes

### Easy Mode
- 8 cards (4 pairs)
- Unlimited attempts
- Lower score multiplier

### Medium Mode
- 16 cards (8 pairs)
- Limited attempts
- Medium score multiplier

### Hard Mode
- 24 cards (12 pairs)
- Very limited attempts
- High score multiplier

## Themes
Each theme includes:
- 8 unique card designs + 1 card back
- Custom background
- Theme music
- Match animation

**Available Themes:**
1. ✅ Retro Pixel Art (Complete)
2. Minimalist Neon
3. Nature Botanical
4. Hand-Drawn Doodle
5. Dark Fantasy
6. Casino Cards
7. Halloween
8. Guy Fawkes / Bonfire Night
9. Christmas
10. Train Railway
11. Numbers/Math
12. Dinosaurs
13. Ocean
14. Space Sci-Fi
15. Japanese Zen

## Credits
- **Engine**: Godot Engine
- **Assets**: AI-generated and custom artwork

## License
[Add your license here]
