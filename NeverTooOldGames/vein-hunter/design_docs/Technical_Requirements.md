# Vein Hunter - Technical Requirements

## Engine
- **Godot Version**: 4.5.1
- **Language**: GDScript

## Required Plugins/Addons
- None (built-in systems)

## Performance Targets
- **Frame Rate**: 60 FPS
- **Memory**: < 150 MB RAM
- **Calculation**: Handle large numbers (BigInt if needed)

## Save System Requirements

### Data to Save
- Total currency earned
- Miner counts and levels
- Click power upgrades
- Prestige level and bonuses
- Offline progress timestamp
- Settings

### Save Format
- JSON file: `user://vein_hunter_save.json`
- Auto-save every 30 seconds
- Save on exit

### Offline Progress
- Calculate time away (max 24 hours)
- Award currency based on income per second
- Display offline earnings on return

## Input Methods

### Mouse
- **Left Click**: Mine/earn currency
- **UI**: Click buttons and miners

### Keyboard
- **Space**: Alternative click
- **1-8**: Quick-buy miners (optional)
- **ESC**: Settings

### Touch (Future Mobile)
- **Tap**: Mine/earn currency
- Touch-optimized UI
- Larger buttons

## Resolution Support
- **Native**: 1920x1080 (16:9)
- **Minimum**: 1280x720
- **Scaling**: UI scales proportionally
- **Fullscreen**: Supported
- **Windowed**: Supported

## Platform-Specific

### Windows
- Standalone executable
- No dependencies
- Low system requirements

### Future Mobile
- Portrait or landscape
- Battery optimization
- Touch controls
- Smaller assets
