// src/components/NotificacionesPanel.tsx 
import { useEffect, useState, useCallback } from "react";
import { useNavigate } from "react-router-dom";
import {
  getNotificaciones,
  responderSolicitudAmistad,
  obtenerSolicitudesPendientes as getSolicitudesAmistad,
  obtenerSeguidores,
  marcarNotificacionesLeidas,
  obtenerCompartidoPorId,
  obtenerPublicacionDeComentario
} from "../services/api";
import defaultProfile from "../assets/img/fotoperfildefault.jpg";
import "../styles/notificaciones.css";

export default function NotificacionesPanel({ usuario }: { usuario: any }) {
  const navigate = useNavigate();
  const [notificaciones, setNotificaciones] = useState<any[]>([]);
  const [solicitudesPendientes, setSolicitudesPendientes] = useState<any[]>([]);
  const [seguidores, setSeguidores] = useState<any[]>([]);
  const [mostrarPanel, setMostrarPanel] = useState(false);
  const [cantidadNoLeidas, setCantidadNoLeidas] = useState(0);

  // ✅ FUNCIÓN CORREGIDA - Manejo de clic en notificaciones
const handleNotificacionClick = async (notificacion: any) => {
  try {
    console.log("🔔 Notificación clickeada:", notificacion);
    
    // 🔥 MANEJO ESPECÍFICO PARA COMPARTIDOS
    if (notificacion.tipo === "compartido" || notificacion.tipo === "compartido_amigo") {
      console.log("📤 Es una notificación de compartido");
      
      if (!notificacion.id_referencia) {
        console.warn("❌ La notificación no tiene id_referencia");
        setMostrarPanel(false);
        navigate("/compartidos");
        return;
      }

      const idCompartido = notificacion.id_referencia;
      
      if (isNaN(idCompartido)) {
        console.error("ID de compartido inválido:", idCompartido);
        setMostrarPanel(false);
        navigate("/compartidos");
        return;
      }

      console.log("🎯 Navegando a compartido específico:", idCompartido);
      setMostrarPanel(false);
      
      // 🔥 NUEVO: Disparar evento para scroll automático
      const scrollEvent = new CustomEvent('scrollToCompartido', {
        detail: { 
          idCompartido: idCompartido,
          fromNotification: true
        }
      });
      window.dispatchEvent(scrollEvent);
      
      // Navegar a compartidos
      navigate(`/compartidos`, { 
        state: { 
          idCompartido: idCompartido,
          fromNotification: true
        }
      });
      return;
    }
      // Manejo para me gusta
      else if (notificacion.tipo === "me_gusta" && notificacion.id_referencia) {
        const idPublicacion = notificacion.id_referencia;
        console.log("❤️ Navegando a publicación:", idPublicacion);
        setMostrarPanel(false);
        
        const scrollEvent = new CustomEvent('scrollToPublicacion', {
          detail: { idPublicacion }
        });
        window.dispatchEvent(scrollEvent);
        
        navigate("/principal");
        
      } 
      // Manejo para comentarios
      else if ((notificacion.tipo === "comentario" || notificacion.tipo === "comentario_respuesta") && notificacion.id_referencia) {
        const idComentario = notificacion.id_referencia;
        console.log("💬 Obteniendo publicación del comentario:", idComentario);
        setMostrarPanel(false);
        
        try {
          const respuesta = await obtenerPublicacionDeComentario(idComentario);
          const idPublicacion = respuesta.id_publicacion;
          
          console.log("📝 Navegando a publicación desde comentario:", idPublicacion);
          
          const scrollEvent = new CustomEvent('scrollToPublicacion', {
            detail: { idPublicacion }
          });
          window.dispatchEvent(scrollEvent);
          
          navigate("/principal");
        } catch (error) {
          console.error("Error obteniendo publicación del comentario:", error);
          // Si falla, ir al principal igualmente
          navigate("/principal");
        }
      } 
      // Para otros tipos de notificaciones sin referencia específica
      else {
        console.log("ℹ️ Notificación sin acción específica:", notificacion.tipo);
        setMostrarPanel(false);
        // Para notificaciones de amistad, seguidores, etc., no hacer nada o ir al perfil
        if (notificacion.tipo === "solicitud_amistad" || notificacion.tipo === "nuevo_seguidor") {
          navigate("/perfil");
        }
      }
      
    } catch (error: any) {
      console.error("💥 Error al manejar notificación:", error);
      
      // Manejo de errores más robusto
      let mensajeError = "No se pudo cargar el contenido de la notificación.";
      
      if (error.response?.status === 404) {
        mensajeError = "El contenido de esta notificación ya no está disponible.";
      } else if (error.response?.status === 403) {
        mensajeError = "No tienes permiso para ver este contenido.";
      } else if (error.message) {
        mensajeError = error.message;
      }
      
      console.error(mensajeError);
      setMostrarPanel(false);
      
      // En caso de error, navegar a una página segura
      navigate("/principal");
    }
  };

  // ✅ Cargar todo (notificaciones, solicitudes, seguidores)
  const cargarTodo = useCallback(async () => {
    await Promise.all([cargarNotificaciones(), cargarSolicitudes(), cargarSeguidores()]);
  }, []);

  useEffect(() => {
    if (usuario?.id_usuario) {
      cargarTodo();
    }
  }, [usuario, cargarTodo]);

  const cargarNotificaciones = async () => {
    try {
      const data = await getNotificaciones();
      setNotificaciones(data);

      // 🔢 Calcular cantidad no leídas directamente
      const noLeidas = data.filter((n: any) => !n.leida).length;
      setCantidadNoLeidas(noLeidas);
    } catch (err) {
      console.error("Error cargando notificaciones:", err);
    }
  };

  const cargarSolicitudes = async () => {
    try {
      const solicitudes = await getSolicitudesAmistad();
      setSolicitudesPendientes(solicitudes.filter((s: any) => s.estado === "pendiente"));
    } catch (err) {
      console.error("Error cargando solicitudes:", err);
    }
  };

  const cargarSeguidores = async () => {
    try {
      const data = await obtenerSeguidores();
      setSeguidores(data);
    } catch (err) {
      console.error("Error cargando seguidores:", err);
    }
  };

  const handleResponder = async (id: number, estado: string) => {
    try {
      await responderSolicitudAmistad(id, estado);
      await cargarSolicitudes();
    } catch (err) {
      console.error("Error al responder solicitud:", err);
    }
  };

  // ✅ Marcar como leídas al abrir el panel
  const togglePanel = async () => {
    const nuevoEstado = !mostrarPanel;
    setMostrarPanel(nuevoEstado);

    if (nuevoEstado) {
      try {
        await marcarNotificacionesLeidas();
        await cargarNotificaciones();
        setCantidadNoLeidas(0);
      } catch (err) {
        console.error("Error al marcar como leídas:", err);
      }
    }
  };

  // ✅ Separar notificaciones por tipo para mejor organización

  const notificacionesSeguidores = notificaciones.filter(n => 
    n.tipo === "nuevo_seguidor"
  );

  const notificacionesCompartidos = notificaciones.filter(n => 
    n.tipo === "compartido" || n.tipo === "compartido_amigo"
  );
  
  const notificacionesSociales = notificaciones.filter(n => 
    n.tipo === "me_gusta" || n.tipo === "comentario" || n.tipo === "comentario_respuesta"
  );
  
  const notificacionesAmistad = notificaciones.filter(n => 
    n.tipo === "solicitud_amistad" || n.tipo === "amistad_aceptada" || n.tipo === "amistad_rechazada"
  );
  
 

  return (
    <div style={{ position: "relative" }}>
      {/* 🔔 Icono con contador */}
      <div className="notificacion-icon" onClick={togglePanel}>
        <span style={{ fontSize: "1.6rem" }}>🔔</span>
        {cantidadNoLeidas > 0 && (
          <span className="notificacion-badge">
            {cantidadNoLeidas > 9 ? "9+" : cantidadNoLeidas}
          </span>
        )}
      </div>

      {mostrarPanel && (
        <div className="notificaciones-panel">
          <h3>Notificaciones</h3>

          {/* 🧡 Solicitudes de Amistad */}
          {solicitudesPendientes.length > 0 && (
            <section className="notificacion-seccion">
              <h4>Solicitudes de amistad</h4>
              {solicitudesPendientes.map((s) => (
                <div key={s.id_solicitud} className="solicitud-item">
                  <img
                    src={s.emisor?.foto_perfil || defaultProfile}
                    alt="perfil"
                    className="foto-perfil-pequena"
                  />
                  <p>
                    <strong>{s.emisor?.nombre_usuario}</strong> te envió una solicitud
                  </p>
                  <div className="solicitud-acciones">
                    <button onClick={() => handleResponder(s.id_solicitud, "aceptada")}>Aceptar</button>
                    <button onClick={() => handleResponder(s.id_solicitud, "rechazada")}>Rechazar</button>
                  </div>
                </div>
              ))}
            </section>
          )}

          {/* 📤 COMPARTIDOS - SEPARADOS */}
          {notificacionesCompartidos.length > 0 && (
            <section className="notificacion-seccion compartidos-seccion">
              <h4>Publicaciones compartidas</h4>
              {notificacionesCompartidos.map((n) => (
                <div
                  key={n.id_notificacion}
                  className={`notificacion ${n.leida ? "leida" : "no-leida"} compartido`}
                  onClick={() => handleNotificacionClick(n)}
                  style={{ cursor: 'pointer' }}
                >
                  <div className="notificacion-contenido">
                    <span className="notificacion-icono">
                      {n.tipo === 'compartido' && '📤'}
                      {n.tipo === 'compartido_amigo' && '👥'}
                    </span>
                    
                    <div className="notificacion-texto">
                      <p>{n.mensaje}</p>
                      <span className="fecha-notificacion">
                        {new Date(n.fecha_creacion).toLocaleDateString('es-ES', {
                          day: 'numeric',
                          month: 'short',
                          hour: '2-digit',
                          minute: '2-digit'
                        })}
                      </span>
                      
                      {/* BOTÓN EXPLÍCITO PARA COMPARTIDOS */}
                      <button 
                        className="btn-ver-compartido"
                        onClick={(e) => {
                          e.stopPropagation();
                          handleNotificacionClick(n);
                        }}
                      >
                        <span>📤 Ver publicación compartida</span>
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </section>
          )}

          {/* ❤️ INTERACCIONES SOCIALES */}
          {notificacionesSociales.length > 0 && (
            <section className="notificacion-seccion">
              <h4>Interacciones</h4>
              {notificacionesSociales.map((n) => (
                <div
                  key={n.id_notificacion}
                  className={`notificacion ${n.leida ? "leida" : "no-leida"}`}
                  onClick={() => handleNotificacionClick(n)}
                  style={{ cursor: 'pointer' }}
                >
                  <div className="notificacion-contenido">
                    <span className="notificacion-icono">
                      {n.tipo === 'me_gusta' && '❤️'}
                      {n.tipo === 'comentario' && '💬'}
                      {n.tipo === 'comentario_respuesta' && '💬'}
                    </span>
                    
                    <div className="notificacion-texto">
                      <p>{n.mensaje}</p>
                      <span className="fecha-notificacion">
                        {new Date(n.fecha_creacion).toLocaleDateString('es-ES', {
                          day: 'numeric',
                          month: 'short',
                          hour: '2-digit',
                          minute: '2-digit'
                        })}
                      </span>
                    </div>
                  </div>
                </div>
              ))}
            </section>
          )}

          {/* 👥 SEGUIDORES */}
          {seguidores.length > 0 && (
            <section className="notificacion-seccion">
              <h4>Personas que te siguen</h4>
              {seguidores.map((seg) => (
                <div key={seg.id_seguimiento} className="seguidor-item">
                  <img
                    src={seg.seguidor?.foto_perfil || defaultProfile}
                    alt="perfil"
                    className="foto-perfil-pequena"
                  />
                  <p>
                    <strong>{seg.seguidor?.nombre_usuario}</strong> comenzó a seguirte
                  </p>
                </div>
              ))}
            </section>
          )}

          {/* 🔔 OTRAS NOTIFICACIONES */}
          {(notificacionesAmistad.length > 0 || notificacionesSeguidores.length > 0) && (
            <section className="notificacion-seccion">
              <h4>Otras notificaciones</h4>
              {[...notificacionesAmistad, ...notificacionesSeguidores].map((n) => (
                <div
                  key={n.id_notificacion}
                  className={`notificacion ${n.leida ? "leida" : "no-leida"}`}
                  onClick={() => handleNotificacionClick(n)}
                  style={{ cursor: 'pointer' }}
                >
                  <div className="notificacion-contenido">
                    <span className="notificacion-icono">
                      {n.tipo === 'solicitud_amistad' && '👋'}
                      {n.tipo === 'amistad_aceptada' && '✅'}
                      {n.tipo === 'amistad_rechazada' && '❌'}
                      {n.tipo === 'nuevo_seguidor' && '👤'}
                    </span>
                    
                    <div className="notificacion-texto">
                      <p>{n.mensaje}</p>
                      <span className="fecha-notificacion">
                        {new Date(n.fecha_creacion).toLocaleDateString('es-ES', {
                          day: 'numeric',
                          month: 'short',
                          hour: '2-digit',
                          minute: '2-digit'
                        })}
                      </span>
                    </div>
                  </div>
                </div>
              ))}
            </section>
          )}

          {/* 📝 SIN NOTIFICACIONES */}
          {notificaciones.length === 0 && solicitudesPendientes.length === 0 && seguidores.length === 0 && (
            <p className="sin-notificaciones">No hay notificaciones recientes</p>
          )}
        </div>
      )}
    </div>
  );
}