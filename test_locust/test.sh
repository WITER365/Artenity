#!/bin/bash

# ========================================
# Quick Test Runner - Artenity Load Tests
# ========================================

echo ""
echo "===================================="
echo "  ARTENITY - LOCUST TEST RUNNER"
echo "===================================="
echo ""

# Check if Locust is installed
if ! command -v locust &> /dev/null; then
    echo "[!] Locust not found. Installing dependencies..."
    pip install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to install dependencies"
        exit 1
    fi
fi

# Display options
echo "Select test type:"
echo ""
echo "  1. Quick Test        (10 users, 60 seconds)"
echo "  2. Standard Test     (50 users, 5 minutes)"
echo "  3. Load Test         (100 users, 10 minutes)"
echo "  4. Stress Test       (200 users, 15 minutes)"
echo "  5. Critical Paths    (30 users, 5 minutes)"
echo "  6. Interactive Mode  (Web UI at localhost:8089)"
echo "  7. Configure Custom  (Interactive configurator)"
echo ""

read -p "Enter choice (1-7): " choice

# Validate input
if [[ ! "$choice" =~ ^[1-7]$ ]]; then
    echo "[!] Invalid choice"
    exit 1
fi

echo ""

# Execute selected test
case $choice in
    1)
        echo "[+] Starting Quick Test..."
        echo "    Users: 10, Duration: 60 seconds"
        echo ""
        locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s
        ;;
    2)
        echo "[+] Starting Standard Test..."
        echo "    Users: 50, Duration: 300 seconds"
        echo ""
        locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s
        ;;
    3)
        echo "[+] Starting Load Test..."
        echo "    Users: 100, Duration: 600 seconds"
        echo ""
        locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s
        ;;
    4)
        echo "[+] Starting Stress Test..."
        echo "    Users: 200, Duration: 900 seconds"
        echo ""
        locust -f locustfile.py --host=http://localhost:8000 -u 200 -r 20 --run-time 900s
        ;;
    5)
        echo "[+] Starting Critical Paths Test..."
        echo "    Users: 30, Duration: 300 seconds"
        echo ""
        locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 300s
        ;;
    6)
        echo "[+] Starting Interactive Mode..."
        echo "    Open http://localhost:8089 in your browser"
        echo ""
        locust -f locustfile.py --host=http://localhost:8000
        ;;
    7)
        echo "[+] Starting Configurator..."
        echo ""
        python configure.py
        ;;
esac
