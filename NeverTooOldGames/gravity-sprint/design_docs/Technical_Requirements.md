# Gravity Sprint - Technical Requirements

## Engine
- **Godot Version**: 4.5.1
- **Language**: GDScript

## Required Plugins/Addons
- None (built-in physics and rendering)

## Performance Targets
- **Frame Rate**: 60 FPS (critical for reflex gameplay)
- **Memory**: < 100 MB RAM
- **Load Times**: < 2 seconds

## Save System Requirements

### Data to Save
- High score (endless mode)
- Best times per challenge level
- Unlocked challenge levels
- Settings (volume, controls)

### Save Format
- JSON file: `user://gravity_sprint_save.json`
- Auto-save after each run
- Cloud save support (future)

## Input Methods

### Keyboard
- **Space**: Flip gravity
- **ESC**: Pause
- **R**: Quick restart

### Mouse
- **Left Click**: Flip gravity
- **UI**: Click buttons

### Touch (Future Mobile)
- **Tap Anywhere**: Flip gravity
- Touch-optimized UI

## Resolution Support
- **Native**: 1920x1080 (16:9)
- **Minimum**: 1280x720
- **Scaling**: Pixel-perfect scaling
- **Fullscreen**: Supported
- **Windowed**: Supported

## Platform-Specific

### Windows
- Standalone executable
- No dependencies
- Gamepad support (optional)

### Future Mobile
- Portrait or landscape
- Touch controls
- Battery optimization
