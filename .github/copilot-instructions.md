# GitHub Copilot Instructions — Office Boss Simulator

## Project Overview
A 3D game built in **Godot 4.6** using **GDScript** (statically typed).
Engine config: **Forward+ renderer**, **Jolt Physics**, **D3D12** on Windows.
The game concept will be filled in once the GDD is finalized — treat this file as a living document.

---

## Language & Style Rules

- **Always use static typing.** Every variable, parameter, and return type must be explicitly typed.
  ```gdscript
  # ✅ correct
  var speed: float = 5.0
  func get_direction() -> Vector3:

  # ❌ wrong
  var speed = 5.0
  func get_direction():
  ```
- Use `@onready` for all node references. Never call `get_node()` inside `_process` or `_physics_process`.
- Use `const` for values that never change at runtime.
- Prefix private variables and functions with `_` (e.g. `_health`, `_apply_gravity()`).
- All signal handlers must follow the naming convention `_on_<node>_<signal>`.
- Use `signal` declarations with typed parameters.
- Never use `setget` — use properties with `get` / `set` blocks (Godot 4 style).

---

## Architecture Conventions

- **Composition over inheritance.** Build complex objects from small, self-contained component scenes.
- **EventBus pattern** for cross-system communication (see `scripts/autoloads/event_bus.gd`).
  Use direct node signals only for parent↔child relationships.
- **Enum state machines** for all character/enemy/AI logic (see snippet `statemachine`).
  Always transition via `transition_to(State.X)` — never write to `current_state` directly.
- **Autoloads** are singletons. Use them for: game state, audio, save data, global events.
  Do NOT use autoloads for gameplay logic that belongs in a scene.
- Scene folder structure:
  - `scenes/characters/` — player, NPCs, enemies
  - `scenes/levels/` — playable levels
  - `scenes/ui/` — HUD, menus, overlays
  - `scenes/environment/` — reusable environment pieces
  - `scripts/components/` — reusable component scripts (hitbox, health, interact, etc.)

---

## Performance / Optimization Rules

> These are **non-negotiable prerequisites** for every new script and scene.

1. **Cache everything in `_ready`.** Use `@onready`. If you access a node more than once, it must be cached.
2. **`_physics_process` for gameplay logic only.** Never do rendering or UI work there.
   Use `_process` only for things that must sync to the visual frame (e.g. camera smoothing).
3. **No allocations in hot paths.** Do not construct new `Vector3`, `Array`, or `Dictionary` objects
   inside `_process` or `_physics_process`. Pre-allocate in `_ready` or use class-level variables.
4. **Collision layers must be explicit.** Every physics body must have its layer and mask set.
   Never leave everything on layer 1 — define named layers in Project Settings.
5. **LOD (Level of Detail).** All `MeshInstance3D` nodes in levels must have a `VisibilityRangeFadeMode`
   and visibility distance set when the mesh is added. Do not skip this step.
6. **Object pooling for frequently spawned nodes.** Any node spawned more than ~5 times per second
   (bullets, particles proxies, etc.) must use a pool — never `instantiate()` per frame.
7. **Avoid `find_child()` / `find_node()` at runtime.** These are O(n) tree walks. Use direct references.
8. **Groups are for broadcast only.** Do not iterate `get_tree().get_nodes_in_group()` every frame.
9. **Signals over polling.** Do not check a condition every frame if it can be driven by a signal.
10. **Mark nodes as `process_mode = DISABLED`** when not in use (e.g. paused enemies off-screen).

---

## Input Map (defined in project.godot)

| Action | Default Key |
|--------|-------------|
| `move_forward` | W |
| `move_back` | S |
| `move_left` | A |
| `move_right` | D |
| `jump` | Space |
| `sprint` | Left Shift |
| `interact` | E |
| `pause` | Escape |
| `primary_action` | Left Mouse Button |

---

## Checklist Before Every Commit

See `docs/DEV_CHECKLIST.md` for the full per-feature checklist.

Short version:
- [ ] All variables typed
- [ ] No `get_node` in process functions
- [ ] Collision layers set
- [ ] LOD distances set on new meshes
- [ ] No debug `print()` left in code
- [ ] Scene tree has no orphaned/broken node references
