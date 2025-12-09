# Shape Shift - Design Document

## Overview

Shape Shift is a physics-based merge puzzle game built in Godot 4.2 targeting mobile platforms. Players drop geometric shapes into a container where physics simulation causes them to fall, stack, and interact. When identical shapes collide, they automatically merge into higher-tier shapes, creating satisfying chain reactions. The game features a neon cyberpunk visual style, timed sessions, and unlockable power-ups.

## Architecture

### High-Level Structure

```
Game Scene (Main)
├── Container (Physics World)
│   └── Shapes (RigidBody2D instances)
├── Drop Controller (Input & Shape Spawning)
├── Merge Manager (Collision Detection & Merging)
├── Timer Manager (Countdown Logic)
├── Power-up Manager (Abilities System)
├── UI Manager (HUD, Menus, Preview)
├── Visual Effects Manager (Particles, Screen Shake)
└── Audio Manager (Sound Effects, Music)
```

### Design Patterns

- **Observer Pattern**: Collision events trigger merge checks, merges notify scoring and effects systems
- **Object Pool Pattern**: Shape instances and particle effects reused for performance
- **State Machine**: Game states (Playing, Paused, GameOver)
- **Command Pattern**: Power-ups implemented as commands that can be executed and tracked

## Components and Interfaces

### Container

**Responsibilities:**
- Define the bounded play area with physics walls
- Detect when shapes reach the top (game over condition)
- Manage the physics world

**Implementation:**
- StaticBody2D walls on left, right, and bottom
- Area2D at the top to detect game over
- Physics layers to separate shapes from walls

### Shape (RigidBody2D)

**Properties:**
- `tier: int` - Shape complexity level (1-10)
- `shape_type: ShapeType` - Geometric form based on tier
- `neon_color: Color` - Bright neon color
- `collision_shape: CollisionShape2D` - Physics collision
- `sprite: Sprite2D` - Visual representation with glow shader

**Key Methods:**
```gdscript
can_merge_with(other: Shape) -> bool
get_merge_tier() -> int
```

**Signals:**
```gdscript
signal collided_with_shape(other: Shape)
```

### DropController

**Responsibilities:**
- Handle touch input for dropping shapes
- Show drop preview indicator
- Spawn shapes at drop position
- Generate next shape
- Manage shape generation probabilities

**Key Methods:**
```gdscript
handle_touch_input(position: Vector2) -> void
drop_shape_at(x_position: float) -> void
generate_next_shape() -> ShapeData
clamp_to_container(x_position: float) -> float
update_drop_preview(x_position: float) -> void
```

**Properties:**
- `current_shape_data: ShapeData` - Shape ready to drop
- `next_shape_data: ShapeData` - Upcoming shape
- `tier_probabilities: Dictionary` - Weighted probabilities
- `recent_shapes: Array[int]` - Track last 3 shapes for variety

### MergeManager

**Responsibilities:**
- Listen for shape collisions
- Detect valid merge opportunities
- Execute merge operations
- Handle chain reactions
- Detect and handle max-tier shape pops

**Key Methods:**
```gdscript
on_shape_collision(shape_a: Shape, shape_b: Shape) -> void
can_merge(shape_a: Shape, shape_b: Shape) -> bool
execute_merge(shape_a: Shape, shape_b: Shape) -> void
handle_max_tier_pop(shape: Shape) -> void
```

**Signals:**
```gdscript
signal merge_executed(old_tier: int, new_tier: int, position: Vector2)
signal max_tier_popped(position: Vector2, bonus_points: int)
signal chain_reaction_started()
```

### TimerManager

**Responsibilities:**
- Track remaining time in session
- Emit signals when time runs out
- Handle pause/resume of timer

**Key Methods:**
```gdscript
start_timer(duration: float) -> void
pause_timer() -> void
resume_timer() -> void
get_remaining_time() -> float
```

**Signals:**
```gdscript
signal time_updated(remaining: float)
signal time_expired()
```

### PowerUpManager

**Responsibilities:**
- Track available power-ups and their counts
- Execute power-up effects
- Award power-ups based on milestones
- Manage power-up cooldowns

**Key Methods:**
```gdscript
unlock_powerup(type: PowerUpType, count: int) -> void
use_powerup(type: PowerUpType) -> bool
get_powerup_count(type: PowerUpType) -> int
check_milestones(score: int, highest_tier: int) -> void
```

**Power-up Types:**
```gdscript
enum PowerUpType {
    SKIP_SHAPE,      # Discard current next shape
    DOUBLE_DROP,     # Drop two shapes quickly
    SLOW_TIME,       # Slow physics for 5 seconds
    CLEAR_BOTTOM     # Remove bottom row of shapes
}
```

### UIManager

**Responsibilities:**
- Display score, timer, and stats
- Show next shape preview
- Display power-up buttons and counts
- Handle menu screens (pause, game over, tutorial)
- Show drop position preview
- Provide visual feedback for player actions
- Manage tutorial overlay with speech bubbles

**Key Methods:**
```gdscript
update_score(score: int) -> void
update_timer(remaining: float) -> void
update_next_shape_preview(shape_data: ShapeData) -> void
update_drop_preview(x_position: float, visible: bool) -> void
show_game_over(final_score: int, highest_tier: int) -> void
show_tutorial() -> void
advance_tutorial_step() -> void
close_tutorial() -> void
```

### VisualEffectsManager

**Responsibilities:**
- Spawn particle effects for merges
- Handle max-tier pop explosions
- Manage screen shake
- Apply neon glow effects

**Key Methods:**
```gdscript
play_merge_effect(position: Vector2, tier: int) -> void
play_pop_explosion(position: Vector2) -> void
screen_shake(intensity: float, duration: float) -> void
```

## Data Models

### ShapeData

```gdscript
class_name ShapeData
extends Resource

@export var tier: int
@export var shape_type: ShapeType
@export var base_size: float
@export var neon_color: Color
@export var points_value: int

enum ShapeType {
    CIRCLE,      # Tier 1
    SQUARE,      # Tier 2
    TRIANGLE,    # Tier 3
    PENTAGON,    # Tier 4
    HEXAGON,     # Tier 5
    STAR,        # Tier 6
    DIAMOND,     # Tier 7
    OCTAGON,     # Tier 8
    CROSS,       # Tier 9
    SUPERSHAPE   # Tier 10 (max)
}
```

### GameConfig

```gdscript
class_name GameConfig
extends Resource

@export var session_duration: float = 120.0  # 2 minutes
@export var container_width: float = 600.0
@export var container_height: float = 1000.0
@export var drop_height: float = 100.0  # Height above container
@export var tier_probabilities: Dictionary = {
    1: 0.40,  # 40% chance
    2: 0.30,  # 30% chance
    3: 0.20,  # 20% chance
    4: 0.10,  # 10% chance
    5: 0.00   # Higher tiers only from merging
}
@export var points_per_tier: Dictionary = {
    1: 0,     # No points for tier 1
    2: 10,    # Exponential scaling
    3: 30,
    4: 70,
    5: 150,
    6: 310,
    7: 630,
    8: 1270,
    9: 2550,
    10: 5000  # Max tier
}
@export var max_tier_bonus: int = 10000
@export var neon_colors: Array[Color] = [
    Color("#FF006E"),  # Neon pink
    Color("#00F5FF"),  # Neon cyan
    Color("#B967FF"),  # Neon purple
    Color("#05FFA1"),  # Neon green
    Color("#FFEA00")   # Neon yellow
]
```

### SessionData

```gdscript
class_name SessionData
extends Resource

@export var score: int = 0
@export var highest_tier_reached: int = 1
@export var remaining_time: float
@export var shapes_dropped: int = 0
@export var total_merges: int = 0
@export var max_chain_length: int = 0
```

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*


### Property 1: Drop position correctness
*For any* horizontal tap position within the screen, the shape should be dropped at the correct horizontal position (clamped to container bounds if necessary).
**Validates: Requirements 1.1, 1.4**

### Property 2: Physics enabled on drop
*For any* dropped shape, physics simulation should be active causing the shape to fall under gravity.
**Validates: Requirements 1.2**

### Property 3: Next shape generation invariant
*For any* shape drop, a new next shape should be immediately generated and ready for the following drop.
**Validates: Requirements 1.3**

### Property 4: Merge detection correctness
*For any* collision between two identical shapes, the merge system should detect and execute the merge.
**Validates: Requirements 2.1**

### Property 5: Merge execution correctness
*For any* valid merge, exactly two shapes should be removed and one higher-tier shape should be created at the merge location.
**Validates: Requirements 2.2**

### Property 6: Chain reaction triggering
*For any* merge that creates a shape touching another identical shape, another merge should be automatically triggered.
**Validates: Requirements 2.3**

### Property 7: Merge scoring correctness
*For any* merge operation, the points awarded should match the configured point value for the resulting shape's tier.
**Validates: Requirements 2.4**

### Property 8: Max tier pop behavior
*For any* creation of the maximum tier shape, it should be removed from the container and bonus points should be awarded.
**Validates: Requirements 2.5**

### Property 9: Tier probability distribution
*For any* large sample of generated shapes, the distribution should match the configured weighted probabilities.
**Validates: Requirements 3.2**

### Property 10: Shape variety constraint
*For any* sequence of generated shapes, the same tier should not appear more than three times consecutively.
**Validates: Requirements 3.3**

### Property 11: Adaptive difficulty
*For any* increase in player progress (average tier), the probability distribution should shift toward higher tiers.
**Validates: Requirements 3.4**

### Property 12: Power-up unlock on milestone
*For any* achievement of a configured milestone, the corresponding power-up should be unlocked and available for use.
**Validates: Requirements 4.1**

### Property 13: Skip power-up behavior
*For any* use of the skip power-up, the current next shape should be discarded and a new one generated, and the power-up count should decrement.
**Validates: Requirements 4.2**

### Property 14: Double-drop power-up behavior
*For any* use of the double-drop power-up, two shapes should be droppable in quick succession before returning to normal behavior.
**Validates: Requirements 4.3**

### Property 15: Power-up count decrement
*For any* power-up usage, the count for that power-up type should decrease by exactly one.
**Validates: Requirements 4.4**

### Property 16: Exponential score scaling
*For any* tier level, the points awarded should scale exponentially (each tier worth roughly 2x the previous tier).
**Validates: Requirements 5.1**

### Property 17: Game over on stack overflow
*For any* game state where shapes reach the top of the container, the game over condition should be detected and the session should end.
**Validates: Requirements 9.1**

### Property 18: System stability under physics
*For any* physics simulation scenario, the game should remain stable without crashing or entering invalid states.
**Validates: Requirements 9.3**

### Property 19: Pause-resume state preservation
*For any* game state, pausing should stop the timer and physics, and resuming should restore both correctly.
**Validates: Requirements 9.4**

## Error Handling

### Physics Operations
- **Shape Stuck**: Detect shapes that haven't moved for extended period, apply small impulse
- **Excessive Velocity**: Clamp shape velocities to prevent tunneling through walls
- **Invalid Collision**: Log warning, skip merge if shapes are invalid

### Drop Operations
- **Drop During Game Over**: Ignore drop requests when game is not in playing state
- **Rapid Drops**: Enforce minimum delay between drops (except during double-drop power-up)
- **Invalid Drop Position**: Clamp to valid container bounds

### Merge Operations
- **Concurrent Merges**: Queue merge operations to prevent race conditions
- **Invalid Tier**: Clamp to valid tier range, log error
- **Missing Shape Reference**: Skip merge, log error, clean up orphaned shapes

### Timer Operations
- **Negative Time**: Clamp to zero, trigger game over
- **Pause During Game Over**: Ignore pause requests in terminal states

## Testing Strategy

### Unit Testing

Unit tests will verify specific examples and edge cases:

- **Drop position clamping**: Out-of-bounds positions clamped correctly
- **Merge at max tier**: Max tier shape pops correctly with bonus points
- **Timer expiration**: Game over triggered when timer reaches zero
- **Power-up edge cases**: Using power-up with count of 1, using when count is 0
- **Chain reaction limits**: Very long chain reactions don't cause performance issues
- **Container boundaries**: Shapes can't escape container

### Property-Based Testing

Property-based tests will verify universal properties across many random inputs using **GdUnit4** (Godot's property-based testing framework):

- Each property test will run a minimum of 100 iterations with randomly generated inputs
- Tests will use custom generators for drop positions, shape configurations, and game states
- Each property-based test will be tagged with a comment referencing the specific correctness property from this design document
- Tag format: `# Feature: shape-shift, Property X: [property description]`

**Key Property Tests:**
- Drop mechanics (Properties 1, 2, 3)
- Merge detection and execution (Properties 4, 5, 6, 7, 8)
- Shape generation (Properties 9, 10, 11)
- Power-up system (Properties 12, 13, 14, 15)
- Scoring (Properties 7, 16)
- Game state management (Properties 17, 18, 19)

**Custom Generators:**
```gdscript
# Generate random drop positions
func generate_drop_position() -> float:
    return randf_range(-100, container_width + 100)

# Generate random game state with shapes
func generate_game_state() -> GameState:
    var state = GameState.new()
    var num_shapes = randi_range(0, 20)
    for i in range(num_shapes):
        state.add_shape(generate_random_shape())
    return state

# Generate random shape tier
func generate_shape_tier() -> int:
    return randi_range(1, 10)
```

### Integration Testing

Integration tests will verify component interactions:
- DropController + MergeManager: Dropped shapes trigger merges correctly
- MergeManager + PowerUpManager: Merges award power-ups at milestones
- TimerManager + DropController: Timer expiration prevents drops
- Full game loop: Start → Drop → Merge → Chain → Game Over → Restart

## Performance Considerations

### Target Performance
- **Frame Rate**: Maintain 60 FPS on mid-range mobile devices
- **Input Latency**: < 100ms from touch to shape drop
- **Merge Processing**: < 50ms per merge operation
- **Physics Simulation**: Stable at 60 physics ticks per second

### Optimization Strategies
- **Object Pooling**: Reuse shape instances instead of creating/destroying
- **Particle Limits**: Cap maximum active particles to 100
- **Physics Layers**: Use collision layers to reduce unnecessary collision checks
- **Batch Merges**: Process multiple merges in same frame if they occur simultaneously
- **Lazy Evaluation**: Only check for game over condition after shapes settle

### Physics Tuning
- **Gravity**: Moderate gravity for satisfying drop speed
- **Friction**: Low friction for smooth stacking
- **Restitution**: Minimal bounce for stable stacking
- **Linear Damping**: Slight damping to prevent perpetual motion
- **Angular Damping**: Higher damping to reduce excessive spinning

## Mobile Considerations

### Screen Sizes
- Support portrait orientation (720x1280 base resolution)
- Scale container proportionally for different screen sizes
- Ensure touch targets are minimum 44x44 pixels for power-up buttons

### Touch Interactions
- Show visual preview of drop position while touching
- Support drag-to-position before releasing to drop
- Clear visual feedback for all touch events
- Haptic feedback on merge and max-tier pop (if available)

### Battery Optimization
- Reduce particle effects on low battery
- Lower physics tick rate when backgrounded
- Pause all simulation when app is not visible

## Visual Design

### Neon Cyberpunk Aesthetic
- **Background**: Dark gradient (near-black to dark purple)
- **Container**: Neon outline with subtle glow
- **Shapes**: Bright neon colors with glow shader
- **Particles**: Neon trails and explosions
- **UI**: Minimalist with neon accents

### Shape Progression
Each tier has distinct visual identity:
1. Small circle (pink)
2. Square (cyan)
3. Triangle (purple)
4. Pentagon (green)
5. Hexagon (yellow)
6. Star (pink)
7. Diamond (cyan)
8. Octagon (purple)
9. Cross (green)
10. Supershape (rainbow glow)

### Visual Effects
- **Merge**: Particle burst with color blend of merging shapes
- **Max Tier Pop**: Explosive particle effect with screen shake
- **Drop**: Subtle trail effect as shape falls
- **Chain Reaction**: Increasing intensity of effects with each merge

## Audio Design

### Sound Effects
- **Drop**: Soft "whoosh" sound
- **Merge**: Satisfying "pop" with pitch based on tier
- **Max Tier Pop**: Explosive sound with reverb
- **Chain Reaction**: Ascending pitch for each merge in chain
- **Power-up Use**: Distinct sound for each power-up type
- **Game Over**: Descending tone

### Music
- **Main Game**: Synthwave/cyberpunk background music (looping)
- **Menu**: Ambient electronic music
- **Volume**: Adjustable in settings, defaults to moderate level

## Future Extensibility

### Potential Features
- **Endless Mode**: No timer, play until container fills
- **Challenge Mode**: Specific goals (reach tier X, score Y points)
- **Daily Challenges**: Special shape sequences or constraints
- **Unlockable Skins**: Different visual themes for shapes
- **Leaderboards**: Compare scores globally
- **Achievements**: Unlock badges for specific accomplishments
- **More Power-ups**: Rotate shape, swap next shape, undo last drop

### Architecture Support
- Component-based design allows easy addition of new shape types
- Signal-based communication enables new power-ups without core changes
- Configuration-driven probabilities and scoring allow easy balancing
- State machine supports additional game modes
- Physics-based gameplay naturally supports new mechanics (wind, gravity changes, etc.)

