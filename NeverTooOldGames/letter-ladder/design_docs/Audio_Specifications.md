# Letter Ladder - Audio Specifications

## Music Track

### Main Theme: "Contemplation"
- **BPM**: 80
- **Length**: 3:00 loop
- **Style**: Ambient, calm, focus music
- **Instruments**: Soft piano, strings, subtle pads
- **Mood**: Thoughtful, peaceful, concentration-friendly
- **Key**: F Major
- **AI Prompt**: "Calm ambient music for puzzle game, 80 BPM, soft piano and strings, peaceful, focus-friendly, non-distracting loop"

## Sound Effects

### Word Interactions
- **Letter Type**: Soft keyboard click, 0.05s
  - **Pitch**: Varies per letter (A=low, Z=high)
  - **AI Prompt**: "Soft keyboard typing sound, gentle click, minimal, game audio"

- **Valid Word**: Pleasant chime, 0.3s
  - **Pattern**: Ascending 2-note sequence
  - **AI Prompt**: "Success chime sound effect, pleasant, satisfying, word puzzle game audio"

- **Invalid Word**: Gentle negative tone, 0.3s
  - **Pattern**: Single low note
  - **AI Prompt**: "Gentle error sound, not harsh, soft negative tone, puzzle game feedback"

- **Puzzle Complete**: Victory jingle, 2.0s
  - **Pattern**: Ascending scale with resolution
  - **AI Prompt**: "Puzzle complete victory jingle, uplifting, satisfying, educational game audio"

### UI Sounds
- **Button Click**: Soft tap, 0.05s
- **Hint Used**: Helpful ding, 0.2s
- **Undo**: Reverse whoosh, 0.15s
- **Level Select**: Page turn, 0.2s
- **AI Prompt**: "UI button click, soft and clean, minimal, educational game interface sound"

### Progression
- **Star Earned**: Twinkle sound, 0.3s
  - **Pattern**: One per star, 0.2s delay between
  - **AI Prompt**: "Star achievement twinkle, magical, satisfying, game reward sound"

- **Level Unlock**: Unlock chime, 0.5s
  - **AI Prompt**: "Level unlock sound, achievement chime, satisfying, progression audio"

- **3-Star Complete**: Special fanfare, 1.5s
  - **AI Prompt**: "Perfect completion fanfare, celebratory, educational game victory"

### Daily Challenge
- **Challenge Available**: Notification chime, 0.4s
- **Streak Milestone**: Celebration sound, 1.0s
- **AI Prompt**: "Daily challenge notification, friendly chime, encouraging, game audio"

## Technical Specifications

### File Formats
- **Music**: OGG Vorbis, 128kbps, stereo
- **SFX**: WAV, 44.1kHz, 16-bit, mono
- **Total Size**: ~5MB

### Volume Levels
- **Music**: -16dB peak (very subtle)
- **SFX**: -10dB peak (gentle)
- **Normalization**: All files normalized

### Implementation
- **Music**: Seamless loop, very low volume
- **SFX**: Minimal pooling needed
- **Priority**: SFX over music (educational focus)
- **Spatial Audio**: Not needed (2D UI)

## Audio Settings
- **Master Volume**: 0-100%
- **Music Volume**: 0-100% (default 30%)
- **SFX Volume**: 0-100% (default 70%)
- **Mute Toggle**: Instant mute all
