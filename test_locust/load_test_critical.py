"""
Locust load tests para endpoints críticos de Artenity
Pruebas enfocadas en funcionalidades clave del sistema
"""

from locust import HttpUser, task, between, events
from locust.contrib.statistics import get_percentile, get_response_time_percentile
import json
import random
import time

class CriticalPathUser(HttpUser):
    """
    Usuario que simula un flujo crítico de uso:
    1. Registro/Login
    2. Ver publicaciones
    3. Interactuar (me gusta, comentarios)
    4. Crear publicaciones
    """
    wait_time = between(2, 5)
    
    def on_start(self):
        self.user_id = None
        self.token = None
        self.publications = []
        self.attempt_login()
    
    def attempt_login(self):
        """Intenta login con usuario existente o crea uno nuevo"""
        email = f"testuser{random.randint(1, 1000)}@test.com"
        password = "password123"
        
        # Primero intentamos login
        response = self.client.post(
            "/login",
            json={
                "correo_electronico": email,
                "contrasena": password
            },
            name="/login"
        )
        
        if response.status_code != 200:
            # Si falla, creamos nuevo usuario
            self.create_new_user(email, password)
    
    def create_new_user(self, email, password):
        """Crea nuevo usuario para pruebas"""
        user_data = {
            "nombre": "Test",
            "apellido": "User",
            "correo_electronico": email,
            "contrasena": password,
            "fecha_nacimiento": "1990-01-01",
            "genero": "M",
            "tipo_arte_preferido": "Pintura",
            "telefono": "+34600000000",
            "nombre_usuario": f"user{random.randint(10000, 99999)}"
        }
        
        response = self.client.post(
            "/usuarios",
            json=user_data,
            name="/usuarios"
        )
        
        if response.status_code == 200:
            # Intentar login con el nuevo usuario
            self.attempt_login()
    
    def get_headers(self):
        """Headers con autenticación"""
        return {
            "token": self.token or "test-token",
            "id_usuario": str(self.user_id or 1),
            "Content-Type": "application/json"
        }
    
    # ========== FLUJO CRÍTICO DE LECTURA ==========
    
    @task(10)
    def flujo_lectura_publicaciones(self):
        """
        Flujo principal de lectura:
        1. Obtener feed
        2. Ver detalles de publicación
        3. Ver comentarios
        """
        # Obtener feed
        response = self.client.get(
            "/publicaciones",
            headers=self.get_headers(),
            name="/publicaciones [feed]"
        )
        
        if response.status_code == 200:
            try:
                pubs = response.json()
                if pubs and len(pubs) > 0:
                    # Guardar publicaciones para tareas posteriores
                    self.publications = pubs[:5]
                    
                    # Ver detalles de una publicación aleatoria
                    pub = random.choice(self.publications)
                    pub_id = pub.get("id_publicacion")
                    
                    if pub_id:
                        # Obtener comentarios
                        self.client.get(
                            f"/comentarios/publicacion/{pub_id}",
                            headers=self.get_headers(),
                            name="/comentarios/publicacion/{id}"
                        )
                        
                        # Obtener estadísticas
                        self.client.get(
                            f"/publicaciones/{pub_id}/estadisticas",
                            headers=self.get_headers(),
                            name="/publicaciones/{id}/estadisticas"
                        )
            except:
                pass
    
    # ========== FLUJO CRÍTICO DE INTERACCIÓN ==========
    
    @task(8)
    def flujo_interaccion(self):
        """
        Flujo de interacción:
        1. Like a publicación
        2. Comentar
        3. Like a comentario
        """
        if not self.publications:
            return
        
        pub = random.choice(self.publications)
        pub_id = pub.get("id_publicacion")
        
        # Me gusta
        self.client.post(
            f"/me-gusta/{pub_id}",
            headers=self.get_headers(),
            name="/me-gusta/{id}"
        )
        
        # Comentar
        comment_data = {
            "id_usuario": self.user_id,
            "id_publicacion": pub_id,
            "contenido": f"Comentario de prueba {random.randint(1, 1000)}"
        }
        
        response = self.client.post(
            "/comentarios",
            json=comment_data,
            headers=self.get_headers(),
            name="/comentarios [crear]"
        )
        
        if response.status_code == 200:
            try:
                comment = response.json()
                comment_id = comment.get("id_comentario")
                
                # Like al comentario
                if comment_id:
                    self.client.post(
                        f"/me-gusta-comentario/{comment_id}",
                        headers=self.get_headers(),
                        name="/me-gusta-comentario/{id}"
                    )
            except:
                pass
    
    # ========== FLUJO CRÍTICO DE CREACIÓN ==========
    
    @task(3)
    def flujo_crear_publicacion(self):
        """Crear nueva publicación (tarea más costosa)"""
        if not self.user_id:
            return
        
        pub_data = {
            "id_usuario": str(self.user_id),
            "contenido": f"Nueva publicación #{random.randint(1, 10000)}",
            "etiquetas": json.dumps(["arte", "test"])
        }
        
        self.client.post(
            "/publicaciones",
            data=pub_data,
            headers={
                "token": self.token or "test-token",
                "id_usuario": str(self.user_id)
            },
            name="/publicaciones [crear]"
        )
    
    # ========== FLUJO CRÍTICO SOCIAL ==========
    
    @task(4)
    def flujo_social(self):
        """
        Interacción social:
        1. Seguir usuario
        2. Ver seguidores
        3. Obtener amigos
        """
        user_id = random.randint(1, 50)
        
        # Seguir
        self.client.post(
            f"/seguir/{user_id}",
            headers=self.get_headers(),
            name="/seguir/{id}"
        )
        
        # Ver seguidores del usuario
        self.client.get(
            f"/seguidores/{user_id}",
            headers=self.get_headers(),
            name="/seguidores/{id}"
        )
        
        # Ver amigos
        self.client.get(
            "/amigos",
            headers=self.get_headers(),
            name="/amigos"
        )
    
    # ========== FLUJO CRÍTICO DE BÚSQUEDA ==========
    
    @task(5)
    def flujo_busqueda_navegacion(self):
        """
        Búsqueda y navegación:
        1. Por categoría
        2. Por usuario
        3. Estadísticas
        """
        categoria = random.choice(["Pintura", "Escultura", "Fotografía"])
        user_id = random.randint(1, 50)
        
        # Por categoría
        self.client.get(
            f"/publicaciones/categoria/{categoria}",
            headers=self.get_headers(),
            name="/publicaciones/categoria/{name}"
        )
        
        # Publicaciones del usuario
        self.client.get(
            f"/publicaciones-usuario/{user_id}",
            headers=self.get_headers(),
            name="/publicaciones-usuario/{id}"
        )
        
        # Estadísticas del perfil
        self.client.get(
            f"/estadisticas-perfil/{user_id}",
            headers=self.get_headers(),
            name="/estadisticas-perfil/{id}"
        )


class AdminUser(HttpUser):
    """Usuario administrador para pruebas de operaciones admin"""
    wait_time = between(3, 7)
    
    def on_start(self):
        self.user_id = 1  # ID admin
        self.token = None
        self.login_admin()
    
    def login_admin(self):
        """Login como admin"""
        response = self.client.post(
            "/login",
            json={
                "correo_electronico": "admin@test.com",
                "contrasena": "admin123"
            },
            name="/login [admin]"
        )
        
        if response.status_code == 200:
            data = response.json()
            self.token = data.get("token")
            self.user_id = data.get("usuario", {}).get("id_usuario")
    
    def get_headers(self):
        return {
            "token": self.token or "test-token",
            "id_usuario": str(self.user_id or 1),
            "Content-Type": "application/json"
        }
    
    @task(3)
    def admin_monitoreo(self):
        """Operaciones de monitoreo admin"""
        # Obtener usuarios
        self.client.get(
            "/usuarios",
            headers=self.get_headers(),
            name="/usuarios [admin]"
        )
        
        # Ver notificaciones
        self.client.get(
            "/notificaciones",
            headers=self.get_headers(),
            name="/notificaciones [admin]"
        )
    
    @task(2)
    def admin_reportes(self):
        """Revisar reportes y estadísticas"""
        user_id = random.randint(1, 50)
        
        self.client.get(
            f"/estadisticas-perfil/{user_id}",
            headers=self.get_headers(),
            name="/estadisticas-perfil/{id} [admin]"
        )


@events.test_start.add_listener
def on_test_start(environment, **kwargs):
    """Se ejecuta al iniciar la prueba"""
    print("\n" + "="*50)
    print("Iniciando prueba de carga - Artenity")
    print("="*50 + "\n")


@events.test_stop.add_listener
def on_test_stop(environment, **kwargs):
    """Se ejecuta al finalizar la prueba"""
    print("\n" + "="*50)
    print("Prueba finalizada")
    print("="*50)
    
    # Mostrar estadísticas resumen
    print("\nEstadísticas resumen:")
    for method, stats in environment.stats.entries.items():
        if stats.num_requests > 0:
            print(f"\n{method[0]} {method[1]}")
            print(f"  Total requests: {stats.num_requests}")
            print(f"  Failures: {stats.num_failures}")
            print(f"  Success rate: {stats.fail_ratio * 100:.2f}%")
            print(f"  Avg response time: {stats.avg_response_time:.2f}ms")
            print(f"  Min: {stats.min_response_time:.2f}ms")
            print(f"  Max: {stats.max_response_time:.2f}ms")
