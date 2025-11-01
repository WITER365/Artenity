import { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function ForgotPassword() {
  const [correo, setCorreo] = useState("");
  const [mensaje, setMensaje] = useState("");
  const [error, setError] = useState("");
  const [cargando, setCargando] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setCargando(true);
    setMensaje("");
    setError("");

    try {
      const response = await fetch("http://localhost:8000/olvidaste-contrasena", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ correo }),
      });

      const data = await response.json();
      if (response.ok) {
        setMensaje(data.mensaje);
      } else {
        setError(data.detail || "Error al procesar la solicitud.");
      }
    } catch {
      setError("No se pudo conectar con el servidor.");
    } finally {
      setCargando(false);
    }
  };

  return (
    <div className="flex flex-col items-center justify-center h-screen bg-gray-100 p-4">
      <div className="bg-white shadow-xl rounded-2xl p-8 w-full max-w-md">
        <h2 className="text-2xl font-bold mb-6 text-center text-gray-700">
          Recuperar contraseña
        </h2>

        <form onSubmit={handleSubmit} className="space-y-5">
          <div>
            <label className="block text-gray-600 mb-2">Correo electrónico</label>
            <input
              type="email"
              value={correo}
              onChange={(e) => setCorreo(e.target.value)}
              className="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
          </div>

          <button
            type="submit"
            disabled={cargando}
            className="w-full bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition disabled:opacity-50"
          >
            {cargando ? "Enviando..." : "Enviar enlace de recuperación"}
          </button>
        </form>

        {mensaje && <p className="mt-4 text-green-600 text-center">{mensaje}</p>}
        {error && <p className="mt-4 text-red-600 text-center">{error}</p>}

        <button
          onClick={() => navigate("/login")}
          className="mt-6 text-blue-500 underline hover:text-blue-700 text-sm block text-center"
        >
          Volver al inicio de sesión
        </button>
      </div>
    </div>
  );
}
