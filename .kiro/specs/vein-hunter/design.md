# Vein Hunter - Design Document

## Overview

Vein Hunter is a mining-themed idle clicker game built in Godot 4.2 targeting mobile platforms. Players click to dig deeper into a mine shaft, discovering resources that can be sold for credits. Credits are used to upgrade mining tools and hire automated miners for idle progression. The game features a futuristic dwarven aesthetic with glowing alien minerals, industrial sci-fi visuals, and depth-based biome progression.

## Architecture

### High-Level Structure

```
Game Scene (Main)
├── Mining Controller (Click & Depth Management)
├── Resource Manager (Discovery & Inventory)
├── Economy Manager (Credits & Selling)
├── Upgrade Manager (Tools & Miners)
├── Idle Manager (Offline Progress)
├── Biome Manager (Depth-based Progression)
├── UI Manager (HUD, Menus, Tutorial)
├── Visual Effects Manager (Particles, Animations)
└── Audio Manager (Sound Effects, Music)
```

### Design Patterns

- **Observer Pattern**: Depth changes notify biome transitions, resource discovery, UI updates
- **Singleton Pattern**: Managers accessible globally
- **Strategy Pattern**: Different resource generation strategies per biome
- **State Machine**: Game states (Playing, Paused, Tutorial, IdleSummary)

## Components and Interfaces

### MiningController

**Responsibilities:**
- Handle click input for mining
- Track current depth
- Calculate mining power from tools and upgrades
- Emit signals for depth changes

**Key Methods:**
```gdscript
on_mine_click() -> void
increase_depth(amount: float) -> void
get_current_depth() -> float
get_mining_power() -> float
calculate_total_mining_power() -> float
```

**Properties:**
- `current_depth: float` - Current depth in meters
- `base_mining_power: float` - Base power per click
- `tool_multiplier: float` - Multiplier from tool upgrades

**Signals:**
```gdscript
signal depth_changed(new_depth: float)
signal milestone_reached(depth: float)
signal click_performed(position: Vector2)
```

### ResourceManager

**Responsibilities:**
- Generate resources based on depth and biome
- Manage resource inventory
- Track resource discovery rates
- Handle resource rarity and value

**Key Methods:**
```gdscript
discover_resource(depth: float, biome: Biome) -> Resource
add_to_inventory(resource: Resource) -> void
get_inventory() -> Dictionary  # resource_type -> quantity
calculate_discovery_chance(depth: float) -> float
get_resource_value(resource_type: ResourceType) -> int
```

**Data:**
```gdscript
enum ResourceType {
    COPPER,
    IRON,
    SILVER,
    GOLD,
    PLATINUM,
    DIAMOND,
    ALIEN_CRYSTAL,
    QUANTUM_ORE,
    DARK_MATTER
}

class_name Resource
extends Resource

@export var type: ResourceType
@export var rarity: float  # 0.0 to 1.0
@export var base_value: int
@export var glow_color: Color
```

**Signals:**
```gdscript
signal resource_discovered(resource: Resource)
signal rare_resource_found(resource: Resource)
```

### EconomyManager

**Responsibilities:**
- Track credits balance
- Handle resource selling
- Calculate sell prices
- Manage transactions

**Key Methods:**
```gdscript
sell_resource(resource_type: ResourceType, quantity: int) -> int
sell_all_resources() -> int
add_credits(amount: int) -> void
spend_credits(amount: int) -> bool
get_balance() -> int
can_afford(cost: int) -> bool
```

**Signals:**
```gdscript
signal credits_changed(new_balance: int)
signal resources_sold(total_value: int)
```

### UpgradeManager

**Responsibilities:**
- Manage tool upgrades
- Track upgrade levels
- Calculate upgrade costs
- Apply upgrade bonuses to mining power

**Key Methods:**
```gdscript
upgrade_tool(tool_type: ToolType) -> bool
get_upgrade_level(tool_type: ToolType) -> int
get_upgrade_cost(tool_type: ToolType, level: int) -> int
get_upgrade_bonus(tool_type: ToolType, level: int) -> float
calculate_total_tool_multiplier() -> float
```

**Data:**
```gdscript
enum ToolType {
    PICKAXE,        # Basic tool
    DRILL,          # Tier 2
    LASER_DRILL,    # Tier 3
    PLASMA_CUTTER,  # Tier 4
    QUANTUM_MINER   # Tier 5
}

class_name ToolUpgrade
extends Resource

@export var tool_type: ToolType
@export var level: int
@export var base_cost: int
@export var cost_multiplier: float = 1.5
@export var power_bonus: float
```

### MinerManager

**Responsibilities:**
- Manage hired miners
- Calculate idle mining rate
- Track miner count and levels
- Apply miner bonuses

**Key Methods:**
```gdscript
hire_miner() -> bool
get_miner_count() -> int
get_idle_mining_rate() -> float  # Depth per second
calculate_total_miner_power() -> float
upgrade_miner_efficiency() -> bool
```

**Data:**
```gdscript
class_name MinerData
extends Resource

@export var count: int = 0
@export var base_power: float = 1.0
@export var efficiency_level: int = 1
@export var hire_cost: int = 100
@export var cost_multiplier: float = 1.3
```

**Signals:**
```gdscript
signal miner_hired(new_count: int)
signal miners_working(depth_per_second: float)
```

### IdleManager

**Responsibilities:**
- Track time away from game
- Calculate offline progress
- Award idle earnings
- Generate idle summary

**Key Methods:**
```gdscript
on_game_paused(timestamp: float) -> void
on_game_resumed(timestamp: float) -> IdleEarnings
calculate_idle_progress(time_elapsed: float) -> IdleEarnings
apply_idle_earnings(earnings: IdleEarnings) -> void
```

**Data:**
```gdscript
class_name IdleEarnings
extends Resource

@export var depth_gained: float
@export var resources_found: Dictionary  # resource_type -> quantity
@export var time_elapsed: float
```

### BiomeManager

**Responsibilities:**
- Define biomes at depth ranges
- Handle biome transitions
- Provide biome-specific resource tables
- Manage biome visual themes

**Key Methods:**
```gdscript
get_current_biome(depth: float) -> Biome
check_biome_transition(old_depth: float, new_depth: float) -> bool
get_biome_resources(biome: Biome) -> Array[ResourceType]
```

**Data:**
```gdscript
enum BiomeType {
    SURFACE,           # 0-100m
    UNDERGROUND,       # 100-500m
    DEEP_CAVERNS,      # 500-1000m
    MAGMA_CHAMBER,     # 1000-2000m
    CRYSTAL_CAVES,     # 2000-5000m
    ALIEN_DEPTHS,      # 5000-10000m
    QUANTUM_VOID       # 10000m+
}

class_name Biome
extends Resource

@export var type: BiomeType
@export var name: String
@export var depth_min: float
@export var depth_max: float
@export var background_color: Color
@export var particle_color: Color
@export var available_resources: Array[ResourceType]
```

**Signals:**
```gdscript
signal biome_entered(biome: Biome)
```

### UIManager

**Responsibilities:**
- Display HUD (depth, credits, mining power, resources)
- Show upgrade shop
- Display idle earnings summary
- Manage tutorial overlay
- Show statistics screen

**Key Methods:**
```gdscript
update_depth_display(depth: float) -> void
update_credits_display(credits: int) -> void
update_mining_power_display(power: float) -> void
show_idle_summary(earnings: IdleEarnings) -> void
show_upgrade_shop() -> void
show_tutorial() -> void
```

## Data Models

### GameState

```gdscript
class_name GameState
extends Resource

@export var current_depth: float = 0.0
@export var credits_balance: int = 0
@export var resource_inventory: Dictionary = {}  # resource_type -> quantity
@export var tool_levels: Dictionary = {}  # tool_type -> level
@export var miner_count: int = 0
@export var miner_efficiency_level: int = 1
@export var deepest_depth_reached: float = 0.0
@export var total_resources_mined: int = 0
@export var total_credits_earned: int = 0
@export var achievements_unlocked: Array[String] = []
@export var tutorial_completed: bool = false
@export var last_play_timestamp: float = 0.0
```

### GameConfig

```gdscript
class_name GameConfig
extends Resource

@export var base_click_power: float = 1.0
@export var base_miner_power: float = 0.5
@export var resource_discovery_base_chance: float = 0.3
@export var biome_definitions: Array[Biome] = []
@export var tool_upgrade_configs: Array[ToolUpgrade] = []
@export var miner_hire_base_cost: int = 100
@export var miner_cost_multiplier: float = 1.3
```

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*


### Property 1: Click depth increase
*For any* click action, the depth should increase by exactly the current mining power value.
**Validates: Requirements 1.1**

### Property 2: Milestone unlock trigger
*For any* depth milestone threshold, reaching or exceeding that depth should trigger the corresponding unlock.
**Validates: Requirements 1.4**

### Property 3: Resource discovery on mining
*For any* mining action (click or idle), there should be a chance to discover resources based on current depth.
**Validates: Requirements 2.1**

### Property 4: Resource inventory addition
*For any* discovered resource, it should be added to the player's inventory with the correct quantity.
**Validates: Requirements 2.2**

### Property 5: Resource value scaling with depth
*For any* two resources discovered at different depths where depth A > depth B, the resource from depth A should have equal or greater value.
**Validates: Requirements 2.3**

### Property 6: Sell availability with inventory
*For any* game state where the inventory contains resources, the sell action should be available.
**Validates: Requirements 3.1**

### Property 7: Credit calculation correctness
*For any* resource sale, the credits awarded should equal the sum of (resource_value × quantity) for all sold resources.
**Validates: Requirements 3.2**

### Property 8: Credits balance update
*For any* credit transaction (earning or spending), the balance should be updated by exactly the transaction amount.
**Validates: Requirements 3.3**

### Property 9: Upgrade purchase availability
*For any* upgrade, it should be purchasable if and only if the player's credits balance is greater than or equal to the upgrade cost.
**Validates: Requirements 4.1**

### Property 10: Mining power increase on upgrade
*For any* tool upgrade, the mining power should increase by the upgrade's specified bonus amount.
**Validates: Requirements 4.2**

### Property 11: Miner hire availability
*For any* miner hire attempt, it should succeed if and only if the player's credits balance is greater than or equal to the hire cost.
**Validates: Requirements 5.1**

### Property 12: Idle mining rate calculation
*For any* number of active miners, the idle mining rate (depth per second) should equal the sum of all miner powers.
**Validates: Requirements 5.2**

### Property 13: Offline progress calculation
*For any* time period spent idle, the depth gained should equal (idle_mining_rate × time_elapsed).
**Validates: Requirements 5.3**

### Property 14: Idle earnings accuracy
*For any* idle period, the calculated earnings (depth and resources) should match what would have been earned if playing actively for that duration.
**Validates: Requirements 5.4**

### Property 15: Biome transition at threshold
*For any* depth threshold defining a biome boundary, crossing that threshold should trigger a biome transition.
**Validates: Requirements 6.1**

### Property 16: Biome-specific resource spawning
*For any* resource discovered in a biome, it should be one of the resources defined for that biome.
**Validates: Requirements 6.3**

### Property 17: Achievement award on milestone
*For any* achievement milestone, reaching the milestone condition should award the achievement.
**Validates: Requirements 8.3**

### Property 18: Statistics persistence
*For any* game session, all statistics (depth, credits, resources) should be saved and restored correctly across sessions.
**Validates: Requirements 8.4**

### Property 19: Rapid click stability
*For any* sequence of rapid clicks, the system should remain stable without crashes or invalid states.
**Validates: Requirements 9.1**

### Property 20: Idle calculation accuracy
*For any* idle period, the calculated progress should be mathematically correct based on mining rates and time elapsed.
**Validates: Requirements 9.2**

### Property 21: Upgrade cap enforcement
*For any* upgrade that would exceed maximum values, the system should clamp to the maximum and prevent further upgrades.
**Validates: Requirements 9.3**

### Property 22: Invalid action stability
*For any* invalid action attempt, the system should remain stable without crashes.
**Validates: Requirements 9.4**

### Property 23: Tutorial progression correctness
*For any* tutorial step completion, the system should advance to the next step or complete the tutorial correctly.
**Validates: Requirements 10.3**

### Property 24: Tutorial completion persistence
*For any* completed tutorial, the completion flag should be set and the tutorial should not show again unless explicitly requested.
**Validates: Requirements 10.4**

## Error Handling

### Mining Operations
- **Negative Depth**: Clamp depth to minimum of 0
- **Overflow Depth**: Cap at maximum safe float value
- **Invalid Mining Power**: Default to base power, log error

### Resource Operations
- **Invalid Resource Type**: Skip discovery, log warning
- **Inventory Overflow**: Cap at maximum stack size per resource
- **Negative Quantity**: Clamp to 0, log error

### Economy Operations
- **Insufficient Credits**: Reject purchase, return false
- **Negative Credits**: Clamp to 0, log error
- **Integer Overflow**: Cap at maximum safe integer

### Upgrade Operations
- **Upgrade Beyond Max Level**: Reject upgrade, inform player
- **Invalid Tool Type**: Log error, skip upgrade
- **Cost Calculation Error**: Use fallback formula

### Idle Progress
- **Negative Time Elapsed**: Treat as 0, log warning
- **Excessive Time Elapsed**: Cap at maximum (e.g., 7 days)
- **Corrupted Timestamp**: Use current time, log error

## Testing Strategy

### Unit Testing

Unit tests will verify specific examples and edge cases:

- **Depth calculations**: Specific click sequences and expected depths
- **Resource value scaling**: Specific depths and expected values
- **Credit calculations**: Specific resource sales and expected credits
- **Upgrade costs**: Specific levels and expected costs
- **Idle progress**: Specific time periods and expected gains
- **Biome transitions**: Specific depths and expected biomes

### Property-Based Testing

Property-based tests will verify universal properties across many random inputs using **GdUnit4**:

- Each property test will run a minimum of 100 iterations
- Tests will use custom generators for game states, depths, resources, and time periods
- Each test will be tagged with: `# Feature: vein-hunter, Property X: [property description]`

**Key Property Tests:**
- Mining mechanics (Properties 1, 2)
- Resource system (Properties 3, 4, 5, 6, 7, 8, 16)
- Upgrade system (Properties 9, 10, 11)
- Idle mechanics (Properties 12, 13, 14, 20)
- Biome system (Properties 15, 16)
- Persistence (Properties 17, 18)
- Stability (Properties 19, 21, 22)
- Tutorial (Properties 23, 24)

**Custom Generators:**
```gdscript
# Generate random depth
func generate_depth() -> float:
    return randf_range(0.0, 100000.0)

# Generate random game state
func generate_game_state() -> GameState:
    var state = GameState.new()
    state.current_depth = generate_depth()
    state.credits_balance = randi_range(0, 1000000)
    state.miner_count = randi_range(0, 100)
    return state

# Generate random time period
func generate_idle_time() -> float:
    return randf_range(0.0, 604800.0)  # Up to 7 days
```

### Integration Testing

Integration tests will verify component interactions:
- MiningController + ResourceManager: Clicks trigger resource discovery
- ResourceManager + EconomyManager: Selling resources awards credits
- EconomyManager + UpgradeManager: Purchases deduct credits correctly
- MinerManager + IdleManager: Miners contribute to idle progress
- Full game loop: Mine → Discover → Sell → Upgrade → Hire → Idle → Return

## Performance Considerations

### Target Performance
- **Frame Rate**: Maintain 60 FPS on mid-range mobile devices
- **Click Response**: < 50ms from click to depth update
- **Idle Calculation**: < 100ms for any idle period up to 7 days
- **Save/Load**: < 200ms for full game state

### Optimization Strategies
- **Incremental Updates**: Update depth display every frame, not every click
- **Batch Resource Discovery**: Process multiple discoveries in one frame
- **Cached Calculations**: Cache mining power, only recalculate on upgrades
- **Efficient Idle Math**: Use formula-based calculation, not simulation
- **Compressed Save Data**: Use binary format for save files

## Mobile Considerations

### Screen Sizes
- Support portrait orientation (720x1280 base resolution)
- Large tap area for mine (minimum 200x200 pixels)
- Ensure UI elements are readable on small screens
- Scale particle effects based on screen size

### Touch Interactions
- Responsive tap feedback (haptic + visual)
- Support tap-and-hold for continuous mining
- Prevent accidental UI taps during rapid clicking
- Clear visual feedback for all interactions

### Battery Optimization
- Reduce particle effects on low battery
- Lower frame rate when idle (30 FPS)
- Pause all animations when backgrounded
- Efficient idle calculation (no active simulation)

## Visual Design

### Futuristic Dwarven Aesthetic
- **Characters**: Dwarves in sci-fi mining suits with glowing visors
- **Tools**: Industrial designs with neon accents and energy effects
- **Mine Shaft**: Dark industrial environment with glowing veins
- **Resources**: Glowing minerals with particle effects
- **UI**: Blend of rugged metal textures with holographic displays

### Biome Visual Themes
1. **Surface** (0-100m): Rocky terrain, daylight, basic minerals
2. **Underground** (100-500m): Dark caves, torch lighting, iron/copper
3. **Deep Caverns** (500-1000m): Massive caverns, bioluminescent fungi, silver/gold
4. **Magma Chamber** (1000-2000m): Lava flows, orange glow, platinum
5. **Crystal Caves** (2000-5000m): Glowing crystals, blue/purple light, diamonds
6. **Alien Depths** (5000-10000m): Otherworldly, green glow, alien crystals
7. **Quantum Void** (10000m+): Abstract space, reality distortion, quantum ore

### Visual Effects
- **Click**: Particle burst, screen shake, depth number popup
- **Resource Discovery**: Glow effect, sparkle particles, notification
- **Rare Resource**: Intense glow, screen flash, special sound
- **Biome Transition**: Screen fade, new color palette, transition effect
- **Upgrade**: Tool glow effect, power-up animation

## Audio Design

### Sound Effects
- **Click/Mine**: Industrial drilling sound (pitch varies with power)
- **Resource Discovery**: Satisfying "ding" or chime
- **Rare Resource**: Special fanfare
- **Sell Resources**: Cash register or credit transfer sound
- **Upgrade**: Power-up sound with mechanical elements
- **Hire Miner**: Dwarf voice line + mechanical activation
- **Biome Transition**: Ambient sound shift

### Music
- **Main Game**: Industrial/electronic soundtrack with dwarven themes
- **Deep Biomes**: More atmospheric and mysterious
- **Volume**: Adjustable, defaults to moderate level

## Future Extensibility

### Potential Features
- **Prestige System**: Reset for permanent bonuses
- **Special Events**: Timed events with bonus resources
- **Miner Customization**: Different miner types with specializations
- **Research Tree**: Unlock new technologies
- **Multiplayer**: Compare progress with friends
- **Daily Challenges**: Special mining objectives
- **Artifacts**: Rare finds that provide unique bonuses

### Architecture Support
- Component-based design allows easy addition of new biomes
- Resource system supports unlimited resource types
- Upgrade system can accommodate new tool types
- Idle system can be extended with offline bonuses
- Achievement system can track any milestone

