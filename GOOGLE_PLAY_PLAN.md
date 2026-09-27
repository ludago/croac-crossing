# Croac Crossing - Plan Google Play Store

## Estado del Proyecto
- **Motor**: Godot 4.4
- **Plataforma**: Android (Google Play Store)
- **Resolución**: 1280x720 (landscape)
- **Tipo**: Frogger estilo clásico
- **Nombre**: Croac Crossing
- **Package**: com.pixelgamestucuman.frogger

---

## Checklist de Implementación

### Fase 1: Funcionalidad Core

| # | Tarea | Estado | Archivos |
|---|-------|--------|----------|
| 1 | Sistema de pausa | ✅ Completado | `game_manager.gd`, `pause_menu.tscn` |
| 2 | Música de fondo | ✅ Completado | `game_manager.gd`, `assets/audio/music/` |
| 3 | Menú de opciones (sonido/música) | ✅ Completado | `options_menu.tscn`, `start_screen.gd`, `pause_menu.gd` |
| 4 | High score guardado | ✅ Completado | `game_manager.gd`, `hud.gd` |
| 5 | Game over mejorado | ✅ Completado | `hud.gd`, `hud.tscn` |
| 6 | Botón Atrás Android | ✅ Completado | `main.gd`, `start_screen.gd` |

### Fase 2: Polish

| # | Tarea | Estado | Archivos |
|---|-------|--------|----------|
| 7 | Transiciones de nivel | ✅ Completado | `screen_transition.gd`, `level.gd`, `main.gd` |
| 8 | Efectos visuales (screen shake, flash) | ✅ Completado | `frog.gd`, `main.gd`, `screen_transition.gd` |
| 9 | Vibración háptica | ✅ Completado | `frog.gd` |

### Fase 3: Preparación Tienda

| # | Tarea | Estado | Archivos |
|---|-------|--------|----------|
| 10 | Ícono de app (512x512) | ✅ Completado | `icon.png` |
| 11 | Splash screen personalizado | ✅ Completado | `splash.png` |
| 12 | Config proyecto (nombre, versión) | ✅ Completado | `project.godot` |
| 13 | Export Android (APK/AAB) | ✅ Completado | `export_presets.cfg` |
| 14 | Screenshots para Play Store | ⏳ Pendiente | `store/` |
| 15 | Descripción de la app | ⏳ Pendiente | `store/description.md` |

---

## Detalles por Paso

### Paso 1: Sistema de Pausa
- Botón de pausa en el HUD (esquina superior derecha)
- Menú emergente con: Continuar, Reintentar, Salir al menú
- Pausar physics y animaciones
- `get_tree().paused = true/false`

### Paso 2: Música de Fondo
- Archivo de música looping en `assets/audio/music/`
- Reproducir en `level.gd` o `game_manager.gd`
- Respetar opción de música ON/OFF
- Fade in/out al cambiar de nivel

### Paso 3: Menú de Opciones
- Accesible desde pantalla de inicio
- Toggle: Sonido ON/OFF
- Toggle: Música ON/OFF
- Guardar preferencias con ConfigFile

### Paso 4: High Score
- Guardar mejor puntaje con `ConfigFile`
- Mostrar en HUD y game over
- Guardar en `user://highscore.cfg`

### Paso 5: Game Over Mejorado
- Mostrar: Puntos obtenidos, Nivel alcanzado, High score
- Botones: Reintentar, Menú principal

### Paso 6: Botón Atrás Android
- En pausa → cerrar pausa
- En juego → pausar
- En menú principal → salir de la app
- Usar `_notification(NOTIFICATION_WM_GO_BACK_REQUEST)`

### Paso 7-13: Config y Export
- Ícono 512x512 para Play Store
- Splash screen con logo del juego
- Versión: 1.0.0
- Configurar export template para Android
- Build AAB para Play Store

---

## Archivos Existentes (completados)
- [x] `scripts/autoload/game_manager.gd` — GameManager
- [x] `scripts/game/level.gd` — Lógica de niveles
- [x] `scripts/player/frog.gd` — Movimiento de rana
- [x] `scripts/vehicles/vehicle.gd` — Vehículos
- [x] `scripts/vehicles/vehicle_spawner.gd` — Spawner
- [x] `scripts/ui/hud.gd` — HUD
- [x] `scripts/ui/touch_controls.gd` — Controles táctiles
- [x] `scripts/ui/start_screen.gd` — Pantalla de inicio
- [x] `main.gd` — Layout del fondo
