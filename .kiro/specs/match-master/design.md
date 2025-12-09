# Match Master - Design Document

## Overview

Match Master is a memory matching game built in Godot 4.2 targeting mobile platforms. Players tap cards to flip them and find matching pairs within limited attempts. The game features an anime kawaii aesthetic with cute artwork, pastel colors, and playful animations. Players progress through levels of increasing difficulty and unlock new themed card sets.

## Architecture

### High-Level Structure

```
Game Scene (Main)
├── Grid Manager (Card Layout & State)
├── Card Manager (Card Flipping & Matching)
├── Level Manager (Progression & Modes)
├── Points Manager (Points Earning & Spending)
├── Ability Manager (Special Abilities)
├── Unlock Manager (Card Sets & Achievements)
├── UI Manager (HUD, Menus, Tutorial)
├── Visual Effects Manager (Particles, Animations)
└── Audio Manager (Sound Effects, Music)
```

### Design Patterns

- **Observer Pattern**: Card flip events notify match checking, UI updates
- **State Machine**: Game states (Playing, Paused, Victory, Failure, Tutorial)
- **Factory Pattern**: Card creation based on card set and level configuration
- **Command Pattern**: Tutorial steps as commands that can be advanced/skipped

## Components and Interfaces

### GridManager

**Responsibilities:**
- Create and manage card grid layout
- Handle grid sizing based on level difficulty
- Shuffle card positions randomly
- Track grid state (which cards are flipped, matched)

**Key Methods:**
```gdscript
create_grid(rows: int, cols: int, card_set: CardSet) -> void
shuffle_cards() -> void
get_card_at_position(position: Vector2i) -> Card
is_grid_complete() -> bool
reset_grid() -> void
```

### Card (Area2D)

**Properties:**
- `card_id: int` - Unique identifier for matching
- `card_design: Texture2D` - Face artwork
- `is_face_up: bool` - Current flip state
- `is_matched: bool` - Whether this card has been matched
- `is_animating: bool` - Whether card is currently animating

**Key Methods:**
```gdscript
flip_up() -> void
flip_down() -> void
mark_as_matched() -> void
can_interact() -> bool
```

**Signals:**
```gdscript
signal card_tapped()
signal flip_complete()
```

### CardManager

**Responsibilities:**
- Handle card flip logic
- Detect and process matches
- Manage the two-card flip sequence
- Track matched pairs

**Key Methods:**
```gdscript
on_card_tapped(card: Card) -> void
check_for_match() -> bool
process_match() -> void
process_no_match() -> void
reset_flipped_cards() -> void
```

**Properties:**
- `first_flipped_card: Card` - First card in current attempt
- `second_flipped_card: Card` - Second card in current attempt
- `matched_pairs: int` - Count of successful matches

**Signals:**
```gdscript
signal match_found(card_a: Card, card_b: Card)
signal no_match(card_a: Card, card_b: Card)
signal all_pairs_matched()
```

### LevelManager

**Responsibilities:**
- Define level configurations based on mode selection
- Track level progression and completion
- Handle level unlocking
- Manage three difficulty modes (Easy, Medium, Hard)

**Key Methods:**
```gdscript
load_level(level_id: int, mode: GameMode) -> LevelConfig
complete_level(level_id: int, attempts_used: int) -> void
is_level_unlocked(level_id: int) -> bool
get_next_level() -> int
calculate_star_rating(attempts_used: int, attempts_allowed: int) -> int
get_mode_config(mode: GameMode) -> ModeConfig
```

**Data:**
```gdscript
enum GameMode {
    EASY,    # 8 cards (4 pairs)
    MEDIUM,  # 16 cards (8 pairs)
    HARD     # 24 cards (12 pairs)
}

class_name ModeConfig
extends Resource

@export var mode: GameMode
@export var num_pairs: int
@export var max_attempts: int
@export var points_multiplier: float

class_name LevelConfig
extends Resource

@export var level_id: int
@export var mode: GameMode
@export var card_set_id: int
@export var unlock_requirement: int  # Previous level to complete
```

### PointsManager

**Responsibilities:**
- Track player's points balance
- Award points for matches
- Handle points spending on abilities
- Calculate points based on match speed and mode

**Key Methods:**
```gdscript
award_points(base_points: int, mode_multiplier: float) -> void
spend_points(cost: int) -> bool
get_balance() -> int
can_afford(cost: int) -> bool
calculate_match_points(match_speed: float, mode: GameMode) -> int
```

**Signals:**
```gdscript
signal points_changed(new_balance: int)
signal points_awarded(amount: int)
signal points_spent(amount: int)
```

### AbilityManager

**Responsibilities:**
- Manage special abilities (Flash, Highlight)
- Handle ability activation
- Deduct points when abilities are used
- Execute ability effects

**Key Methods:**
```gdscript
activate_flash() -> bool
activate_highlight() -> bool
can_use_ability(ability_type: AbilityType) -> bool
get_ability_cost(ability_type: AbilityType) -> int
```

**Data:**
```gdscript
enum AbilityType {
    FLASH,      # Reveal all cards for 2 seconds
    HIGHLIGHT   # Show one matching pair
}

class_name AbilityConfig
extends Resource

@export var ability_type: AbilityType
@export var cost: int
@export var duration: float  # For Flash ability
```

**Signals:**
```gdscript
signal ability_activated(ability_type: AbilityType)
signal flash_started()
signal flash_ended()
signal pair_highlighted(card_a: Card, card_b: Card)
```

### UnlockManager

**Responsibilities:**
- Track unlocked card sets
- Award new card sets at milestones
- Manage player progression data

**Key Methods:**
```gdscript
unlock_card_set(set_id: int) -> void
is_card_set_unlocked(set_id: int) -> bool
check_unlock_milestones(level_completed: int) -> Array[int]
get_unlocked_sets() -> Array[CardSet]
```

**Signals:**
```gdscript
signal card_set_unlocked(set_id: int)
```

### AttemptTracker

**Responsibilities:**
- Track remaining attempts
- Decrement on each flip pair
- Detect when attempts run out

**Key Methods:**
```gdscript
initialize(max_attempts: int) -> void
use_attempt() -> void
get_remaining() -> int
has_attempts_remaining() -> bool
```

**Signals:**
```gdscript
signal attempts_changed(remaining: int)
signal attempts_exhausted()
```

### UIManager

**Responsibilities:**
- Display HUD (attempts remaining, matches found)
- Show level select screen
- Display victory/failure screens
- Manage tutorial overlay
- Show card set selection

**Key Methods:**
```gdscript
update_attempts_display(remaining: int) -> void
update_matches_display(matched: int, total: int) -> void
show_victory_screen(star_rating: int) -> void
show_failure_screen() -> void
show_tutorial() -> void
advance_tutorial_step() -> void
show_level_select() -> void
```

### VisualEffectsManager

**Responsibilities:**
- Play particle effects for matches
- Handle card flip animations
- Display kawaii effects (sparkles, hearts, stars)
- Manage screen transitions

**Key Methods:**
```gdscript
play_match_effect(position: Vector2) -> void
play_perfect_clear_effect() -> void
animate_card_flip(card: Card, face_up: bool) -> void
```

### CardSet

**Data Model:**
```gdscript
class_name CardSet
extends Resource

@export var set_id: int
@export var set_name: String
@export var theme: String  # "Cute Animals", "Kawaii Food", etc.
@export var card_designs: Array[Texture2D]
@export var unlock_level: int
@export var is_unlocked: bool = false
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
@export var unlocked_card_sets: Array[int] = [1]  # Start with one set
@export var selected_card_set: int = 1
@export var total_matches_found: int = 0
@export var tutorial_completed: bool = false
@export var points_balance: int = 0
@export var total_points_earned: int = 0
@export var abilities_used: Dictionary = {}  # ability_type -> count
```

### SessionData

```gdscript
class_name SessionData
extends Resource

@export var level_id: int
@export var mode: GameMode
@export var attempts_remaining: int
@export var attempts_used: int
@export var matched_pairs: int
@export var total_pairs: int
@export var points_earned_this_session: int
@export var start_time: float
@export var is_active: bool
```

## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system-essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Card flip state transition
*For any* face-down card, tapping it should result in the card becoming face-up.
**Validates: Requirements 1.1**

### Property 2: Match detection trigger
*For any* game state with exactly two face-up unmatched cards, the match checking logic should be triggered.
**Validates: Requirements 1.3**

### Property 3: Face-up card interaction prevention
*For any* face-up card, tapping it should not change the game state.
**Validates: Requirements 1.4**

### Property 4: Match identification correctness
*For any* two cards with identical card_id values, they should be identified as a match.
**Validates: Requirements 2.1**

### Property 5: Matched card state persistence
*For any* matched pair of cards, they should remain face-up and reject further interaction attempts.
**Validates: Requirements 2.2**

### Property 6: Non-match flip-back behavior
*For any* two face-up cards that don't match, they should return to face-down state after the mismatch is processed.
**Validates: Requirements 2.4**

### Property 7: Victory condition detection
*For any* game state where all pairs are matched, the level completion condition should be triggered.
**Validates: Requirements 2.5**

### Property 8: Attempt decrement correctness
*For any* pair of card flips (one attempt), the attempt counter should decrease by exactly one.
**Validates: Requirements 3.2**

### Property 9: Failure condition detection
*For any* game state where attempts reach zero and unmatched pairs remain, the level failure condition should be triggered.
**Validates: Requirements 3.3**

### Property 10: Level unlock progression
*For any* completed level N, level N+1 should become unlocked and available for play.
**Validates: Requirements 4.1**

### Property 11: Difficulty scaling
*For any* two levels where level A has a higher level_id than level B, level A should have equal or greater difficulty (more cards or fewer attempts).
**Validates: Requirements 4.2**

### Property 12: Card position randomization
*For any* level started multiple times, the card positions should be different across playthroughs.
**Validates: Requirements 4.3**

### Property 13: Card set unlock at milestones
*For any* milestone level completion, the corresponding card set should be unlocked.
**Validates: Requirements 5.1**

### Property 14: Unlocked card set availability
*For any* unlocked card set, it should be selectable and usable in gameplay.
**Validates: Requirements 5.2, 5.3**

### Property 15: Input resolution correctness
*For any* tap input, it should either resolve to a valid card or be ignored without causing errors.
**Validates: Requirements 7.2**

### Property 16: Animation blocking
*For any* game state where cards are animating, new flip inputs should be queued or ignored until animations complete.
**Validates: Requirements 7.3**

### Property 17: Touch target sizing
*For any* card in the grid, its touch target should be at least 44x44 pixels.
**Validates: Requirements 7.4**

### Property 18: Perfect completion recognition
*For any* level completed with maximum efficiency (minimum attempts used), a perfect rating should be awarded.
**Validates: Requirements 8.3**

### Property 19: Statistics tracking accuracy
*For any* match found or level completed, the corresponding statistics counters should increment correctly.
**Validates: Requirements 8.4**

### Property 20: Rapid input stability
*For any* sequence of rapid tap inputs, the system should remain stable without crashes or invalid states.
**Validates: Requirements 9.1**

### Property 21: Pause-resume state preservation
*For any* game state, pausing and resuming should result in an identical game state.
**Validates: Requirements 9.2**

### Property 22: Interruption stability
*For any* interrupted animation or operation, the system should complete gracefully without entering invalid states.
**Validates: Requirements 9.3, 9.4**

### Property 23: Tutorial progression correctness
*For any* tutorial step dismissal, the system should advance to the next step or complete the tutorial correctly.
**Validates: Requirements 10.3**

### Property 24: Tutorial completion persistence
*For any* completed tutorial, the completion flag should be set and the tutorial should not show again unless explicitly requested.
**Validates: Requirements 10.4**

### Property 25: Mode card count correctness
*For any* selected mode, the grid should contain the correct number of cards (Easy=8, Medium=16, Hard=24).
**Validates: Requirements 3.2, 3.3, 3.4**

### Property 26: Points award on match
*For any* successful match, points should be awarded and added to the player's balance.
**Validates: Requirements 5.1, 5.3**

### Property 27: Points persistence
*For any* points earned, they should be persisted to the player's total balance across sessions.
**Validates: Requirements 5.4**

### Property 28: Ability cost deduction
*For any* ability activation, the cost should be deducted from the points balance if sufficient points are available.
**Validates: Requirements 6.1, 6.3**

### Property 29: Flash ability effect
*For any* Flash ability activation, all cards should be revealed for exactly 2 seconds then hidden again.
**Validates: Requirements 6.2**

### Property 30: Highlight ability effect
*For any* Highlight ability activation, exactly one matching pair should be highlighted.
**Validates: Requirements 6.4**

### Property 31: Insufficient points prevention
*For any* ability purchase attempt with insufficient points, the purchase should be rejected and points balance should remain unchanged.
**Validates: Requirements 6.1, 6.3**

## Error Handling

### Card Interaction Errors
- **Invalid Card Reference**: Log error, skip interaction
- **Card Already Matched**: Silently ignore tap
- **Card Currently Animating**: Queue or ignore tap
- **Null Card**: Log error, prevent crash

### Match Detection Errors
- **Mismatched Card Count**: Reset flip state, log warning
- **Invalid Card IDs**: Treat as non-match, log error
- **Concurrent Match Checks**: Queue checks to prevent race conditions

### Level Loading Errors
- **Invalid Level ID**: Fall back to level 1, log error
- **Missing Card Set**: Use default card set, log warning
- **Corrupted Level Data**: Regenerate level with defaults

### Unlock Errors
- **Invalid Unlock Request**: Log error, ignore request
- **Already Unlocked**: Silently ignore
- **Missing Unlock Data**: Initialize with defaults

## Testing Strategy

### Unit Testing

Unit tests will verify specific examples and edge cases:

- **Grid generation**: Correct number of card pairs for various grid sizes
- **Match detection**: Specific card pairs that should/shouldn't match
- **Attempt tracking**: Edge cases like starting with 0 attempts, using last attempt
- **Level unlocking**: Specific unlock sequences
- **Perfect completion**: Exact attempt counts that qualify as perfect
- **Tutorial progression**: Specific step sequences

### Property-Based Testing

Property-based tests will verify universal properties across many random inputs using **GdUnit4**:

- Each property test will run a minimum of 100 iterations
- Tests will use custom generators for game states, card configurations, and input sequences
- Each test will be tagged with: `# Feature: match-master, Property X: [property description]`

**Key Property Tests:**
- Card flipping mechanics (Properties 1, 2, 3)
- Match detection and processing (Properties 4, 5, 6, 7)
- Attempt tracking (Properties 8, 9)
- Level progression (Properties 10, 11, 12)
- Unlock system (Properties 13, 14)
- Input handling (Properties 15, 16, 17, 20)
- Statistics and ratings (Properties 18, 19)
- State management (Properties 21, 22)
- Tutorial system (Properties 23, 24)

**Custom Generators:**
```gdscript
# Generate random grid configuration
func generate_grid_config() -> Dictionary:
    return {
        "rows": randi_range(2, 6),
        "cols": randi_range(2, 6)
    }

# Generate random game state with flipped cards
func generate_game_state() -> GameState:
    var state = GameState.new()
    var num_flipped = randi_range(0, 2)
    # ... generate cards and flip states
    return state

# Generate random card pair
func generate_card_pair(should_match: bool) -> Array[Card]:
    var card_a = Card.new()
    var card_b = Card.new()
    if should_match:
        card_a.card_id = 1
        card_b.card_id = 1
    else:
        card_a.card_id = 1
        card_b.card_id = 2
    return [card_a, card_b]
```

### Integration Testing

Integration tests will verify component interactions:
- CardManager + GridManager: Flipping cards updates grid state
- CardManager + AttemptTracker: Flips decrement attempts
- LevelManager + UnlockManager: Level completion unlocks content
- Full game loop: Start level → Flip cards → Match pairs → Complete/Fail → Progress

## Performance Considerations

### Target Performance
- **Frame Rate**: Maintain 60 FPS on mid-range mobile devices
- **Input Latency**: < 100ms from tap to card flip start
- **Animation Duration**: 300-500ms per card flip
- **Grid Size**: Support up to 6x6 grid (18 pairs) smoothly

### Optimization Strategies
- **Texture Atlasing**: Pack card designs into texture atlases
- **Object Pooling**: Reuse card instances between levels
- **Lazy Loading**: Load card sets on demand
- **Efficient Grid Storage**: Use flat array with index calculation
- **Animation Batching**: Group particle effects when multiple matches occur

## Mobile Considerations

### Screen Sizes
- Support portrait orientation (720x1280 base resolution)
- Scale grid and cards proportionally for different screens
- Ensure minimum card size of 80x80 pixels for easy tapping
- Maintain 44x44 pixel minimum touch targets

### Touch Interactions
- Clear visual feedback for card taps
- Prevent accidental double-taps
- Support tap-and-hold for card preview (optional feature)
- Haptic feedback on match/mismatch (if available)

### Battery Optimization
- Reduce particle effects on low battery
- Lower animation frame rate when backgrounded
- Pause all animations when app is not visible

## Visual Design

### Anime Kawaii Aesthetic
- **Background**: Soft pastel gradient with cute patterns
- **Cards**: Rounded corners, soft shadows, chibi-style artwork
- **Colors**: Pastel pink, blue, purple, yellow, mint green
- **Fonts**: Rounded, friendly fonts for UI text
- **Particles**: Hearts, stars, sparkles with soft glow

### Card Design
- **Back**: Consistent cute pattern (e.g., pastel hearts or stars)
- **Front**: Themed artwork based on card set
- **Border**: Soft glow effect in pastel colors
- **Matched State**: Slight desaturation or sparkle overlay

### Visual Effects
- **Match**: Burst of hearts/stars, cards glow
- **No Match**: Cards shake slightly before flipping back
- **Perfect Clear**: Rainbow sparkle explosion, confetti
- **Level Complete**: Bouncy victory animation

## Audio Design

### Sound Effects
- **Card Flip**: Soft "whoosh" sound
- **Match Found**: Pleasant "ding" or chime
- **No Match**: Gentle "boop" (not harsh)
- **Perfect Clear**: Triumphant jingle
- **Level Complete**: Victory fanfare
- **Card Set Unlock**: Special unlock sound

### Music
- **Main Game**: Upbeat, cute background music (looping)
- **Menu**: Calm, ambient kawaii music
- **Volume**: Adjustable, defaults to moderate level

## Future Extensibility

### Potential Features
- **Timed Mode**: Complete level before timer expires
- **Combo System**: Bonus points for consecutive matches
- **Power-ups**: Reveal card, extra attempt, hint system
- **Multiplayer**: Race against friend to match pairs first
- **Custom Card Sets**: Player-created card designs
- **Achievements**: Special badges for various accomplishments
- **Daily Challenges**: Special grid configurations with rewards

### Architecture Support
- Component-based design allows easy addition of new card sets
- Level configuration system supports new game modes
- Signal-based communication enables new features without core changes
- Unlock system can be extended for achievements and rewards

