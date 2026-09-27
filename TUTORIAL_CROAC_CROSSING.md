# 📖 TUTORIAL COMPLETO: CÓMO HICIMOS CROAC CROSSING

## MÓDULO 1: ¿Qué es Godot?

### 1.1 ¿Qué es un motor de juegos?

Un motor de juegos es un programa que hace el trabajo pesado por vos. En vez de tener que programar desde cero cómo dibujar píxeles en pantalla, detectar si la rana choca contra un auto, o reproducir un sonido, el motor ya tiene todo eso hecho.

**Godot** es un motor de juegos gratuito y de código abierto. Nosotros usamos la versión 4.4.

### 1.2 ¿Qué es un nodo?

En Godot, **TODO** es un nodo. Un nodo es como una "cajita" que hace una cosa específica. Los más importantes que usamos:

| Nodo | ¿Qué hace? | Ejemplo en nuestro juego |
|------|-------------|--------------------------|
| `Node2D` | Contenedor base para objetos 2D | El fondo, el nivel |
| `Sprite2D` | Dibuja una imagen en pantalla | Los autos, el icono |
| `AnimatedSprite2D` | Muestra animaciones (varias imágenes) | La rana (caminar, saltar, morir) |
| `CharacterBody2D` | Un personaje que se mueve y tiene físicas | La rana |
| `Area2D` | Zona que detecta cuando algo la toca | Los autos (detectan a la rana) |
| `CollisionShape2D` | Forma invisible para detectar choques | Rectángulo en la rana y autos |
| `AudioStreamPlayer` | Reproduce un sonido | Saltos, muerte, música |
| `Control` | Elemento de interfaz (botones, texto) | Menú, HUD, botones |
| `CanvasLayer` | Capa que se dibuja sobre todo | HUD, pausa, transiciones |
| `Node` | Nodo básico sin dibujo | GameManager (el cerebro) |

### 1.3 ¿Qué es una escena?

Una escena es un **grupo de nodos** armados juntos, como un rompecabezas. Cada cosa del juego es una escena:

```
La rana (frog.tscn) = CharacterBody2D
  ├── AnimatedSprite2D (sus animaciones)
  ├── CollisionShape2D (su forma de choque)
  ├── JumpSound (AudioStreamPlayer)
  ├── DeathSound (AudioStreamPlayer)
  └── CroakSound (AudioStreamPlayer)
```

### 1.4 ¿Qué es un script (.gd)?

Un script es un archivo de código que le dice a un nodo **qué hacer**. Está escrito en **GDScript**, que es parecido a Python:

```gdscript
# Este es el código más simple posible
extends Node2D    # "Soy un nodo 2D"

func _draw():     # "Cuando me dibujes..."
    draw_rect(...)  # "...dibuja un rectángulo"
```

### 1.5 Estructura de nuestro proyecto

```
mi_juego/
├── project.godot          ← Configuración del proyecto
├── main.gd                ← El director principal
├── scenes/
│   ├── main.tscn          ← Escena principal
│   ├── player/frog.tscn   ← La rana
│   ├── vehicles/           ← Los autos
│   ├── game/level.tscn    ← El nivel
│   └── ui/                 ← Menús y HUD
├── scripts/
│   ├── autoload/game_manager.gd  ← El cerebro global
│   ├── player/frog.gd    ← Lógica de la rana
│   ├── vehicles/          ← Lógica de autos
│   ├── game/level.gd      ← Lógica del nivel
│   └── ui/                 ← Lógica de menús
└── assets/
    ├── sprites/            ← Imágenes
    └── audio/              ← Sonidos y música
```

---

## MÓDULO 2: El fondo (main.gd)

### 2.1 ¿Qué hace?

`main.gd` dibuja el fondo del juego **a mano** usando código. No usa una imagen de fondo, sino que dibuja rectángulos de colores:

```
┌──────────────────────────┐
│  ZONA SEGURA (verde) 🐸  │  ← Aquí llega la rana para pasar de nivel
├──────────────────────────┤
│  VERDE (pasto)           │  ← Línea de inicio
├──────────────────────────┤
│  GRIS (avenida)         │  ← Donde circulan los autos
│  GRIS (avenida)         │
│  GRIS (avenida)         │
├──────────────────────────┤
│  VERDE (pasto)           │  ← Línea de inicio de la rana
├──────────────────────────┤
│  VERDE MÁS OSCURO        │  ← Borde inferior
└──────────────────────────┘
```

### 2.2 Código explicado línea por línea

```gdscript
extends Node2D   # "Esta escena es un nodo 2D"
```
Cada script empieza con `extends` - esto le dice a Godot qué tipo de nodo es.

```gdscript
var screen_width = 1280    # Ancho de pantalla en píxeles
var screen_height = 720    # Alto de pantalla en píxeles
```
`var` crea una variable. Es como una caja donde guardás un valor.

```gdscript
func _ready():
    pass
```
`_ready()` es una función que Godot llama **automáticamente** cuando la escena está lista. Como no necesitamos hacer nada al inicio, ponemos `pass` (no hacer nada).

```gdscript
func _draw():
    draw_rect(Rect2(0, 0, screen_width, 50), Color(0.1, 0.1, 0.1))
    draw_rect(Rect2(0, 50, screen_width, 50), Color(0.3, 0.7, 0.2))
    # ... más rectángulos
```
`_draw()` es otra función que Godot llama automáticamente para dibujar. Cada `draw_rect()` dibuja un rectángulo:
- `Rect2(x, y, ancho, alto)` = posición y tamaño
- `Color(r, g, b)` = color (0.0 a 1.0 por canal)

---

## MÓDULO 3: El cerebro (GameManager)

### 3.1 ¿Qué es un Autoload?

Un Autoload es un script que **existe siempre**, en todas las escenas. Es como un asistente que está en todos lados. Nosotros tenemos uno solo: **GameManager**.

### 3.2 ¿Qué guarda GameManager?

```gdscript
var lives: int = 5          # Vidas del jugador
var score: int = 0          # Puntos acumulados
var current_level: int = 1  # Nivel actual
var is_game_active: bool = false  # ¿Está jugando?
var high_score: int = 0     # Mejor puntaje guardado
var music_enabled: bool = true   # ¿Música activada?
var sfx_enabled: bool = true     # ¿Efectos activados?
```

`int` = número entero, `bool` = verdadero/falso, `String` = texto.

### 3.3 ¿Qué son las señales (signals)?

Las señales son el concepto **MÁS IMPORTANTE** del juego. Son como un sistema de megáfonos:

```
GameManager dice: "¡PERDÍ UNA VIDA!"  (señal: lives_changed)
    ↓
HUD escucha: "Ah, voy a actualizar el número de vidas en pantalla"
    ↓
Frog escucha: "Ok, me preparo para respawnear"
```

**La señal NO hace nada directamente** - solo avisa. Cada quien escucha y decide qué hacer.

Ejemplo de definición:
```gdscript
signal lives_changed(new_lives)    # "Puedo avisar cuando cambien las vidas"
signal game_over                    # "Puedo avisar cuando el juego termine"
signal touch_move(direction)       # "Puedo avisar cuando toquen la pantalla"
```

Ejemplo de uso:
```gdscript
# En GameManager:
func lose_life():
    lives -= 1                    # Restar una vida
    lives_changed.emit(lives)     # "¡AVISO que cambió!" (el .emit es el megáfono)

# En HUD:
func _ready():
    GameManager.lives_changed.connect(_on_lives_changed)  # "Escucho la señal"

func _on_lives_changed(new_lives):
    livesLabel.text = "VIDAS: " + str(new_lives)          # "Cuando cambie, actualizo el texto"
```

### 3.4 ¿Cómo funciona la dificultad?

```gdscript
func get_difficulty() -> Dictionary:
    if current_level <= 2:
        return {"lanes": 5, "speed": 160.0, "spawn_interval": 3.5}
        # 5 carriles, autos lentos, autos nuevos cada 3.5 segundos
    elif current_level <= 4:
        return {"lanes": 5, "speed": 200.0, "spawn_interval": 2.8}
        # Un poco más rápido
    elif current_level <= 6:
        return {"lanes": 6, "speed": 240.0, "spawn_interval": 2.2}
        # Más carriles, más rápido
    else:
        return {"lanes": 7, "speed": 280.0, "spawn_interval": 1.6}
        # ¡Máxima dificultad!
```

### 3.5 ¿Cómo se guarda el high score?

```gdscript
const SAVE_PATH = "user://highscore.cfg"  # Archivo en la memoria del celular

func save_high_score():
    var config = ConfigFile.new()          # Crear un archivo de configuración
    config.set_value("scores", "high_score", high_score)  # Guardar valor
    config.save(SAVE_PATH)                 # Guardar archivo

func load_high_score():
    var config = ConfigFile.new()
    var err = config.load(SAVE_PATH)       # Intentar cargar
    if err == OK:                          # Si existe
        high_score = config.get_value("scores", "high_score", 0)
```

---

## MÓDULO 4: La rana (frog.gd)

### 4.1 Movimiento por grilla

La rana **NO se mueve libremente** - se mueve de a saltos de 64 píxeles:

```
Posición actual: (640, 640)
         ↑ (salto arriba = -64 en Y)
         |
IZQ ←----+----→ DER
         |
         ↓ (salto abajo = +64 en Y)
```

```gdscript
const JUMP_DISTANCE = 64    # Cada salto mueve 64 píxeles
const JUMP_DURATION = 0.15  # Dura 0.15 segundos

func _on_touch_move(direction: Vector2):
    var target_pos = position + direction * JUMP_DISTANCE
    # Ejemplo: position=(640,640) + Vector2.UP*(64) = (640, 576)
    target_pos.x = clamp(target_pos.x, 32, 1248)  # No salir de pantalla
    target_pos.y = clamp(target_pos.y, 32, 688)
    # clamp limita un valor entre un mínimo y máximo
```

### 4.2 Animaciones

La rana tiene **3 hojas de sprites** (imágenes con varios frames):

```
frog_idle_walk_sheet.png (2 columnas × 4 filas = 8 frames)
┌────┬────┐
│idle│idle│  ← Frame 0, 1: quieta
├────┼────┤
│walk│walk│  ← Frame 2, 3: caminando
├────┼────┤
│jump│jump│  ← Frame 4, 5: saltando
├────┼────┤
│die │die │  ← Frame 6, 7: muriendo
└────┴────┘
```

Cada dirección (izquierda, derecha) tiene su propia hoja.

```gdscript
# Cuando la rana se mueve a la izquierda:
func _set_facing_left():
    sprite.sprite_frames = load("res://assets/sprites/player/frog_idle_walk_left.png")
    # Cambia la hoja de sprites a la versión izquierda
```

### 4.3 ¿Cómo muere la rana?

```gdscript
func die():
    if is_dead:
        return          # Si ya está muerta, no morir dos veces
    is_dead = true
    
    # 1. Animación de muerte
    sprite.play("death")
    
    # 2. Sonido
    jump_sound.stop()
    death_sound.play()
    
    # 3. Efecto visual: flash rojo
    var tween = create_tween()
    sprite.modulate = Color(1, 0.3, 0.3)  # Rojo
    tween.tween_property(sprite, "modulate", Color.WHITE, 0.5)
    
    # 4. Vibración (si es celular)
    if OS.has_feature("mobile"):
        Input.vibrate_handheld(200)  # Vibrar 200ms
    
    # 5. Avisar al GameManager
    GameManager.lose_life()
    
    # 6. Respawnear después de 1 segundo
    await get_tree().create_timer(1.0).timeout
    is_dead = false
    position = start_position  # Volver a posición inicial
```

---

## MÓDULO 5: Los vehículos (vehicle.gd + vehicle_spawner.gd)

### 5.1 Tipos de vehículos

Cada tipo tiene su imagen, tamaño, y velocidad:

| Tipo | Sprite | Velocidad | Tamaño |
|------|--------|-----------|--------|
| Auto | auto.png | Normal (1.0x) | Mediano |
| Deportivo | auto_deportivo.png | Rápido (1.2x) | Pequeño |
| Bus | bus.png | Lento (0.6x) | Grande |
| Camión | camion.png | Medio (0.8x) | Grande |
| Camioneta | camioneta.png | Normal (1.0x) | Mediano |
| Combi | combi.png | Normal (1.0x) | Grande |
| Moto | moto.png | Muy rápido (1.4x) | Pequeño |

### 5.2 Cómo funciona el spawner

El spawner es como una **máquina expendedora de autos**:

```gdscript
# vehicle_spawner.gd
var vehicle_scene = preload("res://scenes/vehicles/car.tscn")
# preload() carga la escena del auto AL INICIO del juego

func _ready():
    # Pre-cargar 2 autos en posiciones aleatorias
    for i in range(2):
        var vehicle = vehicle_scene.instantiate()  # Crear un auto nuevo
        vehicle.position.x = randf_range(0, 1280)  # Posición random
        add_child(vehicle)  # Agregar al juego

func _spawn_vehicle():
    if vehicles_in_lane >= MAX_VEHICLES:
        return  # Si ya hay 3 autos, no crear más
    
    var vehicle = vehicle_scene.instantiate()
    vehicle.position.x = spawn_position  # Empezar fuera de pantalla
    add_child(vehicle)
    vehicles_in_lane += 1
```

### 5.3 Colisiones

El auto es un `Area2D` que detecta cuando toca a la rana:

```
Auto (Area2D, Capa 2)
    └── CollisionShape2D (rectángulo 55×30)

Rana (CharacterBody2D, Capa 1)
    └── CollisionShape2D (rectángulo 50×50)
```

Cuando el auto toca a la rana → `frog.die()` → la rana muere.

---

## MÓDULO 6: El nivel (level.gd)

### 6.1 Cómo se arma un nivel

```gdscript
func setup_level():
    # 1. Obtener dificultad del nivel actual
    var diff = GameManager.get_difficulty()
    var num_lanes = diff.lanes  # 5, 6, o 7 carriles
    
    # 2. Calcular posiciones de carriles
    var lane_height = 64  # Cada carril mide 64px
    var start_y = 120     # Primer carril empieza en Y=120
    
    # 3. Crear un spawner por cada carril
    for i in range(num_lanes):
        var spawner = vehicle_spawner_scene.instantiate()
        spawner.setup(
            speed,          # Velocidad de los autos
            direction,      # Izquierda o derecha
            start_y + i * lane_height,  # Posición Y
            spawn_interval  # Cada cuánto aparece un auto nuevo
        )
        add_child(spawner)
    
    # 4. Crear la rana abajo
    var frog = frog_scene.instantiate()
    frog.position = Vector2(640, 640)  # Centro abajo
    add_child(frog)
```

### 6.2 ¿Cómo pasa de nivel?

Cuando la rana llega a la **zona segura** (arriba, donde está el cordón):

```gdscript
func _on_frog_reached_safe_spot():
    GameManager.next_level()  # +1 nivel, +100 puntos
    # GameManager dice: "¡Nuevo nivel!" (señal level_changed)
    # level.gd escucha: "Ah, recargo los carriles"
    setup_level()  # Armar nivel nuevo con más dificultad
```

---

## MÓDULO 7: La interfaz

### 7.1 ¿Qué es CanvasLayer?

`CanvasLayer` es una capa especial que se dibuja **SIEMPRE encima** del juego. Usamos capas para que el HUD no se mueva cuando la cámara se mueve:

| Capa | Qué hay | ¿Por qué? |
|------|---------|------------|
| 10 | HUD (vidas, puntos) | Siempre visible |
| 20 | Pausa, controles touch | Encima del juego |
| 25 | Opciones | Encima de todo |
| 30 | Transiciones (fade) | Lo último que se ve |

### 7.2 El HUD

```gdscript
# hud.gd
func _ready():
    # Conectarse a las señales del GameManager
    GameManager.lives_changed.connect(_on_lives_changed)
    GameManager.score_changed.connect(_on_score_changed)
    GameManager.level_changed.connect(_on_level_changed)
    GameManager.game_over.connect(_on_game_over)

func _on_lives_changed(new_lives):
    livesLabel.text = "VIDAS: " + str(new_lives)

func _on_score_changed(new_score):
    scoreLabel.text = "PUNTAJE: " + str(new_score)

func _on_game_over():
    gameOverPanel.visible = true  # Mostrar panel de Game Over
    finalScore.text = str(GameManager.score)
    highScore.text = str(GameManager.high_score)
```

### 7.3 La pausa

```gdscript
# pause_menu.gd (tiene process_mode = 3)
# process_mode = 3 significa "funciona aunque el juego esté pausado"

func _on_continuar_pressed():
    GameManager.resume_game()  # Reanudar el árbol de escenas
    visible = false            # Ocultar menú de pausa

func _on_reiniciar_pressed():
    GameManager.resume_game()
    get_tree().reload_current_scene()  # Recargar todo
```

---

## MÓDULO 8: Flujo completo del juego

### 8.1 Diagrama de señales

```
┌─────────────────────────────────────────────┐
│              GAME MANAGER                   │
│  (Autoload, existe siempre)                 │
│                                             │
│  Señales:                                   │
│  ├── lives_changed(lives)  ──────────────→  HUD actualiza "VIDAS: X"
│  ├── score_changed(score)  ──────────────→  HUD actualiza "PUNTAJE: X"
│  ├── level_changed(level)  ──────────────→  HUD actualiza "NIVEL: X"
│  │                                      └→ Level recarga carriles
│  ├── game_over              ──────────────→  HUD muestra Game Over
│  │                                      └→ Level destruye spawners
│  └── touch_move(direction)  ──────────────→  Frog se mueve
└─────────────────────────────────────────────┘
```

### 8.2 Flujo paso a paso

```
1. JUEGO ARRANCA
   Godot lee project.godot → carga start_screen.tscn
   → Ves el menú con "CROAC CROSSING" y el botón JUGAR

2. APRETÁS "JUGAR"
   start_screen.gd → change_scene_to_file("res://main.tscn")
   → main.tscn carga → main.gd dibuja el fondo
   → Se crea Level, HUD, TouchControls, PauseMenu

3. GAME MANAGER EMPIEZA
   GameManager.start_game():
   → lives = 5, score = 0, level = 1
   → Emite señales → HUD muestra "VIDAS: 5", "PUNTAJE: 0"

4. NIVEL SE ARMA
   level.gd llama get_difficulty() → 5 carriles, velocidad 160
   → Crea 5 VehicleSpawners
   → Cada spawner crea 2 autos
   → Se crea la rana abajo

5. JUGÁS
   → Tecla arriba → Frog.salta(64px)
   → Chocás un auto → Frog.die() → GameManager.lose_life()
   → Vidas: 4 → Señal lives_changed → HUD actualiza

6. PASÁS DE NIVEL
   → La rana llega arriba (zona segura)
   → GameManager.next_level() → nivel 2, +100 puntos
   → level.gd recarga carriles (misma dificultad)

7. NIVEL 5+
   → get_difficulty() → 6 carriles, velocidad 240
   → Música cambia a "bgm_fast.wav" (más acelerada)

8. GAME OVER
   → Vidas: 0 → GameManager.game_over.emit()
   → HUD muestra panel con score y high score
   → Botones: "REINTENTAR" (recarga) o "MENU" (vuelve al inicio)
```

### 8.3 Arquitectura resumida

```
┌─────────────────────────────────────────┐
│  project.godot (configuración)          │
│  └── Autoload: GameManager              │
│                                         │
│  start_screen.tscn (menú)               │
│  └── Botón JUGAR → main.tscn           │
│                                         │
│  main.tscn (juego)                      │
│  ├── main.gd (fondo + instancias)       │
│  ├── level.gd (carriles + dificultad)   │
│  │   ├── vehicle_spawner.gd × N         │
│  │   │   └── vehicle.gd × 3 por carril │
│  │   └── frog.gd (movimiento + vida)    │
│  ├── hud.gd (vidas, puntos, pausa)      │
│  ├── touch_controls.gd (botones móvil)  │
│  ├── pause_menu.gd (pausa)              │
│  └── screen_transition.gd (fades)       │
└─────────────────────────────────────────┘
```

---

## RESUMEN DE ARCHIVOS

| Archivo | Líneas | Qué hace |
|---------|--------|----------|
| `main.gd` | 101 | Dibuja fondo, instancia todo |
| `game_manager.gd` | 186 | Cerebro: vidas, puntos, señales, audio |
| `level.gd` | 121 | Arma carriles, crea autos y rana |
| `frog.gd` | 150 | Movimiento, animaciones, muerte |
| `vehicle.gd` | 87 | Un auto que se mueve y choque |
| `vehicle_spawner.gd` | 79 | Crea autos cada X segundos |
| `start_screen.gd` | 42 | Menú principal |
| `hud.gd` | 69 | Muestra vidas/puntos/game over |
| `pause_menu.gd` | 39 | Menú de pausa |
| `options_menu.gd` | 32 | Opciones música/sfx |
| `touch_controls.gd` | 28 | Botones táctiles dirección |
| `screen_transition.gd` | 45 | Efectos fade/flash |
| **TOTAL** | **989** | |
