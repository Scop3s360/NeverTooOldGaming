# Heavy Paddle - Technical Requirements

## Engine
- **Godot Version**: 4.5.1
- **Language**: GDScript

## Required Plugins/Addons
- None (built-in physics)

## Performance Targets
- **Frame Rate**: 60 FPS (critical for arcade gameplay)
- **Memory**: < 50 MB RAM
- **Input Latency**: < 10ms

## Save System Requirements

### Data to Save
- High scores per difficulty
- Win/loss record
- Settings (volume, controls)
- AI difficulty preference

### Save Format
- JSON file: `user://heavy_paddle_save.json`
- Auto-save after each match

## Input Methods

### Keyboard
- **W/S or Arrow Keys**: Move paddle up/down
- **ESC**: Pause

### Mouse
- **Mouse Movement**: Control paddle position
- **Click**: Menu interactions

### Gamepad (Optional)
- **Left Stick**: Move paddle
- **Start**: Pause

### Touch (Future Mobile)
- **Drag**: Move paddle
- Touch-optimized controls

## Resolution Support
- **Native**: 1920x1080 (16:9)
- **Minimum**: 1280x720
- **Scaling**: Maintain aspect ratio
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
