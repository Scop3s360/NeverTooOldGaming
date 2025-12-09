# Match Master - Visual Specifications

## Color Palette (Hex Codes)

### Base UI
- **Background**: `#F5F5DC` (Beige)
- **Card Border**: `#FFFFFF` (White)
- **Button Primary**: `#4A90E2` (Blue)
- **Button Secondary**: `#50C878` (Emerald Green)
- **Text Primary**: `#2C3E50` (Dark Gray)
- **Text Secondary**: `#7F8C8D` (Medium Gray)

### Theme-Specific Palettes

#### Retro Pixel Art
- Primary: `#FF6B6B`, `#4ECDC4`, `#FFE66D`, `#95E1D3`
- Accent: `#F38181`, `#AA96DA`

#### Minimalist Neon
- Background: `#0A0E27` (Dark Blue)
- Neon Colors: `#00F5FF`, `#FF10F0`, `#39FF14`, `#FFFF00`

#### Nature Botanical
- Greens: `#2ECC71`, `#27AE60`, `#16A085`
- Browns: `#8B4513`, `#A0522D`
- Accent: `#F39C12` (Flower yellow)

## Asset Requirements

### Card Assets (Per Theme)
- **Card Back**: 200x280px PNG with transparency
- **Card Faces (8 unique)**: 200x280px PNG with transparency
- **Card Border**: 4px rounded corners
- **Resolution**: 2x for retina displays (400x560px)

### Background Assets
- **Resolution**: 1920x1080px
- **Format**: JPG or PNG
- **Style**: Subtle, non-distracting
- **Per Theme**: 1 unique background

### UI Elements
- **Button**: 200x60px (normal), 400x120px (2x)
- **Icon Size**: 64x64px (normal), 128x128px (2x)
- **Logo**: 512x512px PNG with transparency

## Animation Specifications

### Card Flip
- **Duration**: 0.3 seconds
- **Easing**: Ease-in-out
- **Rotation**: 0° to 180° on Y-axis
- **Frames**: 12 frames for smooth animation

### Match Effect
- **Particle Count**: 20-30 particles
- **Colors**: Match theme colors
- **Duration**: 0.5 seconds
- **Spread**: Radial from card center

## AI Generation Prompts (Per Theme)

### Retro Pixel Art Cards
```
"8-bit pixel art icon of [OBJECT], vibrant colors, 16x16 pixel style scaled up, 
retro video game aesthetic, simple shapes, limited color palette, transparent background"

Objects: coin, heart, key, potion, shield, mushroom, star, sword
```

### Minimalist Neon Cards
```
"Minimalist neon geometric shape [SHAPE], glowing edges, dark background, 
simple clean design, cyberpunk aesthetic, bright neon colors"

Shapes: circle, triangle, square, diamond, hexagon, pentagon, star, cross
```

### Nature Botanical Cards
```
"Watercolor botanical illustration of [PLANT], soft colors, delicate details, 
natural organic style, white background, hand-painted look"

Plants: leaf, flower, fern, mushroom, acorn, pinecone, berry, vine
```

## Style Guidelines

### Card Design Rules
- Clear, recognizable icons
- High contrast for visibility
- Consistent style within theme
- Scalable without quality loss
- Family-friendly imagery

### UI Design Rules
- Large, touch-friendly buttons (minimum 44x44px)
- Clear visual hierarchy
- Consistent spacing (8px grid system)
- Readable fonts (minimum 16px)
- Accessible color contrast (WCAG AA)

## Font Specifications
- **Primary Font**: Roboto or similar sans-serif
- **Heading Size**: 32px bold
- **Body Size**: 18px regular
- **Button Text**: 20px medium
- **Small Text**: 14px regular
