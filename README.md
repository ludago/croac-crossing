# 🐸 Croac Crossing

> A modern **Frogger-style arcade game** built with **Godot 4** — my debut project as a game developer.

![Godot](https://img.shields.io/badge/Godot-4.x-478CBF?logo=godotengine&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)
![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Android%20%7C%20Web-blue)
![Status](https://img.shields.io/badge/Status-Playable-brightgreen)

---

## 🎮 About the Game

**Croac Crossing** is a love letter to the classic arcade genre. Guide your frog across treacherous roads and rivers, dodging cars, trucks, buses, and motorcycles — each with unique speeds and behaviors. Reach the safety zones on the other side to advance. Simple to learn, challenging to master.

### ✨ Key Features

| Feature | Description |
|---------|-------------|
| **5 Vehicle Types** | Cars, sports cars, trucks, buses, motorcycles — each with distinct speed & sprite |
| **Dynamic Spawning** | Procedural wave system with configurable density & difficulty scaling |
| **Touch & Keyboard Controls** | Optimized for both desktop and mobile play |
| **Persistent Progression** | High scores, settings, and game state saved via `GameManager` autoload |
| **Polished UI** | Start screen, pause menu, options, HUD, and smooth screen transitions |
| **Audio System** | Background music (adaptive tempo) + 7 SFX (jump, croak, squash, vehicle passes, game over, level complete) |
| **Export Ready** | Presets configured for Windows, Android (keystore ready), and Web |

---

## 🛠 Technical Stack

- **Engine**: Godot 4.4 (GL Compatibility renderer for broad hardware support)
- **Language**: GDScript (typed, signal-driven architecture)
- **Architecture**: Autoload singleton (`GameManager`) + scene-based composition
- **Input**: `InputMap` actions for remappable controls
- **Persistence**: `ConfigFile` for settings & high scores
- **Build**: Export templates + custom `export_presets.cfg`

---

## 📁 Project Structure

```text
croac-crossing/
├── assets/
│   ├── audio/           # Music (2 tracks) + SFX (7 files)
│   └── sprites/         # Player, vehicles, environment
├── scenes/
│   ├── game/            # Level composition
│   ├── player/          # Frog character
│   ├── ui/              # All UI screens (HUD, menus, transitions)
│   └── vehicles/        # Vehicle instances & spawner
├── scripts/
│   ├── autoload/        # GameManager (global state)
│   ├── game/            # Level logic
│   ├── player/          # Frog movement & animation
│   ├── ui/              # UI controllers
│   └── vehicles/        # Vehicle behavior & spawner
├── main.tscn            # Entry point (boot splash → start screen)
├── project.godot        # Engine configuration
└── export_presets.cfg   # Build profiles
```

---

## 🚀 Getting Started

### Prerequisites
- **Godot 4.4+** (standard or .NET version)

### Run Locally
```bash
# Clone the repository
git clone https://github.com/ludago/croac-crossing.git
cd croac-crossing

# Open in Godot 4 → Press F5 (or click ▶ Play)
```

### Build Exports
```bash
# Windows executable
godot --headless --export-release "Windows Desktop" build/croac-crossing.exe

# Android APK (requires keystore & templates)
godot --headless --export-release "Android" build/croac-crossing.apk

# Web (HTML5)
godot --headless --export-release "Web" build/web/index.html
```

> **Note**: `export_presets.cfg` is included. For Android, add your `croac_crossing.keystore` (gitignored) and configure signing in Project → Export.

---

## 🎯 Design Highlights

- **Signal-first communication** — loose coupling between systems
- **Object pooling** via `VehicleSpawner` — zero allocation during gameplay
- **State machine** for frog (idle → moving → squashed → respawn)
- **Responsive UI** — anchors + containers, works at any resolution (base 1920×720)
- **Accessibility ready** — volume sliders, vibration toggle, control hints

---

## 📜 License

MIT License — free to use, modify, and distribute.  
See [LICENSE](LICENSE) for details.

> **Attribution appreciated**: If you build something cool with this, I'd love to see it!

---

## 👨‍💻 Author

**ludago**  
🎮 First commercial indie project — built to learn, shipped to play.  
🔗 [GitHub](https://github.com/ludago) • [LinkedIn](https://linkedin.com/in/ludago) • [Portfolio](https://tu-sitio.com)

---

> *“Every expert was once a beginner. This is my level one.”*