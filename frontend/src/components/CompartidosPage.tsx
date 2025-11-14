// src/pages/CompartidosPage.tsx
import { useEffect, useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { 
  ArrowLeft, 
  Heart, 
  MessageCircle, 
  Bookmark, 
  Share2, 
  MoreVertical,
  Users,
  X
} from "lucide-react";
import "../styles/compartidos.css";
import defaultProfile from "../assets/img/fotoperfildefault.jpg";
import { 
  obtenerPublicacionesCompartidasAmigos,
  obtenerPublicacionesCompartidas,
  eliminarCompartido,
  darMeGusta, 
  quitarMeGusta, 
  guardarPublicacion, 
  quitarGuardado,
  obtenerEstadisticasPublicacion,
  crearComentario,
  obtenerComentarios
} from "../services/api";
import { useAuth } from "../context/AuthContext";

// Interfaces
interface Usuario {
  id_usuario: number;
  nombre_usuario: string;
  foto_perfil?: string;
}

interface Publicacion {
  id_publicacion: number;
  contenido: string;
  imagen_url?: string;
  usuario: Usuario;
  fecha_creacion: string;
}

interface Compartido {
  id_compartido: number;
  publicacion: Publicacion;
  usuario_compartio: Usuario;
  fecha_compartido: string;
  mensaje?: string;
}

interface EstadisticasPublicacion {
  me_gusta: number;
  comentarios: number;
  compartidos: number;
  usuario_dio_me_gusta: boolean;
  usuario_guardo: boolean;
}

// 🔹 INTERFAZ PARA COMENTARIOS RECIBIDOS DEL BACKEND
interface ComentarioData {
  id_comentario: number;
  contenido: string;
  usuario: Usuario;
  fecha_creacion: string;
  respuestas?: ComentarioData[];
}

// 🔹 NUEVA INTERFAZ PARA ENVIAR COMENTARIOS A LA API
interface NuevoComentarioData {
  contenido: string;
  id_publicacion: number;
  id_comentario_padre?: number | null;
}

export default function CompartidosPage() {
  const navigate = useNavigate();
  const location = useLocation();
  const { usuario } = useAuth();
  
  // 🔹 Nuevo estado para compartir desde notificaciones
  const [compartidoEspecifico, setCompartidoEspecifico] = useState<Compartido | null>(null);

  const [compartidosAmigos, setCompartidosAmigos] = useState<Compartido[]>([]);
  const [misCompartidos, setMisCompartidos] = useState<Compartido[]>([]);
  const [pestanaActiva, setPestanaActiva] = useState<'amigos' | 'mis-compartidos'>('amigos');
  const [cargando, setCargando] = useState(true);
  const [estadisticas, setEstadisticas] = useState<{[key: number]: EstadisticasPublicacion}>({});
  const [comentariosAbiertos, setComentariosAbiertos] = useState<{[key: number]: boolean}>({});
  const [nuevoComentario, setNuevoComentario] = useState<{[key: number]: string}>({});
  const [comentarios, setComentarios] = useState<{[key: number]: ComentarioData[]}>({});

  // 🔹 Detectar si viene un compartido individual desde notificaciones
  useEffect(() => {
    if (location.state?.compartidoEspecifico) {
      setCompartidoEspecifico(location.state.compartidoEspecifico);
      // Limpiar el estado de navegación
      window.history.replaceState({}, document.title);
    }
  }, [location.state]);

  // 🔹 Definir la lista correcta a mostrar
  const compartidosParaMostrar = compartidoEspecifico
    ? [compartidoEspecifico]
    : (pestanaActiva === 'amigos' ? compartidosAmigos : misCompartidos);

  // Carga de datos
  const cargarDatos = async () => {
    try {
      setCargando(true);
      await Promise.all([
        cargarCompartidosAmigos(),
        cargarMisCompartidos()
      ]);
    } catch (error) {
      console.error("Error cargando compartidos:", error);
    } finally {
      setCargando(false);
    }
  };

  const cargarCompartidosAmigos = async () => {
    try {
      const data = await obtenerPublicacionesCompartidasAmigos();
      setCompartidosAmigos(data);
      
      data.forEach((compartido: Compartido) => {
        cargarEstadisticas(compartido.publicacion.id_publicacion);
      });
    } catch (error) {
      console.error("Error cargando compartidos de amigos:", error);
    }
  };

  const cargarMisCompartidos = async () => {
    try {
      const data = await obtenerPublicacionesCompartidas();
      setMisCompartidos(data);
    } catch (error) {
      console.error("Error cargando mis compartidos:", error);
    }
  };

  const cargarEstadisticas = async (idPublicacion: number) => {
    try {
      const stats = await obtenerEstadisticasPublicacion(idPublicacion);
      setEstadisticas(prev => ({ ...prev, [idPublicacion]: stats }));
    } catch (error) {
      console.error("Error cargando estadísticas:", error);
    }
  };

  const cargarComentarios = async (idPublicacion: number) => {
    try {
      const comentariosData = await obtenerComentarios(idPublicacion);
      setComentarios(prev => ({ ...prev, [idPublicacion]: comentariosData }));
    } catch (error) {
      console.error("Error cargando comentarios:", error);
    }
  };

  // Manejo de acciones
  const handleMeGusta = async (idPublicacion: number) => {
    try {
      const stats = estadisticas[idPublicacion];
      if (stats.usuario_dio_me_gusta) {
        await quitarMeGusta(idPublicacion);
        setEstadisticas(prev => ({
          ...prev,
          [idPublicacion]: {
            ...stats,
            me_gusta: stats.me_gusta - 1,
            usuario_dio_me_gusta: false
          }
        }));
      } else {
        await darMeGusta(idPublicacion);
        setEstadisticas(prev => ({
          ...prev,
          [idPublicacion]: {
            ...stats,
            me_gusta: stats.me_gusta + 1,
            usuario_dio_me_gusta: true
          }
        }));
      }
    } catch (error) {
      console.error("Error al manejar me gusta:", error);
    }
  };

  const handleGuardar = async (idPublicacion: number) => {
    try {
      const stats = estadisticas[idPublicacion];
      if (stats.usuario_guardo) {
        await quitarGuardado(idPublicacion);
        setEstadisticas(prev => ({
          ...prev,
          [idPublicacion]: {
            ...stats,
            usuario_guardo: false
          }
        }));
      } else {
        await guardarPublicacion(idPublicacion);
        setEstadisticas(prev => ({
          ...prev,
          [idPublicacion]: {
            ...stats,
            usuario_guardo: true
          }
        }));
      }
    } catch (error) {
      console.error("Error al manejar guardado:", error);
    }
  };

  const toggleComentarios = async (idPublicacion: number) => {
    const nuevoEstado = !comentariosAbiertos[idPublicacion];
    setComentariosAbiertos(prev => ({ ...prev, [idPublicacion]: nuevoEstado }));
    
    if (nuevoEstado && !comentarios[idPublicacion]) {
      await cargarComentarios(idPublicacion);
    }
  };

  // 🔹 FUNCIÓN CORREGIDA - publicarComentario
  const publicarComentario = async (idPublicacion: number) => {
    try {
      const comentario = nuevoComentario[idPublicacion]?.trim();
      if (!comentario) return;

      // Crear el objeto correcto que pide la API
      const comentarioData: NuevoComentarioData = {
        contenido: comentario,
        id_publicacion: idPublicacion
      };

      // Enviar solo un objeto como argumento
      await crearComentario(comentarioData);

      // Vaciar input
      setNuevoComentario(prev => ({ ...prev, [idPublicacion]: '' }));

      // Recargar comentarios
      await cargarComentarios(idPublicacion);

      // Actualizar contador local
      const stats = estadisticas[idPublicacion];
      if (stats) {
        setEstadisticas(prev => ({
          ...prev,
          [idPublicacion]: {
            ...stats,
            comentarios: stats.comentarios + 1
          }
        }));
      }

    } catch (error) {
      console.error("Error publicando comentario:", error);
    }
  };

  const handleEliminarCompartido = async (idCompartido: number) => {
    try {
      await eliminarCompartido(idCompartido);
      // Recargar datos después de eliminar
      await cargarDatos();
    } catch (error) {
      console.error("Error eliminando compartido:", error);
    }
  };

  const verPublicacion = (idPublicacion: number) => {
    navigate(`/publicacion/${idPublicacion}`);
  };

  useEffect(() => {
    cargarDatos();
  }, []);

  // Función para renderizar tarjeta de compartido
  const renderCompartidoCard = (compartido: Compartido) => {
    const publicacion = compartido.publicacion;
    const stats = estadisticas[publicacion.id_publicacion];
    const comentariosPublicacion = comentarios[publicacion.id_publicacion] || [];

    return (
      <div key={compartido.id_compartido} className="compartido-card">
        {/* Header del compartido */}
        <div className="compartido-header">
          <div className="compartido-info">
            <img
              src={compartido.usuario_compartio.foto_perfil || defaultProfile}
              alt="Perfil"
              className="foto-perfil-pequena"
            />
            <div className="compartido-details">
              <span className="usuario-nombre">{compartido.usuario_compartio.nombre_usuario}</span>
              <span className="compartido-texto">compartió una publicación</span>
              <span className="compartido-fecha">
                {new Date(compartido.fecha_compartido).toLocaleDateString()}
              </span>
            </div>
          </div>
          
          {usuario?.id_usuario === compartido.usuario_compartio.id_usuario && (
            <div className="compartido-actions">
              <button
                onClick={() => handleEliminarCompartido(compartido.id_compartido)}
                className="btn-eliminar"
                title="Eliminar compartido"
              >
                <X size={16} />
              </button>
            </div>
          )}
        </div>

        {/* Mensaje del compartido (opcional) */}
        {compartido.mensaje && (
          <div className="compartido-mensaje">
            <p>{compartido.mensaje}</p>
          </div>
        )}

        {/* Publicación original */}
        <div className="publicacion-content">
          <div className="publicacion-header">
            <img
              src={publicacion.usuario.foto_perfil || defaultProfile}
              alt="Perfil"
              className="foto-perfil-pequena"
            />
            <div className="publicacion-user-info">
              <span className="usuario-nombre">{publicacion.usuario.nombre_usuario}</span>
              <span className="publicacion-fecha">
                {new Date(publicacion.fecha_creacion).toLocaleDateString()}
              </span>
            </div>
          </div>

          <div className="publicacion-contenido">
            <p>{publicacion.contenido}</p>
            {publicacion.imagen_url && (
              <img
                src={publicacion.imagen_url}
                alt="Publicación"
                className="publicacion-imagen"
                onClick={() => verPublicacion(publicacion.id_publicacion)}
              />
            )}
          </div>

          {/* Estadísticas y acciones */}
          {stats && (
            <>
              <div className="publicacion-stats">
                <span>{stats.me_gusta} me gusta</span>
                <span>{stats.comentarios} comentarios</span>
                <span>{stats.compartidos} compartidos</span>
              </div>

              <div className="publicacion-actions">
                <button
                  onClick={() => handleMeGusta(publicacion.id_publicacion)}
                  className={`action-btn ${stats.usuario_dio_me_gusta ? 'active' : ''}`}
                >
                  <Heart size={20} />
                  Me gusta
                </button>
                <button
                  onClick={() => toggleComentarios(publicacion.id_publicacion)}
                  className="action-btn"
                >
                  <MessageCircle size={20} />
                  Comentar
                </button>
                <button
                  onClick={() => handleGuardar(publicacion.id_publicacion)}
                  className={`action-btn ${stats.usuario_guardo ? 'active' : ''}`}
                >
                  <Bookmark size={20} />
                  Guardar
                </button>
              </div>
            </>
          )}

          {/* Sección de comentarios */}
          {comentariosAbiertos[publicacion.id_publicacion] && (
            <div className="comentarios-section">
              <div className="comentarios-lista">
                {comentariosPublicacion.map((comentario) => (
                  <div key={comentario.id_comentario} className="comentario">
                    <img
                      src={comentario.usuario.foto_perfil || defaultProfile}
                      alt="Perfil"
                      className="foto-perfil-mini"
                    />
                    <div className="comentario-content">
                      <div className="comentario-header">
                        <span className="usuario-nombre">{comentario.usuario.nombre_usuario}</span>
                        <span className="comentario-fecha">
                          {new Date(comentario.fecha_creacion).toLocaleDateString()}
                        </span>
                      </div>
                      <p>{comentario.contenido}</p>
                    </div>
                  </div>
                ))}
              </div>

              {/* Input de nuevo comentario */}
              <div className="nuevo-comentario">
                <input
                  type="text"
                  placeholder="Escribe un comentario..."
                  value={nuevoComentario[publicacion.id_publicacion] || ''}
                  onChange={(e) => setNuevoComentario(prev => ({
                    ...prev,
                    [publicacion.id_publicacion]: e.target.value
                  }))}
                  onKeyPress={(e) => {
                    if (e.key === 'Enter') {
                      publicarComentario(publicacion.id_publicacion);
                    }
                  }}
                />
                <button
                  onClick={() => publicarComentario(publicacion.id_publicacion)}
                  disabled={!nuevoComentario[publicacion.id_publicacion]?.trim()}
                >
                  Publicar
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    );
  };

  return (
    <div className="compartidos-page">
      {/* Header */}
      <div className="compartidos-header">
        <button 
          className="btn-volver" 
          onClick={() => navigate("/principal")}
        >
          <ArrowLeft size={20} />
          {compartidoEspecifico ? "Volver al inicio" : "Volver"}
        </button>

        <h1>
          {compartidoEspecifico ? "Publicación Compartida" : "Publicaciones Compartidas"}
        </h1>

        {compartidoEspecifico && (
          <div className="compartido-especifico-indicator">
            <span>Vista de publicación compartida</span>
          </div>
        )}
      </div>

      {/* Solo mostrar pestañas si no es un compartido específico */}
      {!compartidoEspecifico && (
        <div className="compartidos-pestanas">
          <button 
            className={`pestana ${pestanaActiva === 'amigos' ? 'activa' : ''}`}
            onClick={() => setPestanaActiva('amigos')}
          >
            <Users size={18} />
            Compartido por Amigos
            <span className="pestana-count">{compartidosAmigos.length}</span>
          </button>
          <button 
            className={`pestana ${pestanaActiva === 'mis-compartidos' ? 'activa' : ''}`}
            onClick={() => setPestanaActiva('mis-compartidos')}
          >
            <Share2 size={18} />
            Mis Compartidos
            <span className="pestana-count">{misCompartidos.length}</span>
          </button>
        </div>
      )}

      {/* Contenido */}
      <div className="compartidos-content">
        {cargando ? (
          <div className="cargando">Cargando publicaciones compartidas...</div>
        ) : compartidosParaMostrar.length > 0 ? (
          <div className="compartidos-lista">
            {/* Renderizar los compartidos */}
            {compartidosParaMostrar.map(renderCompartidoCard)}
          </div>
        ) : (
          <div className="sin-compartidos">
            <Share2 size={64} />
            <h3>No hay publicaciones compartidas</h3>
            <p>
              {pestanaActiva === 'amigos' 
                ? "Cuando tus amigos compartan publicaciones, aparecerán aquí."
                : "Las publicaciones que compartas aparecerán aquí."
              }
            </p>
          </div>
        )}
      </div>
    </div>
  );
}