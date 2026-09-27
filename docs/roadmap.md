# Croac Crossing - Roadmap de Desarrollo

## 🏢 Visión del Proyecto (Equipo: Usuario + OpenCode)
Queremos hacer juegos con Godot para publicar en:
- 📱 **Google Play Store** (celulares Android)
- 💻 **PC** (Windows, Linux, Mac)

Si este juego sale bien, será el primero de muchos. OpenCode es el "señor" programador y el usuario es el diseñador/productor.

---

## ✅ Completado
- [x] Estructura base del proyecto
- [x] Movimiento de rana con flechas (saltos discretos)
- [x] Vehículos que se mueven por carriles
- [x] Colisiones (rana pierde vida al chocar)
- [x] HUD (vidas, puntaje, nivel)
- [x] Progresión de dificultad (fácil → normal → difícil)
- [x] Game over y reinicio
- [x] Meta (llegar arriba = siguiente nivel)
- [x] Separación de carriles ajustada dinámicamente
- [x] Zonas visuales: césped arriba/abajo + avenida gris
- [x] Líneas amarillas punteadas en la avenida
- [x] Salto de rana ajustado a 32px (más desafiante)
- [x] Rana spawna en césped abajo (Y=600)
- [x] Meta en césped arriba (Y=150)
- [x] Vehículos inmediatos al arrancar (no hay demora)
- [x] Touch controls con señales (funciona en celular)

---

## 🔧 Cómo Trabajamos (Equipo OpenCode + Usuario)

### Flujo de trabajo
1. **Yo programo** → creo/modifico archivos en el proyecto
2. **Vos probás** → ejecutan el juego en Godot (botón ▶️ o F5)
3. **Si funciona** → avanzamos al siguiente paso
4. **Si hay error** → veamos el debugging abajo

### Flujo de Debugging (cuando algo no funciona)
1. Vos decís "sale error" o "no funciona"
2. Yo leo el archivo `error_log.txt` en la carpeta del proyecto
3. Si el error no aparece, simplifico el código hasta encontrar qué lo rompe
4. Lo corrijo y vos volvés a probar

### Herramientas de Debug
| Archivo/Herramienta | Para qué sirve |
|---|---|
| `error_log.txt` | Godot guarda errores aquí |
| `ejecutar.bat` | Ejecuta Godot con verbose y guarda el log |
| `print()` en código | Mensajes de debug que aparecen en el log |
| Método de simplificar | Quito código hasta encontrar el bug |

### Cómo Ejecutar con Debug
1. Doble clic en `ejecutar.bat` (en la carpeta del proyecto)
2. Se abre Godot y ejecuta el juego
3. Cerrá Godot cuando termine
4. Abrí `error_log.txt` con el Bloc de Notas

### Cómo Guardar y Retomar
1. **Cerrar Godot** cuando quieras parar
2. **Prender la PC otro día**
3. **Abrir Godot** → Proyecto → Abrir Proyecto → carpeta `mi_juego`
4. Todo está como lo dejaste
5. Decime "mirá el roadmap y seguimos" y yo leo el archivo y continuamos

---

## 📱 Regla de Oro: Mobile-First

**TODO lo que se haga en PC debe ser también probado/mejorado para celular.**

### Checklist para cada cambio:
- [ ] ¿Funciona en PC con teclado?
- [ ] ¿Funciona en celular con touch?
- [ ] ¿Los botones son lo suficientemente grandes para dedos? (mínimo 80x80 px)
- [ ] ¿La posición de los botones es cómoda para pulgares?
- [ ] ¿El texto se lee en pantalla chica?
- [ ] ¿Los elementos visibles no son muy chicos?

### Ajustes pendientes para celular:
- [ ] Botones touch más grandes (80x80 px mínimo)
- [ ] Botones semi-transparentes para no tapar el juego
- [ ] Reposicionar botones para pulgares (abajo a los costados)
- [ ] Ajustar resolución/escala para pantallas chicas
- [ ] Probar en un celular real (no solo en el emulador)

### Cómo probar en celular sin publicar:
1. Conectar celular por USB con depuración activada
2. En Godot: **Proyecto → Exportar → Android → Ejecutar en dispositivo**
3. O exportar APK y pasarlo por USB/WiFi

## 🔧 Pendiente - Mejoras Próximas
- [ ] Pantalla de inicio con título
- [ ] Pantalla de game over mejorada (puntaje final)
- [ ] Ajustes mobile: botones grandes, semi-transparentes, reposicionados

## 🎨 Pendiente - Arte y Visual
- [ ] Sprite de rana (pixel art)
- [ ] Sprites de vehículos (autos, buses, camiones, motos)
- [ ] Fondo de calle con carriles
- [ ] Efecto de sombra en la rana
- [ ] Animación de salto

## 🔊 Pendiente - Audio
- [ ] Sonido de salto
- [ ] Sonido de choque/muerte
- [ ] Sonido de nivel completo
- [ ] Música de fondo

## 🎮 Pendiente - Funcionalidad Extra
- [ ] Ríos con troncos (fase 2 del nivel)
- [ ] Tortugas que se sumergen
- [ ] Monedas/coleccionables
- [ ] Power-ups (invulnerabilidad, velocidad)
- [ ] Sistema de vidas extra
- [ ] Pantalla de selección de nivel

## 📊 Pendiente - Pulido
- [ ] Efecto screen shake al morir
- [ ] Partículas al caer al agua
- [ ] Parallax scrolling en el fondo
- [ ] Guardar puntaje máximo

---

## 📚 GUÍA: Cómo Agregar Gráficos

### Paso 1: Crear o descargar sprites
Herramientas GRATUITAS para crear pixel art:
- **Piskel** (piskelapp.com) → Editor online, fácil para empezar
- **LibreSprite** → Gratis, open source
- **Aseprite** → El mejor (se puede buildear gratis desde source)

### Paso 2: Guardar los sprites
Los sprites van en la carpeta:
```
mi_juego/assets/sprites/player/     ← para la rana
mi_juego/assets/sprites/vehicles/   ← para autos, buses, etc
mi_juego/assets/sprites/environment/← para fondo, calle
```

Formato: **PNG** con fondo transparente
Tamaño recomendado:
- Rana: 32x32 px
- Auto: 32x16 px
- Bus: 64x16 px
- Camión: 48x16 px

### Paso 3: Usar los sprites en Godot
1. Abrí Godot
2. Arrastrá el PNG desde el Explorer a la carpeta "assets/sprites" en el panel de FileSystem (izquierda)
3. En la escena, seleccioná el nodo Sprite2D
4. En el Inspector (derecha), en "Texture" → arrastrá el PNG ahí

### Paso 4: Animaciones (AnimatedSprite2D)
Para animar la rana:
1. Creá un **sprite sheet** (imagen con todos los frames en fila)
2. En Godot, cambiá el Sprite2D por un **AnimatedSprite2D**
3. En SpriteFrames, agregá los frames desde el sprite sheet
4. Configurá FPS (8-12 para estilo retro)

---

## 📚 GUÍA: Cómo Agregar Sonidos

### Paso 1: Descargar sonidos gratuitos
- **freesound.org** → Miles de efectos gratuitos
- **mixkit.co** → Efectos y música gratis
- **opengameart.org** → Assets para juegos

### Paso 2: Guardar los sonidos
```
mi_juego/assets/audio/sfx/      ← efectos de sonido
mi_juego/assets/audio/music/    ← música de fondo
```

Formatos aceptados por Godot: **.wav** (mejor), **.ogg**, **.mp3**

### Paso 3: Usar sonidos en código
```gdscript
# Cargar el sonido
var salto_sfx = preload("res://assets/audio/sfx/hop.wav")

# Reproducir
salto_sfx.play()

# O con nodo AudioStreamPlayer2D
$AudioStreamPlayer2D.stream = preload("res://assets/audio/sfx/hop.wav")
$AudioStreamPlayer2D.play()
```

---

## 📚 GUÍA: Cómo Publicar en Play Store

### Para Android:
1. En Godot: **Proyecto → Exportar**
2. Agregar plataforma: **Android**
3. Configurar:
   - Nombre del juego
   - Paquete (com.tuusuario.frogger)
   - Versión
   - Iconos (512x512)
4. Compilar → genera un APK
5. Subir a Google Play Console (paga $25 USD una vez)

### Para PC:
1. En Godot: **Proyecto → Exportar**
2. Agregar plataforma: **Windows** o **Linux**
3. Compilar → genera una carpeta con el .exe
4. Compartir zip o subir a itch.io

---

## 📁 Estructura del Proyecto
```
mi_juego/
├── project.godot
├── main.gd
├── main.tscn
├── docs/
│   └── roadmap.md
├── assets/
│   ├── sprites/
│   │   ├── player/
│   │   ├── vehicles/
│   │   └── environment/
│   └── audio/
│       ├── sfx/
│       └── music/
├── scripts/
│   ├── autoload/
│   │   └── game_manager.gd
│   ├── player/
│   │   └── frog.gd
│   ├── vehicles/
│   │   ├── vehicle.gd
│   │   └── vehicle_spawner.gd
│   ├── game/
│   │   └── level.gd
│   └── ui/
│       └── hud.gd
└── scenes/
    ├── player/
    │   └── frog.tscn
    ├── vehicles/
    │   ├── car.tscn
    │   └── vehicle_spawner.tscn
    ├── game/
    │   └── level.tscn
    └── ui/
        └── hud.tscn
```
