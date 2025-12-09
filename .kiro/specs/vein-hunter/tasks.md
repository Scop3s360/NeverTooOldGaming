# Implementation Plan

- [ ] 1. Set up project structure and core configuration
  - Create Godot project structure with proper folders (scenes, scripts, resources, assets)
  - Configure project settings for mobile (resolution, orientation, input)
  - Create GameState and GameConfig resource classes
  - Define biome configurations (7 biomes with depth ranges and resources)
  - Define tool upgrade configurations (5 tool types with costs and bonuses)
  - Define resource types and values (9 resource types)
  - _Requirements: All_

- [ ] 2. Implement MiningController for click mechanics
  - Create MiningController script to handle mining
  - Implement click detection on mine area
  - Add depth tracking and increment logic
  - Calculate mining power from base + tool multipliers
  - Emit signals for depth changes and milestones
  - _Requirements: 1.1, 1.2_

- [ ] 2.1 Write property test for click depth increase
  - **Property 1: Click depth increase**
  - **Validates: Requirements 1.1**

- [ ] 2.2 Write property test for milestone unlocks
  - **Property 2: Milestone unlock trigger**
  - **Validates: Requirements 1.4**

- [ ] 3. Implement ResourceManager for discovery and inventory
  - Create ResourceManager script to handle resources
  - Implement resource discovery logic based on depth and biome
  - Add weighted random selection for resource types
  - Implement inventory management (add, remove, query)
  - Calculate resource rarity and value based on depth
  - _Requirements: 2.1, 2.2, 2.3_

- [ ] 3.1 Write property test for resource discovery
  - **Property 3: Resource discovery on mining**
  - **Validates: Requirements 2.1**

- [ ] 3.2 Write property test for inventory addition
  - **Property 4: Resource inventory addition**
  - **Validates: Requirements 2.2**

- [ ] 3.3 Write property test for resource value scaling
  - **Property 5: Resource value scaling with depth**
  - **Validates: Requirements 2.3**

- [ ] 3.4 Write property test for biome-specific resources
  - **Property 16: Biome-specific resource spawning**
  - **Validates: Requirements 6.3**

- [ ] 4. Implement EconomyManager for credits and selling
  - Create EconomyManager script to track credits
  - Implement resource selling logic
  - Calculate sell prices based on resource type and quantity
  - Add credits earning and spending methods
  - Track total credits earned for statistics
  - _Requirements: 3.1, 3.2, 3.3, 3.4_

- [ ] 4.1 Write property test for sell availability
  - **Property 6: Sell availability with inventory**
  - **Validates: Requirements 3.1**

- [ ] 4.2 Write property test for credit calculation
  - **Property 7: Credit calculation correctness**
  - **Validates: Requirements 3.2**

- [ ] 4.3 Write property test for credits balance update
  - **Property 8: Credits balance update**
  - **Validates: Requirements 3.3**

- [ ] 5. Implement UpgradeManager for tools
  - Create UpgradeManager script to handle upgrades
  - Implement tool upgrade system (5 tool types)
  - Calculate upgrade costs with exponential scaling
  - Apply upgrade bonuses to mining power
  - Track upgrade levels per tool type
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

- [ ] 5.1 Write property test for upgrade purchase availability
  - **Property 9: Upgrade purchase availability**
  - **Validates: Requirements 4.1**

- [ ] 5.2 Write property test for mining power increase
  - **Property 10: Mining power increase on upgrade**
  - **Validates: Requirements 4.2**

- [ ] 5.3 Write property test for upgrade cap enforcement
  - **Property 21: Upgrade cap enforcement**
  - **Validates: Requirements 9.3**

- [ ] 6. Implement MinerManager for automation
  - Create MinerManager script to handle miners
  - Implement miner hiring system
  - Calculate idle mining rate from miner count and efficiency
  - Track miner count and efficiency levels
  - Calculate hire costs with exponential scaling
  - _Requirements: 5.1, 5.2_

- [ ] 6.1 Write property test for miner hire availability
  - **Property 11: Miner hire availability**
  - **Validates: Requirements 5.1**

- [ ] 6.2 Write property test for idle mining rate
  - **Property 12: Idle mining rate calculation**
  - **Validates: Requirements 5.2**

- [ ] 7. Implement IdleManager for offline progress
  - Create IdleManager script to handle idle earnings
  - Track last play timestamp
  - Calculate offline progress (depth and resources)
  - Generate idle earnings summary
  - Apply idle earnings on game resume
  - Cap maximum idle time (7 days)
  - _Requirements: 5.3, 5.4, 9.2_

- [ ] 7.1 Write property test for offline progress calculation
  - **Property 13: Offline progress calculation**
  - **Validates: Requirements 5.3**

- [ ] 7.2 Write property test for idle earnings accuracy
  - **Property 14: Idle earnings accuracy**
  - **Validates: Requirements 5.4**

- [ ] 7.3 Write property test for idle calculation accuracy
  - **Property 20: Idle calculation accuracy**
  - **Validates: Requirements 9.2**

- [ ] 8. Implement BiomeManager for depth progression
  - Create BiomeManager script to handle biomes
  - Define 7 biomes with depth ranges and themes
  - Implement biome detection based on current depth
  - Handle biome transitions
  - Provide biome-specific resource tables
  - _Requirements: 6.1, 6.2, 6.3, 6.4_

- [ ] 8.1 Write property test for biome transitions
  - **Property 15: Biome transition at threshold**
  - **Validates: Requirements 6.1**

- [ ] 9. Implement statistics tracking and achievements
  - Add deepest depth tracker
  - Add total resources mined counter
  - Add total credits earned counter
  - Implement achievement system with milestones
  - Award achievements on milestone completion
  - _Requirements: 8.1, 8.2, 8.3, 8.4_

- [ ] 9.1 Write property test for achievement awards
  - **Property 17: Achievement award on milestone**
  - **Validates: Requirements 8.3**

- [ ] 9.2 Write property test for statistics persistence
  - **Property 18: Statistics persistence**
  - **Validates: Requirements 8.4**

- [ ] 10. Implement game state management and persistence
  - Create GameStateManager with states (Playing, Paused, Tutorial, IdleSummary)
  - Implement state transitions
  - Handle game initialization
  - Implement save/load system
  - Persist all game data across sessions
  - _Requirements: 8.4, 9.2_

- [ ] 11. Implement input handling and stability
  - Create InputManager to handle clicks
  - Implement rapid click handling without lag
  - Add input validation and error handling
  - Ensure stability under invalid actions
  - _Requirements: 9.1, 9.4_

- [ ] 11.1 Write property test for rapid click stability
  - **Property 19: Rapid click stability**
  - **Validates: Requirements 9.1**

- [ ] 11.2 Write property test for invalid action stability
  - **Property 22: Invalid action stability**
  - **Validates: Requirements 9.4**

- [ ] 12. Create UI system
  - Create UIManager scene with HUD elements
  - Add depth display with large, readable numbers
  - Add credits balance display
  - Add mining power display
  - Add resource inventory display
  - Create upgrade shop UI with tool list and costs
  - Create miner hiring UI
  - Display idle earnings summary on return
  - Create statistics screen
  - Create tutorial overlay with steps
  - Implement tutorial progression
  - _Requirements: 1.2, 3.4, 4.3, 4.4, 5.4, 8.1, 8.2, 10.1, 10.2, 10.3, 10.4_

- [ ] 12.1 Write property test for tutorial progression
  - **Property 23: Tutorial progression correctness**
  - **Validates: Requirements 10.3**

- [ ] 12.2 Write property test for tutorial completion
  - **Property 24: Tutorial completion persistence**
  - **Validates: Requirements 10.4**

- [ ] 13. Implement VisualEffectsManager
  - Create VisualEffectsManager for particles and animations
  - Implement click particle burst effect
  - Add screen shake on click
  - Create resource discovery glow effect
  - Implement rare resource special effects
  - Add biome transition visual effects
  - Create upgrade power-up animation
  - Implement depth number popup on click
  - _Requirements: 1.3, 2.4, 6.2_

- [ ] 14. Implement AudioManager
  - Create AudioManager singleton
  - Add mining sound effects (drilling, varies with power)
  - Add resource discovery sounds (ding, rare fanfare)
  - Add economy sounds (sell, upgrade, hire)
  - Add biome transition ambient sounds
  - Implement background music (industrial/electronic with dwarven themes)
  - Add volume controls
  - _Requirements: 2.4, 7.3_

- [ ] 15. Implement futuristic dwarven visual theme
  - Design dwarven characters in sci-fi mining suits
  - Create tool visuals (laser drills, plasma cutters with neon accents)
  - Design mine shaft environment (dark industrial with glowing veins)
  - Create resource visuals with glow effects
  - Design UI with rugged metal textures and holographic displays
  - _Requirements: 7.1, 7.2, 7.4_

- [ ] 16. Implement biome visual themes
  - Create visual theme for Surface biome (rocky, daylight)
  - Create visual theme for Underground biome (dark caves, torches)
  - Create visual theme for Deep Caverns biome (massive caverns, bioluminescent)
  - Create visual theme for Magma Chamber biome (lava flows, orange glow)
  - Create visual theme for Crystal Caves biome (glowing crystals, blue/purple)
  - Create visual theme for Alien Depths biome (otherworldly, green glow)
  - Create visual theme for Quantum Void biome (abstract space, reality distortion)
  - Implement smooth transitions between biome visuals
  - _Requirements: 6.2_

- [ ] 17. Create resource artwork and assets
  - Design 9 resource types with distinct visuals
  - Add glow effects for alien minerals
  - Create particle effects for each resource type
  - Ensure resources fit futuristic dwarven aesthetic
  - Optimize textures for mobile
  - _Requirements: 7.2_

- [ ] 18. Polish and optimization
  - Implement efficient depth display updates
  - Optimize particle systems for mobile
  - Cache mining power calculations
  - Implement formula-based idle calculations (no simulation)
  - Add juice (screen shake intensity, particle variety)
  - Tune click feedback for satisfying feel
  - Balance upgrade costs and progression curve
  - _Requirements: 1.3, 9.1_

- [ ] 19. Mobile optimization and testing
  - Test on various screen sizes and resolutions
  - Ensure large tap area for mine (minimum 200x200 pixels)
  - Test performance on mid-range mobile devices
  - Implement battery optimization (reduce effects, lower FPS when idle)
  - Add haptic feedback for clicks and discoveries
  - Test save/load performance
  - Test idle calculation performance (up to 7 days)
  - _Requirements: 9.1, 9.2_

- [ ] 20. Final testing and bug fixes
  - Test full game loop multiple times
  - Test all biome transitions
  - Verify idle progress calculations for various time periods
  - Test upgrade system at all levels
  - Test miner hiring and automation
  - Verify statistics tracking accuracy
  - Test rapid clicking without issues
  - Test save/load across sessions
  - Fix any discovered bugs
  - _Requirements: 9.1, 9.2, 9.3, 9.4_

- [ ] 21. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
