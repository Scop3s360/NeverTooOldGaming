# Letter Ladder - Visual Specifications

## Color Palette (Hex Codes)

### Main Colors
- **Background**: `#F8F9FA` (Soft White)
- **Text Primary**: `#2C3E50` (Dark Charcoal)
- **Text Secondary**: `#7F8C8D` (Medium Gray)
- **Accent**: `#3498DB` (Soft Blue)
- **Success**: `#27AE60` (Green)
- **Error**: `#E74C3C` (Red)

### UI Elements
- **Input Box**: `#FFFFFF` (White) with `#BDC3C7` border
- **Button**: `#3498DB` (Blue)
- **Button Hover**: `#2980B9` (Darker Blue)
- **Disabled**: `#ECF0F1` (Light Gray)

## Asset Requirements

### Letter Tiles
- **Size**: 80x80px (normal), 160x160px (2x)
- **Font Size**: 48px
- **Border**: 2px solid
- **Corner Radius**: 8px
- **Shadow**: Subtle drop shadow

### Word Display
- **Container**: Full width, 100px height
- **Letter Spacing**: 16px between letters
- **Font**: Monospace or clean sans-serif

### UI Elements
- **Button**: 150x50px (normal), 300x100px (2x)
- **Icon Size**: 32x32px (normal), 64x64px (2x)
- **Star Rating**: 48x48px per star

## Animation Specifications

### Letter Change
- **Duration**: 0.2 seconds
- **Effect**: Fade out old, fade in new
- **Scale**: Slight bounce (1.0 → 1.1 → 1.0)

### Valid Word
- **Border Color**: Animate to green
- **Duration**: 0.3 seconds
- **Checkmark**: Fade in, 32x32px icon

### Invalid Word
- **Shake**: 3px horizontal shake, 3 times
- **Duration**: 0.3 seconds
- **Border Color**: Flash red

### Level Complete
- **Stars**: Appear one by one, 0.2s delay each
- **Scale**: Pop in from 0 to 1.2 to 1.0
- **Confetti**: Optional 50 particles

## AI Generation Prompts

### Background Pattern
```
"Subtle word puzzle background pattern, light gray crossword grid texture,
minimalist, clean, professional, very subtle, not distracting"
```

### Icons
```
"Simple line icon for [FUNCTION], minimalist style, clean lines,
professional, monochrome, transparent background"

Functions: hint, undo, restart, settings, star, checkmark, X
```

## Style Guidelines

### Typography Rules
- **Letter Tiles**: Uppercase only
- **Font Weight**: Bold for letters, regular for UI
- **Line Height**: 1.5 for readability
- **Letter Spacing**: Generous for clarity

### Visual Rules
- Clean, uncluttered design
- High contrast for readability
- Consistent spacing (8px grid)
- Professional, educational aesthetic
- Minimal animations (focus on content)

## Font Specifications
- **Primary Font**: Inter or Roboto
- **Letter Tiles**: 48px bold, uppercase
- **Heading**: 32px bold
- **Body Text**: 18px regular
- **Button Text**: 16px medium
- **Small Text**: 14px regular
