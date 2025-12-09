# Implementation Plan

- [ ] 1. Set up project structure and core configuration
  - Create Godot project structure with proper folders (scenes, scripts, resources, assets)
  - Configure project settings for mobile (resolution, orientation, input)
  - Create GameState and SessionData resource classes
  - Create LevelConfig, ModeConfig, and CardSet resource classes
  - Define three mode configurations (Easy=8 cards, Medium=16 cards, Hard=24 cards)
  - Define initial level configurations (levels 1-10)
  - _Requirements: All_

- [ ] 2. Implement Card class and visual representation
  - Create Card scene as Area2D with CollisionShape2D
  - Implement card properties (card_id, is_face_up, is_matched, is_animating)
  - Create card back design (consistent cute pattern)
  - Implement card tap detection
  - Add visual states (face-down, face-up, matched)
  - Apply kawaii styling (rounded corners, soft shadows, pastel colors)
  - _Requirements: 1.1, 1.4, 6.1_

- [ ] 2.1 Write property test for card flip state
  - **Property 1: Card flip state transition**
  - **Validates: Requirements 1.1**

- [ ] 2.2 Write property test for face-up card interaction
  - **Property 3: Face-up card interaction prevention**
  - **Validates: Requirements 1.4**

- [ ] 2.3 Write property test for touch target sizing
  - **Property 17: Touch target sizing**
  - **Validates: Requirements 7.4**

- [ ] 3. Implement GridManager for card layout
  - Create GridManager script to handle grid creation
  - Implement grid generation based on rows and columns
  - Create card positioning logic with proper spacing
  - Implement card shuffling algorithm
  - Add grid state tracking (flipped cards, matched cards)
  - _Requirements: 4.3_

- [ ] 3.1 Write property test for card position randomization
  - **Property 12: Card position randomization**
  - **Validates: Requirements 4.3**

- [ ] 4. Implement CardManager for flip and match logic
  - Create CardManager script to handle card interactions
  - Implement two-card flip sequence tracking
  - Add card flip methods (flip_up, flip_down)
  - Implement match detection logic
  - Handle match processing (keep cards face-up, mark as matched)
  - Handle non-match processing (flip cards back after delay)
  - _Requirements: 1.1, 1.3, 2.1, 2.2, 2.4_

- [ ] 4.1 Write property test for match detection trigger
  - **Property 2: Match detection trigger**
  - **Validates: Requirements 1.3**

- [ ] 4.2 Write property test for match identification
  - **Property 4: Match identification correctness**
  - **Validates: Requirements 2.1**

- [ ] 4.3 Write property test for matched card state
  - **Property 5: Matched card state persistence**
  - **Validates: Requirements 2.2**

- [ ] 4.4 Write property test for non-match behavior
  - **Property 6: Non-match flip-back behavior**
  - **Validates: Requirements 2.4**

- [ ] 5. Implement victory and failure conditions
  - Add logic to detect when all pairs are matched
  - Implement level completion trigger
  - Add logic to detect when attempts are exhausted
  - Implement level failure trigger
  - _Requirements: 2.5, 3.3_

- [ ] 5.1 Write property test for victory condition
  - **Property 7: Victory condition detection**
  - **Validates: Requirements 2.5**

- [ ] 5.2 Write property test for failure condition
  - **Property 9: Failure condition detection**
  - **Validates: Requirements 3.3**

- [ ] 6. Implement AttemptTracker
  - Create AttemptTracker script to manage attempt counter
  - Implement initialization with max attempts
  - Add attempt decrement logic
  - Implement attempt exhaustion detection
  - Emit signals for attempt changes
  - _Requirements: 3.1, 3.2, 3.3_

- [ ] 6.1 Write property test for attempt decrement
  - **Property 8: Attempt decrement correctness**
  - **Validates: Requirements 3.2**

- [ ] 7. Implement mode selection system
  - Create mode selection UI (Easy, Medium, Hard buttons)
  - Implement ModeConfig resource with card counts and attempt limits
  - Add mode selection logic
  - Store selected mode in session data
  - _Requirements: 3.1, 3.2, 3.3, 3.4_

- [ ] 7.1 Write property test for mode card count
  - **Property 25: Mode card count correctness**
  - **Validates: Requirements 3.2, 3.3, 3.4**

- [ ] 8. Implement LevelManager for progression
  - Create LevelManager script to handle level data
  - Implement level loading based on mode selection
  - Add level completion tracking
  - Implement level unlocking logic
  - Calculate star ratings based on performance
  - _Requirements: 7.1, 7.3_

- [ ] 8.1 Write property test for level unlock progression
  - **Property 10: Level unlock progression**
  - **Validates: Requirements 7.1**

- [ ] 8.2 Write property test for perfect completion
  - **Property 18: Perfect completion recognition**
  - **Validates: Requirements 11.3**

- [ ] 9. Implement PointsManager
  - Create PointsManager script to track points
  - Implement points awarding on match (based on speed and mode)
  - Add points balance tracking
  - Implement points persistence across sessions
  - Calculate points with mode multipliers (Easy=1x, Medium=1.5x, Hard=2x)
  - Emit signals for points changes
  - _Requirements: 5.1, 5.2, 5.3, 5.4_

- [ ] 9.1 Write property test for points award
  - **Property 26: Points award on match**
  - **Validates: Requirements 5.1, 5.3**

- [ ] 9.2 Write property test for points persistence
  - **Property 27: Points persistence**
  - **Validates: Requirements 5.4**

- [ ] 10. Implement AbilityManager and special abilities
  - Create AbilityManager script to handle abilities
  - Implement Flash ability (reveal all cards for 2 seconds)
  - Implement Highlight ability (show one matching pair)
  - Add ability cost checking (Flash=50 points, Highlight=30 points)
  - Implement points deduction on ability use
  - Add visual effects for abilities
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [ ] 10.1 Write property test for ability cost deduction
  - **Property 28: Ability cost deduction**
  - **Validates: Requirements 6.1, 6.3**

- [ ] 10.2 Write property test for Flash ability
  - **Property 29: Flash ability effect**
  - **Validates: Requirements 6.2**

- [ ] 10.3 Write property test for Highlight ability
  - **Property 30: Highlight ability effect**
  - **Validates: Requirements 6.4**

- [ ] 10.4 Write property test for insufficient points
  - **Property 31: Insufficient points prevention**
  - **Validates: Requirements 6.1, 6.3**

- [ ] 11. Implement CardSet system
  - Create CardSet resource class with themed card designs
  - Design and create initial card sets (Cute Animals, Kawaii Food, Chibi Characters)
  - Implement card set selection logic
  - Add card design loading based on selected set
  - _Requirements: 8.3_

- [ ] 12. Implement UnlockManager
  - Create UnlockManager script to track unlocks
  - Implement card set unlocking at milestone levels
  - Add unlock checking logic
  - Track unlocked card sets in game state
  - Emit signals when new content is unlocked
  - _Requirements: 8.1, 8.2_

- [ ] 12.1 Write property test for card set unlocks
  - **Property 13: Card set unlock at milestones**
  - **Validates: Requirements 8.1**

- [ ] 12.2 Write property test for unlocked set availability
  - **Property 14: Unlocked card set availability**
  - **Validates: Requirements 8.2, 8.3**

- [ ] 13. Implement input handling and touch controls
  - Create InputManager to handle touch events
  - Implement tap-to-card resolution
  - Add input validation (ignore taps on matched cards, animating cards)
  - Implement input queuing during animations
  - Handle edge cases (taps between cards, rapid taps)
  - _Requirements: 10.1, 10.2, 10.3_

- [ ] 13.1 Write property test for input resolution
  - **Property 15: Input resolution correctness**
  - **Validates: Requirements 10.2**

- [ ] 13.2 Write property test for animation blocking
  - **Property 16: Animation blocking**
  - **Validates: Requirements 10.3**

- [ ] 13.3 Write property test for rapid input stability
  - **Property 20: Rapid input stability**
  - **Validates: Requirements 12.1**

- [ ] 14. Implement game state management
  - Create GameStateManager with states (Playing, Paused, Victory, Failure, Tutorial)
  - Implement state transitions
  - Handle game initialization (start level with mode selection)
  - Implement pause/resume functionality
  - Handle game restart
  - _Requirements: 12.2_

- [ ] 14.1 Write property test for pause-resume
  - **Property 21: Pause-resume state preservation**
  - **Validates: Requirements 12.2**

- [ ] 14.2 Write property test for interruption stability
  - **Property 22: Interruption stability**
  - **Validates: Requirements 12.3, 12.4**

- [ ] 15. Implement statistics tracking
  - Add total matches counter
  - Add levels completed counter
  - Track star ratings per level
  - Track total points earned
  - Track abilities used
  - Implement statistics persistence
  - _Requirements: 11.4_

- [ ] 15.1 Write property test for statistics tracking
  - **Property 19: Statistics tracking accuracy**
  - **Validates: Requirements 11.4**

- [ ] 16. Create UI system
  - Create UIManager scene with HUD elements
  - Add mode selection screen (Easy/Medium/Hard buttons)
  - Add attempts remaining display
  - Add matches found display (X/Y pairs)
  - Add points balance display
  - Add ability buttons (Flash, Highlight) with costs and availability indicators
  - Create level select screen with unlock states
  - Create victory screen with star rating and points earned
  - Create failure screen with retry option
  - Add card set selection screen
  - Create tutorial overlay with steps (include modes, points, abilities)
  - Implement tutorial progression (tap to advance)
  - Add "skip tutorial" option
  - _Requirements: 4.4, 5.2, 7.3, 8.4, 11.1, 11.2, 13.1, 13.2, 13.3, 13.4_

- [ ] 16.1 Write property test for tutorial progression
  - **Property 23: Tutorial progression correctness**
  - **Validates: Requirements 13.3**

- [ ] 16.2 Write property test for tutorial completion
  - **Property 24: Tutorial completion persistence**
  - **Validates: Requirements 13.4**

- [ ] 17. Implement VisualEffectsManager
  - Create VisualEffectsManager for animations and particles
  - Implement card flip animation (smooth rotation)
  - Create match particle effect (hearts, stars, sparkles)
  - Create perfect clear effect (rainbow sparkles, confetti)
  - Add card shake animation for non-matches
  - Implement Flash ability visual (all cards briefly revealed)
  - Implement Highlight ability visual (matching pair glows)
  - Implement bouncy animations for UI elements
  - Apply kawaii styling to all effects
  - _Requirements: 1.2, 2.3, 6.5, 9.3, 9.4_

- [ ] 18. Implement AudioManager
  - Create AudioManager singleton
  - Add sound effects (flip, match, no-match, victory, unlock, ability use)
  - Implement background music (cute, upbeat)
  - Add volume controls
  - Implement sound variation (pitch changes for matches)
  - _Requirements: 2.3_

- [ ] 19. Implement kawaii visual theme
  - Create pastel color palette
  - Design soft gradient background with cute patterns
  - Apply rounded corners and soft shadows to all UI
  - Create cute fonts for text
  - Style all screens with kawaii aesthetic
  - Add decorative elements (hearts, stars, cute characters)
  - _Requirements: 9.1, 9.2_

- [ ] 20. Create card artwork and assets
  - Design card back pattern (consistent across all sets)
  - Create "Cute Animals" card set (12 designs for Hard mode)
  - Create "Kawaii Food" card set (12 designs for Hard mode)
  - Create "Chibi Characters" card set (12 designs for Hard mode)
  - Ensure all artwork fits kawaii aesthetic
  - Optimize textures for mobile
  - _Requirements: 9.1_

- [ ] 21. Polish and optimization
  - Implement object pooling for cards
  - Optimize texture loading and atlasing
  - Add juice (screen shake, particle bursts, bouncy animations)
  - Tune animation timings for satisfying feel
  - Balance mode difficulty (attempts and points)
  - Balance ability costs (Flash=50, Highlight=30)
  - Ensure smooth 60 FPS on mobile
  - _Requirements: 10.1_

- [ ] 22. Mobile optimization and testing
  - Test on various screen sizes and resolutions
  - Verify touch target sizes (minimum 44x44 pixels)
  - Test performance on mid-range mobile devices for all three modes
  - Implement battery optimization
  - Add haptic feedback for matches and ability use
  - Test pause/resume when backgrounding app
  - _Requirements: 10.1, 10.4, 12.2_

- [ ] 23. Final testing and bug fixes
  - Test full game loop for all three modes
  - Test points earning and spending system
  - Test both abilities (Flash and Highlight) in various scenarios
  - Verify all card sets unlock correctly
  - Test edge cases (rapid taps, interruptions, pause during animations, abilities during animations)
  - Verify tutorial includes new features (modes, points, abilities)
  - Test statistics tracking accuracy
  - Fix any discovered bugs
  - _Requirements: 12.1, 12.3, 12.4_

- [ ] 24. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
