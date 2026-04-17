# Game Title

> Short one-line description of the game.

![Godot](https://img.shields.io/badge/Godot-4.x-blue?logo=godot-engine)
![GDScript](https://img.shields.io/badge/Language-GDScript-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## Overview

<!-- 2–3 sentences: genre, core loop, target platform -->

## Screenshots

<!-- Drop screenshots or GIFs here -->

---

## Getting Started

### Prerequisites

| Tool | Version |
|------|---------|
| [Godot Engine](https://godotengine.org/download/) | 4.x |
| [VS Code](https://code.visualstudio.com/) | Latest |
| [Godot Tools (VS Code extension)](https://marketplace.visualstudio.com/items?itemName=geequlim.godot-tools) | Latest |

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
   ```

2. **Open in Godot**  
   Launch Godot 4, click **Import**, and select the `project.godot` file.  
   Godot will re-import all assets on first open.

3. **Open in VS Code**  
   ```bash
   code .
   ```
   Install recommended extensions when prompted (`Extensions: Show Recommended Extensions`).

4. **Point VS Code to Godot**  
   In `.vscode/settings.json`, set `godotTools.editorPath.godot4` to the full path of your `Godot.exe`.

5. **Run the game**  
   - From VS Code: `Ctrl+Shift+B` → **Run Game**, or press `F5` to launch with the debugger.  
   - From Godot: `F5`.

---

## Project Structure

```
├── .github/workflows/   # CI/CD — auto-export on push/tag
├── .vscode/             # Shared VS Code settings, tasks, snippets, launch config
├── addons/              # Godot plugins / third-party addons
├── assets/
│   ├── audio/
│   │   ├── music/
│   │   └── sfx/
│   ├── fonts/
│   ├── models/          # .glb / .gltf 3D models
│   ├── shaders/         # .gdshader files
│   └── textures/
│       ├── environment/
│       └── ui/
├── docs/                # GDD, architecture notes, changelogs
├── exports/             # Built binaries (git-ignored)
├── resources/
│   ├── data/            # .tres data resources (items, levels, config)
│   ├── materials/       # StandardMaterial3D / ShaderMaterial resources
│   └── themes/          # UI Theme resources
├── scenes/
│   ├── autoloads/       # Singleton scenes
│   ├── characters/
│   ├── environment/
│   ├── levels/
│   └── ui/
└── scripts/
    ├── autoloads/       # Singleton scripts (GameManager, AudioManager…)
    ├── characters/
    ├── components/      # Reusable component scripts
    ├── environment/
    ├── ui/
    └── utils/
```

---

## Development Workflow

| Action | Shortcut / Command |
|--------|--------------------|
| Run game | `Ctrl+Shift+B` → **Run Game** |
| Run current scene | `F5` (with **Launch Current Scene** config) |
| Debug with breakpoints | `F5` (with **Launch Game** config) |
| Open Godot editor | `Ctrl+Shift+B` → **Open Godot Editor** |
| Export Windows release | `Ctrl+Shift+B` → **Export: Windows — Release** |

### Branching Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Stable, releasable state |
| `dev` | Active development |
| `feature/*` | New features |
| `fix/*` | Bug fixes |

Tag a release with `vX.Y.Z` to trigger the CI export pipeline and create a GitHub Release automatically.

---

## License

[MIT](LICENSE) — see the LICENSE file for details.
