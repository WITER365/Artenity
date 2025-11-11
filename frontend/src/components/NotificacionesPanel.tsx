import { useEffect, useState, useCallback } from "react";
import {
  getNotificaciones,
  responderSolicitudAmistad,
  obtenerSolicitudesPendientes as getSolicitudesAmistad,
  obtenerSeguidores,
  marcarNotificacionesLeidas,
} from "../services/api";
import defaultProfile from "../assets/img/fotoperfildefault.jpg";
import "../styles/notificaciones.css";

export default function NotificacionesPanel({ usuario }: { usuario: any }) {
  const [notificaciones, setNotificaciones] = useState<any[]>([]);
  const [solicitudesPendientes, setSolicitudesPendientes] = useState<any[]>([]);
  const [seguidores, setSeguidores] = useState<any[]>([]);
  const [mostrarPanel, setMostrarPanel] = useState(false);
  const [cantidadNoLeidas, setCantidadNoLeidas] = useState(0);

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
        await marcarNotificacionesLeidas(); // backend actualiza el estado
        await cargarNotificaciones(); // refresca lista
        setCantidadNoLeidas(0); // contador a 0 inmediatamente
      } catch (err) {
        console.error("Error al marcar como leídas:", err);
      }
    }
  };

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
            <section>
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
                  <div>
                  <button onClick={() => handleResponder(s.id_solicitud, "aceptada")}>Aceptar</button>
                  <button onClick={() => handleResponder(s.id_solicitud, "rechazada")}>Rechazar</button>
                  </div>
                </div>
              ))}
            </section>
          )}

          {/* 🧍 Seguidores */}
          {seguidores.length > 0 && (
            <section>
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

       <section>
  <h4>Otras notificaciones</h4>
  {notificaciones.length > 0 ? (
    notificaciones.map((n) => (
      <div
        key={n.id_notificacion}
        className={`notificacion ${n.leida ? "leida" : "no-leida"}`}
      >
        <p>{n.mensaje}</p>
        <span className="fecha">
          {new Date(n.fecha_creacion).toLocaleString()}
        </span>
        {/* Mostrar tipo de notificación */}
        {n.tipo && (
          <span className={`tipo-notificacion ${n.tipo}`}>
            {n.tipo === 'compartido' && '📤'}
            {n.tipo === 'compartido_amigo' && '👥'}
            {n.tipo === 'me_gusta' && '❤️'}
            {n.tipo === 'comentario' && '💬'}
            {n.tipo === 'nuevo_seguidor' && '👤'}
          </span>
        )}
      </div>
    ))
  ) : (
    <p className="sin-notificaciones">No hay notificaciones recientes</p>
  )}
</section>
        </div>
      )}
    </div>
  );
}
