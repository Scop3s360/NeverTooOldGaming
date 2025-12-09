# Siege and Storm - Design Document

## Overview

Siege and Storm is a dual-phase tower defense game built in Godot 4.2 targeting mobile and PC platforms. Players place towers to defend against enemy waves (Defense Phase), then convert those towers to spawn units that attack the enemy base (Attack Phase). The game features a medieval fantasy cartoon aesthetic with bright colors, exaggerated proportions, and playful visual effects. The unique dual-phase mechanic creates strategic depth as tower placement must consider both defensive coverage and offensive unit spawning.

## Architecture

### High-Level Structure

```
Game Scene (Main)
├── Phase Manager (Defense/Attack Phase Control)
├── Tower Manager (Placement, Upgrades, Mode Switching)
├── Enemy Manager (Wave Spawning, Pathfinding)
├── Unit Manager (Spawning, Pathfinding, Combat)
├── Combat Manager (Damage Calculation, Targeting)
├── Economy Manager (Currency, Costs)
├── Path Manager (Enemy/Unit Routes)
├── Level Manager (Progression, Configuration)
├── UI Manager (HUD, Menus, Tutorial)
├── Visual Effects Manager (Particles, Animations)
└── Audio Manager (Sound Effects, Music)
```

### Design Patterns

- **State Machine**: Game phases (Defense, Attack, Victory, Defeat, Paused, Tutorial)
- **Observer Pattern**: Phase changes notify all relevant systems
- **Factory Pattern**: Tower and unit creation based on type
- **Strategy Pattern**: Different targeting strategies per tower type
- **Command Pattern**: Player actions (place tower, upgrade, convert) as commands

## Components and Interfaces

### PhaseManager

**Responsibilities:**
- Track current game phase
- Handle phase transitions
- Coordinate phase-specific behaviors
- Emit signals for phase changes

**Key Methods:**
```gdscript
start_defense_phase() -> void
start_attack_phase() -> void
end_level(victory: bool) -> void
get_current_phase() -> GamePhase
```

**Data:**
```gdscript
enum GamePhase {
    SETUP,      # Initial tower placement
    DEFENSE,    # Defending against waves
    ATTACK,     # Attacking enemy base
    VICTORY,    # Level completed
    DEFEAT,     # Level failed
    PAUSED,     # Game paused
    TUTORIAL    # Tutorial active
}
```

**Signals:**
```gdscript
signal phase_changed(new_phase: GamePhase)
signal defense_phase_started()
signal attack_phase_started()
signal level_ended(victory: bool)
```

### TowerManager

**Responsibilities:**
- Handle tower placement and validation
- Manage tower upgrades
- Convert towers between defense and attack modes
- Track all placed towers

**Key Methods:**
```gdscript
can_place_tower(position: Vector2, tower_type: TowerType) -> bool
place_tower(position: Vector2, tower_type: TowerType) -> Tower
upgrade_tower(tower: Tower) -> bool
convert_to_attack_mode(tower: Tower) -> void
get_tower_cost(tower_type: TowerType) -> int
get_upgrade_cost(tower: Tower) -> int
```

**Data:**
```gdscript
enum TowerType {
    ARCHER,     # Fast attack, low damage, spawns archer units
    CANNON,     # Slow attack, high damage, spawns knight units
    MAGE,       # Magic damage, area effect, spawns mage units
    BARRACKS    # Spawns multiple weak units continuously
}

class_name Tower
extends Node2D

@export var tower_type: TowerType
@export var level: int = 1
@export var damage: float
@export var attack_speed: float
@export var range: float
@export var is_attack_mode: bool = false
@export var unit_spawn_rate: float
```

**Signals:**
```gdscript
signal tower_placed(tower: Tower)
signal tower_upgraded(tower: Tower)
signal tower_converted(tower: Tower)
```

### EnemyManager

**Responsibilities:**
- Spawn enemy waves according to level configuration
- Manage enemy pathfinding
- Track active enemies
- Handle enemy defeat

**Key Methods:**
```gdscript
start_waves(wave_config: Array[WaveData]) -> void
spawn_wave(wave: WaveData) -> void
get_active_enemies() -> Array[Enemy]
on_enemy_defeated(enemy: Enemy) -> void
```

**Data:**
```gdscript
enum EnemyType {
    GOBLIN,     # Fast, weak
    ORC,        # Medium speed, medium health
    TROLL,      # Slow, high health
    DRAGON      # Flying, high health, fast
}

class_name Enemy
extends CharacterBody2D

@export var enemy_type: EnemyType
@export var max_health: float
@export var current_health: float
@export var speed: float
@export var damage_to_base: float
@export var currency_reward: int

class_name WaveData
extends Resource

@export var enemy_type: EnemyType
@export var count: int
@export var spawn_interval: float
@export var delay_before_wave: float
```

**Signals:**
```gdscript
signal wave_started(wave_number: int)
signal wave_completed(wave_number: int)
signal all_waves_completed()
signal enemy_reached_base(enemy: Enemy)
```

### UnitManager

**Responsibilities:**
- Spawn units from towers in attack mode
- Manage unit pathfinding toward enemy base
- Track active units
- Handle unit combat with enemy towers

**Key Methods:**
```gdscript
spawn_unit(tower: Tower) -> Unit
get_active_units() -> Array[Unit]
on_unit_defeated(unit: Unit) -> void
```

**Data:**
```gdscript
enum UnitType {
    ARCHER,     # Ranged, medium damage
    KNIGHT,     # Melee, high health
    MAGE,       # Ranged, magic damage
    SOLDIER     # Basic melee unit
}

class_name Unit
extends CharacterBody2D

@export var unit_type: UnitType
@export var max_health: float
@export var current_health: float
@export var speed: float
@export var damage: float
@export var attack_range: float
```

**Signals:**
```gdscript
signal unit_spawned(unit: Unit)
signal unit_reached_enemy_base(unit: Unit)
```

### CombatManager

**Responsibilities:**
- Calculate damage between entities
- Handle targeting logic
- Apply damage and check for defeats
- Manage combat timing

**Key Methods:**
```gdscript
tower_attack_enemy(tower: Tower, enemy: Enemy) -> void
unit_attack_tower(unit: Unit, tower: Tower) -> void
unit_attack_base(unit: Unit, base: Base) -> void
get_target_for_tower(tower: Tower, enemies: Array[Enemy]) -> Enemy
apply_damage(target: Node, damage: float) -> void
```

**Targeting Strategies:**
```gdscript
enum TargetingStrategy {
    CLOSEST,    # Target nearest enemy
    STRONGEST,  # Target highest health enemy
    WEAKEST,    # Target lowest health enemy
    FIRST       # Target enemy closest to base
}
```

### EconomyManager

**Responsibilities:**
- Track player currency
- Handle currency transactions
- Calculate costs for towers and upgrades
- Award currency for enemy defeats

**Key Methods:**
```gdscript
add_currency(amount: int) -> void
spend_currency(amount: int) -> bool
get_balance() -> int
can_afford(cost: int) -> bool
```

**Signals:**
```gdscript
signal currency_changed(new_balance: int)
```

### PathManager

**Responsibilities:**
- Define paths for enemies and units
- Provide waypoints for pathfinding
- Handle path following logic

**Key Methods:**
```gdscript
get_enemy_path() -> Path2D
get_unit_path() -> Path2D
get_next_waypoint(current_position: Vector2, path: Path2D) -> Vector2
```

### LevelManager

**Responsibilities:**
- Load level configurations
- Track level progression
- Calculate star ratings
- Handle level unlocking

**Key Methods:**
```gdscript
load_level(level_id: int) -> LevelConfig
complete_level(level_id: int, performance: LevelPerformance) -> void
calculate_star_rating(performance: LevelPerformance) -> int
is_level_unlocked(level_id: int) -> bool
```

**Data:**
```gdscript
class_name LevelConfig
extends Resource

@export var level_id: int
@export var level_name: String
@export var starting_currency: int
@export var player_base_health: int
@export var enemy_base_health: int
@export var waves: Array[WaveData]
@export var available_tower_types: Array[TowerType]
@export var enemy_tower_positions: Array[Vector2]

class_name LevelPerformance
extends Resource

@export var base_health_remaining: int
@export var time_taken: float
@export var currency_remaining: int
```

### Base

**Responsibilities:**
- Track base health
- Handle damage received
- Emit signals for health changes

**Key Methods:**
```gdscript
take_damage(amount: float) -> void
get_health() -> float
is_destroyed() -> bool
```

**Signals:**
```gdscript
signal health_changed(current_health: float, max_health: float)
signal base_destroyed()
```

## Data Models

### GameState

```gdscript
class_name GameState
extends Resource

@export var current_level: int = 1
@export var unlocked_levels: Array[int] = [1]
@export var completed_levels: Array[int] = []
@export var level_star_ratings: Dictionary = {}  # level_id -> stars (1-3)
@export var total_enemies_defeated: int = 0
@export var total_damage_dealt: int = 0
@export var achievements_unlocked: Array[String] = []
@export var tutorial_completed: bool = false
```

### SessionData

```gdscript
class_name SessionData
extends Resource

@export var level_id: int
@export var current_phase: GamePhase
@export var currency: int
@export var player_base_health: int
@export var enemy_base_health: int
@export var current_wave: int
@export var placed_towers: Array[Tower] = []
@export var enemies_defeated_this_level: int = 0
```

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*


### Property 1: Valid placement acceptance
*For any* valid tower placement position, the system should allow placing a tower there.
**Validates: Requirements 1.1**

### Property 2: Currency deduction on placement
*For any* tower placement, the currency should decrease by exactly the tower's cost.
**Validates: Requirements 1.2**

### Property 3: Invalid placement rejection
*For any* invalid tower placement position, the system should reject the placement.
**Validates: Requirements 1.3**

### Property 4: Insufficient currency rejection
*For any* tower placement attempt where currency < cost, the placement should be rejected.
**Validates: Requirements 1.4**

### Property 5: Enemy targeting in range
*For any* enemy within a tower's range, the tower should target and attack it.
**Validates: Requirements 2.1**

### Property 6: Damage application correctness
*For any* tower attack, the damage dealt should equal the tower's damage stat.
**Validates: Requirements 2.2**

### Property 7: Enemy defeat handling
*For any* enemy whose health reaches zero, it should be removed and currency should be awarded.
**Validates: Requirements 2.3**

### Property 8: Targeting priority correctness
*For any* tower with multiple enemies in range, the target selected should match the tower's targeting strategy.
**Validates: Requirements 2.4**

### Property 9: Wave spawning correctness
*For any* level configuration, enemies should spawn according to the wave definitions.
**Validates: Requirements 3.1**

### Property 10: Base damage on enemy arrival
*For any* enemy reaching the player's base, the base should take damage equal to the enemy's damage_to_base value.
**Validates: Requirements 3.2**

### Property 11: Defeat condition trigger
*For any* game state where player base health reaches zero, the level should end in defeat.
**Validates: Requirements 3.3**

### Property 12: Phase transition on wave completion
*For any* defense phase where all waves are defeated, the system should transition to attack phase.
**Validates: Requirements 3.4**

### Property 13: Attack mode conversion availability
*For any* tower during attack phase, it should be convertible to attack mode.
**Validates: Requirements 4.1**

### Property 14: Attack mode behavior change
*For any* tower converted to attack mode, it should stop attacking enemies and start spawning units.
**Validates: Requirements 4.2**

### Property 15: Unit spawning and movement
*For any* tower in attack mode, it should spawn units that move toward the enemy base.
**Validates: Requirements 4.3**

### Property 16: Spawn rate scaling
*For any* increase in attack-mode towers, the total unit spawn rate should increase proportionally.
**Validates: Requirements 4.4**

### Property 17: Unit pathfinding correctness
*For any* spawned unit, it should follow the path toward the enemy base.
**Validates: Requirements 5.1**

### Property 18: Unit combat engagement
*For any* unit encountering an enemy tower, combat should be initiated.
**Validates: Requirements 5.2**

### Property 19: Unit base damage
*For any* unit reaching the enemy base, the base should take damage equal to the unit's damage value.
**Validates: Requirements 5.3**

### Property 20: Victory condition trigger
*For any* game state where enemy base health reaches zero, the level should end in victory.
**Validates: Requirements 5.4**

### Property 21: Upgrade availability
*For any* tower upgrade attempt, it should succeed if and only if currency >= upgrade cost.
**Validates: Requirements 6.1**

### Property 22: Upgrade stat increase
*For any* tower upgrade, the tower's stats (damage, range, or attack speed) should increase by the defined amount.
**Validates: Requirements 6.2**

### Property 23: Upgrade unit improvement
*For any* upgraded tower in attack mode, the units it spawns should have improved stats.
**Validates: Requirements 6.3**

### Property 24: Tower type differentiation
*For any* two different tower types, they should have distinct attack patterns and behaviors.
**Validates: Requirements 7.2**

### Property 25: Unit-tower type correspondence
*For any* tower spawning units, the unit type should match the tower type (archer tower → archer units).
**Validates: Requirements 7.3**

### Property 26: Level unlock progression
*For any* completed level N, level N+1 should become unlocked.
**Validates: Requirements 9.1**

### Property 27: Difficulty scaling
*For any* two levels where level A > level B, level A should have equal or greater difficulty (more/stronger enemies).
**Validates: Requirements 9.2**

### Property 28: Star rating calculation
*For any* level completion, the star rating (1-3) should be calculated correctly based on performance metrics.
**Validates: Requirements 10.3**

### Property 29: Achievement award on milestone
*For any* achievement milestone reached, the achievement should be awarded.
**Validates: Requirements 10.4**

### Property 30: Collision handling stability
*For any* overlapping towers or units, the system should remain stable without crashes.
**Validates: Requirements 11.1**

### Property 31: Pause state preservation
*For any* game state, pausing and resuming should result in an identical game state.
**Validates: Requirements 11.2**

### Property 32: Rapid action stability
*For any* sequence of rapid player actions, the system should remain stable without lag or crashes.
**Validates: Requirements 11.3**

### Property 33: Invalid action stability
*For any* invalid action attempt, the system should remain stable without crashes.
**Validates: Requirements 11.4**

### Property 34: Tutorial progression correctness
*For any* tutorial step completion, the system should advance to the next step correctly.
**Validates: Requirements 12.3**

### Property 35: Tutorial completion and unlock
*For any* completed tutorial, the completion flag should be set and the first level should be unlocked.
**Validates: Requirements 12.4**

## Error Handling

### Tower Operations
- **Invalid Placement**: Reject placement, return false, show feedback
- **Insufficient Currency**: Reject action, display required amount
- **Upgrade Beyond Max**: Cap at maximum level, inform player
- **Null Tower Reference**: Log error, skip operation

### Combat Operations
- **Invalid Target**: Skip attack, log warning
- **Negative Damage**: Clamp to 0, log error
- **Health Overflow**: Cap at maximum health
- **Targeting Failure**: Default to closest enemy

### Pathfinding
- **No Path Available**: Use direct line to target
- **Stuck Entity**: Teleport to next waypoint after timeout
- **Invalid Waypoint**: Skip to next valid waypoint

### Phase Transitions
- **Premature Transition**: Validate conditions before transitioning
- **Invalid Phase**: Log error, maintain current phase
- **Concurrent Transitions**: Queue transitions, process sequentially

## Testing Strategy

### Unit Testing

Unit tests will verify specific examples and edge cases:

- **Tower placement**: Specific positions (valid/invalid)
- **Damage calculations**: Specific tower/enemy combinations
- **Currency transactions**: Specific costs and balances
- **Wave spawning**: Specific wave configurations
- **Phase transitions**: Specific completion conditions
- **Star ratings**: Specific performance metrics

### Property-Based Testing

Property-based tests will verify universal properties across many random inputs using **GdUnit4**:

- Each property test will run a minimum of 100 iterations
- Tests will use custom generators for game states, tower placements, enemy waves
- Each test will be tagged with: `# Feature: siege-and-storm, Property X: [property description]`

**Key Property Tests:**
- Tower system (Properties 1, 2, 3, 4, 21, 22, 23)
- Combat system (Properties 5, 6, 7, 8, 18, 19)
- Enemy system (Properties 9, 10, 11)
- Phase system (Properties 12, 13, 14, 15, 16)
- Unit system (Properties 17, 18, 19)
- Victory/Defeat (Properties 11, 20)
- Progression (Properties 26, 27, 28, 29)
- Stability (Properties 30, 31, 32, 33)
- Tutorial (Properties 34, 35)

**Custom Generators:**
```gdscript
# Generate random tower placement
func generate_tower_placement() -> Dictionary:
    return {
        "position": Vector2(randf_range(0, 1000), randf_range(0, 600)),
        "type": randi_range(0, TowerType.size() - 1)
    }

# Generate random game state
func generate_game_state() -> SessionData:
    var state = SessionData.new()
    state.currency = randi_range(0, 10000)
    state.player_base_health = randi_range(0, 1000)
    state.current_wave = randi_range(0, 10)
    return state

# Generate random enemy wave
func generate_wave() -> WaveData:
    var wave = WaveData.new()
    wave.enemy_type = randi_range(0, EnemyType.size() - 1)
    wave.count = randi_range(5, 20)
    wave.spawn_interval = randf_range(0.5, 2.0)
    return wave
```

### Integration Testing

Integration tests will verify component interactions:
- TowerManager + CombatManager: Towers attack enemies correctly
- EnemyManager + PathManager: Enemies follow paths correctly
- PhaseManager + TowerManager: Phase transitions affect tower behavior
- UnitManager + CombatManager: Units attack enemy towers and base
- Full game loop: Place towers → Defend → Convert → Attack → Win/Lose

## Performance Considerations

### Target Performance
- **Frame Rate**: Maintain 60 FPS with 20+ towers and 50+ enemies/units
- **Pathfinding**: < 1ms per entity per frame
- **Combat Calculations**: < 5ms total per frame
- **UI Updates**: < 2ms per frame

### Optimization Strategies
- **Spatial Partitioning**: Use quadtree for tower-enemy range checks
- **Batch Processing**: Process all combat in single pass
- **Cached Paths**: Pre-calculate paths, don't recalculate each frame
- **Object Pooling**: Reuse enemy and unit instances
- **LOD System**: Reduce detail for distant entities

## Mobile Considerations

### Screen Sizes
- Support both portrait and landscape orientations
- Scale UI elements proportionally
- Ensure tower placement targets are minimum 60x60 pixels
- Adjust camera zoom for different screen sizes

### Touch Interactions
- Tap to select tower type
- Tap valid spot to place
- Tap tower to view info/upgrade
- Pinch to zoom (optional)
- Clear visual feedback for all interactions

### Performance
- Limit maximum entities on screen (100 total)
- Reduce particle effects on low-end devices
- Lower physics tick rate if needed
- Efficient rendering (sprite batching)

## Visual Design

### Medieval Fantasy Cartoon Aesthetic
- **Art Style**: Bright colors, thick outlines, exaggerated proportions
- **Towers**: Stylized castles, colorful flags, animated elements
- **Enemies**: Cute but menacing goblins, orcs, trolls
- **Units**: Heroic knights, archers, mages with oversized weapons
- **Effects**: Sparkles, puffs of smoke, exaggerated impacts

### Visual Effects
- **Tower Attack**: Projectile with trail, impact sparkle
- **Enemy Defeat**: Puff of smoke, coin popup
- **Tower Placement**: Build animation, dust particles
- **Phase Transition**: Screen flash, banner display
- **Upgrade**: Glow effect, power-up animation

## Audio Design

### Sound Effects
- **Tower Placement**: Building sound, hammer hits
- **Tower Attack**: Bow twang, cannon boom, magic whoosh
- **Enemy Defeat**: Satisfying pop, coin sound
- **Base Damage**: Impact sound, alarm
- **Upgrade**: Power-up sound
- **Phase Transition**: Fanfare, dramatic music shift
- **Victory/Defeat**: Triumphant/sad music sting

### Music
- **Main Game**: Upbeat medieval fantasy music
- **Defense Phase**: Tense, action-oriented
- **Attack Phase**: Heroic, triumphant
- **Victory**: Celebratory fanfare
- **Defeat**: Somber theme

## Future Extensibility

### Potential Features
- **More Tower Types**: Tesla coil, ice tower, poison tower
- **Hero Units**: Special powerful units with abilities
- **Tower Abilities**: Active abilities players can trigger
- **Endless Mode**: Survive as many waves as possible
- **Multiplayer**: Compete or cooperate with other players
- **Custom Levels**: Level editor for players
- **Seasonal Events**: Special themed levels and towers

### Architecture Support
- Component-based design allows easy addition of new tower types
- Factory pattern supports new enemy and unit types
- Phase system can accommodate additional phases
- Level system supports unlimited levels and configurations
- Achievement system can track any milestone

