# Carrera de Autos - Godot 4.4

## Controles
- **W / Flecha Arriba**: Acelerar
- **S / Flecha Abajo**: Frenar / Reversa
- **A / Flecha Izquierda**: Girar izquierda
- **D / Flecha Derecha**: Girar derecha
- **Espacio**: Drift
- **ESC**: Volver al menú

## Modos de Juego
1. **Un Jugador vs AI**: compite contra la computadora
2. **Online (2 jugadores)**: crea una sala y comparte tu IP con un amigo

## Cómo jugar Online
1. Un jugador selecciona "Host" (crea la sala)
2. El otro jugador selecciona "Unirse" e ingresa la IP del host
3. Cuando ambos estén conectados, el host inicia la carrera

## Estructura del Proyecto
```
carrera_de_autos/
├── project.godot          # Configuración del proyecto
├── scenes/
│   ├── cars/
│   │   └── car.tscn       # Escena del auto
│   ├── track/
│   │   └── game.tscn      # Escena principal del juego
│   └── ui/
│       ├── main_menu.tscn # Menú principal
│       ├── lobby.tscn     # Pantalla de conexión online
│       └── hud.tscn       # Interfaz de juego
├── scripts/
│   ├── cars/
│   │   ├── car.gd         # Física y movimiento del auto
│   │   └── ai_driver.gd   # IA para el segundo auto
│   ├── track/
│   │   ├── game.gd        # Lógica principal del juego
│   │   └── race_track.gd  # Generación de la pista
│   ├── ui/
│   │   ├── main_menu.gd   # Menú principal
│   │   ├── lobby.gd       # Conexión online
│   │   └── hud.gd         # Interfaz de juego
│   └── networking/
│       └── network_manager.gd  # Sistema multiplayer
├── assets/
│   ├── sprites/           # Imágenes de autos y pista
│   └── audio/             # Sonidos de motor, drift, etc.
└── export/                # Builds exportados
```

## Para agregar sonidos
Coloca archivos .wav en `assets/audio/` y referéncialos en los scripts.

## Para agregar más pistas
Crea una nueva escena que extienda RaceTrack y genera puntos diferentes.

## Próximas mejoras
- [ ] Sprites de autos 2D de mejor calidad
- [ ] Sonidos de motor y drift
- [ ] Múltiples circuitos
- [ ] Sistema de power-ups
- [ ] Tabla de récords
- [ ] Modo campeonato (múltiples carreras)
