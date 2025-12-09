# Heavy Paddle - Game Mechanics

## Player Actions
1. **Move Paddle**: Up/down or mouse movement
2. **Strategic Positioning**: Choose when to move vs stay still
3. **Ball Return**: Hit ball back to opponent

## Rules and Constraints
- Paddle gains weight with movement
- Weight reduces paddle speed
- Staying still reduces weight over time
- Ball bounces off paddles and walls
- Miss ball = opponent scores

## Win Conditions
- First to 11 points wins
- Win by 2 points (deuce rules)

## Lose Conditions
- Opponent reaches winning score first

## Scoring System
- 1 point per missed ball
- First to 11 wins
- Deuce at 10-10

## Difficulty Progression

### AI Difficulty Levels
- **Easy**: Slow reactions, poor positioning
- **Medium**: Good reactions, decent strategy
- **Hard**: Fast reactions, strategic weight management
- **Expert**: Perfect reactions, optimal play

## Momentum System
- **Weight Range**: 0-100
- **Movement Cost**: +5 weight per unit moved
- **Weight Decay**: -2 weight per second stationary
- **Speed Multiplier**: Speed = BaseSpeed * (1 - Weight/100)

## Game Modes
- **Single Player vs AI**: 4 difficulty levels
- **Local 2-Player**: Competitive multiplayer
- **Practice Mode**: No scoring, practice mechanics
