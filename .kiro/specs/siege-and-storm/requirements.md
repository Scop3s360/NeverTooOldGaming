# Requirements Document

## Introduction

Siege and Storm is a dual-phase tower defense game with a medieval fantasy cartoon aesthetic. Players defend their base against enemy waves using towers, then switch to an offensive phase where those same towers spawn units to attack the enemy base. The game features bright, stylized graphics with castles, knights, goblins, and magical elements. The unique dual-phase mechanic creates strategic depth as players must balance defensive positioning with offensive unit spawning.

## Glossary

- **Game System**: The Siege and Storm application including all game logic, UI, and data management
- **Player**: The user interacting with the game
- **Tower**: A defensive structure that attacks enemies during defense phase and spawns units during attack phase
- **Enemy**: An AI-controlled unit that attacks the player's base during defense phase
- **Unit**: A player-controlled entity spawned by towers during attack phase
- **Defense Phase**: The phase where the player defends against enemy waves
- **Attack Phase**: The phase where the player attacks the enemy base with spawned units
- **Base**: The structure that must be protected (player's base) or destroyed (enemy's base)
- **Wave**: A group of enemies that spawn during defense phase
- **Path**: The route enemies follow to reach the player's base
- **Health**: Hit points for bases, towers, enemies, and units
- **Damage**: The amount of health reduced by attacks
- **Currency**: Gold earned from defeating enemies, used to build and upgrade towers
- **Attack Mode**: The state where a tower spawns units instead of attacking
- **Level**: A specific map with defined paths, starting currency, and wave configurations

## Requirements

### Requirement 1

**User Story:** As a player, I want to place towers along the path, so that I can defend my base from enemy waves.

#### Acceptance Criteria

1. WHEN the player selects a tower type THEN the Game System SHALL allow placement on valid tower spots
2. WHEN a tower is placed THEN the Game System SHALL deduct the tower cost from the player's currency
3. WHEN the player attempts to place a tower on an invalid spot THEN the Game System SHALL prevent placement and show visual feedback
4. WHEN the player has insufficient currency THEN the Game System SHALL prevent tower placement and display the required amount

### Requirement 2

**User Story:** As a player, I want towers to automatically attack enemies in range, so that I can defend my base.

#### Acceptance Criteria

1. WHEN an enemy enters a tower's range THEN the Game System SHALL target and attack that enemy
2. WHEN a tower attacks THEN the Game System SHALL deal damage to the target enemy based on tower type
3. WHEN an enemy is defeated THEN the Game System SHALL remove it and award currency to the player
4. WHEN multiple enemies are in range THEN the Game System SHALL prioritize targets based on tower targeting strategy (closest, strongest, etc.)

### Requirement 3

**User Story:** As a player, I want to survive enemy waves, so that I can progress to the attack phase.

#### Acceptance Criteria

1. WHEN a defense phase starts THEN the Game System SHALL spawn enemy waves according to the level configuration
2. WHEN enemies reach the player's base THEN the Game System SHALL deal damage to the base
3. WHEN the player's base health reaches zero THEN the Game System SHALL end the level in defeat
4. WHEN all enemy waves are defeated THEN the Game System SHALL transition to the attack phase

### Requirement 4

**User Story:** As a player, I want to convert towers to attack mode, so that I can spawn units to attack the enemy base.

#### Acceptance Criteria

1. WHEN the attack phase begins THEN the Game System SHALL allow converting towers to attack mode
2. WHEN a tower is converted to attack mode THEN the Game System SHALL stop it from attacking and start spawning units
3. WHEN a tower spawns units THEN the Game System SHALL create units that move toward the enemy base
4. WHEN the player converts more towers THEN the Game System SHALL increase the unit spawn rate

### Requirement 5

**User Story:** As a player, I want my units to attack the enemy base, so that I can win the level.

#### Acceptance Criteria

1. WHEN units are spawned THEN the Game System SHALL move them along the path toward the enemy base
2. WHEN units encounter enemy towers THEN the Game System SHALL engage in combat
3. WHEN units reach the enemy base THEN the Game System SHALL deal damage to it
4. WHEN the enemy base health reaches zero THEN the Game System SHALL complete the level in victory

### Requirement 6

**User Story:** As a player, I want to upgrade towers, so that they become more effective in both phases.

#### Acceptance Criteria

1. WHEN the player has sufficient currency THEN the Game System SHALL allow upgrading towers
2. WHEN a tower is upgraded THEN the Game System SHALL increase its damage, range, or attack speed
3. WHEN a tower is upgraded THEN the Game System SHALL improve the units it spawns during attack phase
4. WHEN viewing a tower THEN the Game System SHALL display upgrade options and costs

### Requirement 7

**User Story:** As a player, I want different tower types with unique abilities, so that I can create diverse strategies.

#### Acceptance Criteria

1. WHEN the game starts THEN the Game System SHALL provide multiple tower types (archer, cannon, mage, etc.)
2. WHEN different tower types are used THEN the Game System SHALL apply unique attack patterns and effects
3. WHEN towers spawn units THEN the Game System SHALL spawn unit types matching the tower type
4. WHEN viewing tower types THEN the Game System SHALL display their stats and special abilities

### Requirement 8

**User Story:** As a player, I want the game to have a medieval fantasy cartoon aesthetic, so that I have an engaging visual experience.

#### Acceptance Criteria

1. WHEN the game is running THEN the Game System SHALL display cartoon-style medieval fantasy graphics
2. WHEN towers and units are shown THEN the Game System SHALL render them with bright colors and exaggerated proportions
3. WHEN combat occurs THEN the Game System SHALL display playful visual effects (sparkles, puffs, exaggerated impacts)
4. WHEN UI elements are displayed THEN the Game System SHALL use a friendly, cartoon-inspired design

### Requirement 9

**User Story:** As a player, I want to progress through levels of increasing difficulty, so that the game remains challenging.

#### Acceptance Criteria

1. WHEN a level is completed THEN the Game System SHALL unlock the next level
2. WHEN levels progress THEN the Game System SHALL increase difficulty with stronger enemies and more waves
3. WHEN starting a level THEN the Game System SHALL display the level number and difficulty rating
4. WHEN viewing the level select screen THEN the Game System SHALL show completed levels and available levels

### Requirement 10

**User Story:** As a player, I want to see my progress and statistics, so that I can track my performance.

#### Acceptance Criteria

1. WHEN a level is active THEN the Game System SHALL display current wave, base health, and currency
2. WHEN viewing statistics THEN the Game System SHALL show levels completed, enemies defeated, and total damage dealt
3. WHEN a level is completed THEN the Game System SHALL award a star rating based on performance
4. WHEN the player achieves milestones THEN the Game System SHALL award achievements

### Requirement 11

**User Story:** As a player, I want the game to handle edge cases gracefully, so that I have a smooth experience.

#### Acceptance Criteria

1. WHEN towers or units overlap THEN the Game System SHALL handle collisions without errors
2. WHEN the game is paused THEN the Game System SHALL freeze all gameplay and allow resuming
3. WHEN rapid actions are performed THEN the Game System SHALL process them without lag or crashes
4. WHEN invalid actions are attempted THEN the Game System SHALL provide clear feedback without disrupting gameplay

### Requirement 12

**User Story:** As a first-time player, I want a simple tutorial, so that I understand the dual-phase mechanics.

#### Acceptance Criteria

1. WHEN the player starts the game for the first time THEN the Game System SHALL display a tutorial level
2. WHEN the tutorial is active THEN the Game System SHALL explain tower placement, defense phase, and attack phase
3. WHEN the player completes tutorial steps THEN the Game System SHALL advance to the next step
4. WHEN the tutorial is completed THEN the Game System SHALL mark it as seen and unlock the first regular level
