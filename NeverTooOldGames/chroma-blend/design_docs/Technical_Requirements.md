# Chroma Blend - Technical Requirements

## Engine
- **Godot Version**: 4.5.1
- **Language**: GDScript

## Required Plugins/Addons
- None (built-in grid and animation systems)

## Performance Targets
- **Frame Rate**: 60 FPS
- **Memory**: < 150 MB RAM
- **Animation**: Smooth tile movements

## Save System Requirements

### Data to Save
- Completed levels
- Star ratings per level
- Best scores per level
- Settings

### Save Format
- JSON file: `user://chroma_blend_save.json`
- Auto-save after each level

## Input Methods

### Mouse
- **Drag**: Merge colors
- **Click**: Select tiles
- **UI**: Click buttons

### Touch (Future Mobile)
- **Drag**: Merge colors
- **Tap**: Select
- Touch-optimized grid

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
- Portrait orientation preferred
- Touch controls
- Smaller assets
