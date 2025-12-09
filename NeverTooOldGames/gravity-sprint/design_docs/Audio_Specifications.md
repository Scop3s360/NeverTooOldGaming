# Gravity Sprint - Audio Specifications

## Music Track

### Main Theme: "Velocity"
- **BPM**: 140
- **Length**: 2:00 loop
- **Style**: Fast-paced electronic, synthwave
- **Instruments**: Synth leads, driving bass, electronic drums
- **Mood**: Intense, fast, adrenaline-pumping
- **Key**: E Minor
- **Dynamic**: Intensity increases with speed
- **AI Prompt**: "Fast-paced electronic music, 140 BPM, intense energy, synthwave style, driving bass, adrenaline rush, endless runner game music"

## Sound Effects

### Player Actions
- **Gravity Flip**: Whoosh with pitch shift, 0.2s
  - **Upward Flip**: Rising pitch
  - **Downward Flip**: Falling pitch
  - **AI Prompt**: "Gravity flip whoosh sound effect, pitch shift, sci-fi, satisfying, game audio"

- **Landing**: Soft thud, 0.1s
  - **Varies**: Pitch based on speed
  - **AI Prompt**: "Soft landing thud, electronic, minimal, game sound effect"

### Obstacles
- **Near Miss**: Tension sound, 0.15s
  - **Trigger**: Within 10px of obstacle
  - **AI Prompt**: "Close call tension sound, brief, electronic, warning audio"

- **Death/Crash**: Explosion, 0.5s
  - **Layers**: Impact + debris + electronic glitch
  - **AI Prompt**: "Crash explosion sound effect, electronic, glitch elements, game death sound"

### Game Events
- **Speed Increase**: Ascending pitch, 0.3s
  - **Trigger**: Every 10 seconds
  - **AI Prompt**: "Speed increase sound, ascending pitch, electronic, acceleration audio"

- **Checkpoint**: Milestone chime, 0.4s
  - **Trigger**: Every 500m
  - **AI Prompt**: "Checkpoint milestone sound, satisfying chime, electronic, achievement audio"

- **New High Score**: Epic chime, 1.0s
  - **AI Prompt**: "New high score fanfare, celebratory, electronic, victory sound"

### Challenge Mode
- **Level Start**: Ready beep sequence, 1.0s
  - **Pattern**: 3-2-1-GO
  - **AI Prompt**: "Countdown beep sequence, 3-2-1-go, electronic, race start audio"

- **Level Complete**: Victory fanfare, 2.0s
  - **AI Prompt**: "Level complete fanfare, triumphant, electronic, victory celebration"

### UI Sounds
- **Button Click**: Soft beep, 0.05s
- **Menu Navigate**: Tick, 0.05s
- **Restart**: Quick whoosh, 0.2s
- **AI Prompt**: "UI button click, minimal electronic beep, clean, game interface sound"

## Ambient Sounds

### Background Atmosphere
- **Wind/Rush**: Continuous loop, volume based on speed
- **Length**: 5.0s seamless loop
- **AI Prompt**: "Rushing wind ambience, continuous loop, sci-fi atmosphere, speed sensation"

### Environmental
- **Distant Hum**: Subtle sci-fi ambience, 10.0s loop
- **AI Prompt**: "Sci-fi ambient hum, subtle, futuristic, background atmosphere"

## Technical Specifications

### File Formats
- **Music**: OGG Vorbis, 192kbps, stereo
- **SFX**: WAV, 44.1kHz, 16-bit, mono
- **Ambient**: OGG Vorbis, 128kbps, stereo

### Volume Levels
- **Music**: -12dB peak
- **SFX**: -6dB peak
- **Ambient**: -18dB peak

### Implementation
- **Music**: Seamless loop, dynamic volume based on speed
- **SFX**: Pooled, max 6 simultaneous
- **Spatial Audio**: Stereo panning for obstacles
- **Pitch Variation**: Speed affects pitch of certain sounds

## Dynamic Audio System
- **Speed 0-50%**: Normal music tempo
- **Speed 50-75%**: Music pitch +5%
- **Speed 75-100%**: Music pitch +10%
- **Death**: Music stops immediately, crash sound plays
