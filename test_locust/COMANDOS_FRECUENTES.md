#!/bin/bash
# Guía de Comandos Frecuentes - Locust Artenity

# ============================================
# EJEMPLOS DE COMANDOS ÚTILES
# ============================================

# 1. PRUEBAS BÁSICAS
# ============================================

# Prueba muy rápida (validar que funciona)
locust -f locustfile.py --host=http://localhost:8000 -u 5 -r 1 --run-time 30s

# Prueba rápida estándar
locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s

# Prueba media
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s

# Prueba grande
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s

# Prueba de estrés
locust -f locustfile.py --host=http://localhost:8000 -u 200 -r 20 --run-time 900s


# 2. MODO WEB INTERACTIVO
# ============================================

# Abre http://localhost:8089 en el navegador
locust -f locustfile.py --host=http://localhost:8000

# Con puerto personalizado
locust -f locustfile.py --host=http://localhost:8000 --web-port 9000


# 3. MODO SIN INTERFAZ (HEADLESS)
# ============================================

# Útil para CI/CD y automatización
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --headless

# Con salida en CSV
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --headless --csv=results

# Con reporte HTML
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --headless --html=report.html


# 4. PRUEBAS DE FLUJOS CRÍTICOS
# ============================================

# Flujos críticos con usuarios realistas
locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 300s

# Flujos críticos en modo headless
locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 300s --headless

# Flujos críticos con reporte
locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 300s --html=critical_report.html


# 5. ESCALONAMIENTOS GRADUAL (RAMP-UP)
# ============================================

# Aumentar usuarios gradualmente con workers
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s

# Script manual para incremento gradual (Linux/Mac)
# for users in 10 20 50 100 150 200; do
#   locust -f locustfile.py --host=http://localhost:8000 -u $users -r $((users/5)) --run-time 120s --headless
#   sleep 30
# done


# 6. CON CONFIGURACIÓN EXTERNA
# ============================================

# Usar archivo de configuración
locust -f locustfile.py -c locust.conf

# Sobrescribir settings
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --loglevel DEBUG


# 7. MODO DISTRIBUIDO (MASTER-SLAVE)
# ============================================

# Terminal 1: Master (controla la prueba)
locust -f locustfile.py --host=http://localhost:8000 --master --web-port 8089

# Terminal 2+: Workers (ejecutan la prueba)
locust -f locustfile.py --host=http://localhost:8000 --worker --master-host=localhost

# Especificar número de workers
locust -f locustfile.py --host=http://localhost:8000 --master --expect-workers=3


# 8. GENERAR REPORTES
# ============================================

# Solo CSV
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --csv=my_test --headless

# Solo HTML
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --html=my_report.html --headless

# Ambos formatos
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --csv=my_test --html=my_report.html --headless

# Con timestamp
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --csv=results_$(date +%Y%m%d_%H%M%S) --headless


# 9. DEBUGGING Y LOGS
# ============================================

# Modo verbose (info detallada)
locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --loglevel INFO

# Modo debug (información de debugging)
locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --loglevel DEBUG

# Guardar logs en archivo
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --logfile=test.log


# 10. CASOS DE USO ESPECÍFICOS
# ============================================

# Validación de regresión diaria
locust -f locustfile.py --host=http://localhost:8000 -u 25 -r 5 --run-time 120s --headless --csv=daily_regression_$(date +%Y%m%d)

# Test post-deploy
locust -f load_test_critical.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --headless

# Prueba de resistencia (varias horas)
locust -f locustfile.py --host=http://localhost:8000 -u 30 -r 3 --run-time 14400s --headless  # 4 horas

# Prueba de pico de carga
locust -f locustfile.py --host=http://localhost:8000 -u 500 -r 50 --run-time 900s --headless

# Benchmark antes/después de cambios
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s --html=before_optimization.html --headless
# ... hacer cambios ...
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s --html=after_optimization.html --headless


# 11. AYUDA Y DOCUMENTACIÓN
# ============================================

# Ver todas las opciones disponibles
locust --help

# Ver documentación en línea
locust --show-task-ratio  # Mostrar proporción de tareas

# Ver qué endpoints se van a probar
locust -f locustfile.py --list  # Listar usuarios/tareas (Locust 2.x+)


# 12. CONFIGURACIÓN AVANZADA
# ============================================

# Stop timeout (tiempo antes de forzar parada)
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --stop-timeout 60

# Con variables de entorno
API_HOST=http://localhost:8000 locust -f locustfile.py --host=$API_HOST -u 50

# Sin reset de estadísticas
locust -f locustfile.py --host=http://localhost:8000 --no-reset-stats

# Con seed para reproducibilidad
locust -f locustfile.py --host=http://localhost:8000 --random-seed=12345


# ============================================
# CONFIGURADOR INTERACTIVO (PYTHON)
# ============================================

# Menú interactivo para configurar todo
python configure.py

# El configurador te permite:
# - Cambiar host
# - Cambiar usuarios
# - Cambiar spawn rate
# - Cambiar duración
# - Cargar presets
# - Ejecutar directamente
# - Guardar configuración


# ============================================
# SCRIPTS AUTOMÁTICOS (WINDOWS)
# ============================================

# Opción automática simple
run_tests.bat

# O Linux/Mac
bash run_tests.sh


# ============================================
# MONITOREO DURANTE LA PRUEBA
# ============================================

# Terminal 1: Locust
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5

# Terminal 2: Monitorear CPU/Memoria (Linux/Mac)
watch -n 1 'free -h && ps aux | grep locust'

# Terminal 2: Monitorear CPU/Memoria (Windows PowerShell)
while ($true) { Get-Process python | Select-Object Name, CPU, Memory; Start-Sleep 2 }

# Terminal 3: Ver logs de la API
tail -f api.log  # Linux/Mac
Get-Content -Tail 20 -Wait api.log  # Windows PowerShell


# ============================================
# ANÁLISIS POST-PRUEBA
# ============================================

# Ver resultados CSV
cat results_stats.csv

# Ver reporte HTML (abrir en navegador)
# Windows
start report.html
# Linux
xdg-open report.html
# Mac
open report.html

# Comparar resultados
diff results_test1_stats.csv results_test2_stats.csv


# ============================================
# TROUBLESHOOTING
# ============================================

# Verificar que API está disponible
curl http://localhost:8000

# Verificar puerto
lsof -i :8000  # Linux/Mac
netstat -ano | findstr :8000  # Windows

# Instalar dependencias faltantes
pip install -r requirements.txt

# Actualizar Locust
pip install --upgrade locust

# Ver versión instalada
locust --version

# Limpiar caché Python
find . -type d -name __pycache__ -exec rm -rf {} +  # Linux/Mac
Get-ChildItem -Recurse -Directory -Name "__pycache__" | Remove-Item -Recurse  # Windows


# ============================================
# NOTAS IMPORTANTES
# ============================================

# 1. Reemplaza http://localhost:8000 con tu URL real si es necesario
# 2. -u: número de usuarios (10, 50, 100, etc.)
# 3. -r: usuarios generados por segundo (spawn rate)
# 4. --run-time: duración (60s, 5m, 1h, etc.)
# 5. --headless: sin interfaz gráfica (para scripts)
# 6. --csv: exportar resultados en CSV
# 7. --html: generar reporte visual en HTML
#
# Combinación típica:
# locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --html=report.html --headless
#
# Esto ejecuta:
# - 50 usuarios virtuales
# - 5 nuevos usuarios por segundo
# - Durante 300 segundos (5 minutos)
# - Genera reporte HTML
# - Sin interfaz gráfica
