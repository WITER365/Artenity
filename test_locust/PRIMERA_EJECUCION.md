# 🚀 PRIMERA EJECUCIÓN - Paso a Paso

## ⏱️ Estimado: 10 minutos

## PASO 1: Verificar Requisitos (1 minuto)

### Windows:
```powershell
# Verificar Python
python --version

# Verificar que API está corriendo
curl http://localhost:8000

# Verificar puerto disponible
netstat -ano | findstr :8000
```

### Linux/Mac:
```bash
# Verificar Python
python3 --version

# Verificar que API está corriendo
curl http://localhost:8000

# Verificar puerto disponible
lsof -i :8000
```

---

## PASO 2: Instalar Dependencias (2 minutos)

```bash
cd test_locust
pip install -r requirements.txt
```

**Esperado:**
```
Successfully installed locust-2.15.0 requests-2.31.0
```

---

## PASO 3: Ejecutar Primera Prueba (1 minuto)

### Opción A: Script Automático (⭐ RECOMENDADO)

**Windows:**
```bash
test.bat
# Elige opción 1 (Quick Test)
```

**Linux/Mac:**
```bash
bash test.sh
# Elige opción 1 (Quick Test)
```

### Opción B: Directo con Locust
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s
```

---

## PASO 4: Ver Resultados (En vivo)

Una vez ejecutado, deberías ver:

```
[xxxx-xx-xx xxxx:xx:xx] A new Locust client connected! (ip: xxxx, id: xxxx)
[xxxx-xx-xx xxxx:xx:xx] Starting new HTTP connection (1): localhost
...
GET /publicaciones 200 [100%]
POST /login 200 [100%]
...
```

---

## PASO 5: Acceder a Dashboard Web

Si ejecutas sin `--run-time`:
```bash
locust -f locustfile.py --host=http://localhost:8000
```

Abre en navegador: **http://localhost:8089**

**En el dashboard:**
1. Ingresa **50** usuarios
2. Click "Start swarming"
3. Observa gráficas en tiempo real

---

## 🎯 Primera Ejecución Exitosa Debería Mostrar:

```
✓ Conexiones exitosas a la API
✓ Respuesta de endpoints en < 1000ms
✓ Tasa de éxito > 95%
✓ RPS > 50 solicitudes/segundo
✓ Sin errores críticos
```

---

## ⚠️ Problemas Comunes en Primera Ejecución

### Problema 1: "Connection refused"
**Causa:** API no está corriendo  
**Solución:**
```bash
# Terminal 1: Iniciar API
cd ..
python -m uvicorn backend.main:app --reload

# Terminal 2: Ejecutar Locust
cd test_locust
locust -f locustfile.py --host=http://localhost:8000
```

### Problema 2: "Locust: command not found"
**Causa:** Locust no está instalado  
**Solución:**
```bash
pip install -r requirements.txt
locust --version  # Verificar
```

### Problema 3: "Address already in use"
**Causa:** Puerto 8000 ya está en uso  
**Solución:**
```bash
# Opción A: Usar otro puerto en API
python -m uvicorn backend.main:app --reload --port 8001

# Opción B: Matar proceso en puerto 8000
# Windows
netstat -ano | findstr :8000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:8000 | xargs kill -9
```

### Problema 4: "High failure rate" (> 10%)
**Causa:** Credenciales incorrectas o API con problemas  
**Solución:**
1. Verifica que existen usuarios en la BD
2. Revisa logs de la API
3. Reduce usuarios: `locust -u 5`
4. Aumenta wait time en código

### Problema 5: "Too many open files"
**Causa:** Demasiadas conexiones simultáneas  
**Solución:**
```bash
# Linux/Mac
ulimit -n 4096

# Windows (reinicia con permisos elevados)
```

---

## ✅ Checklist de Validación

Después de la primera ejecución, verifica:

- [ ] Locust se conectó sin errores
- [ ] Se ejecutó al menos 1 minuto
- [ ] Viste gráficas actualizarse
- [ ] Response times < 2 segundos
- [ ] Failure rate = 0% o < 1%
- [ ] RPS > 10 solicitudes/seg
- [ ] No hay excepciones en logs

---

## 🎓 Próximas Pruebas Recomendadas

### Después de validar (5-10 min):
```bash
# Prueba estándar
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s
```

### Generar reporte (10-15 min):
```bash
# Con reporte HTML
locust -f locustfile.py --host=http://localhost:8000 -u 50 --run-time 300s --html=report.html --headless
```

### Probar flujos críticos (5 min):
```bash
locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 300s
```

---

## 📊 Interpretar Resultados Iniciales

### Response Times
```
✓ Excelente: < 200ms
✓ Bueno:     < 500ms
⚠️ Aceptable: < 1000ms
❌ Malo:      > 2000ms
```

### Failure Rate
```
✓ Perfecto:   0%
✓ Aceptable:  < 1%
⚠️ Preocupante: 1-5%
❌ Crítico:    > 5%
```

### RPS (Requests Per Second)
```
✓ Excelente: > 200
✓ Bueno:     > 100
⚠️ Aceptable: > 50
❌ Bajo:      < 10
```

---

## 💡 Tips para Primera Ejecución

1. **Empieza pequeño**: 10 usuarios, 60 segundos
2. **Observa los logs**: Busca patrones de errores
3. **Verifica la API**: Revisa que está respondiendo
4. **Aumenta gradualmente**: De 10 → 50 → 100 usuarios
5. **Lee los errores**: Son informativos
6. **Guarda resultados**: Para comparar después

---

## 🎯 Meta de Primera Ejecución

**Objetivo:** Validar que el sistema de pruebas funciona correctamente

**Criterios de éxito:**
- ✅ Locust se conecta a la API
- ✅ Se ejecutan al menos 5 minutos sin crashes
- ✅ Varias solicitudes completadas
- ✅ Gráficas actualizadas en tiempo real
- ✅ Failure rate < 5%

---

## 📞 Si Aún Hay Problemas

1. **Consulta README.md** - Troubleshooting detallado
2. **Consulta MEJORES_PRACTICAS.md** - Solución avanzada
3. **Revisa logs de la API** - Errores backend
4. **Verifica conectividad** - `curl http://localhost:8000`
5. **Intenta localhost vs 127.0.0.1**

---

## 🎉 ¡Felicidades!

Si completaste estos pasos, tu sistema de pruebas está:
- ✅ Instalado
- ✅ Configurado
- ✅ Funcionando
- ✅ Listo para producción

**Próximo paso:** Leer [INICIO_RAPIDO.md](INICIO_RAPIDO.md) para explorar más opciones.

---

**Tiempo total estimado:** 10 minutos  
**Dificultad:** ⭐ Principiante  
**Soporte:** Ver archivos .md en este directorio
