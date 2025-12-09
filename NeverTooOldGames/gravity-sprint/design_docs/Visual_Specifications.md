# Gravity Sprint - Visual Specifications

## Color Palette (Hex Codes)

### Main Colors
- **Background**: `#0A0E27` (Deep Space Black)
- **Floor/Ceiling**: `#00F5FF` (Cyan Neon)
- **Player**: `#FFFFFF` (Bright White)
- **Obstacles**: `#FF3366` (Neon Red)
- **UI Text**: `#FFFFFF` (White)
- **Score Highlight**: `#FFD700` (Gold)

### Gradient Background
- Top: `#0A0E27` (Dark Blue)
- Bottom: `#1A1F3A` (Slightly Lighter Blue)

## Asset Requirements

### Player Character
- **Size**: 32x32px (normal), 64x64px (2x)
- **Shape**: Simple geometric (square or circle)
- **Glow Effect**: 4px outer glow in white
- **Animation Frames**: 4 frames for idle pulse

### Obstacles
- **Static Block**: 64x64px, sharp edges
- **Spike**: 32x64px, triangular
- **Moving Platform**: 128x32px
- **All**: Neon red with glow effect

### Environment
- **Floor Line**: 4px thick, cyan, full width
- **Ceiling Line**: 4px thick, cyan, full width
- **Grid Lines**: 1px, `#1A2332`, optional background detail
- **Parallax Stars**: 2-4px dots, white, various opacities

## Animation Specifications

### Gravity Flip
- **Duration**: 0.2 seconds
- **Rotation**: 180° smooth rotation
- **Trail Effect**: 10 particle trail, fading white
- **Screen Rotation**: Optional subtle camera rotation

### Death Effect
- **Particle Explosion**: 30-40 particles
- **Colors**: White to red gradient
- **Duration**: 0.3 seconds
- **Screen Shake**: 5px amplitude, 0.1 seconds

### Speed Lines
- **Appear At**: 50% max speed
- **Opacity**: Increases with speed
- **Color**: `#00F5FF` at 20% opacity
- **Direction**: Horizontal, moving backward

## AI Generation Prompts

### Player Character
```
"Minimalist geometric character sprite, glowing white cube with rounded edges,
sci-fi aesthetic, neon glow effect, transparent background, pixel perfect"
```

### Obstacles
```
"Geometric obstacle sprite, sharp angular design, neon red glowing edges,
cyberpunk aesthetic, dangerous looking, transparent background"
```

### Background Elements
```
"Sci-fi space background, deep blue gradient, subtle grid pattern,
distant stars, minimalist, clean, futuristic"
```

## Style Guidelines

### Visual Rules
- High contrast for clarity
- Neon glow effects on all interactive elements
- Geometric, angular shapes
- Minimal detail for fast recognition
- Smooth animations at 60fps

### UI Design
- Minimal HUD
- Large, readable numbers
- Corner placement for score
- No visual clutter in play area

## Font Specifications
- **Primary Font**: Orbitron or similar sci-fi font
- **Score Size**: 48px bold
- **UI Text**: 24px regular
- **Game Over**: 72px bold
- **Color**: White with cyan glow
