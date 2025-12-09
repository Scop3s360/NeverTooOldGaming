# Chroma Blend - Audio Specifications

## Music Track

### Main Theme: "Palette"
- **BPM**: 95
- **Length**: 2:30 loop
- **Style**: Upbeat, playful, artistic
- **Instruments**: Xylophone, marimba, light percussion, strings
- **Mood**: Creative, cheerful, educational
- **Key**: C Major
- **AI Prompt**: "Playful educational music, 95 BPM, xylophone and marimba, cheerful, artistic vibe, family-friendly loop"

## Sound Effects

### Color Mixing
- **Merge Sound**: Satisfying blend, 0.4s
  - **Layers**: Swirl + chime
  - **AI Prompt**: "Color mixing sound effect, swirling blend, satisfying, artistic, game audio"

- **Create Purple**: Specific chime, 0.3s (E note)
- **Create Orange**: Specific chime, 0.3s (G note)
- **Create Green**: Specific chime, 0.3s (C note)
- **AI Prompt**: "Color creation chime, pleasant tone, satisfying, educational game audio"

- **Invalid Merge**: Gentle negative, 0.2s
  - **AI Prompt**: "Gentle error sound, soft negative tone, not harsh, puzzle feedback"

### Matching
- **Match 3**: Pleasant pop, 0.3s
- **Match 4**: Bigger pop with echo, 0.4s
- **Match 5+**: Explosive pop, 0.5s
- **AI Prompt**: "Match success pop sound, satisfying, bubbly, puzzle game audio"

### Combos
- **Combo 2x**: Ascending chime, 0.2s
- **Combo 3x**: Higher chime, 0.3s
- **Combo 4x+**: Epic chime with reverb, 0.5s
- **AI Prompt**: "Combo achievement sound, ascending notes, exciting, game reward audio"

### Tile Actions
- **Tile Fall**: Soft whoosh, 0.2s
- **Tile Land**: Gentle thud, 0.1s
- **Tile Clear**: Paint splatter, 0.3s
- **AI Prompt**: "Tile movement sound, soft and satisfying, puzzle game audio"

### Game Events
- **Level Complete**: Victory jingle, 2.0s
  - **Pattern**: Ascending scale with resolution
  - **AI Prompt**: "Level complete victory, uplifting, educational, family-friendly celebration"

- **Star Earned**: Twinkle, 0.3s per star
- **Level Failed**: Sympathetic sound, 1.0s
- **AI Prompt**: "Star achievement twinkle, magical, satisfying, game reward"

### UI Sounds
- **Button Click**: Soft tap, 0.05s
- **Undo**: Reverse whoosh, 0.15s
- **Level Select**: Page turn, 0.2s
- **AI Prompt**: "UI button click, soft and clean, minimal, game interface sound"

## Technical Specifications

### File Formats
- **Music**: OGG Vorbis, 192kbps, stereo
- **SFX**: WAV, 44.1kHz, 16-bit, mono
- **Total Size**: ~8MB

### Volume Levels
- **Music**: -14dB peak
- **SFX**: -8dB peak
- **Normalization**: All files normalized

### Implementation
- **Music**: Seamless loop
- **SFX**: Pooled, max 6 simultaneous
- **Layering**: Combo sounds layer on match sounds
- **Pitch Variation**: Match size affects pitch

## Audio Settings
- **Master Volume**: 0-100%
- **Music Volume**: 0-100%
- **SFX Volume**: 0-100%
- **Mute Toggle**: Instant mute all
