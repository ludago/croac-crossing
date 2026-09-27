# Croac Crossing - Progreso del Juego

## Estado Actual del Proyecto
- **Motor**: Godot 4.4
- **Resolución**: 1280x720 (landscape)
- **Tipo**: Frogger estilo clásico
- **Nombre**: Croac Crossing
- **Package**: com.pixelgamestucuman.frogger
- **Version**: 1.0.0

---

## Archivos Modificados

### Scripts
| Archivo | Descripción |
|---------|-------------|
| `scripts/autoload/game_manager.gd` | GameManager con vidas, puntos, niveles, dificultad progresiva, pausa, high score, settings |
| `scripts/game/level.gd` | Lógica de niveles, carriles, desagües seguros, transiciones |
| `scripts/player/frog.gd` | Movimiento de rana, animaciones direccionales, sonidos, shake, haptics |
| `scripts/vehicles/vehicle.gd` | Vehículos con movimiento, sprites reales, rotación, 7 tipos |
| `scripts/vehicles/vehicle_spawner.gd` | Spawner de vehículos (2 por carril al inicio) |
| `scripts/ui/hud.gd` | HUD con vidas, puntos, nivel, pausa, stats de game over |
| `scripts/ui/touch_controls.gd` | Controles táctiles |
| `scripts/ui/start_screen.gd` | Pantalla de inicio con rana animada, créditos, opciones |
| `scripts/ui/options_menu.gd` | Menú de opciones con sonido/música ON/OFF, persistencia |
| `scripts/ui/pause_menu.gd` | Menú de pausa con continuar, reintentar, opciones, salir |
| `scripts/ui/screen_transition.gd` | Transiciones fade_in/fout, flash blanco |
| `main.gd` | Layout del fondo, cordon de vereda, pausa, shake_camera |

### Escenas
| Archivo | Descripción |
|---------|-------------|
| `scenes/player/frog.tscn` | Rana con AnimatedSprite2D, sonidos, colisión |
| `scenes/vehicles/car.tscn` | Vehículo base |
| `scenes/ui/hud.tscn` | Interfaz de usuario con pausa y game over panel |
| `scenes/ui/touch_controls.tscn` | Controles táctiles (derecha) |
| `scenes/ui/start_screen.tscn` | Pantalla de inicio con rana y opciones |
| `scenes/ui/pause_menu.tscn` | Menú de pausa con opciones |
| `scenes/ui/options_menu.tscn` | Menú de opciones con sonido/música ON/OFF |
| `scenes/ui/screen_transition.tscn` | Transiciones de pantalla |

### Assets
| Archivo | Descripción |
|---------|-------------|
| `assets/sprites/player/frog_idle_walk_sheet.png` | Spritesheet rana frontal (8 frames, 128x128 c/u) |
| `assets/sprites/player/frog_idle_walk_left.png` | Spritesheet rana mirando izquierda (8 frames, 128x128 c/u) |
| `assets/sprites/player/frog_idle_walk_right.png` | Spritesheet rana mirando derecha (8 frames, 128x128 c/u) |
| `assets/sprites/vehicles/auto.png` | Auto rojo (top-down) |
| `assets/sprites/vehicles/auto_deportivo.png` | Auto deportivo rojo (top-down) |
| `assets/sprites/vehicles/bus.png` | Bus amarillo (top-down) |
| `assets/sprites/vehicles/camion.png` | Camión verde (top-down) |
| `assets/sprites/vehicles/camioneta.png` | Camioneta verde militar (top-down) |
| `assets/sprites/vehicles/combi.png` | Combi blanca (top-down) |
| `assets/sprites/vehicles/moto.png` | Moto azul (top-down) |
| `assets/sprites/environment/cordon_desague.png` | Imagen de cordon con desagüe (512x220) |
| `assets/audio/music/bgm_normal.wav` | Música de fondo normal |
| `assets/audio/music/bgm_fast.wav` | Música de fondo rápida (niveles altos) |
| `assets/audio/sfx/frog_jump.wav` | Sonido de salto |
| `assets/audio/sfx/frog_croak.wav` | Sonido de croar |
| `assets/audio/sfx/frog_squash.wav` | Sonido de muerte |
| `assets/audio/sfx/game_over.wav` | Sonido de game over |
| `assets/audio/sfx/level_complete.wav` | Sonido de nivel completado |
| `assets/audio/sfx/car_pass.wav` | Sonido de auto |
| `assets/audio/sfx/bus_pass.wav` | Sonido de bus |
| `assets/audio/sfx/truck_pass.wav` | Sonido de camión |
| `assets/audio/sfx/moto_pass.wav` | Sonido de moto |

### Archivos de Configuración
| Archivo | Descripción |
|---------|-------------|
| `project.godot` | Configuración del proyecto (nombre, versión, autoload, display) |
| `export_presets.cfg` | Configuración de exportación Android |
| `icon.png` | Ícono de la app (512x512) |
| `splash.png` | Splash screen |

---

## Mecánicas Implementadas

### 1. Carriles y Vehículos
- Carriles dinámicos según nivel (5-7 carriles)
- Líneas de separación dibujadas dinámicamente
- Vehículos centrados en carriles
- Límite de 3 vehículos por carril
- Velocidad progresiva por nivel
- 7 tipos de vehículos con escala/collision propia

### 2. Dificultad Progresiva
- **Nivel 1-2**: 5 carriles, 160px/s, spawn cada 3.5s
- **Nivel 3-4**: 5 carriles, 200px/s, spawn cada 2.8s
- **Nivel 5-6**: 6 carriles, 240px/s, spawn cada 2.2s
- **Nivel 7+**: 7 carriles, 280px/s, spawn cada 1.6s

### 3. Rana
- 3 Spritesheets: frontal, izquierda, derecha (cada uno 2x4, 128x128)
- Animaciones: idle, idle_left, idle_right, walk, walk_left, walk_right, jump, jump_left, jump_right, death
- Escala 0.4 (50x50 colisión)
- Movimiento con Tween (arco de salto)
- Sprite facing según última dirección
- Sonidos: salto, croar al aterrizar, muerte
- Screen shake al morir
- Vibración háptica en móvil

### 4. Colisiones
- Vehículos en `collision_layer = 2`, mask = 1
- Rana en `collision_layer = 1`, mask = 0
- Vehículos en `_physics_process` para sincronía con physics engine
- Rana usa `move_and_slide()` para sincronizar posición

### 5. Sistema de Desagües (Safe Spots)
- Cordon de vereda arriba de la avenida (imagen real)
- 6 desagües como Area2D invisibles (100x80)
- Al entrar: rana desaparece + 50 puntos + siguiente nivel
- Al tocar cordon sin desagüe: muere
- Rana reaparece visible en el punto de partida

### 6. Layout
```
[0-50]     Negro (margen superior)
[50-150]   Cordon de vereda con desagües
[150-550]  Avenida (5-7 carriles)
[550-650]  Césped de partida
[650-720]  Negro (margen inferior)
```

### 7. Controles
- Flechas del teclado
- D-pad táctil en la derecha de la pantalla
- Botón Atrás Android (pausa/cerrar)

### 8. UI/UX
- Pantalla de inicio con rana animada
- High score persistente (user://highscore.cfg)
- Settings persistente (user://settings.cfg) - música/sonido ON/OFF
- Game over con stats (puntos, nivel, high score)
- Pausa con opciones (continuar, reintentar, opciones, salir)
- Transiciones fade/flash entre pantallas
- Opciones accesibles desde inicio y pausa

---

## Estado de Build
- **APK generado**: `build/frogger.apk` (26.9 MB)
- **Firma**: Keystore de debug (Godot default)
- **Uso**: Prueba en celular
- **Pendiente**: Keystore de release para Play Store

---

## Pendiente para Play Store
- [ ] Crear keystore de release (`keytool -genkey`)
- [ ] Configurar keystore en `export_presets.cfg`
- [ ] Re-exportar APK con keystore de release (o AAB)
- [ ] Screenshots para Play Store
- [ ] Descripción de la app
- [ ] Subir a Google Play Console
