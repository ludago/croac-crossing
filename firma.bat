@echo off
echo ========================================
echo  FIRMA AUTOMATICA DE APK - GODOT 4.4
echo ========================================
echo.

REM === CONFIGURACION (CAMBIAR SEGUN PROYECTO) ===
set KEYSTORE=croac_crossing.keystore
set ALIAS=croac_crossing
set PASSWORD=croac123
set APK_ORIGINAL=build\croac_crossing.apk
set APK_FIRMADO=build\croac_crossing_firmado.apk
set APK_FINAL=build\croac_crossing.apk
set JDK=C:\Program Files\Eclipse Adoptium\jdk-17.0.16.8-hotspot\bin
set ANDROID_SDK=C:\Users\User\AppData\Local\Android\Sdk\build-tools\33.0.1

echo Proyecto: Croac Crossing
echo Keystore: %KEYSTORE%
echo APK: %APK_ORIGINAL%
echo.

REM === PASO 1: VERIFICAR ===
echo [1/4] Verificando firma actual...
%JDK%\keytool.exe -printcert -jarfile %APK_ORIGINAL% >nul 2>&1
if %errorlevel%==0 (
    echo OK: El APK ya esta firmado.
) else (
    echo AVISO: El APK NO esta firmado. Procediendo a firmar...
)
echo.

REM === PASO 2: FIRMAR CON JARSIGNER ===
echo [2/4] Firmando con jarsigner (v1)...
%JDK%\jarsigner.exe -keystore %KEYSTORE% -storepass %PASSWORD% -keypass %PASSWORD% -signedjar %APK_FIRMADO% %APK_ORIGINAL% %ALIAS%
if %errorlevel% neq 0 (
    echo ERROR: Fallo la firma con jarsigner
    pause
    exit /b 1
)
echo OK: Firma v1 completada
echo.

REM === PASO 3: ALINEAR CON ZIPALIGN ===
echo [3/4] Alineando con zipalign...
%ANDROID_SDK%\zipalign.exe -v -p 4 %APK_FIRMADO% %APK_FINAL%_temp >nul
if %errorlevel% neq 0 (
    echo ERROR: Fallo zipalign
    pause
    exit /b 1
)
echo OK: APK alineado
echo.

REM === PASO 4: FIRMAR CON APKSIGNER ===
echo [4/4] Firmando con apksigner (v2/v3)...
del %APK_FIRMADO% >nul 2>&1
%ANDROID_SDK%\apksigner.bat sign --ks %KEYSTORE% --ks-key-alias %ALIAS% --ks-pass pass:%PASSWORD% --key-pass pass:%PASSWORD% %APK_FINAL%_temp
if %errorlevel% neq 0 (
    echo ERROR: Fallo apksigner
    pause
    exit /b 1
)
echo OK: Firma v2/v3 completada
echo.

REM === RENOMBRAR ===
del %APK_FINAL% >nul 2>&1
ren %APK_FINAL%_temp croac_crossing.apk

echo ========================================
echo  APK FIRMADO EXITOSAMENTE
echo ========================================
echo.
echo Archivo: %APK_FINAL%
echo.

REM === VERIFICAR ===
echo Verificando firma final...
%ANDROID_SDK%\apksigner.bat verify --verbose %APK_FINAL%
echo.
echo Listo! Copia el APK a tu celular e intenta instalarlo.
echo.
pause
