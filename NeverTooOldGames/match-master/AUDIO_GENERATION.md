# Audio Generation Guide for Match Master

## Tools for Generating Game Audio

### For Sound Effects (SFX):
1. **Jsfxr** - https://sfxr.me/ (FREE, browser-based)
   - Best for retro 8-bit sound effects
   - Click and tweak until it sounds good
   - Export as .wav

2. **ChipTone** - https://sfbgames.itch.io/chiptone (FREE, download)
   - More advanced retro sound designer
   - Great for 8-bit/chiptune sounds

3. **Freesound.org** - https://freesound.org (FREE, requires account)
   - Search existing sounds
   - Filter by "8-bit", "retro", "game"

### For Music:
1. **Suno.ai** - https://suno.com (FREE tier with downloads)
   - AI music generation
   - Free tier allows downloads
   - Use prompts below

2. **Udio.com** - https://udio.com (Paid only for downloads)
   - AI music generation
   - ⚠️ Free tier does NOT allow downloads (as of 2025)
   - Need paid subscription to download

3. **Incompetech** - https://incompetech.com (FREE with attribution)
   - Royalty-free music library
   - Search "8-bit" or "chiptune"
   - Immediate download, no generation needed

4. **Pixabay Music** - https://pixabay.com/music/ (FREE, no attribution)
   - Free music library
   - Search "8-bit", "chiptune", "retro"
   - Direct download

---

## AI Music Prompts (for Suno/Udio)

### Theme 0: Retro Pixel Art - Background Music

**Prompt:**
```
upbeat 8-bit chiptune music, retro arcade game soundtrack, catchy melody, looping, nostalgic video game music, fast tempo, energetic, NES style, 1 minute loop
```

**Alternative Prompt:**
```
chiptune game music, 8-bit retro arcade, upbeat and fun, looping background music, classic video game style, bouncy melody, 80s arcade cabinet sound
```

**Style Tags:** chiptune, 8-bit, retro game, arcade

---

### Theme 1: Minimalist Neon - Background Music

**Prompt:**
```
synthwave electronic music, neon aesthetic, modern retro, pulsing bass, atmospheric synths, looping background music, cyberpunk vibes, 1 minute loop
```

**Alternative Prompt:**
```
ambient electronic music, neon lights atmosphere, minimal techno, pulsing rhythm, futuristic synths, looping game music, chill synthwave
```

**Style Tags:** synthwave, electronic, ambient, neon

---

## Sound Effect Descriptions (for Jsfxr/ChipTone)

### 1. Card Flip Sound
**Description:** Quick, light swoosh or flip sound
**Jsfxr Settings:**
- Wave Type: Square
- Frequency: Start 400Hz, End 600Hz
- Duration: 0.1 seconds
- Volume: Medium

**AI Prompt (if using AI):**
```
short retro game card flip sound effect, 8-bit style, quick swoosh, 0.1 seconds, arcade game sound
```

---

### 2. Match Success Sound
**Description:** Satisfying "ding" or power-up sound
**Jsfxr Settings:**
- Wave Type: Square
- Frequency: Start 800Hz, End 1200Hz
- Duration: 0.3 seconds
- Add slight reverb

**AI Prompt:**
```
retro game success sound, 8-bit power-up, satisfying ding, positive feedback, arcade game, short and punchy, 0.3 seconds
```

---

### 3. Match Fail Sound
**Description:** Negative buzz or error sound
**Jsfxr Settings:**
- Wave Type: Sawtooth
- Frequency: Start 200Hz, End 100Hz (descending)
- Duration: 0.2 seconds

**AI Prompt:**
```
retro game error sound, 8-bit buzz, negative feedback, wrong answer sound, arcade game, short descending tone, 0.2 seconds
```

---

### 4. Button Click Sound
**Description:** Quick blip
**Jsfxr Settings:**
- Wave Type: Square
- Frequency: 600Hz
- Duration: 0.05 seconds
- Sharp attack

**AI Prompt:**
```
retro game button click, 8-bit blip, UI sound effect, quick and sharp, arcade game menu sound, 0.05 seconds
```

---

### 5. Victory Fanfare
**Description:** Upbeat celebration melody
**Jsfxr Settings:**
- Wave Type: Square
- Create ascending melody (multiple tones)
- Duration: 2-3 seconds
- Upbeat and celebratory

**AI Prompt:**
```
retro game victory fanfare, 8-bit celebration music, upbeat melody, level complete sound, arcade game win music, 2-3 seconds, triumphant
```

---

### 6. Game Over Sound
**Description:** Sad descending tones
**Jsfxr Settings:**
- Wave Type: Square
- Descending frequency
- Duration: 1-2 seconds
- Melancholic

**AI Prompt:**
```
retro game over sound, 8-bit sad melody, descending tones, arcade game death sound, melancholic, 1-2 seconds
```

---

## File Format Requirements

### For Godot:
- **Preferred Format**: .ogg (Ogg Vorbis)
- **Alternative**: .wav (larger file size)
- **NOT Recommended**: .mp3 (licensing issues, larger)

### Conversion:
If you generate .wav or .mp3, convert to .ogg:
- **Online**: https://convertio.co/wav-ogg/
- **Software**: Audacity (free) - File → Export → Export as OGG

---

## File Naming Convention

### Sound Effects:
```
card_flip.ogg
match_success.ogg
match_fail.ogg
button_click.ogg
victory_fanfare.ogg
game_over.ogg
```

### Music (per theme):
```
theme_00_music.ogg  (Retro Pixel Art)
theme_01_music.ogg  (Minimalist Neon)
theme_02_music.ogg  (Nature Botanical)
... etc
```

---

## Where to Place Files

### Sound Effects (shared across all themes):
```
match-master/assets/audio/sfx/
├── card_flip.ogg
├── match_success.ogg
├── match_fail.ogg
├── button_click.ogg
├── victory_fanfare.ogg
└── game_over.ogg
```

### Music (theme-specific):
```
match-master/assets/00_retro_pixel_art/music/
└── theme.ogg

match-master/assets/01_minimalist_neon/music/
└── theme.ogg

... etc for each theme
```

---

## Quick Start Workflow

### For Sound Effects:
1. Go to https://sfxr.me/
2. Click "Pickup/Coin" for success sounds
3. Click "Hit/Hurt" for fail sounds
4. Click "Blip/Select" for button clicks
5. Tweak until it sounds good
6. Export as .wav
7. Convert to .ogg
8. Place in `assets/audio/sfx/`

### For Music:

**Option A - AI Generation (Suno - FREE):**
1. Go to https://suno.com
2. Create free account
3. Paste the prompt for your theme
4. Generate (may take 1-2 minutes)
5. Download the audio file (free tier allows this)
6. Convert to .ogg if needed
7. Place in theme's music folder

**Option B - Pre-made Music (Easier):**
1. Go to https://pixabay.com/music/ or https://incompetech.com
2. Search "8-bit" or "chiptune"
3. Preview tracks until you find one you like
4. Download directly (no generation needed)
5. Convert to .ogg if needed
6. Place in theme's music folder

---

## Testing Your Audio

Once you have the files:
1. Place them in the correct folders
2. Let me know - I'll set up the audio system
3. Test in-game
4. Adjust volume/timing as needed

---

## Audio Specifications

### Sound Effects:
- **Duration**: 0.05 - 3 seconds
- **Sample Rate**: 44100 Hz
- **Bit Depth**: 16-bit
- **Channels**: Mono (saves space)

### Music:
- **Duration**: 1-2 minutes (looping)
- **Sample Rate**: 44100 Hz
- **Bit Depth**: 16-bit
- **Channels**: Stereo
- **Loop**: Must loop seamlessly

---

## Free Sound Effect Packs (Alternative)

If you don't want to generate:

1. **Kenney.nl** - https://kenney.nl/assets?q=audio
   - Free game audio assets
   - "Interface Sounds" pack
   - "Digital Audio" pack

2. **OpenGameArt.org** - https://opengameart.org/art-search-advanced?keys=8-bit+sound
   - Search "8-bit sound effects"
   - Free with attribution

3. **Freesound.org** - https://freesound.org/search/?q=8-bit
   - Requires free account
   - Huge library

---

## Budget Estimate

### Free Options:
- Jsfxr: FREE
- Suno: FREE tier with downloads (limited generations)
- Pixabay/Incompetech: FREE music libraries
- Freesound: FREE (with account)
- **Total: $0**

### Paid Options:
- Suno Pro: $10/month (unlimited generations)
- Udio Standard: $10/month (includes downloads)
- Commission sound designer: $50-200 per theme
- Asset packs: $5-30 per pack

---

## Priority Order

### Phase 1 (Essential):
1. Card flip sound
2. Match success sound
3. Button click sound

### Phase 2 (Important):
4. Match fail sound
5. Victory fanfare
6. Background music (Theme 0)

### Phase 3 (Polish):
7. Game over sound
8. Background music (remaining themes)
9. Additional UI sounds

---

## Notes

- Start with Theme 0 (Retro Pixel Art) audio first
- Test volume levels in-game before generating all themes
- Keep sound effects short (< 1 second) for responsiveness
- Music should loop seamlessly
- All audio should match the theme aesthetic

---

## Need Help?

Once you have audio files generated:
1. Place them in the folders above
2. Let me know what you have
3. I'll set up the audio system to use them
4. We'll test and adjust volumes together
