#!/bin/bash

# Script para ejecutar pruebas de carga con Locust

echo "==================================="
echo "Locust Load Testing - Artenity"
echo "==================================="
echo ""

# Verificar si Locust está instalado
if ! command -v locust &> /dev/null; then
    echo "Locust no está instalado. Instalando dependencias..."
    pip install -r requirements.txt
fi

echo "Selecciona una opción de prueba:"
echo "1) Prueba rápida (10 usuarios, 60 segundos)"
echo "2) Prueba media (50 usuarios, 300 segundos)"
echo "3) Prueba completa (100 usuarios, 600 segundos)"
echo "4) Modo web interactivo (acceso en http://localhost:8089)"
echo ""
read -p "Opción (1-4): " opcion

case $opcion in
    1)
        echo "Iniciando prueba rápida..."
        locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s
        ;;
    2)
        echo "Iniciando prueba media..."
        locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s
        ;;
    3)
        echo "Iniciando prueba completa..."
        locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s
        ;;
    4)
        echo "Iniciando modo web interactivo..."
        echo "Accede a http://localhost:8089 en tu navegador"
        locust -f locustfile.py --host=http://localhost:8000
        ;;
    *)
        echo "Opción inválida"
        ;;
esac
