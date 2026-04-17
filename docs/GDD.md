# Game Design Document (GDD)

> **Project:** Game Title  
> **Version:** 0.1  
> **Last Updated:** <!-- date -->  
> **Author(s):** <!-- names -->

---

## 1. Concept

### 1.1 Elevator Pitch
<!-- One or two sentences. What is the game? Why is it fun? -->

### 1.2 Genre & Inspirations
- **Genre:** 3D Action / Adventure / etc.
- **Inspirations:** <!-- e.g. Dark Souls, Control, etc. -->

### 1.3 Platform & Target Audience
- **Platform(s):** Windows, Linux, Web
- **Audience:** <!-- age range, interests -->

---

## 2. Core Gameplay Loop

```
[Start] → [Explore] → [Encounter/Challenge] → [Reward/Progress] → [Repeat / End]
```

<!-- Expand each step with a 1–2 sentence description -->

---

## 3. Player

### 3.1 Controls

| Input | Action |
|-------|--------|
| WASD / Left Stick | Move |
| Mouse / Right Stick | Camera |
| Space / A | Jump |
| LMB / RT | Primary Attack |
| RMB / LT | Aim / Block |
| E / Y | Interact |
| Esc / Start | Pause |

### 3.2 Movement & Feel
<!-- Describe movement speed, jump feel, camera behavior, etc. -->

### 3.3 Stats / Attributes

| Attribute | Description | Default |
|-----------|-------------|---------|
| Health | Hit points | 100 |
| Speed | Movement speed (m/s) | 5.0 |
| Jump Height | Velocity on jump | 4.5 |

---

## 4. World & Levels

### 4.1 Setting
<!-- Art style, time period, atmosphere -->

### 4.2 Level List

| Level | Scene File | Description | Status |
|-------|-----------|-------------|--------|
| Tutorial | `scenes/levels/tutorial.tscn` | Teaches basic movement | 🔲 Planned |
| Level 1 | `scenes/levels/level_01.tscn` | First combat encounter | 🔲 Planned |

### 4.3 Progression
<!-- Linear? Open world? How do levels unlock? -->

---

## 5. Enemies & AI

| Enemy | Behavior | Health | Attack |
|-------|----------|--------|--------|
| Basic Enemy | Patrol → Chase → Attack | 30 | 10 dmg |

---

## 6. Items & Resources

| Item | Type | Effect |
|------|------|--------|
| Health Pack | Consumable | +25 HP |

---

## 7. Audio

### 7.1 Music
- **Style:** <!-- e.g. Orchestral, Synthwave -->
- **Dynamic audio:** <!-- e.g. tension layers on combat -->

### 7.2 SFX
<!-- Key sound effects: footsteps, attacks, UI, ambience -->

---

## 8. UI / UX

### 8.1 Screens
- [ ] Main Menu
- [ ] Pause Menu
- [ ] HUD (health, stamina, minimap)
- [ ] Inventory / Equipment
- [ ] Game Over / Victory

---

## 9. Technical Notes

- **Engine:** Godot 4.x (GDScript)
- **Rendering:** Forward+ (3D)
- **Target FPS:** 60
- **Save System:** <!-- e.g. JSON to user://save.json -->
- **Key Autoloads:** `GameManager`, `AudioManager`, `SaveManager`

---

## 10. Milestones

| Milestone | Description | Target Date |
|-----------|-------------|-------------|
| Prototype | Core movement + 1 level | <!-- date --> |
| Alpha | All levels playable | <!-- date --> |
| Beta | Content-complete, bug fixing | <!-- date --> |
| Release | Polished, exported | <!-- date --> |
