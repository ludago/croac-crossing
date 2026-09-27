# Croac Crossing - Plan Version 2.0

## Estado Actual (v1.0)

### Lo que existe:
- 4 niveles de dificultad (Easy, Medium, Hard, Extreme)
- Dificultad se estanca desde nivel 7 (7 carriles, 280 px/s, 1.6s spawn)
- Juego infinito sin estado de victoria
- 7 tipos de vehículos (cosméticos, mismo comportamiento)
- 6 puntos seguros fijos por nivel
- 2 pistas de música (normal y rápida)
- Sistema de high score persistente
- Controles táctiles y teclado

### Limitaciones:
- No hay nivel máximo ni victoria
- No hay mecánicas nuevas después del nivel 7
- No hay power-ups ni power-downs
- No hay obstáculos adicionales (río, troncos, tortugas)
- No hay sistema de monedas o coleccionables
- No hay pantalla de selección de niveles
- No hay efecto parallax
- Animación `walk` definida pero nunca usada
- Señales `game_won` y `reached_goal` declaradas pero sin usar

---

## Plan Version 2.0 - Nuevas Funcionalidades

### 1. Sistema de Progresión de Niveles

#### 1.1 Niveles con temáticas diferentes
| Nivel | Temática | Mecánica nueva |
|-------|----------|----------------|
| 1-3 | Avenida | Vehículos (actual) |
| 4-6 | Río | Troncos y tortugas |
| 7-9 | Ciudad | Semáforos y peatones |
| 10-12 | Construction | Obras y desvíos |
| 13-15 | Noche | Visibilidad reducida |
| 16+ | Mixto | Combinación de todas |

#### 1.2 Transiciones entre temáticas
- Pantalla de_intro entre mundos
- Animación de cambio de escenario
- Nueva música por temática

---

### 2. Sistema de Río (Niveles 4-6)

#### 2.1 Troncos
- Se mueven horizontalmente como los vehículos
- La rana puede subirse y viajar con ellos
- Si se llega al borde de la pantalla, la rana muere
- 3 tamaños: pequeño (1 trampolín), mediano (2), grande (3)

#### 2.2 Tortugas
- Grupo de 2-4 tortugas que se mueven juntas
- Periódicamente se sumergen (3 segundos en superficie, 2 segundos bajo agua)
- Si la rana está encima cuando se sumergen, muere
- Algunas tortugas van más rápido que otras

#### 2.3 Mecánica de río
- La rana no puede permanecer en el agua (muere después de 2 segundos)
- Solo puede estar en troncos o tortugas
- Los troncos y tortugas se mueven en direcciones opuestas por carril

---

### 3. Power-ups y Power-downs

#### 3.1 Power-ups (aparecen aleatoriamente)
| Power-up | Efecto | Duración |
|----------|--------|----------|
| Escudo | Inmunidad a 1 colisión | 1 uso |
| Imán | Atrae monedas cercanas | 10s |
| Velocidad | Doble velocidad de salto | 8s |
| Fantasma | Atraviesa vehículos | 5s |
| Vida extra | +1 vida | permanente |
| Moneda x2 | Doble puntos | 15s |

#### 3.2 Power-downs (aparecen en niveles difíciles)
| Power-down | Efecto | Duración |
|------------|--------|----------|
| Hielo | Controles invertidos | 8s |
| Veneno | Velocidad reducida 50% | 6s |
| Oscuridad | Reduce visibilidad | 10s |
| Imán negativo | Repele monedas | 10s |

#### 3.3 Sistema de monedas
- Monedas doradas aparecen en el camino
- 10 monedas = 1 vida extra
- Monedas especiales (plateadas = 5 puntos, doradas = 10 puntos)
- Posición fija por nivel (rejugable)

---

### 4. Sistema de Semáforos (Niveles 7-9)

#### 4.1 Semáforos
- 3 semáforos por nivel en diferentes carriles
- Verde: vehículos pasan
- Amarillo: vehículos frenan
- Rojo: vehículos se detienen (3 segundos)
- La rana puede cruzar cuando está en rojo

#### 4.2 Peatones
- Peatones cruzan la calle cuando el semáforo está en rojo para autos
- Si la rana choca con un peatón, pierde 1 vida
- Peatones son evitables (se mueven lento)

---

### 5. Sistema de Construcción (Niveles 10-12)

#### 5.1 Obras
- Bloques de cono naranja en ciertos carriles
- La rana no puede pasar por encima
- Debe saltar por encima o rodear
- Cambian de posición cada 30 segundos

#### 5.2 Desvíos
- Señales de desvío que redirigen tráfico
- Cambian la dirección de algunos vehículos
- Añaden imprevisibilidad

---

### 6. Modo Noche (Niveles 13-15)

#### 6.1 Visibilidad
- Pantalla oscurecida con luz de linterna en la rana
- Solo se ve un radio alrededor de la rana
- Vehículos aparecen con luces encendidas

#### 6.2 Obstáculos nocturnos
- Gatos que cruzan la calle (rápidos, impredecibles)
- Baches que ralentizan a la rana
- Charcos que deslizan a la rana

---

### 7. Sistema de Puntuación Mejorado

#### 7.1 Puntos por acción
| Acción | Puntos |
|--------|--------|
| Llegar a seguro | +50 |
| Completar nivel | +100 |
| Moneda plateada | +5 |
| Moneda dorada | +10 |
| Sin golpear nada (nivel completo) | +200 (bonus) |
| Recoger power-up | +25 |
| Sobrevivir río sin daño | +150 (bonus) |

#### 7.2 Multiplicador deCombo
- Golpear sin perder vida = combo x1
- Cada nivel sin morir = combo +1
- Si muere, combo se reinicia a x1
- Puntos finales = puntos base * combo

#### 7.3 Tabla de Leaderboard
- Top 10 high scores locales
- Opcional: leaderboard online (futuro)

---

### 8. Contenido Visual Mejorado

#### 8.1 Efectos
- Efecto parallax en fondos (3 capas)
- Partículas al chocar (polvo, chispas)
- Sombras de vehículos
- Reflejos en agua (río)
- Efecto de lluvia en niveles de noche

#### 8.2 Animaciones
- Animación `walk` activada (ya existe pero no se usa)
- Animación de salto mejorada (arco parabólico)
- Animación de muerte variada (3 tipos)
- Animación de power-up activo

#### 8.3 Interfaz
- Barra de progreso de nivel
- Indicador de power-up activo
- Contador de monedas
- Indicador de combo
- Mini-mapa con posición de seguridad

---

### 9. Audio Mejorado

#### 9.1 Música
| Nivel | Música |
|-------|--------|
| 1-3 | Avenida tranquila |
| 4-6 | Río relajante |
| 7-9 | Ciudad energética |
| 10-12 | Construcción tensa |
| 13-15 | Noche misteriosa |
| 16+ | Mixto épico |

#### 9.2 Efectos de sonido
- Sonido de recolección de moneda
- Sonido de power-up
- Sonido de power-down
- Sonido de semáforo
- Sonido de tortuga sumergiendo
- Sonido de tronco
- Sonido de peatón
- Sonido de combo

---

### 10. Modos de Juego

#### 10.1 Modo Historia
- Progresión lineal por niveles
- Desbloqueo de mundos
- Jefe final cada 5 niveles (opcional)

#### 10.2 Modo Supervivencia
- Niveles aleatorios
- Dificultad creciente
- Puntuación alta

#### 10.3 Modo Contrarreloj
- Completar 10 niveles lo más rápido posible
- Ranking de tiempo

#### 10.4 Modo Desafío
- Niveles específicos con obstáculos únicos
- Completar objetivos (ej: "cruzar sin tocar nada")

---

### 11. Contenido No Jugable a Eliminar

#### 11.1 Señales sin usar
- `game_won` → Implementar o eliminar
- `reached_goal` → Implementar o eliminar
- `settings_changed` → Conectar a UI

#### 11.2 Animaciones sin usar
- `walk` (sin sufijo) → Activar o eliminar
- `frog_walk_sheet.png` → Eliminar si no se usa

#### 11.3 Métodos vacíos
- `_on_*_released()` → Implementar o eliminar conexiones

---

### 12. Optimizaciones

#### 12.1 Rendimiento
- Object pooling para vehículos
- LOD (Level of Detail) para sprites lejanos
- Carga diferida de assets
- Compresión de audio

#### 12.2 Datos
- Guardado de progreso (nivel actual, monedas, desbloqueos)
- Sistema de guardado automático
- Backup de datos

---

### 13. Orden de Desarrollo Sugerido

#### Fase 1: Fundamentos (2-3 semanas)
1. Implementar sistema de río (troncos y tortugas)
2. Activar animación `walk`
3. Limpiar señales sin usar
4. Implementar sistema de monedas

#### Fase 2: Power-ups (2 semanas)
1. Crear 6 power-ups
2. Crear 4 power-downs
3. Sistema de recolección
4. UI de power-up activo

#### Fase 3: Nuevos mundos (3-4 semanas)
1. Niveles de semáforo
2. Niveles de construcción
3. Niveles de noche
4. Transiciones entre mundos

#### Fase 4: Puntuación y progresión (2 semanas)
1. Sistema de combo
2. Tabla de leaderboard
3. Guardado de progreso
4. Pantalla de selección de niveles

#### Fase 5: Visual y audio (2 semanas)
1. Efecto parallax
2. Partículas
3. Nuevas músicas
4. Nuevos efectos de sonido

#### Fase 6: Modos de juego (2 semanas)
1. Modo Supervivencia
2. Modo Contrarreloj
3. Modo Desafío
4. Balanceo de dificultad

#### Fase 7: Pulido (1-2 semanas)
1. Optimización
2. Testing
3. Corrección de bugs
4. Documentación

**Tiempo total estimado: 14-18 semanas**

---

### 14. Archivos a Modificar/Crear

#### Modificar:
- `scripts/autoload/game_manager.gd` - Nuevo sistema de progresión
- `scripts/game/level.gd` - Nuevas mecánicas por nivel
- `scripts/player/frog.gd` - Power-ups, animaciones
- `scripts/vehicles/vehicle.gd` - Semáforos, peatones
- `scripts/vehicles/vehicle_spawner.gd` - Nuevos tipos
- `scenes/ui/hud.gd` - Nueva UI
- `scenes/ui/start_screen.tscn` - Menú mejorado

#### Crear:
- `scripts/environment/log.gd` - Troncos
- `scripts/environment/turtle.gd` - Tortugas
- `scripts/environment/traffic_light.gd` - Semáforos
- `scripts/environment/pedestrian.gd` - Peatones
- `scripts/items/coin.gd` - Monedas
- `scripts/items/power_up.gd` - Power-ups
- `scripts/ui/leaderboard.gd` - Tabla de puntuación
- `scripts/ui/level_select.gd` - Selección de niveles
- `scenes/environment/river.tscn` - Escena de río
- `scenes/environment/city.tscn` - Escena de ciudad
- `scenes/items/coin.tscn` - Escena de moneda
- `scenes/items/power_up.tscn` - Escena de power-up

---

### 15. Prioridades

#### Alta prioridad (Mínimo para v2.0):
- Sistema de río (troncos y tortugas)
- Power-ups básicos (escudo, vida extra)
- Sistema de monedas
- Activar animación `walk`
- Limpiar código sin usar
- Guardado de progreso

#### Media prioridad (Ideal para v2.0):
- Niveles de semáforo
- Efecto parallax
- Nuevas músicas
- Sistema de combo
- Tabla de leaderboard

#### Baja prioridad (Futuro v2.1+):
- Niveles de construcción
- Modo nocturno
- Modos de juego adicionales
- Leaderboard online
- Achievement system

---

*Plan creado: 14 de Septiembre de 2026*
*Última actualización: 14 de Septiembre de 2026*
*Autor: Daniel Gómez - Pixel Games Tucumán*
