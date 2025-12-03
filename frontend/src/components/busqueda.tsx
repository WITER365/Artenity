import React, { useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import { 
  getUsuarios, 
  getPublicaciones,
  obtenerPublicacionesPorCategoria // Agregar esta importación
} from "../services/api";
import "../styles/busqueda.css";

const Busqueda: React.FC = () => {
  const [query, setQuery] = useState("");
  const [usuarios, setUsuarios] = useState<any[]>([]);
  const [publicaciones, setPublicaciones] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  const location = useLocation();
  const params = new URLSearchParams(location.search);

  const categoriaNombre = params.get("categoria"); 
  const categoriaID = params.get("id");

  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);

      const users = await getUsuarios();
      
      // Si viene categoria desde CategoriasPage
      if (categoriaNombre) {
        try {
          // Usar la función importada correctamente
          const publicacionesFiltradas = await obtenerPublicacionesPorCategoria(categoriaNombre);
          setPublicaciones(publicacionesFiltradas);
        } catch (error) {
          console.error("Error cargando publicaciones por categoría:", error);
          // Fallback: obtener todas y filtrar localmente
          const pubs = await getPublicaciones();
          const filtradas = pubs.filter((p: any) =>
            p.etiquetas?.some((tag: string) => 
              tag.toLowerCase().includes(categoriaNombre.toLowerCase())
            )
          );
          setPublicaciones(filtradas);
        }
      } else {
        // Si no hay categoría, obtener todas las publicaciones
        const pubs = await getPublicaciones();
        setPublicaciones(pubs);
      }

      setUsuarios(users);
      setLoading(false);
    };

    fetchData();
  }, [categoriaNombre]);

  // 🔍 Buscar usuarios manualmente
  const handleBuscar = async (e: React.FormEvent) => {
    e.preventDefault();

    const filtrados = usuarios.filter(
      (u: any) =>
        u.name.toLowerCase().includes(query.toLowerCase()) ||
        u.correo.toLowerCase().includes(query.toLowerCase())
    );

    setUsuarios(filtrados);
    setPublicaciones([]); // limpiar publicaciones cuando se busca texto
  };

  if (loading) return <p className="no-resultados">Cargando...</p>;

  return (
    <div className="busqueda-container">
      {/* BARRA DE BÚSQUEDA */}
      <header className="busqueda-header">
        <form onSubmit={handleBuscar} className="busqueda-form">
          <input
            type="text"
            placeholder="Buscar usuarios o arte..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
          />
          <button type="submit">Buscar</button>
        </form>
      </header>

      <main className="busqueda-resultados">

        {/* ⭐ SI VIENE UNA CATEGORIA DESDE LA PÁGINA PRINCIPAL */}
        {categoriaNombre && (
          <>
            <h2 className="titulo-categoria">
              Publicaciones en: <span>{categoriaNombre}</span>
            </h2>

            {publicaciones.length > 0 ? (
              publicaciones.map((p) => (
                <div key={p.id_publicacion} className="resultado-card">
                  
                  <div className="resultado-header">
                    <strong>{p.usuario_nombre}</strong> 
                    <span>@{p.usuario_correo}</span>
                  </div>

                  <div className="resultado-content">
                    <p>{p.descripcion}</p>

                    {p.imagen && (
                      <img
                        src={p.imagen}
                        className="resultado-imagen"
                        alt="arte"
                      />
                    )}
                  </div>
                </div>
              ))
            ) : (
              <p className="no-resultados">No hay publicaciones en esta categoría.</p>
            )}
          </>
        )}

        {/* 🔵 RESULTADOS DE BÚSQUEDA DE USUARIOS */}
        {!categoriaNombre && usuarios.length > 0 && (
          usuarios.map((u) => (
            <div key={u.id} className="resultado-card">
              <div className="resultado-header">
                <strong>{u.name}</strong> <span>@{u.correo}</span>
              </div>
            </div>
          ))
        )}

        {!categoriaNombre && usuarios.length === 0 && (
          <p className="no-resultados">No hay resultados para mostrar.</p>
        )}
      </main>
    </div>
  );
};

export default Busqueda;