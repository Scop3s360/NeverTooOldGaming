# Invasion Protocol - Audio Specifications

## Music Track

### Main Theme: "March of the Horde"
- **BPM**: 110
- **Length**: 2:30 loop
- **Style**: Epic orchestral, dark fantasy
- **Instruments**: Strings, brass, war drums, choir
- **Mood**: Intense, strategic, epic
- **Key**: D Minor
- **AI Prompt**: "Epic dark fantasy orchestral music, 110 BPM, war drums, brass fanfare, invasion theme, strategic battle music loop"

## Sound Effects

### Unit Actions
- **Unit Spawn**: Summoning sound, 0.4s
  - **Layers**: Portal + materialization
  - **AI Prompt**: "Unit spawn sound effect, summoning portal, materialization, fantasy game audio"

- **Unit Movement**: Footsteps, 0.2s loop
  - **Varies**: By unit type (heavy vs light)
  - **AI Prompt**: "Fantasy unit footsteps, marching sound, varied by unit type, game audio"

- **Unit Attack**: Weapon sound, 0.3s
  - **Varies**: Sword, axe, magic, etc.
  - **AI Prompt**: "Fantasy weapon attack sound, sword swing, impact, battle audio"

- **Unit Death**: Death cry, 0.5s
  - **Varies**: By unit type
  - **AI Prompt**: "Fantasy unit death sound, creature cry, not too graphic, game audio"

### Tower Actions
- **Tower Attack**: Projectile sound, 0.4s
  - **Arrow**: Whoosh + thud
  - **Magic**: Mystical bolt
  - **Cannon**: Explosion
  - **AI Prompt**: "Tower attack sound effect, projectile launch, fantasy defense audio"

- **Tower Destroyed**: Explosion, 0.8s
  - **AI Prompt**: "Tower destruction explosion, satisfying, fantasy battle audio"

### Currency
- **Currency Gain**: Coin sound, 0.2s
  - **Pitch**: Varies with amount
  - **AI Prompt**: "Gold coin sound effect, metallic, satisfying, fantasy game currency"

- **Insufficient Funds**: Negative buzz, 0.3s
  - **AI Prompt**: "Insufficient funds sound, negative buzz, clear feedback, game audio"

### Game Events
- **Wave Start**: Horn blast, 1.0s
  - **AI Prompt**: "Battle horn sound effect, war horn blast, epic, fantasy game audio"

- **Level Complete**: Victory fanfare, 3.0s
  - **Pattern**: Triumphant orchestral
  - **AI Prompt**: "Epic victory fanfare, orchestral celebration, triumphant, fantasy game win"

- **Level Failed**: Defeat horn, 2.0s
  - **AI Prompt**: "Defeat horn sound, somber, not too sad, fantasy game loss"

- **Throne Reached**: Epic chime, 1.5s
  - **AI Prompt**: "Throne reached sound, epic achievement, fantasy victory audio"

### UI Sounds
- **Button Click**: Stone tap, 0.1s
- **Unit Select**: Selection chime, 0.1s
- **Menu Navigate**: Soft tick, 0.05s
- **AI Prompt**: "Medieval UI button click, stone tap, fantasy game interface sound"

## Technical Specifications

### File Formats
- **Music**: OGG Vorbis, 192kbps, stereo
- **SFX**: WAV, 44.1kHz, 16-bit, mono (except spatial)
- **Total Size**: ~15MB

### Volume Levels
- **Music**: -12dB peak
- **SFX**: -6dB peak
- **Normalization**: All files normalized

### Implementation
- **Music**: Seamless loop
- **SFX**: Pooled, max 12 simultaneous
- **Spatial Audio**: Stereo panning based on position
- **Priority**: Important sounds (death, victory) override others

## Audio Settings
- **Master Volume**: 0-100%
- **Music Volume**: 0-100%
- **SFX Volume**: 0-100%
- **Mute Toggle**: Instant mute all
