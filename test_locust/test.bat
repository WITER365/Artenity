@echo off
REM ========================================
REM Quick Test Runner - Artenity Load Tests
REM ========================================

setlocal enabledelayedexpansion

echo.
echo ====================================
echo   ARTENITY - LOCUST TEST RUNNER
echo ====================================
echo.

REM Check if Locust is installed
where locust >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [!] Locust not found. Installing dependencies...
    pip install -r requirements.txt
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Failed to install dependencies
        pause
        exit /b 1
    )
)

REM Display options
echo Select test type:
echo.
echo   1. Quick Test        (10 users, 60 seconds)
echo   2. Standard Test     (50 users, 5 minutes)
echo   3. Load Test         (100 users, 10 minutes)
echo   4. Stress Test       (200 users, 15 minutes)
echo   5. Critical Paths    (30 users, 5 minutes)
echo   6. Interactive Mode  (Web UI at localhost:8089)
echo   7. Configure Custom  (Interactive configurator)
echo.

set /p choice="Enter choice (1-7): "

REM Validate input
if not "%choice%"=="" (
    if not "%choice%"=="1" if not "%choice%"=="2" if not "%choice%"=="3" if not "%choice%"=="4" if not "%choice%"=="5" if not "%choice%"=="6" if not "%choice%"=="7" (
        echo [!] Invalid choice
        pause
        exit /b 1
    )
)

if "%choice%"=="" (
    echo [!] No choice selected
    pause
    exit /b 1
)

REM Execute selected test
echo.
if "%choice%"=="1" (
    echo [+] Starting Quick Test...
    echo     Users: 10, Duration: 60 seconds
    echo.
    locust -f locustfile.py --host=http://localhost:8000 -u 10 -r 2 --run-time 60s
) else if "%choice%"=="2" (
    echo [+] Starting Standard Test...
    echo     Users: 50, Duration: 300 seconds
    echo.
    locust -f locustfile.py --host=http://localhost:8000 -u 50 -r 5 --run-time 300s
) else if "%choice%"=="3" (
    echo [+] Starting Load Test...
    echo     Users: 100, Duration: 600 seconds
    echo.
    locust -f locustfile.py --host=http://localhost:8000 -u 100 -r 10 --run-time 600s
) else if "%choice%"=="4" (
    echo [+] Starting Stress Test...
    echo     Users: 200, Duration: 900 seconds
    echo.
    locust -f locustfile.py --host=http://localhost:8000 -u 200 -r 20 --run-time 900s
) else if "%choice%"=="5" (
    echo [+] Starting Critical Paths Test...
    echo     Users: 30, Duration: 300 seconds
    echo.
    locust -f load_test_critical.py --host=http://localhost:8000 -u 30 -r 3 --run-time 300s
) else if "%choice%"=="6" (
    echo [+] Starting Interactive Mode...
    echo     Open http://localhost:8089 in your browser
    echo.
    locust -f locustfile.py --host=http://localhost:8000
) else if "%choice%"=="7" (
    echo [+] Starting Configurator...
    echo.
    python configure.py
)

REM Cleanup
endlocal
pause
