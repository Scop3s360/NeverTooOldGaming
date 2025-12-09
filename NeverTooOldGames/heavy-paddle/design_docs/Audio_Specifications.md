# Heavy Paddle - Audio Specifications

## Music Track

### Main Theme: "Retro Arcade"
- **BPM**: 120
- **Length**: 1:30 loop
- **Style**: 8-bit chiptune, retro arcade
- **Instruments**: Square wave, triangle wave, noise channel
- **Mood**: Energetic, nostalgic, competitive
- **Key**: C Major
- **AI Prompt**: "8-bit chiptune arcade music, retro video game style, energetic, competitive, Pong-inspired, loop"

## Sound Effects

### Gameplay Sounds
- **Paddle Hit**: Classic "boop", 0.1s
  - **Pitch**: Varies with paddle weight
  - **Light Paddle**: Higher pitch (C5)
  - **Heavy Paddle**: Lower pitch (C3)
  - **AI Prompt**: "Retro arcade paddle hit sound, classic boop, 8-bit style, Pong-inspired"

- **Wall Bounce**: Higher pitched boop, 0.1s
  - **Pitch**: E5
  - **AI Prompt**: "Retro arcade wall bounce sound, high pitch boop, 8-bit"

- **Score Point**: Victory chime, 0.5s
  - **Pattern**: Ascending 3-note sequence
  - **AI Prompt**: "Retro arcade score sound, ascending chime, 8-bit victory"

- **Miss/Point Lost**: Negative buzz, 0.3s
  - **Pattern**: Descending tone
  - **AI Prompt**: "Retro arcade miss sound, negative buzz, 8-bit game over tone"

### Weight System Sounds
- **Weight Increase**: Subtle low tone, 0.1s
  - **Pitch**: Descending
  - **AI Prompt**: "Subtle weight increase sound, low tone, minimal, 8-bit"

- **Weight Decrease**: Subtle high tone, 0.1s
  - **Pitch**: Ascending
  - **AI Prompt**: "Subtle weight decrease sound, high tone, minimal, 8-bit"

- **Max Weight Warning**: Beep, 0.2s
  - **Pattern**: Repeating every 2s when at max
  - **AI Prompt**: "Warning beep sound, retro arcade, alert tone, 8-bit"

### Game Events
- **Match Start**: Ready beep, 0.5s
  - **Pattern**: Single beep
  - **AI Prompt**: "Match start beep, retro arcade, game begin sound, 8-bit"

- **Match Win**: Victory fanfare, 2.0s
  - **Pattern**: Classic arcade victory tune
  - **AI Prompt**: "Victory fanfare, retro arcade, triumphant, 8-bit celebration"

- **Match Lose**: Defeat sound, 1.5s
  - **Pattern**: Descending tones
  - **AI Prompt**: "Defeat sound, retro arcade, game over, 8-bit sad tone"

### UI Sounds
- **Button Click**: Retro beep, 0.05s
- **Menu Navigate**: Soft tick, 0.05s
- **Mode Select**: Confirmation beep, 0.1s
- **AI Prompt**: "Retro arcade UI beep, minimal, clean, 8-bit interface sound"

## Technical Specifications

### File Formats
- **Music**: OGG Vorbis, 128kbps, mono (authentic retro)
- **SFX**: WAV, 22.05kHz, 8-bit, mono (authentic retro)
- **Total Size**: ~2MB (very small)

### Volume Levels
- **Music**: -12dB peak
- **SFX**: -6dB peak
- **All**: Normalized for consistency

### Implementation
- **Music**: Seamless loop
- **SFX**: No pooling needed (simple game)
- **Pitch Variation**: Weight affects paddle hit pitch
- **Spatial Audio**: Stereo panning for ball position

### Retro Authenticity
- **Bit Depth**: 8-bit for authentic sound
- **Sample Rate**: 22.05kHz (retro standard)
- **Channels**: Mono (except spatial effects)
- **Waveforms**: Square, triangle, noise only

## Audio Settings
- **Master Volume**: 0-100%
- **Music Volume**: 0-100%
- **SFX Volume**: 0-100%
- **Mute Toggle**: Instant mute all
