# Implementation Plan

- [ ] 1. Set up project structure and core configuration
  - Create Godot project structure with proper folders (scenes, scripts, resources, assets)
  - Configure project settings for mobile (resolution, orientation, input)
  - Set up physics layers and collision masks
  - Create GameConfig resource with all configuration values
  - _Requirements: All_

- [ ] 2. Implement container and physics world
  - Create Container scene with StaticBody2D walls (left, right, bottom)
  - Add Area2D at top for game-over detection
  - Configure physics materials (friction, restitution)
  - Test container boundaries prevent shapes from escaping
  - _Requirements: 1.1, 1.2, 9.1_

- [ ] 3. Implement Shape class and visual representation
  - Create Shape scene as RigidBody2D with CollisionShape2D
  - Implement ShapeData resource class with tier, type, color, points
  - Create visual representation with Sprite2D and neon glow shader
  - Implement shape type variations for each tier (circle, square, triangle, etc.)
  - Add shape colors from neon palette
  - _Requirements: 2.1, 6.1_

- [ ] 3.1 Write property test for shape physics
  - **Property 2: Physics enabled on drop**
  - **Validates: Requirements 1.2**

- [ ] 4. Implement DropController for shape spawning
  - Create DropController script to handle shape generation
  - Implement weighted random shape generation with tier probabilities
  - Implement variety constraint (no more than 3 consecutive same shapes)
  - Create method to spawn shape at specified horizontal position
  - Implement position clamping to container bounds
  - _Requirements: 1.1, 1.3, 1.4, 3.2, 3.3_

- [ ] 4.1 Write property test for drop position correctness
  - **Property 1: Drop position correctness**
  - **Validates: Requirements 1.1, 1.4**

- [ ] 4.2 Write property test for next shape generation
  - **Property 3: Next shape generation invariant**
  - **Validates: Requirements 1.3**

- [ ] 4.3 Write property test for tier probability distribution
  - **Property 9: Tier probability distribution**
  - **Validates: Requirements 3.2**

- [ ] 4.4 Write property test for shape variety constraint
  - **Property 10: Shape variety constraint**
  - **Validates: Requirements 3.3**

- [ ] 5. Implement touch input handling
  - Create InputManager to handle touch events
  - Implement touch-to-drop functionality
  - Add drop preview indicator that follows touch position
  - Implement hold-and-drag to position before dropping
  - Connect input to DropController
  - _Requirements: 1.1, 8.1, 8.3, 8.4_

- [ ] 6. Implement MergeManager for collision detection
  - Create MergeManager script to listen for shape collisions
  - Implement collision detection between shapes
  - Add logic to check if two shapes can merge (same tier)
  - Implement merge queue to handle concurrent merges
  - _Requirements: 2.1_

- [ ] 6.1 Write property test for merge detection
  - **Property 4: Merge detection correctness**
  - **Validates: Requirements 2.1**

- [ ] 7. Implement merge execution logic
  - Implement merge operation: remove two shapes, spawn higher-tier shape
  - Calculate merge position (midpoint of colliding shapes)
  - Handle tier progression (tier N + tier N = tier N+1)
  - Implement max-tier detection and pop behavior
  - _Requirements: 2.2, 2.5_

- [ ] 7.1 Write property test for merge execution
  - **Property 5: Merge execution correctness**
  - **Validates: Requirements 2.2**

- [ ] 7.2 Write property test for max tier pop
  - **Property 8: Max tier pop behavior**
  - **Validates: Requirements 2.5**

- [ ] 8. Implement chain reaction system
  - Add logic to detect when newly merged shape touches another identical shape
  - Implement recursive or queued merge processing for chains
  - Track chain length for statistics
  - _Requirements: 2.3_

- [ ] 8.1 Write property test for chain reactions
  - **Property 6: Chain reaction triggering**
  - **Validates: Requirements 2.3**

- [ ] 9. Implement scoring system
  - Create ScoreManager to track current score
  - Implement point calculation based on shape tier
  - Add bonus points for max-tier pops
  - Track highest tier reached
  - Emit signals for score changes
  - _Requirements: 2.4, 2.5, 5.1_

- [ ] 9.1 Write property test for merge scoring
  - **Property 7: Merge scoring correctness**
  - **Validates: Requirements 2.4**

- [ ] 9.2 Write property test for exponential score scaling
  - **Property 16: Exponential score scaling**
  - **Validates: Requirements 5.1**

- [ ] 10. Implement TimerManager
  - Create TimerManager script with countdown timer
  - Implement start, pause, resume functionality
  - Emit signals for time updates and expiration
  - Handle timer reaching zero (trigger game over)
  - _Requirements: 4.3, 4.4, 5.3, 5.4_

- [ ] 11. Implement game state management
  - Create GameStateManager with states (Playing, Paused, GameOver)
  - Implement state transitions
  - Handle game initialization (start new session)
  - Implement game over detection (timer expires or container full)
  - Implement restart functionality
  - _Requirements: 7.1, 7.2, 7.4, 9.1_

- [ ] 11.1 Write property test for game over detection
  - **Property 17: Game over on stack overflow**
  - **Validates: Requirements 9.1**

- [ ] 11.2 Write property test for pause-resume
  - **Property 19: Pause-resume state preservation**
  - **Validates: Requirements 9.4**

- [ ] 12. Implement PowerUpManager
  - Create PowerUpManager script to track power-up counts
  - Implement power-up types (Skip, DoubleDrop, SlowTime, ClearBottom)
  - Add milestone detection logic (award power-ups at score thresholds)
  - Implement skip shape power-up
  - Implement double-drop power-up
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

- [ ] 12.1 Write property test for power-up unlocks
  - **Property 12: Power-up unlock on milestone**
  - **Validates: Requirements 4.1**

- [ ] 12.2 Write property test for skip power-up
  - **Property 13: Skip power-up behavior**
  - **Validates: Requirements 4.2**

- [ ] 12.3 Write property test for double-drop power-up
  - **Property 14: Double-drop power-up behavior**
  - **Validates: Requirements 4.3**

- [ ] 12.4 Write property test for power-up count decrement
  - **Property 15: Power-up count decrement**
  - **Validates: Requirements 4.4**

- [ ] 13. Implement adaptive difficulty
  - Add logic to track player progress (average tier of shapes in container)
  - Implement probability adjustment based on progress
  - Gradually increase higher-tier shape spawn rates
  - _Requirements: 3.4_

- [ ] 13.1 Write property test for adaptive difficulty
  - **Property 11: Adaptive difficulty**
  - **Validates: Requirements 3.4**

- [ ] 14. Create UI system
  - Create UIManager scene with HUD elements
  - Add score display label
  - Add timer display label
  - Add next shape preview area
  - Add power-up buttons with count displays
  - Create pause menu
  - Create game over screen with final stats
  - Create tutorial overlay with speech bubbles
  - Implement tutorial progression (tap to advance)
  - Add "skip tutorial" option
  - Track tutorial completion state
  - _Requirements: 3.1, 5.2, 7.3, 10.1, 10.2, 10.3, 10.4_

- [ ] 15. Implement VisualEffectsManager
  - Create VisualEffectsManager for particle effects
  - Implement merge particle effect (color blend of merging shapes)
  - Implement max-tier pop explosion effect
  - Implement screen shake on max-tier pop
  - Add neon glow shader to shapes
  - Create drop trail effect
  - _Requirements: 2.3, 6.3, 6.4_

- [ ] 16. Implement AudioManager
  - Create AudioManager singleton
  - Add sound effects (drop, merge, pop, power-up, game over)
  - Implement pitch variation for merge sounds based on tier
  - Add background music (synthwave/cyberpunk)
  - Implement volume controls
  - _Requirements: 2.3_

- [ ] 17. Implement neon cyberpunk visual theme
  - Create dark gradient background
  - Apply neon colors to all shapes based on tier
  - Add glow shaders to shapes and UI elements
  - Style container with neon outline
  - Apply cyberpunk aesthetic to all UI elements
  - _Requirements: 6.1, 6.2_

- [ ] 18. Polish and optimization
  - Implement object pooling for shapes and particles
  - Optimize physics performance (collision layers, sleeping bodies)
  - Add juice (screen shake, particle effects, sound timing)
  - Tune physics parameters (gravity, friction, damping)
  - Test and adjust difficulty curve
  - _Requirements: 8.2, 9.3_

- [ ] 18.1 Write property test for system stability
  - **Property 18: System stability under physics**
  - **Validates: Requirements 9.3**

- [ ] 19. Mobile optimization and testing
  - Test on various screen sizes and resolutions
  - Optimize touch target sizes (minimum 44x44 pixels)
  - Test performance on mid-range mobile devices
  - Implement battery optimization (reduce effects on low battery)
  - Add haptic feedback for merges and pops
  - _Requirements: 7.1, 7.2, 7.3, 7.4, 8.2_

- [ ] 20. Final testing and bug fixes
  - Test full game loop multiple times
  - Test edge cases (rapid drops, long chains, full container)
  - Verify all power-ups work correctly
  - Test pause/resume functionality
  - Test game over conditions (timer and overflow)
  - Fix any discovered bugs
  - _Requirements: 8.3, 9.2, 9.4_

- [ ] 21. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
