# 📋 Archivos de Pruebas de Carga - Artenity

## Resumen Ejecutivo

Se han creado archivos completos de pruebas de carga usando Locust para la API de Artenity. El suite cubre todos los endpoints principales y simula comportamiento real de usuarios.

---

## 📁 Estructura de Archivos

```
test_locust/
├── README.md                    # Documentación principal
├── MEJORES_PRACTICAS.md         # Guía detallada de buenas prácticas
├── requirements.txt             # Dependencias (Locust, requests)
├── locust.conf                  # Archivo de configuración por defecto
│
├── locustfile.py               # Suite COMPLETA de pruebas
├── load_test_critical.py       # Pruebas de FLUJOS CRÍTICOS
│
├── configure.py                 # Configurador interactivo
├── run_tests.sh                 # Script para Linux/Mac
├── run_tests.bat                # Script para Windows
│
└── [Generated files]
    ├── config.json              # Configuración guardada
    ├── results_*.csv            # Resultados en CSV
    ├── report.html              # Reporte visual
    └── logs.txt                 # Logs de ejecución
```

---

## 🎯 Archivos Creados

### 1. **locustfile.py** (Principal)
**Descripción:** Suite completa de pruebas de todos los endpoints

**Incluye pruebas para:**
- ✅ Autenticación (login, usuarios)
- ✅ Perfiles (obtener, actualizar)
- ✅ Publicaciones (crear, listar, eliminar)
- ✅ Likes y guardados
- ✅ Comentarios (crear, listar, eliminar)
- ✅ Seguir usuarios
- ✅ Amistad (solicitudes, aceptar, amigos)
- ✅ Notificaciones
- ✅ Estadísticas
- ✅ Bloqueos
- ✅ Reportes
- ✅ Compartir
- ✅ No me interesa

**Usuarios virtuales:** 10+  
**Tareas ponderadas:** Sí, según uso real  
**Autenticación:** JWT incluida  

---

### 2. **load_test_critical.py** (Flujos Críticos)
**Descripción:** Pruebas enfocadas en flujos críticos de usuario

**Incluye dos tipos de usuarios:**

#### CriticalPathUser
- **Lectura:** Obtener feed, ver comentarios, estadísticas
- **Interacción:** Likes, comentarios, likes en comentarios
- **Creación:** Publicaciones nuevas
- **Social:** Seguir, ver seguidores, amigos

#### AdminUser
- **Monitoreo:** Ver usuarios, notificaciones
- **Reportes:** Estadísticas de perfiles

**Simulación realista de 🎬 comportamiento:**
- Wait time variable (2-5 segundos entre tareas)
- Flujos conectados (si hay publicaciones, interactúa)
- Listeners para estadísticas

---

### 3. **requirements.txt**
```
locust>=2.15.0
requests>=2.31.0
```

---

### 4. **locust.conf**
Configuración por defecto (10 usuarios, 300 segundos)

---

### 5. **run_tests.bat** (Windows)
Script interactivo con opciones:
1. Prueba rápida (10 usuarios, 60s)
2. Prueba media (50 usuarios, 300s)
3. Prueba completa (100 usuarios, 600s)
4. Modo web interactivo

---

### 6. **run_tests.sh** (Linux/Mac)
Mismo script, versión bash

---

### 7. **configure.py**
Configurador interactivo en Python con:
- Menú visual
- Cambiar host, usuarios, duración
- Presets predefinidos
- Ejecutar prueba directamente
- Guardar/cargar configuración

**Uso:**
```bash
python configure.py
```

---

### 8. **README.md**
Documentación completa con:
- Instalación
- Uso básico
- Ejemplos de comandos
- Interpretación de resultados
- Solución de problemas
- Lista de todos los endpoints testeados

---

### 9. **MEJORES_PRACTICAS.md**
Guía detallada con:
- Preparación previa
- Estrategia de pruebas escalonadas
- Monitoreo en tiempo real
- Análisis de resultados
- Optimizaciones
- Casos de uso comunes
- Solución de problemas avanzada

---

## 🚀 Forma Rápida de Empezar

### Opción 1: Script automático (⭐ RECOMENDADO)

**Windows:**
```bash
cd test_locust
run_tests.bat
```

**Linux/Mac:**
```bash
cd test_locust
bash run_tests.sh
```

### Opción 2: Configurador interactivo

```bash
cd test_locust
python configure.py
```

### Opción 3: Línea de comandos directa

```bash
# Prueba rápida
locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s

# Modo web (recomendado para ver gráficas)
locust -f locustfile.py --host=http://localhost:8000
# Luego accede a http://localhost:8089
```

---

## 📊 Métricas que Monitorean

### Por cada request:
- ✅ Tiempo de respuesta (min, max, promedio)
- ✅ Tasa de fallos
- ✅ Requests por segundo (RPS)
- ✅ Percentiles (95th, 99th)

### Global:
- ✅ Número de usuarios activos
- ✅ Gráficas en tiempo real
- ✅ Estadísticas acumulativas

---

## 🎨 Interfaz Web

Si ejecutas en modo web (`locust -f locustfile.py --host=...`):

1. Accede a **http://localhost:8089**
2. Configura usuarios y spawn rate
3. Click "Start swarming"
4. Observa gráficas en tiempo real:
   - **Response Time**: Tiempo de respuesta
   - **RPS**: Solicitudes por segundo
   - **Failure Rate**: Porcentaje de fallos
   - **Users**: Número de usuarios activos

---

## 💡 Características Principales

### 1. **Autenticación Realista**
- Login con JWT
- Headers con token e id_usuario
- Manejo de fallos de autenticación

### 2. **Datos Aleatorios**
- Usuarios únicos
- IDs aleatorios de publicaciones
- Comentarios variados
- Timestamps realistas

### 3. **Tareas Ponderadas**
Las tareas más frecuentes tienen mayor peso:
- Lectura (8 tareas)
- Likes (6 tareas)
- Comentarios (4 tareas)
- Creación (3 tareas)

### 4. **Validación**
- Manejo de errores
- Verificación de estado HTTP
- Logs detallados

---

## ⚙️ Configuración Personalizada

### Para cambiar parámetros:

**Opción A:** Editar `locust.conf`
```conf
host = http://localhost:8000
users = 50
spawn-rate = 5
run-time = 600
```

**Opción B:** Ejecutar con parámetros
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 600s
```

**Opción C:** Usar configurador
```bash
python configure.py
```

---

## 📈 Ejemplos de Uso

### Validación Post-Deploy
```bash
locust -f load_test_critical.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --headless
```

### Benchmarking
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s --csv=benchmark.csv
```

### Prueba de Estrés
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 200 -r 20 --run-time 900s
```

### Con Reporte HTML
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 --run-time 300s --html=report.html
```

---

## 🔗 Endpoints Cubiertos (50+)

| Categoría | Endpoints |
|-----------|-----------|
| **Usuarios** | POST /usuarios, GET /usuarios, DELETE /usuarios/{id} |
| **Auth** | POST /login |
| **Perfiles** | GET /perfiles/{id}, PUT /perfiles/{id} |
| **Publicaciones** | POST, GET, DELETE /publicaciones |
| **Likes** | POST/DELETE /me-gusta/{id} |
| **Comentarios** | POST/GET/DELETE /comentarios |
| **Seguir** | POST/DELETE /seguir/{id}, GET /seguidores, GET /siguiendo |
| **Amistad** | POST/PUT /amistad/{id}, GET /amigos, DELETE /amigos/{id} |
| **Notificaciones** | GET /notificaciones, PUT /notificaciones/leidas |
| **Estadísticas** | GET /estadisticas-perfil/{id}, GET /publicaciones/{id}/estadisticas |
| **Bloqueos** | POST /bloquear/{id}, GET /usuarios-bloqueados, DELETE /desbloquear/{id} |
| **Otros** | POST /reportar/{id}, POST /compartir/{id}, POST /no-me-interesa/{id} |

---

## 📌 Requisitos Previos

- ✅ Python 3.8+
- ✅ pip (gestor de paquetes)
- ✅ API Artenity ejecutándose en http://localhost:8000
- ✅ Base de datos disponible
- ✅ Suficientes recursos (CPU, memoria, red)

---

## 🔧 Instalación Rápida

```bash
# 1. Navegar al directorio
cd test_locust

# 2. Instalar dependencias
pip install -r requirements.txt

# 3. Ejecutar pruebas
python configure.py  # Opción: configurador interactivo
# O
run_tests.bat  # Windows
# O
bash run_tests.sh  # Linux/Mac
```

---

## 📞 Soporte

Para más información, consulta:
- 📖 **README.md** - Documentación principal
- 🏆 **MEJORES_PRACTICAS.md** - Guía avanzada
- 🌐 **Locust Docs**: https://docs.locust.io/

---

## ✨ Características Destacadas

🎯 **Realista**: Simula comportamiento real de usuarios  
⚡ **Rápido**: Pruebas configurable de 60s a horas  
📊 **Visual**: Gráficas en tiempo real en navegador  
🔄 **Repetible**: Resultados consistentes  
📈 **Escalable**: Desde 10 a 1000+ usuarios  
🛠️ **Personalizable**: Fácil de adaptar a nuevos endpoints  
📝 **Documentado**: Guías completas incluidas  

---

**Creado:** Diciembre 2024  
**Versión:** 1.0  
**Estado:** ✅ Listo para usar
