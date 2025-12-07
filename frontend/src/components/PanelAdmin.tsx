import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import {
  obtenerEstadisticasAdmin,
  obtenerUsuariosAdmin,
  cambiarRolUsuario,
  eliminarUsuarioAdmin,
  obtenerPublicacionesAdmin,
  eliminarPublicacionAdmin,
  obtenerReportesAdmin,
  obtenerReportesProblemasAdmin,
  actualizarEstadoReporte,
  UsuarioAdmin,
  PublicacionAdmin,
  ReporteAdmin,
  ReporteProblemaAdmin,
  EstadisticasAdmin,
} from "../services/api";
import { useAuth } from "../context/AuthContext";
import {
  Shield,
  Users,
  FileText,
  AlertTriangle,
  Trash2,
  Search,
  ChevronLeft,
  ChevronRight,
  X,
  Check,
  Clock,
  CheckCircle,
  XCircle,
  BarChart3,
  Settings,
  Eye,
} from "lucide-react";
import "../styles/paneladmin.css";

const PanelAdmin: React.FC = () => {
  const navigate = useNavigate();
  const { usuario } = useAuth();
  const [activeTab, setActiveTab] = useState<string>("estadisticas");
  const [loading, setLoading] = useState<boolean>(false);
  const [message, setMessage] = useState<{ type: "success" | "error"; text: string } | null>(null);

  // Estadísticas
  const [estadisticas, setEstadisticas] = useState<EstadisticasAdmin | null>(null);

  // Usuarios
  const [usuarios, setUsuarios] = useState<UsuarioAdmin[]>([]);
  const [usuariosTotal, setUsuariosTotal] = useState<number>(0);
  const [usuariosSkip, setUsuariosSkip] = useState<number>(0);
  const [usuariosBusqueda, setUsuariosBusqueda] = useState<string>("");

  // Publicaciones
  const [publicaciones, setPublicaciones] = useState<PublicacionAdmin[]>([]);
  const [publicacionesTotal, setPublicacionesTotal] = useState<number>(0);
  const [publicacionesSkip, setPublicacionesSkip] = useState<number>(0);

  // Reportes
  const [reportes, setReportes] = useState<ReporteAdmin[]>([]);
  const [reportesTotal, setReportesTotal] = useState<number>(0);
  const [reportesSkip, setReportesSkip] = useState<number>(0);

  // Reportes de problemas
  const [reportesProblemas, setReportesProblemas] = useState<ReporteProblemaAdmin[]>([]);
  const [reportesProblemasTotal, setReportesProblemasTotal] = useState<number>(0);
  const [reportesProblemasSkip, setReportesProblemasSkip] = useState<number>(0);
  const [filtroEstado, setFiltroEstado] = useState<string>("");

  const limit = 20;

  useEffect(() => {
    if (!usuario?.es_admin) {
      navigate("/paginaprincipal");
      return;
    }

    cargarDatos();
  }, [usuario, activeTab, usuariosSkip, publicacionesSkip, reportesSkip, reportesProblemasSkip, filtroEstado]);

  const cargarDatos = async () => {
    setLoading(true);
    try {
      switch (activeTab) {
        case "estadisticas":
          const stats = await obtenerEstadisticasAdmin();
          setEstadisticas(stats);
          break;
        case "usuarios":
          const usuariosData = await obtenerUsuariosAdmin(usuariosSkip, limit, usuariosBusqueda || undefined);
          setUsuarios(usuariosData.usuarios);
          setUsuariosTotal(usuariosData.total);
          break;
        case "publicaciones":
          const publicacionesData = await obtenerPublicacionesAdmin(publicacionesSkip, limit);
          setPublicaciones(publicacionesData.publicaciones);
          setPublicacionesTotal(publicacionesData.total);
          break;
        case "reportes":
          const reportesData = await obtenerReportesAdmin(reportesSkip, limit);
          setReportes(reportesData.reportes);
          setReportesTotal(reportesData.total);
          break;
        case "reportes-problemas":
          const reportesProblemasData = await obtenerReportesProblemasAdmin(
            reportesProblemasSkip,
            limit,
            filtroEstado || undefined
          );
          setReportesProblemas(reportesProblemasData.reportes);
          setReportesProblemasTotal(reportesProblemasData.total);
          break;
      }
    } catch (error: any) {
      mostrarMensaje("error", error.response?.data?.detail || "Error al cargar datos");
    } finally {
      setLoading(false);
    }
  };

  const mostrarMensaje = (type: "success" | "error", text: string) => {
    setMessage({ type, text });
    setTimeout(() => setMessage(null), 5000);
  };

  const handleCambiarRol = async (usuarioId: number, esAdmin: boolean) => {
    try {
      await cambiarRolUsuario(usuarioId, !esAdmin);
      mostrarMensaje("success", `Rol de administrador ${!esAdmin ? "activado" : "desactivado"} correctamente`);
      cargarDatos();
    } catch (error: any) {
      mostrarMensaje("error", error.response?.data?.detail || "Error al cambiar rol");
    }
  };

  const handleEliminarUsuario = async (usuarioId: number, nombreUsuario: string) => {
    if (!window.confirm(`¿Estás seguro de eliminar al usuario ${nombreUsuario}? Esta acción no se puede deshacer.`)) {
      return;
    }
    try {
      await eliminarUsuarioAdmin(usuarioId);
      mostrarMensaje("success", "Usuario eliminado correctamente");
      cargarDatos();
    } catch (error: any) {
      mostrarMensaje("error", error.response?.data?.detail || "Error al eliminar usuario");
    }
  };

  const handleEliminarPublicacion = async (idPublicacion: number) => {
    if (!window.confirm("¿Estás seguro de eliminar esta publicación?")) {
      return;
    }
    try {
      await eliminarPublicacionAdmin(idPublicacion);
      mostrarMensaje("success", "Publicación eliminada correctamente");
      cargarDatos();
    } catch (error: any) {
      mostrarMensaje("error", error.response?.data?.detail || "Error al eliminar publicación");
    }
  };

  const handleActualizarEstadoReporte = async (idReporte: number, nuevoEstado: string) => {
    try {
      await actualizarEstadoReporte(idReporte, nuevoEstado);
      mostrarMensaje("success", "Estado actualizado correctamente");
      cargarDatos();
    } catch (error: any) {
      mostrarMensaje("error", error.response?.data?.detail || "Error al actualizar estado");
    }
  };

  const buscarUsuarios = () => {
    setUsuariosSkip(0);
    cargarDatos();
  };

  const limpiarBusqueda = () => {
    setUsuariosBusqueda("");
    setUsuariosSkip(0);
    // Usar setTimeout para asegurar que el estado se actualice antes de recargar
    setTimeout(() => {
      // Forzar recarga con búsqueda vacía
      obtenerUsuariosAdmin(0, limit, undefined).then((usuariosData) => {
        setUsuarios(usuariosData.usuarios);
        setUsuariosTotal(usuariosData.total);
      }).catch((error: any) => {
        mostrarMensaje("error", error.response?.data?.detail || "Error al cargar usuarios");
      });
    }, 50);
  };

  if (!usuario?.es_admin) {
    return null;
  }

  return (
    <div className="panel-admin">
      <div className="panel-admin-header">
        <div className="panel-admin-title">
          <Shield className="icon" />
          <h1>Panel de Administración</h1>
        </div>
        <button className="btn-volver" onClick={() => navigate("/perfil")}>
          <ChevronLeft /> Volver
        </button>
      </div>

      {message && (
        <div className={`mensaje ${message.type}`}>
          {message.text}
          <X onClick={() => setMessage(null)} />
        </div>
      )}

      <div className="panel-admin-tabs">
        <button
          className={activeTab === "estadisticas" ? "active" : ""}
          onClick={() => setActiveTab("estadisticas")}
        >
          <BarChart3 /> Estadísticas
        </button>
        <button
          className={activeTab === "usuarios" ? "active" : ""}
          onClick={() => setActiveTab("usuarios")}
        >
          <Users /> Usuarios
        </button>
        <button
          className={activeTab === "publicaciones" ? "active" : ""}
          onClick={() => setActiveTab("publicaciones")}
        >
          <FileText /> Publicaciones
        </button>
        <button
          className={activeTab === "reportes" ? "active" : ""}
          onClick={() => setActiveTab("reportes")}
        >
          <AlertTriangle /> Reportes
        </button>
        <button
          className={activeTab === "reportes-problemas" ? "active" : ""}
          onClick={() => setActiveTab("reportes-problemas")}
        >
          <Settings /> Reportes de Problemas
        </button>
      </div>

      <div className="panel-admin-content">
        {loading && <div className="loading">Cargando...</div>}

        {activeTab === "estadisticas" && estadisticas && (
          <div className="estadisticas-grid">
            <div className="stat-card">
              <Users className="stat-icon" />
              <div className="stat-value">{estadisticas.total_usuarios}</div>
              <div className="stat-label">Total Usuarios</div>
            </div>
            <div className="stat-card">
              <FileText className="stat-icon" />
              <div className="stat-value">{estadisticas.total_publicaciones}</div>
              <div className="stat-label">Publicaciones</div>
            </div>
            <div className="stat-card">
              <FileText className="stat-icon" />
              <div className="stat-value">{estadisticas.total_comentarios}</div>
              <div className="stat-label">Comentarios</div>
            </div>
            <div className="stat-card">
              <AlertTriangle className="stat-icon" />
              <div className="stat-value">{estadisticas.total_reportes}</div>
              <div className="stat-label">Reportes</div>
            </div>
            <div className="stat-card">
              <Settings className="stat-icon" />
              <div className="stat-value">{estadisticas.total_reportes_problemas}</div>
              <div className="stat-label">Reportes de Problemas</div>
            </div>
            <div className="stat-card">
              <Users className="stat-icon" />
              <div className="stat-value">{estadisticas.usuarios_activos_30_dias}</div>
              <div className="stat-label">Usuarios Activos (30 días)</div>
            </div>
          </div>
        )}

        {activeTab === "usuarios" && (
          <div className="tab-content">
            <div className={`busqueda-container ${usuariosBusqueda ? "busqueda-activa" : ""}`}>
              <div style={{ position: "relative", flex: 1 }}>
                <input
                  type="text"
                  placeholder="Buscar por nombre, usuario, correo..."
                  value={usuariosBusqueda}
                  onChange={(e) => setUsuariosBusqueda(e.target.value)}
                  onKeyPress={(e) => e.key === "Enter" && buscarUsuarios()}
                  style={{ paddingRight: usuariosBusqueda ? "40px" : "1rem" }}
                />
                {usuariosBusqueda && (
                  <button
                    onClick={limpiarBusqueda}
                    style={{
                      position: "absolute",
                      right: "8px",
                      top: "50%",
                      transform: "translateY(-50%)",
                      background: "transparent",
                      border: "none",
                      color: "rgba(255, 255, 255, 0.7)",
                      cursor: "pointer",
                      padding: "4px",
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center",
                      borderRadius: "4px",
                      transition: "all 0.2s ease"
                    }}
                    onMouseEnter={(e) => {
                      e.currentTarget.style.background = "rgba(255, 255, 255, 0.1)";
                      e.currentTarget.style.color = "#ffffff";
                    }}
                    onMouseLeave={(e) => {
                      e.currentTarget.style.background = "transparent";
                      e.currentTarget.style.color = "rgba(255, 255, 255, 0.7)";
                    }}
                    title="Limpiar búsqueda"
                  >
                    <X size={18} />
                  </button>
                )}
              </div>
              <button onClick={buscarUsuarios}>
                <Search size={18} />
                Buscar
              </button>
            </div>
            {usuarios.length > 0 ? (
              <div className="table-container">
                <table>
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Usuario</th>
                      <th>Correo</th>
                      <th>Publicaciones</th>
                      <th>Seguidores</th>
                      <th>Admin</th>
                      <th>Acciones</th>
                    </tr>
                  </thead>
                  <tbody>
                    {usuarios.map((u) => (
                      <tr key={u.id_usuario}>
                        <td>{u.id_usuario}</td>
                        <td>{u.nombre_usuario || "-"}</td>
                        <td>{u.correo_electronico}</td>
                        <td>{u.total_publicaciones}</td>
                        <td>{u.total_seguidores}</td>
                        <td>
                          <button
                            className={`btn-rol ${u.es_admin ? "admin" : ""}`}
                            onClick={() => handleCambiarRol(u.id_usuario, u.es_admin)}
                          >
                            {u.es_admin ? <CheckCircle size={16} /> : <XCircle size={16} />}
                            {u.es_admin ? "Admin" : "Usuario"}
                          </button>
                        </td>
                        <td>
                          <button
                            className="btn-eliminar"
                            onClick={() => handleEliminarUsuario(u.id_usuario, u.nombre_usuario)}
                          >
                            <Trash2 size={16} />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <div className="no-results">
                <strong>
                  {usuariosBusqueda 
                    ? `No se encontraron usuarios que coincidan con "${usuariosBusqueda}"`
                    : "No hay usuarios para mostrar"}
                </strong>
                {usuariosBusqueda && (
                  <p>Intenta con otro término de búsqueda o limpia el filtro</p>
                )}
              </div>
            )}
            <div className="pagination">
              <button
                disabled={usuariosSkip === 0}
                onClick={() => setUsuariosSkip(Math.max(0, usuariosSkip - limit))}
              >
                <ChevronLeft /> Anterior
              </button>
              <span>
                {usuariosSkip + 1}-{Math.min(usuariosSkip + limit, usuariosTotal)} de {usuariosTotal}
              </span>
              <button
                disabled={usuariosSkip + limit >= usuariosTotal}
                onClick={() => setUsuariosSkip(usuariosSkip + limit)}
              >
                Siguiente <ChevronRight />
              </button>
            </div>
          </div>
        )}

        {activeTab === "publicaciones" && (
          <div className="tab-content">
            <div className="table-container">
              <table>
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Contenido</th>
                    <th>Fecha</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  {publicaciones.map((p) => (
                    <tr key={p.id_publicacion}>
                      <td>{p.id_publicacion}</td>
                      <td>{p.usuario.nombre_usuario}</td>
                      <td className="contenido-cell">
                        {p.contenido ? (p.contenido.length > 50 ? `${p.contenido.substring(0, 50)}...` : p.contenido) : "-"}
                      </td>
                      <td>{new Date(p.fecha_creacion).toLocaleDateString()}</td>
                      <td>
                        <button
                          className="btn-eliminar"
                          onClick={() => handleEliminarPublicacion(p.id_publicacion)}
                        >
                          <Trash2 />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="pagination">
              <button
                disabled={publicacionesSkip === 0}
                onClick={() => setPublicacionesSkip(Math.max(0, publicacionesSkip - limit))}
              >
                <ChevronLeft /> Anterior
              </button>
              <span>
                {publicacionesSkip + 1}-{Math.min(publicacionesSkip + limit, publicacionesTotal)} de {publicacionesTotal}
              </span>
              <button
                disabled={publicacionesSkip + limit >= publicacionesTotal}
                onClick={() => setPublicacionesSkip(publicacionesSkip + limit)}
              >
                Siguiente <ChevronRight />
              </button>
            </div>
          </div>
        )}

        {activeTab === "reportes" && (
          <div className="tab-content">
            <div className="table-container">
              <table>
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Reportante</th>
                    <th>Reportado</th>
                    <th>Motivo</th>
                    <th>Fecha</th>
                  </tr>
                </thead>
                <tbody>
                  {reportes.map((r) => (
                    <tr key={r.id_reporte}>
                      <td>{r.id_reporte}</td>
                      <td>{r.reportante.nombre_usuario}</td>
                      <td>{r.reportado.nombre_usuario}</td>
                      <td>{r.motivo}</td>
                      <td>{r.fecha ? new Date(r.fecha).toLocaleDateString() : "-"}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="pagination">
              <button
                disabled={reportesSkip === 0}
                onClick={() => setReportesSkip(Math.max(0, reportesSkip - limit))}
              >
                <ChevronLeft /> Anterior
              </button>
              <span>
                {reportesSkip + 1}-{Math.min(reportesSkip + limit, reportesTotal)} de {reportesTotal}
              </span>
              <button
                disabled={reportesSkip + limit >= reportesTotal}
                onClick={() => setReportesSkip(reportesSkip + limit)}
              >
                Siguiente <ChevronRight />
              </button>
            </div>
          </div>
        )}

        {activeTab === "reportes-problemas" && (
          <div className="tab-content">
            <div className="filtros-container">
              <select value={filtroEstado} onChange={(e) => setFiltroEstado(e.target.value)}>
                <option value="">Todos los estados</option>
                <option value="pendiente">Pendiente</option>
                <option value="en_proceso">En Proceso</option>
                <option value="resuelto">Resuelto</option>
              </select>
            </div>
            <div className="table-container">
              <table>
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Tipo</th>
                    <th>Descripción</th>
                    <th>Email</th>
                    <th>Estado</th>
                    <th>Fecha</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  {reportesProblemas.map((r) => (
                    <tr key={r.id_reporte}>
                      <td>{r.id_reporte}</td>
                      <td>{r.tipo_problema}</td>
                      <td className="contenido-cell">
                        {r.descripcion.length > 50 ? `${r.descripcion.substring(0, 50)}...` : r.descripcion}
                      </td>
                      <td>{r.email_contacto}</td>
                      <td>
                        <span className={`estado-badge estado-${r.estado}`}>
                          {r.estado === "pendiente" && <Clock />}
                          {r.estado === "en_proceso" && <Settings />}
                          {r.estado === "resuelto" && <CheckCircle />}
                          {r.estado}
                        </span>
                      </td>
                      <td>{r.fecha_reporte ? new Date(r.fecha_reporte).toLocaleDateString() : "-"}</td>
                      <td>
                        <select
                          value={r.estado}
                          onChange={(e) => handleActualizarEstadoReporte(r.id_reporte, e.target.value)}
                        >
                          <option value="pendiente">Pendiente</option>
                          <option value="en_proceso">En Proceso</option>
                          <option value="resuelto">Resuelto</option>
                        </select>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="pagination">
              <button
                disabled={reportesProblemasSkip === 0}
                onClick={() => setReportesProblemasSkip(Math.max(0, reportesProblemasSkip - limit))}
              >
                <ChevronLeft /> Anterior
              </button>
              <span>
                {reportesProblemasSkip + 1}-{Math.min(reportesProblemasSkip + limit, reportesProblemasTotal)} de {reportesProblemasTotal}
              </span>
              <button
                disabled={reportesProblemasSkip + limit >= reportesProblemasTotal}
                onClick={() => setReportesProblemasSkip(reportesProblemasSkip + limit)}
              >
                Siguiente <ChevronRight />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default PanelAdmin;

