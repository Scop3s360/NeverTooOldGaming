# Heavy Paddle - Visual Specifications

## Color Palette (Hex Codes)

### Main Colors
- **Background**: `#000000` (Pure Black)
- **Paddles**: `#FFFFFF` (White)
- **Ball**: `#FFFFFF` (White)
- **Center Line**: `#FFFFFF` at 30% opacity
- **UI Text**: `#FFFFFF` (White)

### Weight Indicator
- **Light (0-33%)**: `#00FF00` (Green)
- **Medium (34-66%)**: `#FFD700` (Yellow)
- **Heavy (67-100%)**: `#FF0000` (Red)
- **Gradient**: Smooth transition between colors

## Asset Requirements

### Paddles
- **Size**: 20x100px (normal), 40x200px (2x)
- **Shape**: Rectangle with 4px rounded corners
- **Glow**: 2px outer glow when light, none when heavy
- **Thickness**: Visually increases with weight

### Ball
- **Size**: 16x16px circle (normal), 32x32px (2x)
- **Glow**: 4px outer glow
- **Trail**: Optional 5-frame motion blur

### Weight Bar
- **Size**: 100x10px per paddle
- **Position**: Above/below paddle
- **Fill**: Gradient based on weight
- **Border**: 1px white outline

### UI Elements
- **Score Display**: 72px height numbers
- **Button**: 200x60px (normal), 400x120px (2x)

## Animation Specifications

### Paddle Movement
- **Light Weight**: Smooth, instant response
- **Heavy Weight**: Sluggish, delayed response
- **Interpolation**: Lerp based on weight value

### Ball Hit
- **Flash**: Brief white flash at contact point
- **Duration**: 0.1 seconds
- **Particle**: 5-10 particles at impact

### Weight Change
- **Bar Fill**: Smooth animation, 0.2 seconds
- **Color Transition**: Smooth gradient shift
- **Paddle Thickness**: Gradual visual change

### Score
- **Increment**: Number scales up briefly
- **Flash**: Brief glow effect
- **Duration**: 0.3 seconds

## AI Generation Prompts

### Retro Effects
```
"Retro arcade glow effect, neon white light, CRT screen aesthetic,
scanlines optional, clean geometric shapes, high contrast"
```

### Particle Effects
```
"Simple white particle burst, retro arcade style, pixelated,
glowing effect, transparent background"
```

## Style Guidelines

### Visual Rules
- Pure black and white only (except weight indicator)
- High contrast for visibility
- Retro arcade aesthetic
- Minimal visual effects
- Clear, instant feedback
- 60fps smooth animations

### UI Design
- Minimal HUD
- Large, readable score
- Corner placement for UI
- No visual clutter in play area
- Retro arcade font

## Font Specifications
- **Primary Font**: Press Start 2P or similar pixel font
- **Score Size**: 72px
- **Menu Text**: 24px
- **Small Text**: 16px
- **Color**: White only
- **Style**: Monospace, retro arcade
