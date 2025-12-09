# Mirror Maze - Technical Requirements

## Engine
- **Godot Version**: 4.5.1
- **Language**: GDScript

## Required Plugins/Addons
- None (built-in physics and movement)

## Performance Targets
- **Frame Rate**: 60 FPS
- **Memory**: < 100 MB RAM
- **Input Latency**: < 10ms (critical for platformer)

## Save System Requirements

### Data to Save
- Completed levels
- Best move count per level
- Settings

### Save Format
- JSON file: `user://mirror_maze_save.json`
- Auto-save after each level

## Input Methods

### Keyboard
- **Arrow Keys or WASD**: Move
- **Space**: Jump
- **R**: Restart level
- **Z**: Undo (optional)
- **ESC**: Pause/menu

### Gamepad (Optional)
- **Left Stick**: Move
- **A Button**: Jump
- **Start**: Pause

### Touch (Future Mobile)
- **Virtual D-Pad**: Movement
- **Button**: Jump
- Touch-optimized UI

## Resolution Support
- **Native**: 1920x1080 (16:9)
- **Minimum**: 1280x720
- **Scaling**: Pixel-perfect or proportional
- **Fullscreen**: Supported
- **Windowed**: Supported

## Platform-Specific

### Windows
- Standalone executable
- No dependencies
- Lightweight

### Future Mobile
- Portrait or landscape
- Touch controls
- Battery optimization
