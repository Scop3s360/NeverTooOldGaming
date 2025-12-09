# Vein Hunter - Audio Specifications

## Music Track

### Main Theme: "Deep Excavation"
- **BPM**: 105
- **Length**: 2:30 loop
- **Style**: Electronic industrial, futuristic
- **Instruments**: Synth bass, electronic drums, industrial sounds, ambient pads
- **Mood**: Productive, motivating, futuristic
- **Key**: E Minor
- **AI Prompt**: "Futuristic mining music, 105 BPM, electronic industrial, synth bass, productive vibe, sci-fi atmosphere, motivating loop"

## Sound Effects

### Mining Actions
- **Click/Mine**: Satisfying thunk, 0.2s
  - **Layers**: Laser + rock break
  - **Pitch**: Varies slightly per click
  - **AI Prompt**: "Futuristic mining click sound, laser drill, rock breaking, satisfying, sci-fi game audio"

- **Rock Break**: Crumbling sound, 0.3s
  - **AI Prompt**: "Rock breaking sound effect, crumbling, debris, mining game audio"

### Resource Discovery
- **Common Ore**: Simple chime, 0.2s (C note)
- **Copper**: Warm chime, 0.3s (D note)
- **Silver**: Bright chime, 0.3s (E note)
- **Gold**: Rich chime, 0.4s (G note)
- **Emerald**: Magical chime, 0.4s (A note)
- **Ruby**: Deep chime, 0.4s (B note)
- **Diamond**: Crystal chime, 0.5s (C note, octave up)
- **Alien Crystal**: Ethereal chime, 0.6s (complex harmony)
- **Quantum Matter**: Epic chime, 0.8s (rainbow harmony)
- **AI Prompt**: "Resource discovery chime, [RARITY], satisfying, sci-fi mining game audio"

### Miner Actions
- **Purchase**: Unlock sound + mechanical, 0.6s
  - **AI Prompt**: "Miner purchase sound, unlock, mechanical activation, sci-fi game audio"

- **Upgrade**: Power-up whoosh, 0.5s
  - **AI Prompt**: "Upgrade power-up sound, futuristic, satisfying, sci-fi enhancement audio"

- **Miner Working**: Drilling loop, 1.0s seamless loop
  - **Varies**: By miner type (laser, plasma, quantum)
  - **AI Prompt**: "Futuristic mining drill sound, [TYPE], continuous loop, sci-fi industrial audio"

### Progression
- **Level Up**: Achievement sound, 1.0s
  - **AI Prompt**: "Level up achievement sound, satisfying, futuristic, sci-fi game audio"

- **Prestige Available**: Shimmering alert, 1.5s
  - **AI Prompt**: "Prestige available sound, shimmering alert, epic, sci-fi game audio"

- **Prestige Activate**: Epic fanfare, 3.0s
  - **Layers**: Orchestral + electronic
  - **AI Prompt**: "Prestige activation fanfare, epic, futuristic orchestral, sci-fi game victory"

- **Milestone**: Celebration sound, 1.0s
  - **AI Prompt**: "Milestone achievement sound, celebratory, satisfying, sci-fi game audio"

### Depth Progression
- **Depth Change**: Transition sound, 0.8s
  - **Pattern**: Descending tone
  - **AI Prompt**: "Depth level transition sound, descending, atmospheric, mining game audio"

- **New Resource Unlocked**: Discovery chime, 1.0s
  - **AI Prompt**: "New resource discovery sound, exciting, sci-fi exploration audio"

### UI Sounds
- **Button Click**: Metallic tap, 0.1s
- **Tab Switch**: Swoosh, 0.15s
- **Menu Open**: Rising tone, 0.2s
- **Menu Close**: Falling tone, 0.2s
- **AI Prompt**: "Futuristic UI button click, metallic, clean, sci-fi interface sound"

## Ambient Sounds

### Cave Atmosphere
- **Cave Ambience**: Continuous loop, 10.0s
  - **Layers**: Distant machinery, mineral resonance, echoes
  - **AI Prompt**: "Deep cave ambience, futuristic mining operation, distant machinery, sci-fi atmosphere loop"

### Miner Ambience
- **Multiple Miners**: Layered drilling sounds
  - **Volume**: Increases with miner count
  - **AI Prompt**: "Industrial mining ambience, multiple drills, futuristic, sci-fi background audio"

## Technical Specifications

### File Formats
- **Music**: OGG Vorbis, 192kbps, stereo
- **SFX**: WAV, 44.1kHz, 16-bit, mono
- **Ambient**: OGG Vorbis, 128kbps, stereo
- **Total Size**: ~12MB

### Volume Levels
- **Music**: -12dB peak
- **SFX**: -6dB peak
- **Ambient**: -18dB peak
- **Normalization**: All files normalized

### Implementation
- **Music**: Seamless loop
- **SFX**: Pooled, max 10 simultaneous
- **Ambient**: Layered, dynamic volume based on miners
- **Pitch Variation**: Click sounds vary slightly

## Audio Settings
- **Master Volume**: 0-100%
- **Music Volume**: 0-100%
- **SFX Volume**: 0-100%
- **Ambient Volume**: 0-100%
- **Mute Toggle**: Instant mute all
