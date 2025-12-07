// frontend/components/artenity.tsx
import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import "../styles/artenity.css";
import { Link } from "react-router-dom";
import { obtenerAnuncio } from "../services/api";
import { X } from "lucide-react";
import artenityimg from "../assets/img/artenity.png";
import libroImg from "../assets/img/libro.png";
import musicaImg from "../assets/img/musica.png";
import pinturaImg from "../assets/img/pintura.png";
import danzaImg from "../assets/img/danza.png";
import cineImg from "../assets/img/cine.png";

interface Anuncio {
  id_anuncio: number;
  titulo: string;
  contenido: string | null;
  activo: boolean;
  fecha_creacion: string;
  fecha_actualizacion: string;
}

const Artenity: React.FC = () => {
  const navigate = useNavigate();
  const [mostrarAnuncio, setMostrarAnuncio] = useState(false);
  const [anuncio, setAnuncio] = useState<Anuncio | null>(null);
  const [cargando, setCargando] = useState(false);

  // Función para manejar clics en iconos
  const handleIconClick = (categoryName: string) => {
    // Navegar directamente a búsqueda con la categoría (sin token requerido)
    navigate(`/busqueda?categoria=${encodeURIComponent(categoryName)}`);
  };

  // Función para manejar el click en el botón del anuncio
  const handleAnuncioClick = async () => {
    setMostrarAnuncio(true);
    setCargando(true);
    try {
      const anuncioData = await obtenerAnuncio();
      setAnuncio(anuncioData);
    } catch (error) {
      console.error("Error cargando anuncio:", error);
      // Si hay error, mostrar un anuncio por defecto
      setAnuncio({
        id_anuncio: 0,
        titulo: "LO QUE SUCEDE CON EL MUNDO DEL ARTE",
        contenido: "Bienvenido a Artenity, la plataforma donde el arte cobra vida. Descubre, comparte y conecta con artistas de todo el mundo.",
        activo: true,
        fecha_creacion: new Date().toISOString(),
        fecha_actualizacion: new Date().toISOString()
      });
    } finally {
      setCargando(false);
    }
  };

  // Cerrar modal al hacer click fuera o en la X
  const cerrarAnuncio = () => {
    setMostrarAnuncio(false);
    setAnuncio(null);
  };

  return (
    <div
      className="fullscreen-bg"
      style={{
        width: "100vw",
        minHeight: "100vh",
        background: `url(${artenityimg}) no-repeat center center`,
        backgroundSize: "cover",
      }}
    >
      <div className="header-text">ARTENITY</div>

      <div className="icons-row">
        <div 
          className="icon libro" 
          onClick={() => handleIconClick("Literatura")}
          data-name="Literatura"
        >
          <img src={libroImg} alt="Libro" />
        </div>
        <div 
          className="icon musica" 
          onClick={() => handleIconClick("Música")}
          data-name="Música"
        >
          <img src={musicaImg} alt="Música" />
        </div>
        <div 
          className="icon pintura" 
          onClick={() => handleIconClick("Pintura")}
          data-name="Pintura"
        >
          <img src={pinturaImg} alt="Pintura" />
        </div>
        <div 
          className="icon danza" 
          onClick={() => handleIconClick("Danza")}
          data-name="Danza"
        >
          <img src={danzaImg} alt="Danza" />
        </div>
        <div 
          className="icon cine" 
          onClick={() => handleIconClick("Cine")}
          data-name="Cine"
        >
          <img src={cineImg} alt="Cine" />
        </div>
      </div>

      <div className="banner-buttons">
        <button 
          className="banner-button"
          onClick={handleAnuncioClick}
        >
          LO QUE SUCEDE CON EL MUNDO DEL ARTE
        </button>
        <Link to="/login" className="bannor-button">INGRESAR</Link>
        <Link to="/register" className="bannar-button">REGISTRAR</Link>
      </div>

      {/* Modal del Anuncio */}
      {mostrarAnuncio && (
        <div 
          className="anuncio-modal-overlay"
          onClick={cerrarAnuncio}
        >
          <div 
            className="anuncio-modal-content"
            onClick={(e) => e.stopPropagation()}
          >
            <button 
              className="anuncio-modal-close"
              onClick={cerrarAnuncio}
            >
              <X size={20} />
            </button>
            
            {cargando ? (
              <div className="anuncio-loading">
                <div className="anuncio-spinner"></div>
                <p>Cargando...</p>
              </div>
            ) : anuncio ? (
              <>
                <h2 className="anuncio-modal-title">{anuncio.titulo}</h2>
                <div className="anuncio-modal-body">
                  {anuncio.contenido ? (
                    <div 
                      className="anuncio-contenido"
                      dangerouslySetInnerHTML={{ __html: anuncio.contenido }}
                    />
                  ) : (
                    <p className="anuncio-sin-contenido">
                      Bienvenido a Artenity, la plataforma donde el arte cobra vida. 
                      Descubre, comparte y conecta con artistas de todo el mundo.
                    </p>
                  )}
                </div>
              </>
            ) : (
              <div className="anuncio-error">
                <p>No se pudo cargar el anuncio</p>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default Artenity;