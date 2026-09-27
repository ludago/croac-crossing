# Guía: Subir Croac Crossing a Google Play Store

## Requisitos Previos

### Cuenta de Desarrollador
- Crear cuenta en [Google Play Console](https://play.google.com/console) (USO UNA VEZ - USD $25)
- Aceptar acuerdos de distribución

### Software Necesario
- Godot 4.4 (ya lo tenés)
- Android Studio (para el SDK)
- JDK 17 (viene con Android Studio)
- Template de exportación Android para Godot

---

## Paso 1: Configurar Android Studio

1. Descargar e instalar [Android Studio](https://developer.android.com/studio)
2. Abrir Android Studio → SDK Manager
3. Instalar:
   - Android SDK Platform 33 o superior
   - Android SDK Build-Tools 33.0.2 o superior
   - Android SDK Command-line Tools
4. Anotar la ruta del SDK (ej: `C:\Users\Usuario\AppData\Local\Android\Sdk`)

---

## Paso 2: Configurar Godot para Android

1. Abrir Godot → Editor → Configuración de la red
2. Ir a la pestaña "Exportación"
3. Hacer clic en "Descargar templates de exportación"
4. Seleccionar "Android" y descargar
5. Ir a Editor → Configuración de la red → Android
6. Configurar:
   - **Ruta del SDK**: La ruta de Android Studio SDK
   - **Ruta del JDK**: Viene con Android Studio (Generalmente `C:\Program Files\Android\Android Studio\jbr`)

---

## Paso 3: Generar Clave de Firma (Keystore)

1. Abrir terminal/cmd
2. Ejecutar:
```bash
keytool -genkey -v -keystore frogger.keystore -alias frogger -keyalg RSA -keysize 2048 -validity 10000
```
3. Ingresar contraseña (acordátela)
4. Completar datos (nombre, organización, etc.)
5. Guardar `frogger.keystore` en una carpeta segura

---

## Paso 4: Configurar Exportación en Godot

1. Ir a Proyecto → Exportar
2. Hacer clic en "Añadir..." → Android
3. En la pestaña "Opciones":
   - **Nombre personalizado**: Croac Crossing
   - **Paquete**: `com.tudominio.frogger` (cambiar tudominio)
   - **Código de versión**: 1 (incrementar cada actualización)
   - **Nombre de versión**: 1.0.0
4. En "Firma":
   - Seleccionar "Exportar con formato Uso de Clave"
   - Rellenar:
     - Keystore: Ruta a `frogger.keystore`
     - Contraseña: La que pusiste
     - Alias: frogger
     - Contraseña alias: La que pusiste

---

## Paso 5: Generar APK/AAB

### Para testing (APK):
1. Proyecto → Exportar
2. Seleccionar perfil "Android"
3. Elegir "Exportar APK"
4. Seleccionar carpeta de destino
5. Clic en "Exportar"

### Para Play Store (AAB - recomendado):
1. Proyecto → Exportar
2. Seleccionar perfil "Android"
3. Elegir "Exportar AAB"
4. Seleccionar carpeta de destino
5. Clic en "Exportar"

**Nota**: Google Play requiere AAB (Android App Bundle) desde agosto 2021

---

## Paso 6: Preparar Assets para Play Store

### Ícono de la app
- Tamaño: 512x512 px
- Formato: PNG (sin transparencia)
- Ya creado: `icon.png`

### Screenshots
- Mínimo 2 screenshots
- Tamaño recomendado: 1080x1920 (portrait) o 1920x1080 (landscape)
- Formato: JPG o PNG
- Guardar en carpeta `store/screenshots/`

### Imagen feature (opcional)
- 1024x500 px
- Se muestra en búsquedas

### Descripción
- Corta (80 caracteres máx)
- Larga (4000 caracteres máx)
- Guardar en `store/description.md`

---

## Paso 7: Subir a Google Play Console

1. Ir a [Google Play Console](https://play.google.com/console)
2. Crear aplicación
3. Completar:
   - Nombre: Croac Crossing
   - Idioma: Español
   - Tipo: Juego
   - Gratuito/Pago
4. Ir a "Producción" → "Crear nueva versión"
5. Subir AAB (el archivo generado)
6. Completar:
   - Notas de versión
   - Dirección de correo (requerida)
7. Ir a "Pestaña de información de la contacto"
   - Email de soporte
   - Teléfono (opcional)
8. Ir a "Política de privacidad"
   - URL de política de privacidad (requerida)
9. Revisar y publicar

---

## Paso 8: Esperar Revisión

- Google revisa la app (generalmente 1-7 días)
- Si hay problemas, te notifican por email
- Una vez aprobada, aparece en la Play Store

---

## Comandos Útiles de Godot

```bash
# Exportar APK desde línea de comandos
godot --headless --export-release "Android" build/frogger.apk

# Exportar AAB desde línea de comandos
godot --headless --export-release "Android" build/frogger.aab
```

---

## Estructura de Archivos del Proyecto

```
mi_juego/
├── icon.png                    # Ícono de la app
├── splash.png                  # Splash screen
├── export_presets.cfg          # Config de exportación
├── project.godot               # Config del proyecto
├── assets/
│   ├── sprites/               # Sprites del juego
│   └── audio/                 # Sonidos y música
├── scenes/                    # Escenas del juego
├── scripts/                   # Scripts GDScript
└── store/                     # Assets de Play Store
    ├── screenshots/           # Screenshots
    └── description.md         # Descripción
```

---

## Notas Importantes

- **Versión**: Incrementar `config/version` en project.godot cada actualización
- **Código de versión**: Incrementar en export_presets.cfg cada vez
- **Pruebas**: Siempre probar en dispositivo real antes de subir
- **Permisos**: El juego no necesita permisos especiales
- **Tamaño**: AAB comprime mejor que APK

---

## Checklist Final

- [ ] Cuenta de desarrollador creada (USD $25)
- [ ] Android Studio instalado
- [ ] Template de exportación descargado
- [ ] Keystore generado y guardado
- [ ] Configuración de firma en Godot
- [ ] APK/AAB generado
- [ ] Screenshots preparados
- [ ] Descripción escrita
- [ ] Política de privacidad (si aplica)
- [ ] Subido a Play Console
- [ ] Esperando revisión
