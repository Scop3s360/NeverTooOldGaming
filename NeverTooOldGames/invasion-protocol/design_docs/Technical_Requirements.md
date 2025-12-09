# Invasion Protocol - Technical Requirements

## Engine
- **Godot Version**: 4.5.1
- **Language**: GDScript

## Required Plugins/Addons
- None (built-in pathfinding and AI)

## Performance Targets
- **Frame Rate**: 60 FPS
- **Memory**: < 200 MB RAM
- **Max Units On Screen**: 50+

## Save System Requirements

### Data to Save
- Completed levels
- Star ratings per level
- Unlocked units
- Settings

### Save Format
- JSON file: `user://invasion_protocol_save.json`
- Auto-save after each level

## Input Methods

### Mouse
- **Click**: Spawn unit, UI interaction
- **Hover**: Preview unit stats

### Keyboard
- **1-6**: Quick-select units
- **Space**: Pause
- **ESC**: Menu

### Touch (Future Mobile)
- **Tap**: Spawn unit
- Touch-optimized UI

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

### Future Mobile
- Landscape orientation
- Touch controls
- Optimized performance
