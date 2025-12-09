# Match Master - Audio Specifications

## Music Tracks (Per Theme)

### Main Menu Music
- **BPM**: 100
- **Length**: 2:00 loop
- **Style**: Upbeat, welcoming
- **Instruments**: Light piano, strings, percussion
- **Mood**: Friendly, inviting, casual
- **AI Prompt**: "Casual game menu music, upbeat and welcoming, light instrumentation, family-friendly, loop"

### Theme-Specific Music (15 Tracks)

#### 1. Retro Pixel Art
- **Style**: 8-bit chiptune
- **BPM**: 120
- **AI Prompt**: "8-bit chiptune music, retro video game style, upbeat, nostalgic, loop"

#### 2. Minimalist Neon
- **Style**: Synthwave
- **BPM**: 110
- **AI Prompt**: "Synthwave music, neon aesthetic, electronic, chill, loop"

#### 3. Nature Botanical
- **Style**: Acoustic, natural
- **BPM**: 90
- **AI Prompt**: "Nature-inspired acoustic music, peaceful, organic instruments, calming, loop"

#### 4. Hand-Drawn Doodle
- **Style**: Quirky, playful
- **BPM**: 115
- **AI Prompt**: "Quirky playful music, whimsical, light-hearted, fun, loop"

#### 5. Dark Fantasy
- **Style**: Orchestral, mysterious
- **BPM**: 95
- **AI Prompt**: "Dark fantasy orchestral music, mysterious, magical, atmospheric, loop"

#### 6. Casino Cards
- **Style**: Jazz, lounge
- **BPM**: 105
- **AI Prompt**: "Casino lounge jazz music, sophisticated, smooth, classy, loop"

#### 7. Halloween
- **Style**: Spooky, playful
- **BPM**: 100
- **AI Prompt**: "Halloween music, spooky but playful, not scary, family-friendly, loop"

#### 8. Guy Fawkes
- **Style**: Energetic, celebratory
- **BPM**: 125
- **AI Prompt**: "Bonfire night celebration music, energetic, festive, British folk elements, loop"

#### 9. Christmas
- **Style**: Holiday, cheerful
- **BPM**: 110
- **AI Prompt**: "Christmas holiday music, cheerful, festive, joyful, family-friendly, loop"

#### 10. Train Railway
- **Style**: Industrial, rhythmic
- **BPM**: 100
- **AI Prompt**: "Train railway music, industrial rhythm, mechanical, nostalgic, loop"

#### 11. Numbers/Math
- **Style**: Educational, upbeat
- **BPM**: 115
- **AI Prompt**: "Educational music, upbeat and encouraging, learning-friendly, positive, loop"

#### 12. Dinosaurs
- **Style**: Adventure, prehistoric
- **BPM**: 105
- **AI Prompt**: "Dinosaur adventure music, prehistoric, exciting, family-friendly, loop"

#### 13. Ocean
- **Style**: Ambient, flowing
- **BPM**: 85
- **AI Prompt**: "Ocean ambient music, flowing, peaceful, underwater atmosphere, loop"

#### 14. Space Sci-Fi
- **Style**: Electronic, cosmic
- **BPM**: 95
- **AI Prompt**: "Space sci-fi music, cosmic, electronic, futuristic, atmospheric, loop"

#### 15. Japanese Zen
- **Style**: Meditative, traditional
- **BPM**: 70
- **AI Prompt**: "Japanese zen music, meditative, traditional instruments, peaceful, minimalist, loop"

## Sound Effects

### Card Interactions
- **Card Flip**: Soft whoosh, 0.2s
  - **AI Prompt**: "Card flip sound effect, soft whoosh, satisfying, game audio"

- **Card Match**: Pleasant chime, 0.3s
  - **Pitch**: Varies by theme
  - **AI Prompt**: "Match success chime, pleasant, satisfying, game reward sound"

- **Card Mismatch**: Gentle negative tone, 0.3s
  - **AI Prompt**: "Mismatch sound, gentle negative tone, not harsh, game feedback"

- **All Pairs Matched**: Victory fanfare, 2.0s
  - **Theme-specific**: Different per theme
  - **AI Prompt**: "Victory fanfare, celebratory, triumphant, game completion sound"

### UI Sounds
- **Button Click**: Soft click, 0.05s
- **Button Hover**: Subtle highlight, 0.05s
- **Menu Open**: Swoosh in, 0.2s
- **Menu Close**: Swoosh out, 0.2s
- **AI Prompt**: "UI button click, soft and clean, minimal, game interface sound"

### Shop Sounds
- **Theme Preview**: Brief music snippet, 2.0s
- **Purchase Success**: Cash register + unlock, 0.5s
- **Insufficient Funds**: Negative buzz, 0.3s
- **AI Prompt**: "Purchase success sound, cash register, satisfying unlock, game shop audio"

### Game Events
- **Victory**: Celebration music, 3.0s
- **Game Over**: Sympathetic sound, 1.5s
- **New High Score**: Achievement chime, 1.0s
- **AI Prompt**: "Game victory celebration, uplifting, triumphant, family-friendly"

## Technical Specifications

### File Formats
- **Music**: OGG Vorbis, 192kbps, stereo
- **SFX**: WAV, 44.1kHz, 16-bit, mono
- **Total Size**: ~50MB for all audio

### Volume Levels
- **Music**: -14dB peak (non-intrusive)
- **SFX**: -8dB peak
- **Normalization**: All files normalized

### Implementation
- **Music**: Seamless looping, crossfade 1.0s
- **SFX**: Pooled, max 4 simultaneous
- **Theme Switching**: Smooth crossfade between tracks
- **Memory**: Lazy load themes, unload unused

## Audio Settings
- **Master Volume**: 0-100%
- **Music Volume**: 0-100%
- **SFX Volume**: 0-100%
- **Mute Toggle**: Instant mute all
