# 🚀 INICIO RÁPIDO - Pruebas de Carga Artenity

## ⏱️ 5 minutos para empezar

### Paso 1: Instalar (1 min)
```bash
cd test_locust
pip install -r requirements.txt
```

### Paso 2: Ejecutar (2 formas)

#### Opción A: Script automático
**Windows:**
```bash
run_tests.bat
```
**Linux/Mac:**
```bash
bash run_tests.sh
```

#### Opción B: Línea de comandos
```bash
locust -f locustfile.py --host=http://localhost:8000
```

### Paso 3: Ver resultados
- Se abre http://localhost:8089 automáticamente
- Ingresa **50** usuarios y haz click "Start swarming"
- Observa las gráficas en tiempo real

---

## 📊 Lo que verás

```
Response Times Over Time    → Tiempo de respuesta
Number of Users             → Usuarios activos
Requests per second         → RPS (solicitudes/seg)
Failure Rate               → % de errores
Status Codes               → 200, 400, 500, etc.
```

---

## 🎯 3 Niveles de Prueba

### Nivel 1: Validación (⚡ Rápido)
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s
```
✅ Verifica que funciona  
⏱️ 1 minuto  
👥 10 usuarios  

### Nivel 2: Normal (📈 Estándar)
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s
```
✅ Simula carga normal  
⏱️ 5 minutos  
👥 50 usuarios  

### Nivel 3: Estrés (💥 Máximo)
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 200 -r 20 --run-time 900s
```
✅ Prueba límites  
⏱️ 15 minutos  
👥 200 usuarios  

---

## ✅ Requisitos Previos

- [ ] API corriendo: `python -m uvicorn backend.main:app --reload`
- [ ] Puerto 8000 disponible
- [ ] Python 3.8+
- [ ] 2GB RAM libre

---

## 🆘 Si algo falla

### "Connection refused"
```bash
# Verifica que API está corriendo
curl http://localhost:8000
```

### "Locust not found"
```bash
# Instala dependencias
pip install -r requirements.txt
```

### "Too many failures"
- Reduce usuarios: `locust -u 10` (en lugar de 50)
- Verifica credenciales en main.py

---

## 📁 Archivos clave

| Archivo | Propósito |
|---------|-----------|
| **locustfile.py** | Pruebas completas (50+ endpoints) |
| **load_test_critical.py** | Flujos críticos de usuario |
| **configure.py** | Configurador interactivo |
| **README.md** | Documentación detallada |
| **MEJORES_PRACTICAS.md** | Guía avanzada |

---

## 💡 Usos Comunes

### Validar después de deploy
```bash
locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 300s --headless
```

### Generar reporte
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s --html=report.html --headless
```

### Benchmarking
```bash
locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s --csv=benchmark.csv --headless
```

---

## 📈 Qué Significan las Métricas

| Métrica | Ideal | Malo |
|---------|-------|------|
| Failure Rate | 0% | > 1% |
| Response Time (avg) | < 500ms | > 2000ms |
| RPS | > 100 | < 10 |
| 95th percentile | < 1000ms | > 5000ms |

---

## 🎓 Próximos Pasos

1. **Leer README.md** - Documentación completa
2. **Ver MEJORES_PRACTICAS.md** - Optimizaciones
3. **Explorar COMANDOS_FRECUENTES.md** - Más ejemplos
4. **Personalizar locustfile.py** - Agregar tests propios

---

## 🔗 Links

- **Documentación Locust**: https://docs.locust.io/
- **Nuestro README**: [README.md](README.md)
- **Guía de Prácticas**: [MEJORES_PRACTICAS.md](MEJORES_PRACTICAS.md)
- **Comandos Frecuentes**: [COMANDOS_FRECUENTES.md](COMANDOS_FRECUENTES.md)

---

## ⚡ Comando Más Útil (cópialo y pega)

```bash
locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s
```

Esto abre interfaz web donde puedes:
- Ver gráficas en tiempo real
- Ajustar usuarios mientras corre
- Ver estadísticas por endpoint

---

**¿Listo para probar?** 🚀

```bash
cd test_locust
run_tests.bat    # Windows
# o
bash run_tests.sh  # Linux/Mac
```

Luego accede a http://localhost:8089

¡Éxito! 🎉
