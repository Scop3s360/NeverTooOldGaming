# Invasion Protocol - Visual Specifications

## Color Palette (Hex Codes)

### Environment
- **Background**: `#1A1A2E` (Dark Blue-Gray)
- **Castle Stone**: `#4A4A5A` (Gray)
- **Path**: `#6A6A7A` (Light Gray)
- **Grass/Ground**: `#2D4A2B` (Dark Green)

### Player Units (Invaders)
- **Primary**: `#FF4444` (Bright Red)
- **Secondary**: `#FF8800` (Orange)
- **Accent**: `#FFD700` (Gold)
- **Glow**: Red/orange glow effect

### Enemy Towers (Defenders)
- **Primary**: `#4444FF` (Bright Blue)
- **Secondary**: `#8844FF` (Purple)
- **Accent**: `#00FFFF` (Cyan)
- **Glow**: Blue/purple glow effect

### UI
- **Currency**: `#FFD700` (Gold)
- **Button**: `#8B0000` (Dark Red)
- **Text**: `#FFFFFF` (White)

## Asset Requirements

### Unit Sprites
- **Size**: 32x32px (normal), 64x64px (2x)
- **Frames**: 4-frame walk cycle
- **Style**: Cartoon, stylized
- **Glow**: 2px outer glow in team color

### Tower Sprites
- **Size**: 64x64px (normal), 128x128px (2x)
- **Style**: Medieval fantasy, cartoon
- **Animation**: Idle pulse, attack animation
- **Levels**: 3 visual upgrade tiers

### Castle/Throne
- **Size**: 128x128px (normal), 256x256px (2x)
- **Style**: Gothic medieval castle
- **Detail**: High detail, imposing
- **Damage States**: 3 states (healthy, damaged, destroyed)

### Path
- **Tile Size**: 64x64px
- **Style**: Stone pathway
- **Seamless**: Tileable texture

## Animation Specifications

### Unit Movement
- **Walk Cycle**: 4 frames, 0.4 seconds loop
- **Speed**: Varies by unit type
- **Direction**: Face movement direction

### Unit Attack
- **Duration**: 0.3 seconds
- **Effect**: Weapon swing or projectile
- **Impact**: Small particle burst

### Tower Attack
- **Projectile**: Arrow, magic bolt, or beam
- **Speed**: 500px per second
- **Trail**: Fading trail effect
- **Impact**: Explosion or hit effect

### Unit Death
- **Duration**: 0.5 seconds
- **Effect**: Fade out with particles
- **Sound Sync**: Matches death sound

## AI Generation Prompts

### Unit Sprites
```
"Cartoon fantasy [UNIT TYPE] character sprite, side view, simple design,
bright colors, red/orange team colors, medieval fantasy style,
transparent background, game asset"

Unit Types: grunt soldier, tank warrior, fast runner, healer cleric, siege unit
```

### Tower Sprites
```
"Medieval fantasy [TOWER TYPE], cartoon style, blue/purple colors,
defensive structure, game asset, isometric or side view,
detailed but stylized, transparent background"

Tower Types: arrow tower, magic tower, cannon tower, barracks
```

### Castle
```
"Gothic medieval castle throne room, cartoon style, imposing,
dark fantasy aesthetic, detailed stonework, game background asset"
```

## Style Guidelines

### Visual Rules
- Cartoon/stylized, not realistic
- Clear team color distinction (red vs blue)
- High contrast for visibility
- Bright, vibrant colors
- Medieval fantasy theme
- Family-friendly violence

### Unit Design Rules
- Easily distinguishable silhouettes
- Clear visual hierarchy (size = power)
- Consistent art style across all units
- Readable at small sizes

### UI Design
- Medieval fantasy theme
- Stone/metal textures
- Gold accents for currency
- Clear, readable fonts
- Dark background for contrast

## Font Specifications
- **Primary Font**: Cinzel or similar medieval font
- **Heading**: 32px bold
- **Body Text**: 18px regular
- **Currency**: 24px bold
- **Unit Cost**: 16px medium
- **Color**: White with dark outline for readability
