@echo off
REM Script para ejecutar pruebas de carga con Locust en Windows

echo ===================================
echo Locust Load Testing - Artenity
echo ===================================
echo.

REM Verificar si Locust está instalado
where locust >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Locust no está instalado. Instalando dependencias...
    pip install -r requirements.txt
)

echo Selecciona una opcion de prueba:
echo 1) Prueba rapida (10 usuarios, 60 segundos)
echo 2) Prueba media (50 usuarios, 300 segundos)
echo 3) Prueba completa (100 usuarios, 600 segundos)
echo 4) Modo web interactivo (acceso en http://localhost:8089)
echo.
set /p opcion="Opcion (1-4): "

if %opcion%==1 (
    echo Iniciando prueba rapida...
    locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s
) else if %opcion%==2 (
    echo Iniciando prueba media...
    locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s
) else if %opcion%==3 (
    echo Iniciando prueba completa...
    locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s
) else if %opcion%==4 (
    echo Iniciando modo web interactivo...
    echo Accede a http://localhost:8089 en tu navegador
    locust -f locustfile.py --host=http://localhost:8000
) else (
    echo Opcion invalida
)

pause
