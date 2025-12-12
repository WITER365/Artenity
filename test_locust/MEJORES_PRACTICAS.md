# Guía de Mejores Prácticas - Pruebas de Carga con Locust

## 📌 Índice
1. [Antes de Ejecutar](#antes-de-ejecutar)
2. [Durante las Pruebas](#durante-las-pruebas)
3. [Análisis de Resultados](#análisis-de-resultados)
4. [Optimizaciones](#optimizaciones)
5. [Solución de Problemas](#solución-de-problemas)

## 🔧 Antes de Ejecutar

### 1. Preparar el Entorno

```bash
# Instalar dependencias
pip install -r requirements.txt

# Verificar que Locust está instalado
locust --version
```

### 2. Verificar la API

```bash
# Probar que la API está disponible
curl http://localhost:8000

# Ver logs de la API
tail -f api.log
```

### 3. Preparar la Base de Datos

```bash
# Verificar conexión a BD
python -c "from backend.database import engine; engine.connect()"

# Crear datos de prueba si es necesario
python -c "from backend import models, database; models.Base.metadata.create_all(bind=database.engine)"
```

### 4. Recursos del Sistema

Asegúrate de tener suficientes recursos:

```bash
# En Windows (PowerShell)
Get-Process

# En Linux/Mac
top  # Prensa 'q' para salir
```

**Requisitos mínimos:**
- CPU: 2+ cores
- Memoria: 4GB+
- Ancho de banda: 10Mbps+

## ⚙️ Durante las Pruebas

### Estrategia Escalada

```bash
# Fase 1: Validación (pequeño volumen)
locust -f locustfile.py --host=http://localhost:8000 -u 5 -r 1 --run-time 60s

# Fase 2: Carga normal (uso típico)
locust -f locustfile.py --host=http://localhost:8000 -u 25 -r 5 --run-time 300s

# Fase 3: Pico de carga
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s

# Fase 4: Prueba de estrés (máximo)
locust -f locustfile.py --host=http://localhost:8000 -u 200 -r 20 --run-time 900s
```

### Monitoreo en Tiempo Real

**Terminal 1 - Ejecutar Locust:**
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5
```

**Terminal 2 - Monitorear API:**
```bash
# Linux/Mac
watch -n 1 'curl -s http://localhost:8000/docs | grep -c "paths"'

# Windows PowerShell
while ($true) { (Invoke-WebRequest http://localhost:8000).StatusCode; Start-Sleep 2 }
```

**Terminal 3 - Monitorear Sistema:**
```bash
# Linux/Mac
watch -n 1 'free -h && ps aux | grep python'

# Windows PowerShell
while ($true) { Get-Process python | Select-Object Name, CPU, Memory; Start-Sleep 2 }
```

### Usar Interfaz Web

```bash
locust -f locustfile.py --host=http://localhost:8000
```

Luego accede a: http://localhost:8089

**En la interfaz:**
1. Ingresa usuarios deseados (ej: 50)
2. Ingresa spawn rate (ej: 5)
3. Click en "Start swarming"
4. Observa gráficas en tiempo real

## 📊 Análisis de Resultados

### Métricas Clave a Evaluar

```
Métrica                  Objetivo        Crítica si
─────────────────────────────────────────────────────
Response Time (avg)      < 500ms         > 2000ms
Response Time (95th)     < 1000ms        > 5000ms
Failure Rate             0%              > 1%
RPS (Peak)              > 100            < 10
Throughput              Consistente     Cae > 50%
```

### Interpretar Gráficas

1. **Response Time Over Time**
   - Ideal: Línea plana
   - Malo: Línea ascendente (degrada)
   - Crítico: Picos altos repentinos

2. **Users**
   - Línea debe ser diagonal (aumento gradual)
   - Sin saltos abruptos

3. **Failure Rate**
   - Debe ser 0% todo el tiempo
   - Cualquier incremento indica problema

4. **Requests/sec**
   - Debe ser consistente
   - Caídas indican saturación

### Exportar Resultados

```bash
# CSV
locust -f locustfile.py --host=http://localhost:8000 -u 50 --run-time 300s --csv=results

# HTML Report
locust -f locustfile.py --host=http://localhost:8000 -u 50 --run-time 300s --html=report.html
```

## 🚀 Optimizaciones

### 1. Optimizar Tareas Ponderadas

```python
# En locustfile.py, ajusta los pesos @task:
@task(10)  # Frecuente
def tarea_frecuente(self):
    pass

@task(1)   # Rara
def tarea_rara(self):
    pass
```

### 2. Pool de Conexiones

```python
# Ya está optimizado en HttpUser, pero puedes ajustar:
class ArtenityUser(HttpUser):
    pool_size = 10  # Conexiones simultáneas
    pool_connections = 5
```

### 3. Tiempos de Espera Realistas

```python
# Espera corta para API rápida
wait_time = between(0.5, 2)

# Espera larga para simular lectura
wait_time = between(3, 7)
```

### 4. Datos Aleatorios Eficientes

```python
# Bien - Computado una sola vez
random_email = f"user{random.randint(1, 1000)}@test.com"

# Mal - Computado múltiples veces
for i in range(1000):
    random.randint(1, 1000)  # Evitar loops innecesarios
```

## 🔍 Solución de Problemas

### "Connection refused"

```bash
# Verifica que la API está corriendo
lsof -i :8000  # Linux/Mac
netstat -ano | findstr :8000  # Windows

# Reinicia la API
pkill -f "uvicorn"  # Linux/Mac
Stop-Process -Name "python" # Windows (cuidado, mata todo Python)
```

### "Too many open files"

```bash
# Linux/Mac - Aumentar límite
ulimit -n 4096

# Reducir usuarios en Locust
locust -u 50 -r 5  # Antes de aumentar

# Agregar delay
wait_time = between(1, 3)
```

### "High failure rate"

```python
# 1. Verificar timeouts
from locust import HttpUser
# Agregar timeout
self.client.get(url, timeout=30)

# 2. Verificar datos válidos
print(response.text)  # Ver qué retorna

# 3. Agregar validación
if response.status_code != 200:
    print(f"Error: {response.status_code}")
```

### "Memory leak"

```bash
# Monitorear uso de memoria
watch -n 1 'ps aux | grep locust'

# Reiniciar Locust periodicamente
# Usar workers en lugar de una sola instancia
```

## 📈 Casos de Uso Comunes

### 1. Prueba de Regresión (Daily)

```bash
locust -f locustfile.py --host=http://localhost:8000 \
  -u 25 -r 5 --run-time 120s --headless \
  --csv=reports/daily_$(date +%Y%m%d).csv
```

### 2. Validación Post-Deploy

```bash
locust -f load_test_critical.py --host=http://localhost:8000 \
  -u 50 -r 5 --run-time 300s --headless
```

### 3. Benchmarking de Rendimiento

```bash
# Grabar baseline
locust -f locustfile.py --host=http://localhost:8000 \
  -u 100 -r 10 --run-time 600s --headless \
  --html=baseline.html

# Comparar después de cambios
locust -f locustfile.py --host=http://localhost:8000 \
  -u 100 -r 10 --run-time 600s --headless \
  --html=after_changes.html
```

### 4. Prueba de Carga en Escalera

```bash
# Script manual: aumentar gradualmente
for users in 10 25 50 100 200; do
  locust -f locustfile.py --host=http://localhost:8000 \
    -u $users -r $((users/5)) --run-time 60s --headless
  sleep 30
done
```

## 🎓 Checklist Final

Antes de reportar resultados:

- [ ] API completamente estable
- [ ] Base de datos sin errores
- [ ] Red sin congestión
- [ ] Máquina con recursos suficientes
- [ ] Prueba ejecutada mínimo 2 veces
- [ ] Resultados consistentes
- [ ] Logs guardados
- [ ] Screenshots de gráficas
- [ ] Documento con análisis

## 📞 Soporte y Documentación

- **Locust Docs**: https://docs.locust.io/
- **FastAPI Performance**: https://fastapi.tiangolo.com/deployment/
- **HTTP Performance**: https://tools.ietf.org/html/rfc7231#section-6.3.1

---

**Última actualización**: 2024
**Versión**: 1.0
