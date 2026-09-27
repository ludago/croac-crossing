# Pixel Games Tucumán - Roadmap de Desarrollo de Videojuegos

> **Empresa**: Pixel Games Tucumán  
> **Fundador**: Daniel Gómez  
> **Ubicación**: Tucumán, Argentina  
> **Motor**: Godot Engine  
> **Plataforma objetivo**: Google Play Store (Android)  
> **Monetización**: Ads + In-App Purchases  

---

## Visión General

Pixel Games Tucumán es un estudio indie de desarrollo de videojuegos desde Tucumán, Argentina. Nos enfocamos en crear experiencias móviles accesibles, adictivas y de alta calidad. Comenzamos con Frogger-style games y escalamos hacia géneros más ambiciosos.

---

## Fase 0: Fundación del Estudio (Semana 1-2)

### Identidad de Marca
- [x] Definir nombre del estudio: **Pixel Games Tucumán**
- [ ] Crear logo profesional (mínimo 512x512, fondo transparente)
- [ ] Definir paleta de colores corporativa
- [ ] Crear cuenta de developer en Google Play Console ($25 USD one-time)
- [ ] Crear cuenta de redes sociales (Twitter/X, Instagram, TikTok)
- [ ] Definir página web mínima (itch.io o landing page)

### Infraestructura
- [ ] Configurar repositorio Git (GitHub/GitLab)
- [ ] Establish branching strategy (main, develop, feature/*)
- [ ] Documentar pipeline de build (Godot → APK/AAB → Play Store)
- [ ] Crear plantilla de proyecto base para nuevos juegos
- [ ] Configurar backup automático (Google Drive / NAS)

---

## Fase 1: Conceptualización (Semana 3-4)

### Para Cada Nuevo Juego
- [ ] Brainstorming de 10+ ideas de juegos
- [ ] Evaluar cada idea por: dificultad técnica, mercado, monetización, pasión
- [ ] Seleccionar 1 idea ganadora
- [ ] Definir "elevator pitch" (1 frase que venda el juego)
- [ ] Crear Game Design Document (GDD) básico:
  - Nombre del juego
  - Género y referencias
  - Mecánica core (1-2 oraciones)
  - Público objetivo
  - Estilo visual
  - Monetización planeada

### Análisis de Mercado
- [ ] Investigar 5-10 competidores directos
- [ ] Analizar ratings y reseñas de competidores
- [ ] Identificar gaps en el mercado
- [ ] Definir USP (Unique Selling Proposition)

---

## Fase 2: Pre-Producción (Semana 5-8)

### Diseño
- [ ] Crear wireframes de pantallas principales
- [ ] Definir flujo de juego completo (start → gameplay → game over → retry)
- [ ] Diseñar sistema de progresión (niveles, dificultad)
- [ ] Definir métricas de éxito (retención D1/D7, sesiones promedio)
- [ ] Crear moodboard visual

### Arte y Audio
- [ ] Definir estilo artístico (pixel art, vectorial, 3D low-poly, etc.)
- [ ] Crear paleta de colores del juego
- [ ] Diseñar personaje principal (3 bocetos mínimo)
- [ ] Crear spritesheet del personaje principal
- [ ] Diseñar fondos/escenarios (2-3 variaciones)
- [ ] Seleccionar/crear efectos de sonido (5-10 efectos base)
- [ ] Seleccionar/crear música de fondo (1-2 tracks)

### Prototipado
- [ ] Crear prototipo jugable (graybox) en 1-2 semanas
- [ ] Implementar mecánica core únicamente
- [ ] Testear con 3-5 personas
- [ ] Recopilar feedback y ajustar
- [ ] Decidir: go/no-go para producción completa

---

## Fase 3: Producción (Semana 9-20)

### Semana 9-12: Core Gameplay
- [ ] Implementar movimiento del jugador
- [ ] Implementar sistema de colisiones
- [ ] Implementar sistema de puntuación
- [ ] Implementar sistema de vidas/health
- [ ] Crear 3-5 niveles prototipo
- [ ] Implementar sistema de dificultad progresiva
- [ ] Agregar efectos de sonido básicos

### Semana 13-16: Contenido
- [ ] Crear todos los niveles (10-20+ niveles)
- [ ] Integrar assets de arte finales
- [ ] Integrar música y efectos de sonido
- [ ] Implementar animaciones del personaje
- [ ] Crear pantallas UI (start, pause, game over, settings)
- [ ] Implementar sistema de pausa
- [ ] Implementar high score / leaderboard local

### Semana 17-20: Polish
- [ ] Screen transitions (fade in/out)
- [ ] Screen shake en eventos importantes
- [ ] Vibración háptica en móvil
- [ ] Partículas y efectos visuales
- [ ] Optimización de rendimiento
- [ ] Testear en múltiples dispositivos
- [ ] Fix de bugs menores
- [ ] Ajustar dificultad basado en playtesting

---

## Fase 4: UI/UX y Monetización (Semana 21-24)

### Interfaz de Usuario
- [ ] Pantalla de inicio atractiva con animación
- [ ] Menú de opciones completo (sonido, música, vibración, idioma)
- [ ] Tutorial integrado (no popups, learning by doing)
- [ ] Game over screen con estadísticas
- [ ] Pantalla de logros/achievements (opcional)
- [ ] Botón "Más juegos" (cross-promotion)

### Monetización
- [ ] **Interstitial Ads**: Al cambiar de nivel (cada 3-5 niveles)
- [ ] **Rewarded Ads**: Vidas extra, continuar, desbloquear contenido
- [ ] **Banner Ads**: En menú y game over (no durante gameplay)
- [ ] **In-App Purchases** (opcional):
  - Quitar ads ($1.99-$2.99)
  - Pack de skins ($0.99)
  - Monedas/ilimitado ($0.99-$4.99)
- [ ] Integrar SDK de AdMob (Google)
- [ ] Configurar test ads para desarrollo
- [ ] Testear con ads reales en release build

### Analytics
- [ ] Integrar Firebase Analytics (opcional pero recomendado)
- [ ] Trackear: sesiones, retención, nivel donde abandonan, compras
- [ ] Crear eventos personalizados importantes

---

## Fase 5: Testing y QA (Semana 25-28)

### Pruebas Internas
- [ ] Testear en 3+ dispositivos Android diferentes
- [ ] Testear en tablets y celulares
- [ ] Verificar performance (60 FPS target)
- [ ] Verificar uso de memoria (<200MB ideal)
- [ ] Verificar batería (no drain excesivo)
- [ ] Testear con conexión lenta/sin internet
- [ ] Verificar que ads cargan correctamente
- [ ] Testear flujo completo: install → play → die → retry → close

### Pruebas Externas
- [ ] Dar beta a 10-20 testers (amigos, familia, gaming communities)
- [ ] Recopilar feedback estructurado
- [ ] Medir tiempo de sesión promedio
- [ ] Identificar puntos de frustración
- [ ] Hacer ajustes finales

### Bugs Críticos
- [ ] No crashes en gameplay
- [ ] No freezes
- [ ] No pérdida de progreso
- [ ] Ads no interrumpen gameplay crítico
- [ ] Purchases funcionan correctamente

---

## Fase 6: Assets de Play Store (Semana 29-30)

### Gráficos Requeridos
- [ ] **Ícono de app**: 512x512 PNG (sin transparencia para Play Store)
- [ ] **Feature Graphic**: 1024x500 JPG/PNG
- [ ] **Screenshots**: 2-8 capturas (16:9 o 9:16)
  - Pantalla de inicio
  - Gameplay action
  - Game over / stats
  - Múltiples niveles
- [ ] **Video preview** (opcional pero recomendado): 30-60 seg

### Textos
- [ ] **Título**: Máx 30 caracteres
- [ ] **Descripción corta**: Máx 80 caracteres
- [ ] **Descripción completa**: 4000 caracteres máximo
  - Primeras 2 líneas son las más importantes (aparecen sin expandir)
  - Incluir palabras clave relevantes al género
  - Incluir llamada a la acción
- [ ] **What's New** (changelog para actualizaciones)

### Clasificación
- [ ] Completar IARC rating questionnaire
- [ ] Definir categoría: Casual / Arcade / Action
- [ ] Establecer contenido: violence level, ads disclosure, data safety

---

## Fase 7: Exportar y Publicar (Semana 31-32)

### Build Final
- [ ] Generar keystore de release (`keytool -genkey`)
- [ ] Guardar keystore en lugar seguro (backup!)
- [ ] Configurar `export_presets.cfg` con keystore release
- [ ] Exportar AAB (Android App Bundle) - preferido por Play Store
- [ ] También exportar APK para testing directo
- [ ] Verificar firma del AAB/APK
- [ ] Testear build final en dispositivo real

### Google Play Console
- [ ] Crear nueva app en Play Console
- [ ] Configurar package name (com.pixelgamestucuman.nombrejuego)
- [ ] Subir AAB/APK
- [ ] Completar toda la información requerida
- [ ] Subir screenshots, ícono, feature graphic
- [ ] Escribir descripción
- [ ] Configurar precios (gratis o pago)
- [ ] Configurar países/regiones
- [ ] Configurar nivel de exposición para menores (si aplica)
- [ ] Responder IARC questionnaire
- [ ] Revisar todo antes de submit

### Submit
- [ ] Enviar para revisión
- [ ] Esperar 1-7 días (primer review puede tardar más)
- [ ] Si rechazan: leer razón, corregir, re-submit
- [ ] Si aprueban: ¡Lanzamiento!

---

## Fase 8: Post-Lanzamiento (Semana 33+)

### Marketing
- [ ] Publicar en redes sociales (lanzamiento)
- [ ] Crear trailer de 30 seg para TikTok/Reels/Shorts
- [ ] Enviar a gaming blogs/YouTubers pequeños
- [ ] Postear en r/AndroidGaming, r/indiegaming
- [ ] Crear Discord del estudio (opcional)
- [ ] Responder TODAS las reseñas de Play Store

### Métricas y Análisis
- [ ] Monitorear installs vs uninstalls
- [ ] Analizar retención D1, D7, D30
- [ ] Revisar crash reports (Firebase Crashlytics)
- [ ] Analizar qué niveles causan abandono
- [ ] Monitorear revenue de ads
- [ ] A/B test headlines y screenshots

### Actualizaciones
- [ ] Planificar roadmap de contenido post-launch:
  - **Semana 1-2**: Hotfixes de bugs críticos
  - **Semana 3-4**: Nuevos niveles o contenido gratuito
  - **Mes 2**: Nueva mecánica o modo de juego
  - **Mes 3**: Eventos temporales o desafíos diarios
  - **Mes 6**: Major update o expansión
- [ ] Mantener juego actualizado (Google penaliza apps abandonadas)

### Siguiente Juego
- [ ] Mientras el juego actual crece, empezar conceptualización del siguiente
- [ ] Mantener pipeline constante: 1 juego lanzado + 1 en desarrollo + 1 en concepto

---

## Pipeline de Desarrollo Recomendado

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Concepto   │────▶│ Producción  │────▶│  Lanzamiento│
│  (2 sem)    │     │  (12 sem)   │     │  (2 sem)    │
└─────────────┘     └─────────────┘     └─────────────┘
       │                   │                   │
       ▼                   ▼                   ▼
    GDD v1             Build 1.0           Marketing
    Prototipo          Testing             Analytics
    Go/No-go           Polish              Updates
```

**Ciclo total por juego: ~8-12 meses** (variable según complejidad)

---

## Revenue Estimado (参考)

### Juego Casual Móvil (Free-to-Play)
| Métrica | Estimado bajo | Estimado medio | Estimado alto |
|---------|--------------|----------------|---------------|
| Installs (mes 1) | 1,000 | 10,000 | 100,000 |
| DAU | 100 | 1,000 | 10,000 |
| ARPDAU | $0.01 | $0.03 | $0.08 |
| Revenue/mes | $30 | $900 | $24,000 |
| Revenue/año | $360 | $10,800 | $288,000 |

### Fuentes de Revenue
1. **Ad Revenue** (70-80% del revenue típico)
   - Interstitial: $2-5 eCPM
   - Rewarded: $10-15 eCPM
   - Banner: $0.5-2 eCPM
2. **In-App Purchases** (20-30%)
   - Remove ads
   - Cosmetics/skins
   - Premium currency

---

## Herramientas del Estudio

| Categoría | Herramienta | Costo |
|-----------|-------------|-------|
| Game Engine | Godot 4.4 | Gratis |
| IDE/Code | VS Code + GDScript | Gratis |
| Arte 2D | Aseprite / GIMP / Piskel | Gratis-$20 |
| Arte 3D | Blender | Gratis |
| Audio | Audacity / SFXR | Gratis |
| Audio Música | Bosca Ceoil / LMMS | Gratis |
| Control Versiones | Git + GitHub | Gratis |
| Analytics | Firebase | Gratis |
| Ads | AdMob | Gratis (revenue share) |
| Testing | Fisical devices | ~$200-500 |

---

## Scripts Útiles del Estudio

Estos scripts son esenciales para cada proyecto. Siempre tenerlos en la raíz del proyecto.

### ejecutar.bat - Ejecutar juego con logs
```bat
@echo off
echo Ejecutando Godot...
"C:\Users\User\Desktop\godot\Godot_v4.4.1-stable_win64.exe" --path "C:\Users\User\Desktop\TU_PROYECTO" --verbose 1> "C:\Users\User\Desktop\TU_PROYECTO\error_log.txt" 2>&1
echo Listo. Abrí error_log.txt
pause
```
**Para qué sirve**: Ejecuta el juego y guarda TODA la salida (errores, warnings, prints) en `error_log.txt`. Esencial para debuggear cuando algo falla y no ves errores en pantalla.

### error_log.bat - Ver errores rápidamente
```bat
@echo off
if exist "C:\Users\User\Desktop\TU_PROYECTO\error_log.txt" (
    type "C:\Users\User\Desktop\TU_PROYECTO\error_log.txt"
) else (
    echo No hay error_log.txt. Ejecutá primero ejecutar.bat
)
pause
```
**Para qué sirve**: Abre el log de errores sin necesidad de buscar el archivo. Útil para revisar qué pasó después de un crash.

### exportar.bat - Exportar APK rápido
```bat
@echo off
echo Exportando APK...
"C:\Users\User\Desktop\godot\Godot_v4.4.1-stable_win64.exe" --headless --path "C:\Users\User\Desktop\TU_PROYECTO" --export-release "Android" "C:\Users\User\Desktop\TU_PROYECTO\build\nombre_juego.apk"
echo Listo. APK en build/
pause
```
**Para qué sirve**: Exporta el APK sin abrir el editor. Ahorra tiempo vs hacerlo desde la UI.

### NOTA: En cada proyecto, copiar estos 3 scripts y ajustar las rutas al nombre del proyecto nuevo.

---

## Checklist General por Juego

Antes de PUBLICAR cada juego, verificar:

- [ ] Juego es divertido y adictivo (core loop funciona)
- [ ] Funciona en 3+ dispositivos Android
- [ ] No crashes ni freezes
- [ ] Logs limpios (revisar error_log.txt)
- [ ] Ads integrados y funcionando
- [ ] Monetización configurada
- [ ] Screenshots atractivos (8 máximo)
- [ ] Descripción optimizada con keywords
- [ ] Ícono profesional y reconocible
- [ ] High score / progresión funciona
- [ ] Pausa funciona correctamente
- [ ] Botón atrás de Android funciona
- [ ] Música y sonidos no se cortan
- [ ] Tamaño del APK <50MB (ideal <30MB)
- [ ] Build firmado con keystore release
- [ ] Testeado por al menos 5 personas
- [ ] Google Play Console configurado
- [ ] ejecutar.bat y error_log.bat funcionando

---

## Notas para Daniel

1. **No busques perfección, busca completitud.** Un juego de 7/10 lanzado genera más revenue que un juego de 10/10 que nunca se lanza.

2. **Empieza simple.** Cada juego nuevo debe ser más ambicioso que el anterior, pero no saltes de 2D casual a 3D MMO de un día para otro.

3. **Monetización desde el día 1.** Diseña el juego con ads en mente desde el inicio, no los pegues después.

4. **Responde TODAS las reseñas.** Los usuarios aprecian cuando el dev responde. Esto genera confianza y retención.

5. **Publica constemente.** Es mejor publicar 4 juegos de 7/10 al año que 1 juego de 9/10 cada 2 años.

6. **Aprende de los datos.** No adivines qué funciona, mira las métricas. Si el nivel 3 tiene 80% de abandono, ahí hay un problema.

7. **Cada juego es una oportunidad de aprender.** El primer juego será el peor. El décimo será increíble. Pero solo si publicas los primeros 9.

8. **Usa los scripts.** ejecutar.bat y error_log.bat te ahorrarán horas de debugging. Siempre ejecuta desde ahí, nunca directamente desde el editor cuando estés testando.

---

## Resumen de Juegos Planeados

| # | Nombre | Género | Estado | Fecha objetivo |
|---|--------|--------|--------|----------------|
| 1 | Croac Crossing | Frogger / Arcade | ✅ Completado | 2026 |
| 2 | [Próximo juego] | [Por definir] | 📋 Concepto | Q3 2026 |
| 3 | [Juego 3] | [Por definir] | 📋 Concepto | Q4 2026 |
| 4 | [Juego 4] | [Por definir] | 📋 Concepto | Q1 2027 |

---

*Última actualización: Septiembre 2026*  
*Pixel Games Tucumán - Daniel Gómez*
