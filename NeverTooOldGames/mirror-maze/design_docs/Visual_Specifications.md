# Mirror Maze - Visual Specifications

## Color Palette (Hex Codes)

### Main Character
- **Fill**: `#FFFFFF` (White)
- **Outline**: `#000000` (Black, 2px)
- **Glow**: `#00BFFF` (Light Blue)

### Shadow Character
- **Fill**: `#2C2C2C` (Dark Gray)
- **Outline**: `#000000` (Black, 2px)
- **Glow**: `#8B008B` (Dark Magenta)

### Environment
- **Background**: `#808080` (Medium Gray)
- **Platforms**: `#FFFFFF` (White) for main, `#2C2C2C` (Dark Gray) for shadow
- **Hazards**: `#FF0000` (Red)
- **Goals**: `#00FF00` (Green) for main, `#006400` (Dark Green) for shadow

### UI
- **Text**: `#FFFFFF` (White)
- **Background**: `#2C2C2C` at 80% opacity
- **Accent**: `#00BFFF` (Light Blue)

## Asset Requirements

### Character Sprites
- **Size**: 32x32px (normal), 64x64px (2x)
- **Frames**: 4-frame walk cycle, 2-frame jump
- **Style**: Simple geometric (square or circle with face)
- **Glow**: 4px outer glow

### Platform Tiles
- **Size**: 64x64px (normal), 128x128px (2x)
- **Style**: Solid color, minimal detail
- **Seamless**: Tileable if needed

### Hazard Sprites
- **Spikes**: 32x32px, triangular
- **Pits**: Darker background color
- **Moving Hazards**: 64x64px with animation

### Goal Markers
- **Size**: 48x48px (normal), 96x96px (2x)
- **Style**: Glowing portal or flag
- **Animation**: Pulsing glow

## Animation Specifications

### Character Movement
- **Walk Cycle**: 4 frames, 0.4 seconds loop
- **Jump**: 2 frames, arc motion
- **Synchronized**: Both characters move in perfect sync

### Mirror Effect
- **Visual Indicator**: Subtle line showing mirror axis
- **Opacity**: 20% white line
- **Position**: Center of screen or mirror point

### Death Effect
- **Duration**: 0.3 seconds
- **Effect**: Character fades out
- **Particles**: 10-15 particles matching character color

### Level Complete
- **Duration**: 1.0 second
- **Effect**: Both characters glow brightly
- **Celebration**: Small particle burst from each

## AI Generation Prompts

### Character Sprites
```
"Minimalist geometric character sprite, [COLOR], simple face,
cute design, clean lines, game asset, transparent background,
pixel art or vector style"

Colors: white (main), dark gray (shadow)
```

### Platform Tiles
```
"Simple platform tile, [COLOR], clean geometric design,
minimal detail, game asset, seamless tileable"
```

### Environment
```
"Minimalist puzzle platformer background, gray gradient,
clean, geometric, not distracting, subtle grid pattern"
```

## Style Guidelines

### Visual Rules
- Minimalist, clean design
- High contrast between characters
- Clear visual distinction (light vs shadow)
- Simple, geometric shapes
- No unnecessary detail
- Focus on gameplay clarity

### Character Design Rules
- Easily distinguishable at a glance
- Synchronized animations
- Clear visual feedback for actions
- Cute but simple aesthetic

### Level Design Rules
- Single-screen puzzles
- Clear platform layout
- Obvious goals
- Hazards clearly marked in red
- Minimal visual clutter

## Font Specifications
- **Primary Font**: Roboto or similar clean sans-serif
- **Heading**: 32px bold
- **Body Text**: 18px regular
- **Move Counter**: 24px medium
- **Par Display**: 20px regular
- **Color**: White with dark outline
