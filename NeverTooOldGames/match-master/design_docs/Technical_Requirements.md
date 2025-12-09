# Match Master - Technical Requirements

## Engine
- **Godot Version**: 4.5.1
- **Language**: GDScript

## Required Plugins/Addons
- None (using built-in Godot features)

## Performance Targets

### Frame Rate
- **Target**: 60 FPS
- **Minimum**: 30 FPS on low-end hardware

### Memory
- **Target**: < 200 MB RAM usage
- **Asset Loading**: Lazy load themes to reduce initial memory

### Load Times
- **Game Start**: < 3 seconds
- **Scene Transitions**: < 0.5 seconds
- **Theme Switching**: < 1 second

## Save System Requirements

### Data to Save
- Player points total
- Unlocked themes (boolean array)
- High scores per difficulty
- Current game state (for continue feature)
- Settings (volume, etc.)

### Save Format
- JSON file stored locally
- Location: `user://save_data.json`

### Save Triggers
- Auto-save after each game completion
- Auto-save after shop purchases
- Auto-save on game exit
- Manual save option in pause menu

### Data Persistence
- Save file survives game updates
- Backward compatibility for save format

## Input Methods

### Mouse
- **Primary**: Left click for all interactions
- **Hover**: Visual feedback on hoverable elements

### Keyboard
- **ESC**: Pause game / Back to previous menu
- **Space**: Alternative select (optional)
- **Arrow Keys**: Navigate menus (optional)

### Touch (Future Mobile Port)
- Tap to flip cards
- Swipe gestures for menu navigation
- Touch-friendly button sizes (minimum 44x44 pixels)

## Resolution Support
- **Native**: 1920x1080 (16:9)
- **Minimum**: 1280x720
- **Scaling**: Maintain aspect ratio, letterbox if needed
- **Fullscreen**: Supported
- **Windowed**: Supported with resize

## Platform-Specific

### Windows
- Executable export
- No external dependencies
- Installer optional (zip distribution primary)

### Future Mobile
- Portrait and landscape support
- Touch controls
- Smaller asset sizes for mobile
