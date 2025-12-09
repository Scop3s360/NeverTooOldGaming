# Implementation Plan

- [ ] 1. Set up project structure and core configuration
  - Create Godot project structure with proper folders (scenes, scripts, resources, assets)
  - Configure project settings for mobile and PC (resolution, orientation, input)
  - Create GameState and SessionData resource classes
  - Create LevelConfig, WaveData, and performance tracking classes
  - Define 4 tower types with stats (Archer, Cannon, Mage, Barracks)
  - Define 4 enemy types with stats (Goblin, Orc, Troll, Dragon)
  - Define initial level configurations (levels 1-10)
  - _Requirements: All_

- [ ] 2. Implement Base class for player and enemy bases
  - Create Base scene with health tracking
  - Implement damage reception logic
  - Add health display
  - Emit signals for health changes and destruction
  - _Requirements: 3.2, 3.3, 5.3, 5.4_

- [ ] 3. Implement PathManager for entity movement
  - Create PathManager script to define paths
  - Implement enemy path (from spawn to player base)
  - Implement unit path (from player base to enemy base)
  - Add waypoint system for path following
  - _Requirements: 3.1, 5.1_

- [ ] 4. Implement Tower class and TowerManager
  - Create Tower scene with attack and spawn capabilities
  - Implement TowerManager script for placement and management
  - Add placement validation (valid spots, currency check)
  - Implement tower placement with currency deduction
  - Add tower upgrade system
  - Track all placed towers
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 6.1, 6.2_

- [ ] 4.1 Write property test for valid placement
  - **Property 1: Valid placement acceptance**
  - **Validates: Requirements 1.1**

- [ ] 4.2 Write property test for currency deduction
  - **Property 2: Currency deduction on placement**
  - **Validates: Requirements 1.2**

- [ ] 4.3 Write property test for invalid placement rejection
  - **Property 3: Invalid placement rejection**
  - **Validates: Requirements 1.3**

- [ ] 4.4 Write property test for insufficient currency rejection
  - **Property 4: Insufficient currency rejection**
  - **Validates: Requirements 1.4**

- [ ] 4.5 Write property test for upgrade availability
  - **Property 21: Upgrade availability**
  - **Validates: Requirements 6.1**

- [ ] 4.6 Write property test for upgrade stat increase
  - **Property 22: Upgrade stat increase**
  - **Validates: Requirements 6.2**

- [ ] 5. Implement Enemy class and EnemyManager
  - Create Enemy scene with health, movement, and pathfinding
  - Implement EnemyManager script for wave spawning
  - Add wave configuration system
  - Implement enemy pathfinding along defined path
  - Handle enemy defeat and currency rewards
  - Track active enemies
  - _Requirements: 2.3, 3.1, 3.2_

- [ ] 5.1 Write property test for wave spawning
  - **Property 9: Wave spawning correctness**
  - **Validates: Requirements 3.1**

- [ ] 5.2 Write property test for base damage on arrival
  - **Property 10: Base damage on enemy arrival**
  - **Validates: Requirements 3.2**

- [ ] 5.3 Write property test for enemy defeat handling
  - **Property 7: Enemy defeat handling**
  - **Validates: Requirements 2.3**

- [ ] 6. Implement CombatManager for damage and targeting
  - Create CombatManager script to handle all combat
  - Implement tower-to-enemy combat
  - Implement unit-to-tower combat
  - Implement unit-to-base combat
  - Add targeting logic with multiple strategies (closest, strongest, etc.)
  - Calculate and apply damage
  - _Requirements: 2.1, 2.2, 2.4, 5.2, 5.3_

- [ ] 6.1 Write property test for enemy targeting
  - **Property 5: Enemy targeting in range**
  - **Validates: Requirements 2.1**

- [ ] 6.2 Write property test for damage application
  - **Property 6: Damage application correctness**
  - **Validates: Requirements 2.2**

- [ ] 6.3 Write property test for targeting priority
  - **Property 8: Targeting priority correctness**
  - **Validates: Requirements 2.4**

- [ ] 6.4 Write property test for unit combat engagement
  - **Property 18: Unit combat engagement**
  - **Validates: Requirements 5.2**

- [ ] 6.5 Write property test for unit base damage
  - **Property 19: Unit base damage**
  - **Validates: Requirements 5.3**

- [ ] 7. Implement PhaseManager for game flow
  - Create PhaseManager script to control phases
  - Implement defense phase logic
  - Implement attack phase logic
  - Handle phase transitions
  - Detect victory and defeat conditions
  - _Requirements: 3.3, 3.4, 4.1, 5.4_

- [ ] 7.1 Write property test for defeat condition
  - **Property 11: Defeat condition trigger**
  - **Validates: Requirements 3.3**

- [ ] 7.2 Write property test for phase transition
  - **Property 12: Phase transition on wave completion**
  - **Validates: Requirements 3.4**

- [ ] 7.3 Write property test for victory condition
  - **Property 20: Victory condition trigger**
  - **Validates: Requirements 5.4**

- [ ] 8. Implement tower attack mode conversion
  - Add attack mode toggle to towers
  - Implement behavior change (stop attacking, start spawning)
  - Track tower mode state
  - _Requirements: 4.1, 4.2_

- [ ] 8.1 Write property test for attack mode availability
  - **Property 13: Attack mode conversion availability**
  - **Validates: Requirements 4.1**

- [ ] 8.2 Write property test for attack mode behavior
  - **Property 14: Attack mode behavior change**
  - **Validates: Requirements 4.2**

- [ ] 9. Implement Unit class and UnitManager
  - Create Unit scene with health, movement, and combat
  - Implement UnitManager script for spawning and management
  - Add unit spawning from towers in attack mode
  - Implement unit pathfinding toward enemy base
  - Handle unit combat with enemy towers
  - Track active units
  - _Requirements: 4.3, 4.4, 5.1, 6.3_

- [ ] 9.1 Write property test for unit spawning and movement
  - **Property 15: Unit spawning and movement**
  - **Validates: Requirements 4.3**

- [ ] 9.2 Write property test for spawn rate scaling
  - **Property 16: Spawn rate scaling**
  - **Validates: Requirements 4.4**

- [ ] 9.3 Write property test for unit pathfinding
  - **Property 17: Unit pathfinding correctness**
  - **Validates: Requirements 5.1**

- [ ] 9.4 Write property test for upgrade unit improvement
  - **Property 23: Upgrade unit improvement**
  - **Validates: Requirements 6.3**

- [ ] 10. Implement EconomyManager for currency
  - Create EconomyManager script to track currency
  - Implement currency earning from enemy defeats
  - Implement currency spending for towers and upgrades
  - Add currency balance tracking
  - Emit signals for currency changes
  - _Requirements: 1.2, 1.4, 2.3, 6.1_

- [ ] 11. Implement tower type differentiation
  - Create distinct behaviors for each tower type
  - Implement Archer tower (fast, low damage, ranged)
  - Implement Cannon tower (slow, high damage, area effect)
  - Implement Mage tower (magic damage, special effects)
  - Implement Barracks tower (spawns multiple units)
  - Ensure unit types match tower types
  - _Requirements: 7.1, 7.2, 7.3_

- [ ] 11.1 Write property test for tower type differentiation
  - **Property 24: Tower type differentiation**
  - **Validates: Requirements 7.2**

- [ ] 11.2 Write property test for unit-tower correspondence
  - **Property 25: Unit-tower type correspondence**
  - **Validates: Requirements 7.3**

- [ ] 12. Implement LevelManager for progression
  - Create LevelManager script to handle levels
  - Implement level loading from configuration
  - Add level completion tracking
  - Implement level unlocking logic
  - Calculate star ratings based on performance
  - Track statistics (enemies defeated, damage dealt)
  - _Requirements: 9.1, 9.2, 9.3, 9.4, 10.3, 10.4_

- [ ] 12.1 Write property test for level unlock progression
  - **Property 26: Level unlock progression**
  - **Validates: Requirements 9.1**

- [ ] 12.2 Write property test for difficulty scaling
  - **Property 27: Difficulty scaling**
  - **Validates: Requirements 9.2**

- [ ] 12.3 Write property test for star rating calculation
  - **Property 28: Star rating calculation**
  - **Validates: Requirements 10.3**

- [ ] 12.4 Write property test for achievement awards
  - **Property 29: Achievement award on milestone**
  - **Validates: Requirements 10.4**

- [ ] 13. Implement game state management and stability
  - Create GameStateManager with state machine
  - Implement pause/resume functionality
  - Handle collision detection without errors
  - Ensure stability under rapid actions
  - Handle invalid actions gracefully
  - _Requirements: 11.1, 11.2, 11.3, 11.4_

- [ ] 13.1 Write property test for collision stability
  - **Property 30: Collision handling stability**
  - **Validates: Requirements 11.1**

- [ ] 13.2 Write property test for pause state preservation
  - **Property 31: Pause state preservation**
  - **Validates: Requirements 11.2**

- [ ] 13.3 Write property test for rapid action stability
  - **Property 32: Rapid action stability**
  - **Validates: Requirements 11.3**

- [ ] 13.4 Write property test for invalid action stability
  - **Property 33: Invalid action stability**
  - **Validates: Requirements 11.4**

- [ ] 14. Create UI system
  - Create UIManager scene with HUD elements
  - Add currency display
  - Add base health displays (player and enemy)
  - Add wave counter
  - Add tower selection panel
  - Create tower info/upgrade panel
  - Create level select screen
  - Create victory/defeat screens with star ratings
  - Create statistics screen
  - Create tutorial overlay
  - Implement tutorial progression
  - _Requirements: 1.3, 1.4, 6.4, 7.4, 9.3, 9.4, 10.1, 10.2, 12.1, 12.2, 12.3, 12.4_

- [ ] 14.1 Write property test for tutorial progression
  - **Property 34: Tutorial progression correctness**
  - **Validates: Requirements 12.3**

- [ ] 14.2 Write property test for tutorial completion
  - **Property 35: Tutorial completion and unlock**
  - **Validates: Requirements 12.4**

- [ ] 15. Implement VisualEffectsManager
  - Create VisualEffectsManager for particles and animations
  - Implement tower attack effects (projectiles, impacts)
  - Create enemy defeat effects (poof, coins)
  - Add tower placement animation
  - Implement phase transition effects
  - Create upgrade power-up animation
  - Add base damage effects
  - Implement victory/defeat animations
  - Apply cartoon styling to all effects
  - _Requirements: 1.3, 2.3, 8.3_

- [ ] 16. Implement AudioManager
  - Create AudioManager singleton
  - Add tower sound effects (bow, cannon, magic)
  - Add enemy sounds (defeat, movement)
  - Add UI sounds (placement, upgrade, button clicks)
  - Add phase transition sounds
  - Implement background music (defense, attack, victory, defeat)
  - Add volume controls
  - _Requirements: 8.3_

- [ ] 17. Implement medieval fantasy cartoon visual theme
  - Design cartoon-style towers with bright colors
  - Create cute enemy sprites (goblins, orcs, trolls)
  - Design heroic unit sprites (knights, archers, mages)
  - Create stylized base designs
  - Design playful UI with thick outlines
  - Apply exaggerated proportions to all characters
  - _Requirements: 8.1, 8.2, 8.4_

- [ ] 18. Create level maps and configurations
  - Design 10 level maps with paths
  - Create wave configurations for each level
  - Balance difficulty progression
  - Place enemy tower positions for attack phase
  - Define starting currency and base health per level
  - _Requirements: 9.1, 9.2_

- [ ] 19. Polish and optimization
  - Implement spatial partitioning for range checks
  - Optimize pathfinding with cached paths
  - Implement object pooling for enemies and units
  - Add juice (screen shake, particle variety, impact effects)
  - Tune combat feel (attack speed, damage feedback)
  - Balance tower costs and upgrade progression
  - Test with 20+ towers and 50+ entities
  - _Requirements: 11.3_

- [ ] 20. Mobile and PC optimization
  - Test on various screen sizes and orientations
  - Ensure tower placement targets are 60x60 pixels minimum
  - Test performance with maximum entities
  - Implement LOD system for distant entities
  - Add touch controls with clear feedback
  - Test keyboard/mouse controls for PC
  - Optimize rendering (sprite batching)
  - _Requirements: 11.3_

- [ ] 21. Final testing and bug fixes
  - Test full game loop for all levels
  - Test both phases (defense and attack) thoroughly
  - Verify all tower types work correctly
  - Test upgrade system at all levels
  - Verify phase transitions work smoothly
  - Test victory and defeat conditions
  - Verify statistics tracking accuracy
  - Test tutorial completeness
  - Fix any discovered bugs
  - _Requirements: 11.1, 11.2, 11.3, 11.4_

- [ ] 22. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.
