# Pruebas de Carga - Locust para Artenity

Este directorio contiene las pruebas de carga para la API de Artenity usando Locust.

## 📋 Contenido

- **locustfile.py** - Suite completa de pruebas de todos los endpoints
- **load_test_critical.py** - Pruebas enfocadas en flujos críticos de uso
- **requirements.txt** - Dependencias necesarias
- **locust.conf** - Archivo de configuración
- **run_tests.sh** - Script para ejecutar en Linux/Mac
- **run_tests.bat** - Script para ejecutar en Windows

## 🚀 Instalación

```bash
# Instalación de dependencias
pip install -r requirements.txt
```

## 📝 Uso

### Opción 1: Script automático (Recomendado)

**Windows:**
```bash
run_tests.bat
```

**Linux/Mac:**
```bash
bash run_tests.sh
```

### Opción 2: Línea de comandos

**Prueba rápida (10 usuarios, 60 segundos):**
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s
```

**Modo web interactivo:**
```bash
locust -f locustfile.py --host=http://localhost:8000
```
Luego accede a http://localhost:8089

**Prueba de flujos críticos:**
```bash
locust -f load_test_critical.py --host=http://localhost:8000 -u 20 -r 4 --run-time 300s
```

## 🎯 Tipos de Pruebas

### locustfile.py
Suite completa que prueba:
- Usuarios y autenticación
- Perfiles
- Publicaciones
- Likes y guardados
- Comentarios
- Sistema de seguimiento
- Amistad
- Notificaciones
- Estadísticas
- Bloqueos y reportes
- Compartir contenido

**Características:**
- 10+ usuarios virtuales simultáneos
- Tareas ponderadas según uso real
- Autenticación JWT

### load_test_critical.py
Enfocado en flujos de usuario críticos:
- **CriticalPathUser**: Simula uso normal
  - Lectura de publicaciones
  - Interacción (likes, comentarios)
  - Creación de contenido
  - Navegación social

- **AdminUser**: Operaciones administrativas
  - Monitoreo
  - Reportes
  - Estadísticas

## 📊 Parámetros de Ejecución

- `-u` / `--users`: Número de usuarios virtuales
- `-r` / `--spawn-rate`: Usuarios generados por segundo
- `--run-time`: Duración de la prueba (ej: 60s, 5m)
- `-f` / `--locustfile`: Archivo de pruebas
- `--host`: URL base de la API
- `--headless`: Modo sin interfaz gráfica

## 💡 Ejemplos de Uso

**Prueba de estrés gradual:**
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s
```

**Prueba de estabilidad:**
```bash
locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 1800s
```

**Modo sin interfaz (para CI/CD):**
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --headless
```

**Con reporte CSV:**
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --csv=results
```

## 📈 Interpretación de Resultados

### Métricas Principales

- **RPS** (Requests Per Second): Solicitudes por segundo
- **Response time**: Tiempo de respuesta (promedio, mín, máx)
- **Failure Rate**: Porcentaje de fallos
- **95/99th percentile**: Percentiles de tiempo de respuesta

### Métricas por Endpoint

Para cada endpoint se muestra:
- Total de requests
- Número de fallos
- Tasa de éxito
- Tiempo promedio
- Min/Max

## ⚙️ Configuración

Edita `locust.conf` para cambiar configuración por defecto:

```conf
host = http://localhost:8000
users = 10
spawn-rate = 2
run-time = 300
```

## 🐛 Solución de Problemas

### "Failed to load URL"
- Verifica que la API esté corriendo en http://localhost:8000
- Revisa la consola de la API para errores

### Errores de autenticación
- Asegúrate de que existen usuarios de prueba en la BD
- Verifica las credenciales en el código

### Bajo rendimiento
- Reduce el número de usuarios
- Aumenta el `wait_time`
- Verifica recursos del servidor

## 📚 Documentación de Endpoints Testeados

### Autenticación
- `POST /usuarios` - Crear usuario
- `POST /login` - Autenticar usuario

### Perfiles
- `GET /perfiles/{id}` - Obtener perfil
- `PUT /perfiles/{id}` - Actualizar perfil

### Publicaciones
- `POST /publicaciones` - Crear publicación
- `GET /publicaciones` - Obtener feed
- `GET /publicaciones/categoria/{cat}` - Por categoría
- `DELETE /publicaciones/{id}` - Eliminar

### Interacción
- `POST /me-gusta/{id}` - Me gusta
- `DELETE /me-gusta/{id}` - Quitar like
- `POST /guardar/{id}` - Guardar
- `GET /guardados` - Ver guardados

### Comentarios
- `POST /comentarios` - Crear comentario
- `GET /comentarios/publicacion/{id}` - Obtener comentarios
- `DELETE /comentarios/{id}` - Eliminar comentario

### Social
- `POST /seguir/{id}` - Seguir usuario
- `DELETE /dejar-seguir/{id}` - Dejar de seguir
- `GET /seguidores` - Mi lista de seguidores
- `GET /siguiendo` - Mi lista de seguidos

### Amistad
- `POST /amistad/{id}` - Solicitar amistad
- `PUT /amistad/{id}` - Aceptar solicitud
- `GET /amigos` - Lista de amigos
- `DELETE /amigos/{id}` - Eliminar amigo

### Notificaciones
- `GET /notificaciones` - Obtener notificaciones
- `PUT /notificaciones/leidas` - Marcar como leídas

### Estadísticas
- `GET /estadisticas-perfil/{id}` - Estadísticas de perfil
- `GET /publicaciones/{id}/estadisticas` - Estadísticas de publicación

### Bloqueos
- `POST /bloquear/{id}` - Bloquear usuario
- `GET /usuarios-bloqueados` - Lista de bloqueados
- `DELETE /desbloquear/{id}` - Desbloquear usuario

### Otros
- `POST /reportar/{id}` - Reportar usuario
- `POST /compartir/{id}` - Compartir publicación
- `POST /no-me-interesa/{id}` - Marcar como no interesa

## 🔗 Links útiles

- Documentación Locust: https://locust.io/
- FastAPI: https://fastapi.tiangolo.com/
- Pruebas de carga: https://en.wikipedia.org/wiki/Load_testing

## 📝 Notas

- Las pruebas utilizan datos aleatorios para simular uso realista
- Se requiere que la API esté corriendo en http://localhost:8000
- La base de datos debe tener al menos algunos usuarios registrados
- Se pueden modificar las tareas y pesos según necesidades específicas

## ✅ Checklist Antes de Ejecutar

- [ ] API corriendo en http://localhost:8000
- [ ] Base de datos disponible
- [ ] Python y Locust instalados
- [ ] Dependencias instaladas: `pip install -r requirements.txt`
- [ ] Servidor con recursos suficientes
- [ ] CORS configurado correctamente en la API
