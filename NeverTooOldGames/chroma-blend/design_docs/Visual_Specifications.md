# Chroma Blend - Visual Specifications

## Color Palette (Hex Codes)

### Primary Colors
- **Red**: `#FF0000`
- **Blue**: `#0000FF`
- **Yellow**: `#FFFF00`

### Secondary Colors (Mixed)
- **Purple** (Red + Blue): `#8B00FF`
- **Orange** (Red + Yellow): `#FF8C00`
- **Green** (Blue + Yellow): `#00FF00`

### UI Colors
- **Background**: `#FFFEF0` (Cream)
- **Grid Lines**: `#D3D3D3` (Light Gray)
- **Text**: `#2C3E50` (Dark Gray)
- **Button**: `#3498DB` (Blue)

## Asset Requirements

### Color Tiles
- **Size**: 64x64px (normal), 128x128px (2x)
- **Shape**: Rounded square (8px radius)
- **Border**: 2px white outline
- **Glow**: Subtle outer glow matching color

### Grid
- **Cell Size**: 64x64px
- **Grid**: 6x6 or 8x8 depending on level
- **Spacing**: 4px between tiles
- **Background**: Subtle texture

### Merge Animation
- **Swirl Effect**: Two colors blend together
- **Duration**: 0.5 seconds
- **Frames**: 15 frames for smooth blend

### Match Effect
- **Particle Count**: 30 particles
- **Colors**: Matching tile color
- **Duration**: 0.6 seconds
- **Effect**: Paint splatter style

## Animation Specifications

### Color Merge
- **Duration**: 0.5 seconds
- **Effect**: Swirl/blend animation
- **Colors**: Smooth gradient transition
- **Sound Sync**: Matches audio cue

### Tile Clear
- **Duration**: 0.4 seconds
- **Effect**: Burst into paint splatter
- **Particles**: 20-30 per tile
- **Gravity**: Particles fall down

### Tile Fall
- **Speed**: 400px per second
- **Easing**: Ease-in (gravity effect)
- **Bounce**: Small bounce on landing

### Combo Effect
- **Screen Flash**: Subtle white flash
- **Particle Multiplier**: More particles per combo
- **Duration**: 0.3 seconds

## AI Generation Prompts

### Paint Splatter Effects
```
"Watercolor paint splatter effect, [COLOR], organic shapes,
artistic, transparent background, high resolution, vibrant"
```

### Tile Designs
```
"Simple geometric tile with [COLOR] fill, rounded corners,
clean design, slight gradient, paint texture, white border"
```

### Background
```
"Subtle watercolor paper texture, cream color, artistic,
clean, not distracting, high resolution"
```

## Style Guidelines

### Visual Rules
- Vibrant, saturated colors
- Artistic, painterly aesthetic
- Clear color differentiation
- Smooth, satisfying animations
- Educational color theory focus

### Color Mixing Rules
- Visual representation of color theory
- Clear before/after states
- Smooth gradient transitions
- Accurate color mixing representation

### UI Design
- Clean, uncluttered grid
- Large, touch-friendly tiles
- Clear objective display
- Colorful but not overwhelming
- Educational and fun

## Font Specifications
- **Primary Font**: Quicksand or similar rounded font
- **Heading**: 32px bold
- **Body Text**: 18px regular
- **Move Counter**: 48px bold
- **Objective**: 20px medium
- **Color**: Dark gray for readability
