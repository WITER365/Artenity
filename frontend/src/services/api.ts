// frontend/services/api.ts
import axios from "axios";
import { Usuario } from "../context/AuthContext";

// ================== CONFIGURACIÓN ==================
const API_URL = "http://localhost:8000";

const api = axios.create({
    baseURL: API_URL,
    headers: { 
        "Content-Type": "application/json",
        "Accept": "application/json"
    },
});

// Interceptor para manejar errores 401
api.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error.response?.status === 401) {
            console.error("Error 401: No autorizado. Verifica que estés autenticado.");
            // Opcional: redirigir al login
            // window.location.href = "/login";
        }
        return Promise.reject(error);
    }
);

// ======== UTILIDADES ========
function getToken(): string {
  const token = localStorage.getItem("token");
  // Si no hay token, no lances error, devuelve string vacío
  return token || "";
}

function getUsuarioId(): number | null {
  try {
    const usuario = localStorage.getItem("usuario");
    if (!usuario) return null;
    const parsed = JSON.parse(usuario);
    return parsed.id_usuario || null;
  } catch (error) {
    console.error("Error obteniendo ID de usuario:", error);
    return null;
  }
}

function getAuthHeaders() {
  const token = getToken();
  const usuarioId = getUsuarioId();
  
  if (!token || !usuarioId) {
    console.warn("Token o usuario ID no disponible. Headers de autenticación incompletos.");
  }
  
  return {
    "token": token || "",
    "id_usuario": usuarioId ? usuarioId.toString() : "",
  };
}

// ================== USUARIOS ==================
export async function getUsuarios(): Promise<Usuario[]> {
  const res = await api.get("/usuarios", { headers: getAuthHeaders() });
  return res.data;
}

export async function addUsuario(usuario: any): Promise<Usuario> {
  const res = await api.post("/usuarios", usuario);
  return res.data;
}

export async function deleteUsuario(id: number): Promise<Usuario> {
  const res = await api.delete(`/usuarios/${id}`);
  return res.data;
}

export async function registerUsuario(usuario: any): Promise<Usuario> {
  return addUsuario(usuario);
}

// ================== LOGIN / SESIÓN ==================
// ================== LOGIN / SESIÓN ==================
export async function loginUsuario(correo_electronico: string, contrasena: string) {
  try {
    const res = await api.post("/login", { correo_electronico, contrasena });
    
    if (res.data && res.data.token && res.data.usuario) {
      const { token, usuario } = res.data;
      localStorage.setItem("token", token);
      localStorage.setItem("usuario", JSON.stringify(usuario));
      return { token, usuario };
    } else {
      throw new Error("Respuesta del servidor inválida");
    }
  } catch (error: any) {
    if (error.response) {
      // El servidor respondió con un código de error
      throw new Error(error.response.data.detail || "Error en el inicio de sesión");
    } else if (error.request) {
      // La solicitud fue hecha pero no se recibió respuesta
      throw new Error("No se pudo conectar con el servidor");
    } else {
      // Algo pasó al configurar la solicitud
      throw new Error("Error al configurar la solicitud");
    }
  }
}

// ================== PERFILES ==================
export async function getPerfil(id_usuario: number) {
  const res = await api.get(`/perfiles/${id_usuario}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function actualizarPerfil(id_usuario: number, data: FormData) {
  const res = await api.put(`/perfiles/${id_usuario}`, data, {
    headers: {
      ...getAuthHeaders(),
      "Content-Type": "multipart/form-data",
    },
  });
  return res.data;
}

// ================== PUBLICACIONES ==================
export async function crearPublicacion(data: FormData) {
  const res = await api.post("/publicaciones", data, {
    headers: {
      ...getAuthHeaders(),
      "Content-Type": "multipart/form-data",
    },
  });
  return res.data;
}

export async function getPublicaciones() {
  const res = await api.get("/publicaciones", { headers: getAuthHeaders() });
  return res.data;
}

export async function eliminarPublicacion(id_publicacion: number) {
  const res = await api.delete(`/publicaciones/${id_publicacion}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function obtenerPublicacionesUsuario(id_usuario: number) {
  const res = await api.get(`/publicaciones-usuario/${id_usuario}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

// ================== RELACIONES SOCIALES ==================
export async function seguirUsuario(id_seguido: number) {
  const res = await api.post(`/seguir/${id_seguido}`, null, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function dejarDeSeguirUsuario(id_seguido: number) {
  const res = await api.delete(`/dejar-seguir/${id_seguido}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function obtenerSeguidores() {
  const res = await api.get("/seguidores", { headers: getAuthHeaders() });
  return res.data;
}

export async function obtenerSeguidoresUsuario(id_usuario: number) {
  const res = await api.get(`/seguidores/${id_usuario}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function obtenerSiguiendo() {
  const res = await api.get("/siguiendo", { headers: getAuthHeaders() });
  return res.data;
}

export async function obtenerSiguiendoUsuario(id_usuario: number) {
  const res = await api.get(`/siguiendo/${id_usuario}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

// Verificar si un usuario sigue a otro
export async function verificarSiSigueUsuario(idUsuarioSeguido: number): Promise<boolean> {
  const res = await api.get(`/verificar-seguimiento/${idUsuarioSeguido}`, {
    headers: getAuthHeaders(),
  });
  return res.data.sigue;
}

// ================== AMISTADES ==================
export async function enviarSolicitudAmistad(id_receptor: number) {
  const res = await api.post(`/amistad/${id_receptor}`, null, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function responderSolicitudAmistad(id_solicitud: number, estado: string) {
  const formData = new FormData();
  formData.append("estado", estado);

  const res = await api.put(`/amistad/${id_solicitud}`, formData, {
    headers: {
      ...getAuthHeaders(),
      "Content-Type": "multipart/form-data",
    },
  });
  return res.data;
}

export async function obtenerSolicitudesPendientes() {
  const res = await api.get("/solicitudes-amistad", { headers: getAuthHeaders() });
  return res.data;
}

export async function obtenerAmigos(id_usuario?: number) {
  const url = id_usuario ? `/amigos?id_usuario=${id_usuario}` : "/amigos";
  const res = await api.get(url, { headers: getAuthHeaders() });
  return res.data;
}

export async function eliminarAmigo(id_amigo: number) {
  const res = await api.delete(`/amigos/${id_amigo}`, { headers: getAuthHeaders() });
  return res.data;
}

// ================== NOTIFICACIONES ==================
export async function getNotificaciones() {
  const res = await api.get("/notificaciones", { headers: getAuthHeaders() });
  return res.data;
}

export async function marcarNotificacionesLeidas() {
  const res = await api.put("/notificaciones/leidas", {}, { headers: getAuthHeaders() });
  return res.data;
}

// ================== REPORTES ==================
export async function reportarUsuario(id_reportado: number, motivo: string, evidencia?: File) {
  const formData = new FormData();
  formData.append("motivo", motivo);
  if (evidencia) formData.append("evidencia", evidencia);

  const res = await api.post(`/reportar/${id_reportado}`, formData, {
    headers: {
      ...getAuthHeaders(),
      "Content-Type": "multipart/form-data",
    },
  });

  return res.data;
}

// ================== CATEGORÍAS ==================
export async function obtenerCategorias() {
  const res = await api.get("/categorias");
  return res.data;
}

// ================== ESTADÍSTICAS ==================
export async function obtenerEstadisticasPerfil(id_usuario: number) {
  const res = await api.get(`/estadisticas-perfil/${id_usuario}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export const obtenerEstadisticasMeGustas = async (idusuario: number) => {
  const res = await api.get(`/estadisticas-me-gustas/${idusuario}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
};

// ================== RECUPERACIÓN DE CONTRASEÑA ==================
export async function solicitarRecuperacion(correo: string) {
  const res = await api.post("/olvidaste-contrasena", { correo });
  return res.data;
}

export async function restablecerContrasena(token: string, nueva_contrasena: string) {
  const res = await api.post("/restablecer-contrasena", { token, nueva_contrasena });
  return res.data;
}

// ================== BLOQUEAR / DESBLOQUEAR ==================
export async function bloquearUsuario(id_usuario_bloqueado: number) {
  const res = await api.post(`/bloquear/${id_usuario_bloqueado}`, null, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function desbloquearUsuario(id_usuario_bloqueado: number) {
  const res = await api.delete(`/desbloquear/${id_usuario_bloqueado}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function obtenerUsuariosBloqueados() {
  const res = await api.get("/usuarios-bloqueados", { headers: getAuthHeaders() });
  return res.data;
}

// ================== NO ME INTERESA ==================
export async function noMeInteresa(id_publicacion: number) {
  const res = await api.post(`/no-me-interesa/${id_publicacion}`, null, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function obtenerNoMeInteresa() {
  const res = await api.get("/no-me-interesa", { headers: getAuthHeaders() });
  return res.data;
}

export async function quitarNoMeInteresa(id_publicacion: number) {
  const res = await api.delete(`/quitar-no-me-interesa/${id_publicacion}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

// ================== REACCIONES, COMENTARIOS Y GUARDADOS ==================
export async function darMeGusta(idPublicacion: number) {
  const res = await api.post(`/me-gusta/${idPublicacion}`, null, { headers: getAuthHeaders() });
  return res.data;
}

export async function quitarMeGusta(idPublicacion: number) {
  const res = await api.delete(`/me-gusta/${idPublicacion}`, { headers: getAuthHeaders() });
  return res.data;
}

export async function guardarPublicacion(idPublicacion: number) {
  const res = await api.post(`/guardar/${idPublicacion}`, null, { headers: getAuthHeaders() });
  return res.data;
}

export async function quitarGuardado(idPublicacion: number) {
  const res = await api.delete(`/guardar/${idPublicacion}`, { headers: getAuthHeaders() });
  return res.data;
}

// ======== COMENTARIOS ========
export interface ComentarioData {
  contenido: string;
  id_publicacion: number;
  id_comentario_padre?: number | null;
}

export async function crearComentario(comentarioData: ComentarioData) {
  const res = await api.post("/comentarios", comentarioData, { headers: getAuthHeaders() });
  return res.data;
}

export async function obtenerComentarios(idPublicacion: number) {
  const res = await api.get(`/comentarios/publicacion/${idPublicacion}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function obtenerPublicacionDeComentario(idComentario: number) {
  const res = await api.get(`/comentarios/${idComentario}/publicacion`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function eliminarComentario(idComentario: number) {
  const res = await api.delete(`/comentarios/${idComentario}`, { headers: getAuthHeaders() });
  return res.data;
}

// ======== ME GUSTA COMENTARIOS ========
export async function darMeGustaComentario(idComentario: number) {
  const res = await api.post(`/me-gusta-comentario/${idComentario}`, null, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

export async function quitarMeGustaComentario(idComentario: number) {
  const res = await api.delete(`/me-gusta-comentario/${idComentario}`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

// ======== ESTADÍSTICAS PUBLICACIONES ========
export async function obtenerEstadisticasPublicacion(idPublicacion: number) {
  const res = await api.get(`/publicaciones/${idPublicacion}/estadisticas`, {
    headers: getAuthHeaders(),
  });
  return res.data;
}

// ======== GUARDADOS ========
export async function obtenerPublicacionesGuardadas() {
  const res = await api.get("/guardados", { headers: getAuthHeaders() });
  return res.data;
}

// ======== ALIASES COMPATIBILIDAD ========
export const getSolicitudesAmistad = obtenerSolicitudesPendientes;
export const getAmigos = obtenerAmigos;
export const getCategorias = obtenerCategorias;


// ================== COMPARTIR PUBLICACIONES ==================
export async function obtenerPublicacionesCompartidas() {
  try {
    const res = await api.get("/compartidos", { 
      headers: getAuthHeaders() 
    });
    return res.data;
  } catch (error) {
    console.error("Error obteniendo publicaciones compartidas:", error);
    throw error;
  }
}

export async function obtenerPublicacionesCompartidasAmigos() {
  try {
    const res = await api.get("/compartidos/amigos", {
      headers: getAuthHeaders(),
    });
    return res.data;
  } catch (error) {
    console.error("Error obteniendo compartidos de amigos:", error);
    throw error;
  }
}

export async function obtenerMisCompartidos() {
  try {
    const res = await api.get("/compartidos/mis-compartidos", {
      headers: getAuthHeaders(),
    });
    return res.data;
  } catch (error) {
    console.error("Error obteniendo mis compartidos:", error);
    throw error;
  }
}

export async function obtenerCompartidoPorId(idCompartido: number) {
  if (!idCompartido || isNaN(idCompartido)) {
    throw new Error("ID de compartido inválido");
  }
  
  try {
    const res = await api.get(`/compartidos/detalle/${idCompartido}`, {
      headers: getAuthHeaders(),
    });
    return res.data;
  } catch (error) {
    console.error(`Error obteniendo compartido ${idCompartido}:`, error);
    throw error;
  }
}

export async function compartirPublicacion(
  idPublicacion: number, 
  mensaje?: string, 
  tipo: string = "perfil", 
  amigosIds?: number[]
) {
  try {
    const formData = new FormData();
    if (mensaje) formData.append("mensaje", mensaje);
    formData.append("tipo", tipo);
    
    if (tipo === "amigos" && amigosIds && amigosIds.length > 0) {
      formData.append("amigos_ids", amigosIds.join(","));
    }

    const res = await api.post(`/compartir/${idPublicacion}`, formData, {
      headers: {
        ...getAuthHeaders(),
        "Content-Type": "multipart/form-data",
      },
    });
    return res.data;
  } catch (error) {
    console.error("Error compartiendo publicación:", error);
    throw error;
  }
}

export async function eliminarCompartido(idCompartido: number) {
  try {
    const res = await api.delete(`/compartidos/${idCompartido}`, { 
      headers: getAuthHeaders() 
    });
    return res.data;
  } catch (error) {
    console.error("Error eliminando compartido:", error);
    throw error;
  }
}

// ================== DIAGNÓSTICO DE CONEXIÓN ==================
export async function diagnosticoConexion() {
  console.log("🔍 Iniciando diagnóstico de conexión...");
  
  try {
    // 1. Verificar si el backend responde
    console.log("1. Probando conexión con el backend...");
    const health = await fetch("http://127.0.0.1:8000/health");
    console.log("✅ Backend responde:", health.status);
    
    // 2. Verificar autenticación
    console.log("2. Verificando autenticación...");
    const token = localStorage.getItem("token");
    const usuario = localStorage.getItem("usuario");
    console.log("✅ Token:", token ? "PRESENTE" : "FALTANTE");
    console.log("✅ Usuario:", usuario ? "PRESENTE" : "FALTANTE");
    
    // 3. Probar endpoint de compartidos
    console.log("3. Probando endpoint de compartidos...");
    const compartidos = await obtenerPublicacionesCompartidasAmigos();
    console.log("✅ Compartidos cargados:", compartidos.length);
    
    return { exito: true, mensaje: "Conexión exitosa" };
  } catch (error: any) {
    console.error("❌ Error en diagnóstico:", error);
    return { exito: false, mensaje: error.message };
  }
}