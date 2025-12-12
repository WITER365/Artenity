from locust import HttpUser, task, between
import json
import random
from datetime import datetime

class ArtenityUser(HttpUser):
    wait_time = between(1, 3)
    
    def on_start(self):
        """Se ejecuta antes de empezar las tareas"""
        self.user_id = None
        self.token = None
        self.publication_id = None
        self.comment_id = None
        self.friend_id = None
        self.login()
    
    def login(self):
        """Realiza login y obtiene token"""
        # Intentar login con usuario existente
        login_data = {
            "correo_electronico": f"testuser{random.randint(1, 100)}@example.com",
            "contrasena": "password123"
        }
        
        response = self.client.post(
            "/login",
            json=login_data,
            headers={"Content-Type": "application/json"}
        )
        
        if response.status_code == 200:
            data = response.json()
            self.token = data.get("token")
            self.user_id = data.get("usuario", {}).get("id_usuario")
    
    def get_headers(self):
        """Retorna headers con token e id_usuario"""
        return {
            "token": self.token or "test-token",
            "id_usuario": str(self.user_id or 1),
            "Content-Type": "application/json"
        }
    
    # ==================== USUARIOS ====================
    
    @task(2)
    def crear_usuario(self):
        """Crear nuevo usuario"""
        unique_email = f"newuser{random.randint(10000, 99999)}@example.com"
        user_data = {
            "nombre": "Test",
            "apellido": "User",
            "correo_electronico": unique_email,
            "contrasena": "password123",
            "fecha_nacimiento": "1990-01-01",
            "genero": "M",
            "tipo_arte_preferido": "Pintura",
            "telefono": "+34600000000",
            "nombre_usuario": f"testuser{random.randint(10000, 99999)}"
        }
        
        self.client.post(
            "/usuarios",
            json=user_data,
            headers={"Content-Type": "application/json"}
        )
    
    @task(1)
    def obtener_usuarios(self):
        """Obtener lista de usuarios"""
        self.client.get(
            "/usuarios",
            headers=self.get_headers()
        )
    
    # ==================== PERFILES ====================
    
    @task(3)
    def obtener_perfil(self):
        """Obtener perfil de usuario"""
        user_id = random.randint(1, 50)
        self.client.get(
            f"/perfiles/{user_id}",
            headers=self.get_headers()
        )
    
    @task(2)
    def actualizar_perfil(self):
        """Actualizar perfil de usuario"""
        if not self.user_id:
            return
        
        profile_data = {
            "descripcion": f"Artista apasionado por {random.choice(['pintura', 'escultura', 'fotografía'])}",
            "biografia": "Descripción biografía del artista"
        }
        
        self.client.put(
            f"/perfiles/{self.user_id}",
            data=profile_data,
            headers={
                "token": self.token or "test-token",
                "id_usuario": str(self.user_id)
            }
        )
    
    # ==================== PUBLICACIONES ====================
    
    @task(5)
    def crear_publicacion(self):
        """Crear nueva publicación"""
        if not self.user_id:
            return
        
        pub_data = {
            "id_usuario": str(self.user_id),
            "contenido": f"Contenido de publicación #{random.randint(1, 1000)}",
            "etiquetas": json.dumps(["arte", "cultura"])
        }
        
        response = self.client.post(
            "/publicaciones",
            data=pub_data,
            headers={
                "token": self.token or "test-token",
                "id_usuario": str(self.user_id)
            }
        )
        
        if response.status_code == 200:
            data = response.json()
            self.publication_id = data.get("id_publicacion")
    
    @task(8)
    def obtener_publicaciones(self):
        """Obtener feed de publicaciones"""
        self.client.get(
            "/publicaciones",
            headers=self.get_headers()
        )
    
    @task(3)
    def obtener_publicaciones_por_categoria(self):
        """Obtener publicaciones de categoría"""
        categoria = random.choice(["Pintura", "Escultura", "Fotografía", "Danza"])
        self.client.get(
            f"/publicaciones/categoria/{categoria}",
            headers=self.get_headers()
        )
    
    @task(2)
    def eliminar_publicacion(self):
        """Eliminar publicación"""
        if not self.publication_id:
            return
        
        self.client.delete(
            f"/publicaciones/{self.publication_id}",
            headers=self.get_headers()
        )
    
    @task(3)
    def obtener_publicaciones_usuario(self):
        """Obtener publicaciones de usuario específico"""
        user_id = random.randint(1, 50)
        self.client.get(
            f"/publicaciones-usuario/{user_id}",
            headers=self.get_headers()
        )
    
    # ==================== LIKES Y GUARDADOS ====================
    
    @task(6)
    def me_gusta_publicacion(self):
        """Dar like a publicación"""
        pub_id = random.randint(1, 100)
        self.client.post(
            f"/me-gusta/{pub_id}",
            headers=self.get_headers()
        )
    
    @task(4)
    def quitar_me_gusta(self):
        """Quitar like de publicación"""
        pub_id = random.randint(1, 100)
        self.client.delete(
            f"/me-gusta/{pub_id}",
            headers=self.get_headers()
        )
    
    @task(4)
    def guardar_publicacion(self):
        """Guardar publicación"""
        pub_id = random.randint(1, 100)
        self.client.post(
            f"/guardar/{pub_id}",
            headers=self.get_headers()
        )
    
    @task(3)
    def obtener_guardados(self):
        """Obtener publicaciones guardadas"""
        self.client.get(
            "/guardados",
            headers=self.get_headers()
        )
    
    # ==================== COMENTARIOS ====================
    
    @task(4)
    def crear_comentario(self):
        """Crear comentario en publicación"""
        pub_id = random.randint(1, 100)
        comment_data = {
            "id_usuario": self.user_id,
            "id_publicacion": pub_id,
            "contenido": f"Comentario interesante #{random.randint(1, 1000)}"
        }
        
        response = self.client.post(
            "/comentarios",
            json=comment_data,
            headers=self.get_headers()
        )
        
        if response.status_code == 200:
            data = response.json()
            self.comment_id = data.get("id_comentario")
    
    @task(5)
    def obtener_comentarios(self):
        """Obtener comentarios de publicación"""
        pub_id = random.randint(1, 100)
        self.client.get(
            f"/comentarios/publicacion/{pub_id}",
            headers=self.get_headers()
        )
    
    @task(3)
    def eliminar_comentario(self):
        """Eliminar comentario"""
        if not self.comment_id:
            return
        
        self.client.delete(
            f"/comentarios/{self.comment_id}",
            headers=self.get_headers()
        )
    
    # ==================== SEGUIR ====================
    
    @task(3)
    def seguir_usuario(self):
        """Seguir usuario"""
        user_id = random.randint(1, 50)
        self.client.post(
            f"/seguir/{user_id}",
            headers=self.get_headers()
        )
    
    @task(2)
    def dejar_seguir(self):
        """Dejar de seguir usuario"""
        user_id = random.randint(1, 50)
        self.client.delete(
            f"/dejar-seguir/{user_id}",
            headers=self.get_headers()
        )
    
    @task(3)
    def obtener_seguidores(self):
        """Obtener seguidores"""
        self.client.get(
            "/seguidores",
            headers=self.get_headers()
        )
    
    @task(2)
    def obtener_siguiendo(self):
        """Obtener seguidos"""
        self.client.get(
            "/siguiendo",
            headers=self.get_headers()
        )
    
    @task(2)
    def obtener_seguidores_usuario(self):
        """Obtener seguidores de usuario"""
        user_id = random.randint(1, 50)
        self.client.get(
            f"/seguidores/{user_id}",
            headers=self.get_headers()
        )
    
    @task(2)
    def obtener_siguiendo_usuario(self):
        """Obtener seguidos por usuario"""
        user_id = random.randint(1, 50)
        self.client.get(
            f"/siguiendo/{user_id}",
            headers=self.get_headers()
        )
    
    # ==================== AMISTAD ====================
    
    @task(2)
    def enviar_solicitud_amistad(self):
        """Enviar solicitud de amistad"""
        user_id = random.randint(1, 50)
        self.client.post(
            f"/amistad/{user_id}",
            headers=self.get_headers()
        )
    
    @task(2)
    def obtener_solicitudes_amistad(self):
        """Obtener solicitudes de amistad pendientes"""
        self.client.get(
            "/solicitudes-amistad",
            headers=self.get_headers()
        )
    
    @task(1)
    def aceptar_solicitud_amistad(self):
        """Aceptar solicitud de amistad"""
        request_id = random.randint(1, 50)
        self.client.put(
            f"/amistad/{request_id}",
            headers=self.get_headers()
        )
    
    @task(2)
    def obtener_amigos(self):
        """Obtener lista de amigos"""
        self.client.get(
            "/amigos",
            headers=self.get_headers()
        )
    
    @task(1)
    def eliminar_amigo(self):
        """Eliminar amigo"""
        friend_id = random.randint(1, 50)
        self.client.delete(
            f"/amigos/{friend_id}",
            headers=self.get_headers()
        )
    
    # ==================== NOTIFICACIONES ====================
    
    @task(3)
    def obtener_notificaciones(self):
        """Obtener notificaciones"""
        self.client.get(
            "/notificaciones",
            headers=self.get_headers()
        )
    
    @task(2)
    def marcar_notificaciones_leidas(self):
        """Marcar notificaciones como leídas"""
        self.client.put(
            "/notificaciones/leidas",
            headers=self.get_headers()
        )
    
    # ==================== ESTADÍSTICAS ====================
    
    @task(2)
    def obtener_estadisticas_perfil(self):
        """Obtener estadísticas del perfil"""
        user_id = random.randint(1, 50)
        self.client.get(
            f"/estadisticas-perfil/{user_id}",
            headers=self.get_headers()
        )
    
    @task(2)
    def obtener_estadisticas_publicacion(self):
        """Obtener estadísticas de publicación"""
        pub_id = random.randint(1, 100)
        self.client.get(
            f"/publicaciones/{pub_id}/estadisticas",
            headers=self.get_headers()
        )
    
    @task(1)
    def obtener_estadisticas_me_gustas(self):
        """Obtener estadísticas de me gustas recibidos"""
        user_id = random.randint(1, 50)
        self.client.get(
            f"/estadisticas-me-gustas/{user_id}",
            headers=self.get_headers()
        )
    
    # ==================== BLOQUEOS ====================
    
    @task(1)
    def bloquear_usuario(self):
        """Bloquear usuario"""
        user_id = random.randint(1, 50)
        self.client.post(
            f"/bloquear/{user_id}",
            headers=self.get_headers()
        )
    
    @task(1)
    def obtener_usuarios_bloqueados(self):
        """Obtener usuarios bloqueados"""
        self.client.get(
            "/usuarios-bloqueados",
            headers=self.get_headers()
        )
    
    @task(1)
    def desbloquear_usuario(self):
        """Desbloquear usuario"""
        user_id = random.randint(1, 50)
        self.client.delete(
            f"/desbloquear/{user_id}",
            headers=self.get_headers()
        )
    
    # ==================== REPORTES ====================
    
    @task(1)
    def reportar_usuario(self):
        """Reportar usuario"""
        user_id = random.randint(1, 50)
        report_data = {
            "razon": random.choice(["Contenido inapropiado", "Acoso", "Spam", "Otro"])
        }
        self.client.post(
            f"/reportar/{user_id}",
            json=report_data,
            headers=self.get_headers()
        )
    
    # ==================== COMPARTIR ====================
    
    @task(2)
    def compartir_publicacion(self):
        """Compartir publicación"""
        pub_id = random.randint(1, 100)
        share_data = {
            "id_usuario_receptor": random.randint(1, 50)
        }
        self.client.post(
            f"/compartir/{pub_id}",
            json=share_data,
            headers=self.get_headers()
        )
    
    @task(2)
    def obtener_compartidos(self):
        """Obtener publicaciones compartidas"""
        self.client.get(
            "/compartidos",
            headers=self.get_headers()
        )
    
    # ==================== NO ME INTERESA ====================
    
    @task(2)
    def marcar_no_me_interesa(self):
        """Marcar publicación como 'no me interesa'"""
        pub_id = random.randint(1, 100)
        self.client.post(
            f"/no-me-interesa/{pub_id}",
            headers=self.get_headers()
        )
    
    @task(1)
    def obtener_no_me_interesa(self):
        """Obtener publicaciones marcadas como 'no me interesa'"""
        self.client.get(
            "/no-me-interesa",
            headers=self.get_headers()
        )
    
    @task(1)
    def quitar_no_me_interesa(self):
        """Quitar marcado 'no me interesa'"""
        pub_id = random.randint(1, 100)
        self.client.delete(
            f"/quitar-no-me-interesa/{pub_id}",
            headers=self.get_headers()
        )
