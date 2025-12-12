#!/usr/bin/env python3
"""
Script de configuración para pruebas de carga Locust
Permite configurar URL, usuarios, duración, etc.
"""

import os
import sys
import json
import subprocess
from pathlib import Path

class LocustConfig:
    def __init__(self):
        self.config = {
            "host": "http://localhost:8000",
            "users": 10,
            "spawn_rate": 2,
            "run_time": "300s",
            "workers": 1,
            "logfile": None
        }
        self.config_file = "config.json"
    
    def load_config(self):
        """Carga configuración desde archivo si existe"""
        if os.path.exists(self.config_file):
            try:
                with open(self.config_file, 'r') as f:
                    self.config.update(json.load(f))
                print("✓ Configuración cargada desde config.json")
            except:
                print("⚠ No se pudo cargar config.json, usando valores por defecto")
    
    def save_config(self):
        """Guarda configuración actual"""
        with open(self.config_file, 'w') as f:
            json.dump(self.config, f, indent=2)
        print("✓ Configuración guardada en config.json")
    
    def show_menu(self):
        """Muestra menú principal"""
        print("\n" + "="*50)
        print("CONFIGURADOR DE LOCUST - ARTENITY")
        print("="*50)
        print(f"\nConfiguración actual:")
        print(f"  Host: {self.config['host']}")
        print(f"  Usuarios: {self.config['users']}")
        print(f"  Spawn rate: {self.config['spawn_rate']} usuarios/seg")
        print(f"  Duración: {self.config['run_time']}")
        print(f"  Workers: {self.config['workers']}")
        print(f"\nOpciones:")
        print("  1) Cambiar host (URL de la API)")
        print("  2) Cambiar número de usuarios")
        print("  3) Cambiar spawn rate")
        print("  4) Cambiar duración")
        print("  5) Cambiar número de workers")
        print("  6) Cargar configuración predefinida")
        print("  7) Ejecutar prueba con configuración actual")
        print("  8) Guardar y salir")
        print("  9) Salir sin guardar")
        print("="*50)
    
    def change_host(self):
        """Cambiar URL del host"""
        print(f"\nHost actual: {self.config['host']}")
        new_host = input("Nuevo host (ej: http://localhost:8000): ").strip()
        if new_host:
            self.config['host'] = new_host
            print(f"✓ Host actualizado a: {new_host}")
    
    def change_users(self):
        """Cambiar número de usuarios"""
        print(f"\nUsuarios actuales: {self.config['users']}")
        try:
            new_users = int(input("Nuevo número de usuarios: ").strip())
            if new_users > 0:
                self.config['users'] = new_users
                print(f"✓ Usuarios actualizados a: {new_users}")
            else:
                print("⚠ El número debe ser mayor a 0")
        except ValueError:
            print("⚠ Entrada inválida")
    
    def change_spawn_rate(self):
        """Cambiar spawn rate"""
        print(f"\nSpawn rate actual: {self.config['spawn_rate']}")
        try:
            new_rate = int(input("Nuevo spawn rate (usuarios/seg): ").strip())
            if new_rate > 0:
                self.config['spawn_rate'] = new_rate
                print(f"✓ Spawn rate actualizado a: {new_rate}")
            else:
                print("⚠ El número debe ser mayor a 0")
        except ValueError:
            print("⚠ Entrada inválida")
    
    def change_duration(self):
        """Cambiar duración"""
        print(f"\nDuración actual: {self.config['run_time']}")
        print("Ejemplos: 60s, 5m, 1h")
        new_duration = input("Nueva duración: ").strip()
        if new_duration:
            self.config['run_time'] = new_duration
            print(f"✓ Duración actualizada a: {new_duration}")
    
    def change_workers(self):
        """Cambiar número de workers"""
        print(f"\nWorkers actuales: {self.config['workers']}")
        try:
            new_workers = int(input("Nuevo número de workers (1=standalone): ").strip())
            if new_workers > 0:
                self.config['workers'] = new_workers
                print(f"✓ Workers actualizados a: {new_workers}")
            else:
                print("⚠ El número debe ser mayor a 0")
        except ValueError:
            print("⚠ Entrada inválida")
    
    def load_presets(self):
        """Carga configuraciones predefinidas"""
        print("\nConfiguraciones predefinidas:")
        print("  1) Prueba rápida (10 usuarios, 60s)")
        print("  2) Prueba media (50 usuarios, 5m)")
        print("  3) Prueba pesada (100 usuarios, 10m)")
        print("  4) Prueba de estrés (200 usuarios, 15m)")
        print("  5) Prueba de estabilidad (30 usuarios, 30m)")
        
        choice = input("\nSelecciona una opción (1-5): ").strip()
        
        presets = {
            "1": {"users": 10, "spawn_rate": 2, "run_time": "60s"},
            "2": {"users": 50, "spawn_rate": 5, "run_time": "300s"},
            "3": {"users": 100, "spawn_rate": 10, "run_time": "600s"},
            "4": {"users": 200, "spawn_rate": 20, "run_time": "900s"},
            "5": {"users": 30, "spawn_rate": 3, "run_time": "1800s"}
        }
        
        if choice in presets:
            self.config.update(presets[choice])
            print(f"✓ Configuración predefinida cargada")
            print(f"  Usuarios: {self.config['users']}")
            print(f"  Spawn rate: {self.config['spawn_rate']}")
            print(f"  Duración: {self.config['run_time']}")
    
    def run_test(self):
        """Ejecuta la prueba con configuración actual"""
        print("\nSelecciona tipo de prueba:")
        print("  1) Prueba completa (locustfile.py)")
        print("  2) Pruebas críticas (load_test_critical.py)")
        print("  3) Modo web interactivo")
        
        choice = input("\nOpción (1-3): ").strip()
        
        locustfile = {
            "1": "locustfile.py",
            "2": "load_test_critical.py",
            "3": None  # Para modo web
        }.get(choice, "locustfile.py")
        
        # Construir comando
        cmd = [
            "locust",
            "-f", locustfile,
            "--host", self.config['host'],
            "-u", str(self.config['users']),
            "-r", str(self.config['spawn_rate']),
        ]
        
        if choice != "3":  # No agregar duración para modo web
            cmd.extend(["--run-time", self.config['run_time']])
        
        print(f"\n{'='*50}")
        print(f"Iniciando prueba...")
        print(f"Comando: {' '.join(cmd)}")
        print(f"{'='*50}\n")
        
        try:
            subprocess.run(cmd, check=True)
        except FileNotFoundError:
            print("⚠ Locust no está instalado. Instálalo con: pip install -r requirements.txt")
        except KeyboardInterrupt:
            print("\n\nPrueba detenida por el usuario")
        except Exception as e:
            print(f"\n⚠ Error al ejecutar prueba: {e}")
    
    def run(self):
        """Loop principal"""
        self.load_config()
        
        while True:
            self.show_menu()
            choice = input("\nSelecciona una opción (1-9): ").strip()
            
            if choice == "1":
                self.change_host()
            elif choice == "2":
                self.change_users()
            elif choice == "3":
                self.change_spawn_rate()
            elif choice == "4":
                self.change_duration()
            elif choice == "5":
                self.change_workers()
            elif choice == "6":
                self.load_presets()
            elif choice == "7":
                self.run_test()
            elif choice == "8":
                self.save_config()
                print("✓ Configuración guardada. ¡Hasta luego!")
                break
            elif choice == "9":
                print("⚠ Configuración no guardada. ¡Hasta luego!")
                break
            else:
                print("⚠ Opción inválida")

if __name__ == "__main__":
    config = LocustConfig()
    try:
        config.run()
    except KeyboardInterrupt:
        print("\n\nPrograma interrumpido")
        sys.exit(0)
