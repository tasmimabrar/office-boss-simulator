# Development Checklist

Use this before every commit and after every new feature. Items marked **[OPT]** are
optimization prerequisites — they must be completed before a feature is considered done.

---

## ✅ Every Feature

### Code Quality
- [ ] All variables, parameters, and return types are explicitly typed
- [ ] Private members and functions are prefixed with `_`
- [ ] No `get_node()` calls inside `_process` or `_physics_process` — use `@onready`
- [ ] No leftover `print()` debug calls
- [ ] Signal handlers follow `_on_<node>_<signal>` naming

### Scene Tree
- [ ] No orphaned nodes (nodes with no parent or broken references)
- [ ] No broken `NodePath` references (yellow warning icons in Godot editor)
- [ ] Scripts are attached to the correct node type
- [ ] Scene root node is named clearly (e.g. `Player`, `MainLevel`, not `Node3D`)

### Assets
- [ ] All new assets have been imported by Godot (`.import` sidecars exist and are committed)
- [ ] No placeholder / test assets left in the project

---

## [OPT] Optimization Prerequisites
> Complete these for **every new scene or script** before moving on.

### Physics & Collision
- [ ] Every `PhysicsBody3D` and `Area3D` has explicit **collision layer** and **collision mask** set
  - Layer 1 = World / Static Geometry
  - Layer 2 = Player
  - Layer 3 = Enemies / NPCs
  - Layer 4 = Interactables
  - Layer 5 = Hitboxes / Hurtboxes
  - Layer 6 = Projectiles
  *(Add layers in Project → Project Settings → Layer Names → 3D Physics)*
- [ ] No physics body is left on the default "everything on layer 1" setting

### Rendering & Meshes
- [ ] Every `MeshInstance3D` in a level scene has **Visibility Range** (min/max distance) set
- [ ] Every `MeshInstance3D` in a level scene has `VisibilityRangeFadeMode` set to `Self` or `Dependencies`
- [ ] Large static geometry uses **StaticBody3D** (not CharacterBody3D or RigidBody3D)
- [ ] Shadows: only key lights have `shadow_enabled = true` — fill/ambient lights do not

### Process / Update Loops
- [ ] Movement and game logic live in `_physics_process`, not `_process`
- [ ] Camera smoothing / visual-only updates live in `_process` only
- [ ] No new `Vector3`, `Array`, or `Dictionary` allocations inside process functions
- [ ] Any per-frame condition check that could be signal-driven has been replaced with a signal

### Spawning
- [ ] Any node spawned more than ~5 times per second uses an **object pool** (not `instantiate()`)

### Node Access
- [ ] No `find_child()`, `find_node()`, or `get_node()` calls at runtime outside `_ready`
- [ ] No `get_tree().get_nodes_in_group()` calls inside process functions

### Off-Screen / Inactive Nodes
- [ ] Enemies, NPCs, or complex objects that are off-screen or inactive have `process_mode = DISABLED`

---

## [OPT] New Level Checklist
> Complete when adding a new level scene.

- [ ] `WorldEnvironment` node present with a configured `Environment` resource
- [ ] At least one `DirectionalLight3D` with shadows enabled (the "sun")
- [ ] Occlusion: `OccluderInstance3D` added to large geometry where applicable
- [ ] Navigation: `NavigationRegion3D` baked if NPCs/enemies need pathfinding
- [ ] LOD distances reviewed for all significant meshes
- [ ] Performance baseline checked: target 60 fps in Godot editor play mode

---

## [OPT] New Character / NPC Checklist
> Complete when adding a new character scene.

- [ ] Root is `CharacterBody3D` (player/NPCs) or `RigidBody3D` (physics objects)
- [ ] `CollisionShape3D` uses a **primitive shape** (Capsule, Box, Sphere) — never ConcavePolygon
- [ ] Collision layer and mask explicitly set (not default)
- [ ] State machine uses enum pattern (`transition_to(State.X)`)
- [ ] Animations driven by `AnimationTree` (not raw `AnimationPlayer.play()` calls in logic)
- [ ] LOD / visibility range set on character mesh

---

## Release / Build Checklist

- [ ] `GODOT_VERSION` in `.github/workflows/godot-ci.yml` matches current engine version
- [ ] Export presets configured in Godot editor (Project → Export)
- [ ] Export templates downloaded for all target platforms
- [ ] `exports/` folder is gitignored ✓ (already set)
- [ ] Version tag applied: `git tag v0.x.x && git push --tags`
