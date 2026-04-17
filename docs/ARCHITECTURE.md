# Architecture Notes

## Autoloads (Singletons)

Register these in **Project → Project Settings → Autoload**.

| Name | Script | Responsibility |
|------|--------|----------------|
| `GameManager` | `scripts/autoloads/game_manager.gd` | Game state (current level, score, pause) |
| `AudioManager` | `scripts/autoloads/audio_manager.gd` | Music/SFX playback, bus control |
| `SaveManager` | `scripts/autoloads/save_manager.gd` | Serialize/deserialize save data |
| `EventBus` | `scripts/autoloads/event_bus.gd` | Global signals (decoupled communication) |

---

## Signal Architecture (EventBus Pattern)

To avoid tight coupling between systems, use a global `EventBus` autoload for cross-system events.

```gdscript
# scripts/autoloads/event_bus.gd
extends Node

signal player_died()
signal score_changed(new_score: int)
signal level_completed(level_id: String)
```

```gdscript
# Emitting (from any script)
EventBus.player_died.emit()

# Listening (from any script)
EventBus.player_died.connect(_on_player_died)
```

---

## Scene Composition Pattern

Prefer **composition over inheritance** using reusable component scenes:

```
Player (CharacterBody3D)
├── HitboxComponent  (Area3D) — receives damage
├── HealthComponent  (Node)   — tracks HP, emits died signal
├── StateMachineComponent (Node) — drives animation/logic states
├── CameraArm (SpringArm3D)
│   └── Camera3D
└── MeshInstance3D
```

Each component script is self-contained and communicates via signals.

---

## State Machine Convention

All character/enemy logic uses the **enum state machine** pattern (see snippet `statemachine`).  
Transitions are always gated through `transition_to(State.X)` — never set `current_state` directly.

---

## Resource-Driven Data

Game data (items, levels, enemy stats) lives in `.tres` custom resources in `resources/data/`.  
This avoids hardcoded values and makes balancing/iteration faster.

```gdscript
class_name EnemyData
extends Resource

@export var display_name: String = ""
@export var max_health: int = 50
@export var move_speed: float = 3.0
@export var attack_damage: int = 10
```

---

## Save System

Save file location: `user://save.json`  
Use `FileAccess` (Godot 4) — never use `File` (Godot 3 API).

```gdscript
# Saving
var data := { "level": 2, "health": 80 }
var file := FileAccess.open("user://save.json", FileAccess.WRITE)
file.store_string(JSON.stringify(data))

# Loading
var file := FileAccess.open("user://save.json", FileAccess.READ)
var data: Dictionary = JSON.parse_string(file.get_as_text())
```

---

## Naming Conventions

| Item | Convention | Example |
|------|-----------|---------|
| Script files | `snake_case.gd` | `player_controller.gd` |
| Scene files | `snake_case.tscn` | `main_menu.tscn` |
| Classes | `PascalCase` | `class_name PlayerController` |
| Functions | `snake_case` | `func take_damage()` |
| Signals | `snake_case` (past tense) | `signal health_depleted` |
| Constants | `SCREAMING_SNAKE_CASE` | `const MAX_SPEED := 10.0` |
| Private members | `_leading_underscore` | `var _current_state` |
| Node references | `_leading_underscore + type suffix` | `@onready var _anim: AnimationPlayer` |

---

## Performance Guidelines

- Use `@onready` for all node references — never call `get_node()` in `_process()`.
- Prefer `_physics_process()` for physics/movement; `_process()` for visuals only.
- Use `Object.call_deferred()` for scene tree modifications from signals.
- Pool frequently-spawned objects (bullets, particles) with a custom `ObjectPool` component.
- Profile with Godot's built-in **Profiler** (`Debugger → Profiler`) before optimizing.
