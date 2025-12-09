# Vein Hunter - Visual Specifications

## Color Palette (Hex Codes)

### Cave Environment
- **Background Deep**: `#0A0A0A` (Near Black)
- **Cave Walls**: `#2C2416` (Dark Brown)
- **Rock**: `#4A4A4A` (Dark Gray)
- **Dirt**: `#5C4033` (Brown)

### Resources (Glowing)
- **Common Ore**: `#808080` (Gray)
- **Copper**: `#FF6B35` (Orange)
- **Silver**: `#C0C0C0` (Silver)
- **Gold**: `#FFD700` (Gold)
- **Emerald**: `#50C878` (Green)
- **Ruby**: `#E0115F` (Ruby Red)
- **Diamond**: `#00FFFF` (Cyan)
- **Alien Crystal**: `#9D00FF` (Purple)
- **Quantum Matter**: Rainbow gradient

### Dwarves/Miners
- **Skin**: `#FFDBAC` (Peach)
- **Beard**: `#8B4513` (Brown) or `#FF6347` (Red)
- **Tech Suit**: `#4A90E2` (Blue) with `#00FFFF` (Cyan) accents
- **Tools**: `#C0C0C0` (Silver) with `#00FFFF` (Cyan) glow

### UI
- **Currency**: `#FFD700` (Gold)
- **Button**: `#2C2416` (Dark Brown) with `#FFD700` border
- **Text**: `#FFFFFF` (White)
- **Progress Bar**: `#4A90E2` (Blue)

## Asset Requirements

### Miner Sprites
- **Size**: 48x48px (normal), 96x96px (2x)
- **Frames**: 4-frame mining animation
- **Style**: Cartoon dwarf with futuristic gear
- **Glow**: Cyan tech glow on equipment

### Resource Sprites
- **Size**: 16x16px to 32x32px
- **Style**: Glowing gems/crystals
- **Glow**: Strong outer glow matching color
- **Rarity**: Larger = rarer

### Mining Zone
- **Size**: 400x600px central area
- **Style**: Cross-section of cave/mine
- **Layers**: Visual depth progression
- **Animation**: Particles, dust, glow effects

### Tool/Equipment Icons
- **Size**: 64x64px (normal), 128x128px (2x)
- **Style**: Futuristic mining tools
- **Glow**: Cyan tech glow
- **Detail**: High detail, sci-fi aesthetic

## Animation Specifications

### Click Effect
- **Duration**: 0.3 seconds
- **Effect**: Rock breaking, particles
- **Particles**: 15-20 rock fragments
- **Glow**: Brief flash at click point

### Miner Working
- **Loop**: 1.0 second continuous
- **Animation**: Drilling/mining motion
- **Particles**: Continuous dust/sparks
- **Sound Sync**: Matches drilling sound

### Resource Discovery
- **Duration**: 0.5 seconds
- **Effect**: Glow intensifies, particle burst
- **Rare Resources**: More dramatic effect
- **Float Up**: Resource floats to currency display

### Depth Progression
- **Visual Change**: Background gets darker/different
- **New Resources**: Appear at deeper levels
- **Transition**: Smooth fade between depth layers

## AI Generation Prompts

### Dwarf Miner Sprites
```
"Cartoon dwarf character with futuristic mining equipment, laser drill,
plasma pickaxe, tech suit with glowing cyan accents, friendly design,
game sprite, transparent background, side view"
```

### Resource Gems
```
"Glowing [COLOR] crystal gem, sci-fi alien mineral, bright glow effect,
transparent background, game asset, high detail, magical appearance"

Colors: orange, silver, gold, green, red, cyan, purple, rainbow
```

### Mining Equipment
```
"Futuristic mining tool icon, [TOOL], sci-fi design, glowing cyan accents,
high-tech, detailed, game UI icon, transparent background"

Tools: laser drill, plasma pickaxe, quantum excavator, singularity mine
```

### Cave Background
```
"Deep underground cave cross-section, dark atmosphere, glowing alien minerals,
futuristic mining operation, sci-fi aesthetic, game background"
```

## Style Guidelines

### Visual Rules
- Dark cave atmosphere with glowing elements
- High contrast (dark background, bright resources)
- Sci-fi meets fantasy aesthetic
- Satisfying visual feedback
- Progressive visual depth
- Futuristic dwarven theme

### Resource Design Rules
- Glow intensity = rarity
- Size = value
- Distinct colors for each type
- Easily recognizable
- Satisfying to collect

### Miner Design Rules
- Cartoon but detailed
- Clear visual upgrades
- Consistent dwarf aesthetic
- Futuristic equipment
- Friendly, hardworking appearance

### UI Design
- Dark theme (cave aesthetic)
- Gold accents for currency
- Cyan tech glow for buttons
- Clear information hierarchy
- Satisfying number displays

## Font Specifications
- **Primary Font**: Orbitron or similar sci-fi font
- **Currency Display**: 36px bold
- **Miner Names**: 18px regular
- **Income Display**: 20px medium
- **Depth Indicator**: 24px bold
- **Color**: White with cyan glow effect
