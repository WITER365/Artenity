-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-12-2025 a las 02:20:01
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `artenity`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amistades`
--

CREATE TABLE `amistades` (
  `id_amistad` int(11) NOT NULL,
  `id_usuario1` int(11) NOT NULL,
  `id_usuario2` int(11) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `amistades`
--

INSERT INTO `amistades` (`id_amistad`, `id_usuario1`, `id_usuario2`, `estado`) VALUES
(2, 1, 58, 'aceptada'),
(10, 57, 56, 'aceptada'),
(11, 57, 58, 'aceptada'),
(12, 56, 58, 'aceptada'),
(13, 56, 22, 'aceptada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bloqueos_usuarios`
--

CREATE TABLE `bloqueos_usuarios` (
  `id_bloqueo` int(11) NOT NULL,
  `id_bloqueador` int(11) DEFAULT NULL,
  `id_bloqueado` int(11) DEFAULT NULL,
  `fecha_bloqueo` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_obra`
--

CREATE TABLE `categorias_obra` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias_obra`
--

INSERT INTO `categorias_obra` (`id_categoria`, `nombre`, `descripcion`) VALUES
(1, 'Pintura', 'Obras creadas con pigmentos sobre una superficie.'),
(2, 'Escultura', 'Arte tridimensional realizado en piedra, metal, madera u otros materiales.'),
(3, 'Dibujo', 'Técnica artística basada en líneas y trazos.'),
(4, 'Grabado', 'Reproducción de imágenes mediante matrices entintadas.'),
(5, 'Fotografía', 'Captura de imágenes con cámara.'),
(6, 'Cine', 'Arte audiovisual mediante secuencias fílmicas.'),
(7, 'Arquitectura', 'Diseño y construcción de estructuras con valor estético.'),
(8, 'Diseño', 'Creación visual funcional (gráfico, industrial, de moda, etc.).'),
(9, 'Teatro', 'Representación dramática en vivo.'),
(10, 'Danza', 'Expresión artística mediante el movimiento corporal.'),
(11, 'Ópera', 'Arte escénico que une música y canto lírico.'),
(12, 'Ballet', 'Danza clásica de alto rigor técnico.'),
(13, 'Circo', 'Espectáculos con acrobacia, magia, humor y más.'),
(14, 'Mímica', 'Expresión escénica basada en gestos y silencios.'),
(15, 'Música clásica', 'Composiciones académicas de tradición europea.'),
(16, 'Jazz', 'Género musical con énfasis en la improvisación.'),
(17, 'Rock', 'Género musical contemporáneo con guitarras y percusión.'),
(18, 'Pop', 'Música popular contemporánea de fácil acceso.'),
(19, 'Folclórica', 'Música tradicional de culturas populares.'),
(20, 'Electrónica', 'Música generada o manipulada digitalmente.'),
(21, 'Poesía', 'Composición literaria que expresa belleza o sentimiento.'),
(22, 'Narrativa', 'Relatos en forma de cuento o novela.'),
(23, 'Drama', 'Textos teatrales con carga emocional y conflicto.'),
(24, 'Ensayo', 'Texto argumentativo breve sobre un tema.'),
(25, 'Arte digital', 'Obras creadas usando medios digitales.'),
(26, 'Arte interactivo', 'Obras que requieren la participación del espectador.'),
(27, 'Arte de nuevos medios', 'Creaciones basadas en tecnología emergente.'),
(28, 'Animación', 'Imágenes en movimiento generadas por técnicas gráficas.'),
(29, 'Videojuegos', 'Medio interactivo con narrativa y diseño artístico.'),
(30, 'Artesanía', 'Producción manual con identidad cultural.'),
(31, 'Cerámica', 'Objetos artísticos modelados en arcilla.'),
(32, 'Textiles', 'Creaciones con tela, hilos y técnicas manuales.'),
(33, 'Joyería', 'Diseño artístico de adornos y accesorios.'),
(34, 'Orfebrería', 'Trabajo artístico en metales preciosos.'),
(35, 'Música y danza folclóricas', 'Expresiones musicales y coreográficas tradicionales.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chats`
--

CREATE TABLE `chats` (
  `id_chat` int(11) NOT NULL,
  `id_usuario1` int(11) NOT NULL,
  `id_usuario2` int(11) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `ultima_actividad` timestamp NOT NULL DEFAULT current_timestamp(),
  `fondo_chat_usuario1` varchar(50) DEFAULT 'default',
  `color_burbuja_usuario1` varchar(20) DEFAULT '#6C63FF',
  `fondo_chat_usuario2` varchar(50) DEFAULT 'default',
  `color_burbuja_usuario2` varchar(20) DEFAULT '#6C63FF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `chats`
--

INSERT INTO `chats` (`id_chat`, `id_usuario1`, `id_usuario2`, `fecha_creacion`, `ultima_actividad`, `fondo_chat_usuario1`, `color_burbuja_usuario1`, `fondo_chat_usuario2`, `color_burbuja_usuario2`) VALUES
(1, 56, 57, '2025-11-28 06:58:33', '2025-12-01 00:59:06', 'default', '#61ff88', 'default', '#6C63FF'),
(4, 58, 1, '2025-12-01 03:01:52', '2025-12-01 03:02:23', 'default', '#ff00ea', 'default', '#6C63FF'),
(5, 58, 57, '2025-12-01 03:01:54', '2025-12-01 03:02:27', 'default', '#6C63FF', 'default', '#6C63FF'),
(6, 56, 58, '2025-12-01 03:14:10', '2025-12-01 06:16:42', 'blue', '#000000', 'default', '#6C63FF'),
(7, 56, 22, '2025-12-01 06:15:11', '2025-12-01 06:15:25', 'default', '#6C63FF', 'default', '#6C63FF');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colecciones_arte`
--

CREATE TABLE `colecciones_arte` (
  `id_coleccion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `colecciones_arte`
--

INSERT INTO `colecciones_arte` (`id_coleccion`, `id_usuario`, `nombre`, `descripcion`, `fecha_creacion`) VALUES
(1, 1, 'Favoritos del mes', 'Obras destacadas del mes', '2025-01-15 08:00:00'),
(2, 2, 'Inspiración natural', 'Obras con paisajes y naturaleza', '2025-01-15 08:10:00'),
(3, 3, 'Escultura top', 'Esculturas que me inspiran', '2025-01-15 08:20:00'),
(4, 4, 'Mis ilustraciones', 'Colección personal de ilustraciones', '2025-01-15 08:30:00'),
(5, 5, 'Técnica mixta', 'Mezcla de estilos y técnicas', '2025-01-15 08:40:00'),
(6, 6, 'Acuarelas suaves', 'Obras en acuarela con tonos suaves', '2025-01-15 08:50:00'),
(7, 7, 'Arte digital', 'Obras realizadas en digital', '2025-01-15 09:00:00'),
(8, 8, 'Tinta & papel', 'Dibujos en tinta', '2025-01-15 09:10:00'),
(9, 9, 'Collage creativo', 'Recortes e ideas en papel', '2025-01-15 09:20:00'),
(10, 10, 'Murales favoritos', 'Pinturas en muros urbanos', '2025-01-15 09:30:00'),
(11, 11, 'Colores vivos', 'Obras con colores fuertes y brillantes', '2025-01-15 09:40:00'),
(12, 12, 'Sombras y luces', 'Estudio de contrastes', '2025-01-15 09:50:00'),
(13, 13, 'Clásicos modernos', 'Obras de arte moderno que me encantan', '2025-01-15 10:00:00'),
(14, 14, 'Bocetos', 'Dibujos y esbozos iniciales', '2025-01-15 10:10:00'),
(15, 15, 'Arte político', 'Obras con mensajes sociales', '2025-01-15 10:20:00'),
(16, 16, 'Retratos', 'Rostros humanos expresivos', '2025-01-15 10:30:00'),
(17, 17, 'Animales', 'Obras de fauna real e imaginaria', '2025-01-15 10:40:00'),
(18, 18, 'Obras compartidas', 'Obras que otros me recomendaron', '2025-01-15 10:50:00'),
(19, 19, 'Estilo pop', 'Colores y estilo de cultura pop', '2025-01-15 11:00:00'),
(20, 20, 'Escenarios urbanos', 'Arte sobre la ciudad', '2025-01-15 11:10:00'),
(21, 21, 'Detalles pequeños', 'Miniaturas y detalles finos', '2025-01-15 11:20:00'),
(22, 22, 'Rostros famosos', 'Personajes conocidos en el arte', '2025-01-15 11:30:00'),
(23, 23, 'Fotografía artística', 'Imágenes con mirada artística', '2025-01-15 11:40:00'),
(24, 24, 'Mi historia', 'Obras que me representan', '2025-01-15 11:50:00'),
(25, 25, 'Composición digital', 'Ediciones y montajes creativos', '2025-01-15 12:00:00'),
(26, 26, 'Infancia', 'Obras sobre la niñez y juego', '2025-01-15 12:10:00'),
(27, 27, 'Arte visual 2025', 'Lo mejor del arte de este año', '2025-01-15 12:20:00'),
(28, 28, 'Estilo libre', 'Obras sin categoría definida', '2025-01-15 12:30:00'),
(29, 29, 'Proyecto final', 'Obras para mi portafolio', '2025-01-15 12:40:00'),
(30, 30, 'Simbolismo', 'Obras con gran carga simbólica', '2025-01-15 12:50:00'),
(31, 1, 'Inspiración Visual', 'Obras que me inspiran a diario', '2025-08-24 12:50:42'),
(32, 2, 'Mis Favoritas', 'Colección de mis obras favoritas', '2025-08-24 12:50:42'),
(33, 3, 'Pinturas al óleo', 'Pinturas seleccionadas al óleo', '2025-08-24 12:50:42'),
(34, 4, 'Galería Urbana', 'Arte callejero y urbano', '2025-08-24 12:50:42'),
(35, 5, 'Realismo Mágico', 'Obras con estilo surrealista y mágico', '2025-08-24 12:50:42'),
(36, 6, 'Sombras y Luces', 'Estudio de contraste en obras', '2025-08-24 12:50:42'),
(37, 7, 'Naturaleza Viva', 'Pinturas y fotos de la naturaleza', '2025-08-24 12:50:42'),
(38, 8, 'Digital World', 'Arte hecho con herramientas digitales', '2025-08-24 12:50:42'),
(39, 9, 'Expresionismo', 'Obras con estilo expresionista', '2025-08-24 12:50:42'),
(40, 10, 'Tinta Negra', 'Dibujos en tinta monocromática', '2025-08-24 12:50:42'),
(41, 11, 'Arte Geométrico', 'Formas abstractas y geométricas', '2025-08-24 12:50:42'),
(42, 12, 'Impresionismo', 'Pinceladas libres y colores vivos', '2025-08-24 12:50:42'),
(43, 13, 'Retratos', 'Colección de retratos de artistas emergentes', '2025-08-24 12:50:42'),
(44, 14, 'Mis composiciones', 'Obras propias guardadas', '2025-08-24 12:50:42'),
(45, 15, 'Arte Literario', 'Obras que nacen de la literatura', '2025-08-24 12:50:42'),
(46, 16, 'El Color Azul', 'Obras dominadas por el color azul', '2025-08-24 12:50:42'),
(47, 17, 'Minimalismo', 'Colección de arte minimalista', '2025-08-24 12:50:42'),
(48, 18, 'Mis bocetos', 'Bocetos iniciales e ideas crudas', '2025-08-24 12:50:42'),
(49, 19, 'Sombras del alma', 'Colección con emociones oscuras', '2025-08-24 12:50:42'),
(50, 20, 'Arte Experimental', 'Obras fuera de lo convencional', '2025-08-24 12:50:42'),
(51, 21, 'Poesía Visual', 'Obras que mezclan palabra e imagen', '2025-08-24 12:50:42'),
(52, 22, 'Cultura Pop', 'Obras influenciadas por la cultura popular', '2025-08-24 12:50:42'),
(53, 23, 'Mujeres en el Arte', 'Obras hechas por y sobre mujeres', '2025-08-24 12:50:42'),
(54, 24, 'Monocromos', 'Obras en una sola tonalidad', '2025-08-24 12:50:42'),
(55, 25, 'Simbolismo', 'Colección cargada de símbolos y metáforas', '2025-08-24 12:50:42'),
(56, 26, 'Viajes y paisajes', 'Obras inspiradas en viajes', '2025-08-24 12:50:42'),
(57, 27, 'Arte latinoamericano', 'Obras de autores latinos', '2025-08-24 12:50:42'),
(58, 28, 'Infantil y colorido', 'Obras alegres y para todas las edades', '2025-08-24 12:50:42'),
(59, 29, 'Misterio y oscuridad', 'Obras en estilo gótico y oscuro', '2025-08-24 12:50:42'),
(60, 30, 'Fragmentos de mí', 'Obras con las que me identifico', '2025-08-24 12:50:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colecciones_obras`
--

CREATE TABLE `colecciones_obras` (
  `id` int(11) NOT NULL,
  `id_coleccion` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `colecciones_obras`
--

INSERT INTO `colecciones_obras` (`id`, `id_coleccion`, `id_publicacion`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 3, 5),
(6, 3, 6),
(7, 4, 7),
(8, 4, 8),
(9, 5, 9),
(10, 5, 10),
(11, 6, 11),
(12, 6, 12),
(13, 7, 13),
(14, 7, 14),
(15, 8, 15),
(16, 8, 16),
(17, 9, 17),
(18, 9, 18),
(19, 10, 19),
(20, 10, 20),
(21, 11, 21),
(22, 11, 22),
(23, 12, 23),
(24, 12, 24),
(25, 13, 25),
(26, 13, 26),
(27, 14, 27),
(28, 14, 28),
(29, 15, 29),
(30, 15, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_publicacion` int(11) DEFAULT NULL,
  `id_comentario_padre` int(11) DEFAULT NULL,
  `contenido` varchar(500) NOT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentario`, `id_usuario`, `id_publicacion`, `id_comentario_padre`, `contenido`, `fecha`) VALUES
(1, 57, 22, NULL, 'sxsxsx', '2025-11-12 17:34:42'),
(2, 57, 22, 1, 'sxxsxsxx', '2025-11-12 17:34:46'),
(3, 56, 22, NULL, 'cdcdcdc', '2025-11-12 17:34:59'),
(4, 56, 22, 2, 'cdcdcd', '2025-11-12 17:35:06'),
(5, 56, 22, 4, 'jjjj', '2025-11-12 21:13:08'),
(6, 56, 22, 3, 'nhnhnhn', '2025-11-12 21:13:12'),
(7, 56, 22, 1, 'bbfbfbfbf', '2025-11-12 21:13:20'),
(8, 56, 22, 4, 'c c c c', '2025-11-12 21:13:26'),
(9, 56, 22, 8, 'j', '2025-11-12 21:13:33'),
(10, 57, 22, NULL, 'ffbfb', '2025-11-12 22:13:14'),
(11, 57, 22, NULL, ' hhhhh', '2025-11-12 22:13:18'),
(12, 56, 16, NULL, 'vfvvfv', '2025-11-14 01:03:07'),
(13, 56, 21, NULL, 'dcdcdc', '2025-11-14 01:03:13'),
(14, 56, 21, NULL, 'frfrfr', '2025-11-14 01:03:35'),
(15, 56, 21, 13, 'frfrfrf', '2025-11-14 01:03:38'),
(16, 56, 21, 15, 'frfrfrfr', '2025-11-14 01:03:41'),
(17, 56, 21, NULL, 'efefe', '2025-11-14 01:31:56'),
(18, 56, 22, NULL, 'dddeeeed', '2025-11-16 17:29:21'),
(19, 56, 22, NULL, 'd', '2025-11-16 17:37:07'),
(20, 56, 22, NULL, 'gato', '2025-11-16 17:37:40'),
(21, 56, 22, NULL, 'hola', '2025-11-16 17:40:57'),
(22, 56, 22, NULL, 'perro', '2025-11-16 17:41:06'),
(23, 56, 22, 22, 'zorro', '2025-11-16 17:41:30'),
(24, 56, 22, 23, 'mica', '2025-11-16 17:41:51'),
(25, 56, 22, NULL, 'gata', '2025-11-16 17:48:54'),
(28, 56, 22, NULL, 'njmk', '2025-11-16 18:35:04'),
(29, 56, 22, 1, 'dfvdfg', '2025-11-16 18:35:09'),
(30, 56, 7, NULL, 'efefe', '2025-11-16 18:48:23'),
(31, 56, 7, 30, 'fefef', '2025-11-16 18:48:26'),
(33, 57, 1, NULL, 'x', '2025-11-24 16:15:38'),
(34, 57, 22, NULL, 'cdcdcd', '2025-11-24 20:03:04'),
(39, 56, 18, NULL, 'siii{', '2025-11-25 23:24:57'),
(41, 56, 18, NULL, 'ccscsc', '2025-11-27 20:17:31'),
(43, 56, 18, 41, 'bbbgbgbgbgbgb', '2025-12-01 00:13:23'),
(44, 56, 18, 43, ' v v v v v v ', '2025-12-01 00:13:30'),
(45, 56, 18, NULL, ' v v v v v v', '2025-12-01 00:13:39'),
(46, 56, 18, NULL, ' c c c c c ', '2025-12-01 00:13:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios_obra`
--

CREATE TABLE `comentarios_obra` (
  `id_comentario` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `contenido` text NOT NULL,
  `fecha_comentario` datetime DEFAULT current_timestamp(),
  `id_comentario_padre` int(11) DEFAULT NULL,
  `tipo_reaccion` enum('ninguna','me gusta','me encanta','wow') DEFAULT 'ninguna',
  `estado` enum('visible','oculto','reportado') DEFAULT 'visible',
  `es_editado` tinyint(1) DEFAULT 0,
  `numero_reportes` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentarios_obra`
--

INSERT INTO `comentarios_obra` (`id_comentario`, `id_usuario`, `id_publicacion`, `contenido`, `fecha_comentario`, `id_comentario_padre`, `tipo_reaccion`, `estado`, `es_editado`, `numero_reportes`) VALUES
(1, 2, 1, 'Me encanta el paisaje', '2025-01-12 08:00:00', NULL, 'me gusta', 'visible', 0, 0),
(2, 3, 1, 'Los colores son muy vivos', '2025-01-12 08:10:00', NULL, 'me encanta', 'visible', 0, 0),
(3, 4, 2, 'Gran técnica en la escultura', '2025-01-12 08:15:00', NULL, 'wow', 'visible', 0, 0),
(4, 5, 3, 'La luz está perfectamente capturada', '2025-01-12 08:20:00', NULL, 'me gusta', 'visible', 0, 0),
(5, 6, 4, 'Muy buen uso de herramientas digitales', '2025-01-12 08:30:00', NULL, 'me encanta', 'visible', 0, 0),
(6, 7, 5, 'Inspirador diseño', '2025-01-12 08:40:00', NULL, 'wow', 'visible', 0, 0),
(7, 8, 6, '¡Quiero ver más ilustraciones!', '2025-01-12 08:50:00', NULL, 'me gusta', 'visible', 0, 0),
(8, 9, 7, 'Los tonos son perfectos', '2025-01-12 09:00:00', NULL, 'me encanta', 'visible', 0, 0),
(9, 10, 8, 'La línea es precisa y expresiva', '2025-01-12 09:10:00', NULL, 'wow', 'visible', 0, 0),
(10, 11, 9, 'Hermoso trabajo de collage', '2025-01-12 09:20:00', NULL, 'me gusta', 'visible', 0, 0),
(11, 12, 10, '¡Ese mural tiene mucho impacto!', '2025-01-12 09:30:00', NULL, 'me encanta', 'visible', 0, 0),
(12, 13, 11, 'Vibrante y con actitud', '2025-01-12 09:40:00', NULL, 'wow', 'visible', 0, 0),
(13, 14, 12, 'Una abstracción que comunica', '2025-01-12 09:50:00', NULL, 'me gusta', 'visible', 0, 0),
(14, 15, 13, 'Muy realista, casi parece una foto', '2025-01-12 10:00:00', NULL, 'me encanta', 'visible', 0, 0),
(15, 16, 14, 'Conceptualmente poderoso', '2025-01-12 10:10:00', NULL, 'wow', 'visible', 0, 0),
(16, 17, 15, 'Buen retrato, transmite emoción', '2025-01-12 10:20:00', NULL, 'me gusta', 'visible', 0, 0),
(17, 18, 16, 'Hermosa acuarela', '2025-01-12 10:30:00', NULL, 'me encanta', 'visible', 0, 0),
(18, 19, 17, '¿Dónde fue esta performance?', '2025-01-12 10:40:00', NULL, 'wow', 'visible', 0, 0),
(19, 20, 18, 'Colores muy llamativos', '2025-01-12 10:50:00', NULL, 'me gusta', 'visible', 0, 0),
(20, 21, 19, 'Buen mensaje social', '2025-01-12 11:00:00', NULL, 'me encanta', 'visible', 0, 0),
(21, 22, 20, 'Sonido envolvente', '2025-01-12 11:10:00', NULL, 'wow', 'visible', 0, 0),
(22, 23, 21, 'Elegante caligrafía', '2025-01-12 11:20:00', NULL, 'me gusta', 'visible', 0, 0),
(23, 24, 22, '¡Increíble tejido!', '2025-01-12 11:30:00', NULL, 'me encanta', 'visible', 0, 0),
(24, 25, 23, 'Me gusta el diseño de la app', '2025-01-12 11:40:00', NULL, 'wow', 'visible', 0, 0),
(25, 26, 24, 'Muy interesante uso cultural', '2025-01-12 11:50:00', NULL, 'me gusta', 'visible', 0, 0),
(26, 27, 25, 'Buena composición', '2025-01-12 12:00:00', NULL, 'me encanta', 'visible', 0, 0),
(27, 28, 26, 'Impactante mensaje', '2025-01-12 12:10:00', NULL, 'wow', 'visible', 0, 0),
(28, 29, 27, 'Me gusta el diseño', '2025-01-12 12:20:00', NULL, 'me gusta', 'visible', 0, 0),
(29, 30, 28, 'Textura muy bien lograda', '2025-01-12 12:30:00', NULL, 'me encanta', 'visible', 0, 0),
(30, 1, 1, 'Gracias por compartir', '2025-01-12 12:40:00', 1, 'me gusta', 'visible', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compartidos`
--

CREATE TABLE `compartidos` (
  `id_compartido` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `mensaje` text DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `expiracion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compartidos`
--

INSERT INTO `compartidos` (`id_compartido`, `id_usuario`, `id_publicacion`, `tipo`, `mensaje`, `fecha`, `expiracion`) VALUES
(40, 58, 6, 'amigos', '', '2025-11-24 16:54:15', NULL),
(44, 58, 12, 'amigos', '', '2025-11-24 23:59:38', NULL),
(60, 56, 16, 'amigos', '', '2025-11-25 23:55:19', NULL),
(61, 56, 15, 'amigos', '', '2025-11-25 23:55:44', NULL),
(62, 56, 14, 'perfil', '', '2025-11-25 23:56:03', NULL),
(63, 56, 18, 'amigos', '', '2025-11-27 20:17:25', NULL),
(64, 57, 66, 'perfil', 'si', '2025-11-27 21:09:45', NULL),
(66, 56, 66, 'amigos', '', '2025-12-01 00:12:50', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuraciones_chat`
--

CREATE TABLE `configuraciones_chat` (
  `id` int(11) NOT NULL,
  `id_chat` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fondo_chat` varchar(50) DEFAULT NULL,
  `color_burbuja` varchar(7) DEFAULT NULL,
  `fondo_personalizado` varchar(500) DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuraciones_chat`
--

INSERT INTO `configuraciones_chat` (`id`, `id_chat`, `id_usuario`, `fondo_chat`, `color_burbuja`, `fondo_personalizado`, `fecha_actualizacion`) VALUES
(1, 6, 56, 'pattern-grid', '#d06bff', NULL, '2025-12-01 00:11:55'),
(2, 1, 56, 'pattern-dots', '#BB8FCE', NULL, '2025-12-01 01:17:28'),
(3, 7, 56, 'gradient-sunset', '#e4a572', NULL, '2025-12-01 01:17:46'),
(4, 6, 58, 'pink', '#BB8FCE', NULL, '2025-12-01 01:16:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_usuario`
--

CREATE TABLE `configuracion_usuario` (
  `id_configuracion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `modo_oscuro` tinyint(1) DEFAULT 0,
  `tamaño_fuente` enum('pequeño','mediano','grande') DEFAULT 'mediano',
  `alto_contraste` tinyint(1) DEFAULT 0,
  `idioma_preferido` varchar(50) DEFAULT 'español',
  `privacidad_perfil` enum('publico','privado','solo_amigos') DEFAULT 'publico',
  `recibir_notificaciones` tinyint(1) DEFAULT 1,
  `fecha_actualizacion` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `configuracion_usuario`
--

INSERT INTO `configuracion_usuario` (`id_configuracion`, `id_usuario`, `modo_oscuro`, `tamaño_fuente`, `alto_contraste`, `idioma_preferido`, `privacidad_perfil`, `recibir_notificaciones`, `fecha_actualizacion`) VALUES
(1, 1, 1, 'mediano', 0, 'español', 'publico', 1, '2025-08-24 12:50:42'),
(2, 2, 0, 'grande', 1, 'inglés', 'privado', 1, '2025-08-24 12:50:42'),
(3, 3, 1, 'pequeño', 0, 'portugués', 'solo_amigos', 0, '2025-08-24 12:50:42'),
(4, 4, 0, 'mediano', 0, 'español', 'publico', 1, '2025-08-24 12:50:42'),
(5, 5, 1, 'grande', 1, 'francés', 'privado', 0, '2025-08-24 12:50:42'),
(6, 6, 1, 'mediano', 0, 'alemán', 'solo_amigos', 1, '2025-08-24 12:50:42'),
(7, 7, 0, 'pequeño', 1, 'español', 'publico', 1, '2025-08-24 12:50:42'),
(8, 8, 1, 'grande', 0, 'italiano', 'privado', 1, '2025-08-24 12:50:42'),
(9, 9, 0, 'mediano', 0, 'español', 'solo_amigos', 0, '2025-08-24 12:50:42'),
(10, 10, 1, 'pequeño', 1, 'español', 'publico', 1, '2025-08-24 12:50:42'),
(11, 11, 1, 'mediano', 0, 'japonés', 'privado', 0, '2025-08-24 12:50:42'),
(12, 12, 0, 'grande', 1, 'español', 'solo_amigos', 1, '2025-08-24 12:50:42'),
(13, 13, 1, 'mediano', 1, 'coreano', 'publico', 1, '2025-08-24 12:50:42'),
(14, 14, 0, 'pequeño', 0, 'español', 'privado', 1, '2025-08-24 12:50:42'),
(15, 15, 1, 'grande', 1, 'inglés', 'solo_amigos', 0, '2025-08-24 12:50:42'),
(16, 16, 0, 'mediano', 0, 'español', 'publico', 1, '2025-08-24 12:50:42'),
(17, 17, 1, 'pequeño', 1, 'francés', 'privado', 1, '2025-08-24 12:50:42'),
(18, 18, 1, 'grande', 0, 'español', 'solo_amigos', 1, '2025-08-24 12:50:42'),
(19, 19, 0, 'mediano', 1, 'alemán', 'publico', 0, '2025-08-24 12:50:42'),
(20, 20, 1, 'pequeño', 0, 'español', 'privado', 1, '2025-08-24 12:50:42'),
(21, 21, 0, 'grande', 1, 'italiano', 'solo_amigos', 1, '2025-08-24 12:50:42'),
(22, 22, 1, 'mediano', 1, 'portugués', 'publico', 1, '2025-08-24 12:50:42'),
(23, 23, 0, 'pequeño', 0, 'español', 'privado', 0, '2025-08-24 12:50:42'),
(24, 24, 1, 'grande', 1, 'español', 'solo_amigos', 1, '2025-08-24 12:50:42'),
(25, 25, 0, 'mediano', 0, 'español', 'publico', 1, '2025-08-24 12:50:42'),
(26, 26, 1, 'pequeño', 1, 'inglés', 'privado', 1, '2025-08-24 12:50:42'),
(27, 27, 0, 'grande', 0, 'francés', 'solo_amigos', 0, '2025-08-24 12:50:42'),
(28, 28, 1, 'mediano', 1, 'español', 'publico', 1, '2025-08-24 12:50:42'),
(29, 29, 0, 'pequeño', 0, 'alemán', 'privado', 1, '2025-08-24 12:50:42'),
(30, 30, 1, 'grande', 1, 'español', 'solo_amigos', 1, '2025-08-24 12:50:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeria_arte`
--

CREATE TABLE `galeria_arte` (
  `id_galeria` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `tipo` enum('destacada','nueva','popular','recomendada') DEFAULT 'nueva',
  `fecha_agregado` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `galeria_arte`
--

INSERT INTO `galeria_arte` (`id_galeria`, `id_publicacion`, `tipo`, `fecha_agregado`) VALUES
(1, 1, 'destacada', '2025-01-18 08:00:00'),
(2, 2, 'nueva', '2025-01-18 08:05:00'),
(3, 3, 'popular', '2025-01-18 08:10:00'),
(4, 4, 'recomendada', '2025-01-18 08:15:00'),
(5, 5, 'destacada', '2025-01-18 08:20:00'),
(6, 6, 'nueva', '2025-01-18 08:25:00'),
(7, 7, 'popular', '2025-01-18 08:30:00'),
(8, 8, 'recomendada', '2025-01-18 08:35:00'),
(9, 9, 'destacada', '2025-01-18 08:40:00'),
(10, 10, 'nueva', '2025-01-18 08:45:00'),
(11, 11, 'popular', '2025-01-18 08:50:00'),
(12, 12, 'recomendada', '2025-01-18 08:55:00'),
(13, 13, 'destacada', '2025-01-18 09:00:00'),
(14, 14, 'nueva', '2025-01-18 09:05:00'),
(15, 15, 'popular', '2025-01-18 09:10:00'),
(16, 16, 'recomendada', '2025-01-18 09:15:00'),
(17, 17, 'destacada', '2025-01-18 09:20:00'),
(18, 18, 'nueva', '2025-01-18 09:25:00'),
(19, 19, 'popular', '2025-01-18 09:30:00'),
(20, 20, 'recomendada', '2025-01-18 09:35:00'),
(21, 21, 'destacada', '2025-01-18 09:40:00'),
(22, 22, 'nueva', '2025-01-18 09:45:00'),
(23, 23, 'popular', '2025-01-18 09:50:00'),
(24, 24, 'recomendada', '2025-01-18 09:55:00'),
(25, 25, 'destacada', '2025-01-18 10:00:00'),
(26, 26, 'nueva', '2025-01-18 10:05:00'),
(27, 27, 'popular', '2025-01-18 10:10:00'),
(28, 28, 'recomendada', '2025-01-18 10:15:00'),
(29, 29, 'destacada', '2025-01-18 10:20:00'),
(30, 30, 'nueva', '2025-01-18 10:25:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guardados`
--

CREATE TABLE `guardados` (
  `id_guardado` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_publicacion` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `guardados`
--

INSERT INTO `guardados` (`id_guardado`, `id_usuario`, `id_publicacion`, `fecha`) VALUES
(2, 56, 12, '2025-11-12 16:56:34'),
(3, 56, 14, '2025-11-12 16:56:36'),
(12, 57, 22, '2025-11-14 21:13:07'),
(13, 57, 4, '2025-11-16 17:20:34'),
(19, 56, 7, '2025-11-16 18:48:20'),
(23, 56, 22, '2025-11-25 02:23:32'),
(24, 56, 21, '2025-11-25 02:23:33'),
(26, 56, 16, '2025-11-25 02:23:36'),
(27, 56, 13, '2025-11-25 02:23:51'),
(34, 57, 16, '2025-11-25 23:40:54'),
(37, 56, 18, '2025-11-27 20:17:52'),
(38, 57, 66, '2025-11-27 20:31:40'),
(39, 56, 66, '2025-11-28 02:07:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guardados_obra`
--

CREATE TABLE `guardados_obra` (
  `id_guardado` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `fecha_guardado` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `guardados_obra`
--

INSERT INTO `guardados_obra` (`id_guardado`, `id_usuario`, `id_publicacion`, `fecha_guardado`) VALUES
(1, 1, 5, '2025-08-24 12:50:42'),
(2, 2, 8, '2025-08-24 12:50:42'),
(3, 3, 3, '2025-08-24 12:50:42'),
(4, 4, 12, '2025-08-24 12:50:42'),
(5, 5, 1, '2025-08-24 12:50:42'),
(6, 6, 6, '2025-08-24 12:50:42'),
(7, 7, 2, '2025-08-24 12:50:42'),
(8, 8, 4, '2025-08-24 12:50:42'),
(9, 9, 9, '2025-08-24 12:50:42'),
(10, 10, 7, '2025-08-24 12:50:42'),
(11, 11, 10, '2025-08-24 12:50:42'),
(12, 12, 11, '2025-08-24 12:50:42'),
(13, 13, 13, '2025-08-24 12:50:42'),
(14, 14, 14, '2025-08-24 12:50:42'),
(15, 15, 15, '2025-08-24 12:50:42'),
(16, 16, 16, '2025-08-24 12:50:42'),
(17, 17, 17, '2025-08-24 12:50:42'),
(18, 18, 18, '2025-08-24 12:50:42'),
(19, 19, 19, '2025-08-24 12:50:42'),
(20, 20, 20, '2025-08-24 12:50:42'),
(21, 21, 21, '2025-08-24 12:50:42'),
(22, 22, 22, '2025-08-24 12:50:42'),
(23, 23, 23, '2025-08-24 12:50:42'),
(24, 24, 24, '2025-08-24 12:50:42'),
(25, 25, 25, '2025-08-24 12:50:42'),
(26, 26, 26, '2025-08-24 12:50:42'),
(27, 27, 27, '2025-08-24 12:50:42'),
(28, 28, 28, '2025-08-24 12:50:42'),
(29, 29, 29, '2025-08-24 12:50:42'),
(30, 30, 30, '2025-08-24 12:50:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_interacciones_obra`
--

CREATE TABLE `historial_interacciones_obra` (
  `id_historial` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `accion` varchar(255) DEFAULT NULL,
  `fecha_accion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_interacciones_obra`
--

INSERT INTO `historial_interacciones_obra` (`id_historial`, `id_publicacion`, `id_usuario`, `accion`, `fecha_accion`) VALUES
(1, 1, 2, 'Comentario', '2025-01-12 13:00:00'),
(2, 2, 3, 'Like', '2025-01-12 13:05:00'),
(3, 3, 4, 'Comentario', '2025-01-12 13:10:00'),
(4, 4, 5, 'Guardado', '2025-01-12 13:15:00'),
(5, 5, 6, 'Compartido', '2025-01-12 13:20:00'),
(6, 6, 7, 'Like', '2025-01-12 13:25:00'),
(7, 7, 8, 'Comentario', '2025-01-12 13:30:00'),
(8, 8, 9, 'Reporte', '2025-01-12 13:35:00'),
(9, 9, 10, 'Editado', '2025-01-12 13:40:00'),
(10, 10, 11, 'Comentario', '2025-01-12 13:45:00'),
(11, 11, 12, 'Like', '2025-01-12 13:50:00'),
(12, 12, 13, 'Guardado', '2025-01-12 13:55:00'),
(13, 13, 14, 'Comentario', '2025-01-12 14:00:00'),
(14, 14, 15, 'Like', '2025-01-12 14:05:00'),
(15, 15, 16, 'Guardado', '2025-01-12 14:10:00'),
(16, 16, 17, 'Reporte', '2025-01-12 14:15:00'),
(17, 17, 18, 'Comentario', '2025-01-12 14:20:00'),
(18, 18, 19, 'Like', '2025-01-12 14:25:00'),
(19, 19, 20, 'Comentario', '2025-01-12 14:30:00'),
(20, 20, 21, 'Guardado', '2025-01-12 14:35:00'),
(21, 21, 22, 'Comentario', '2025-01-12 14:40:00'),
(22, 22, 23, 'Like', '2025-01-12 14:45:00'),
(23, 23, 24, 'Comentario', '2025-01-12 14:50:00'),
(24, 24, 25, 'Compartido', '2025-01-12 14:55:00'),
(25, 25, 26, 'Comentario', '2025-01-12 15:00:00'),
(26, 26, 27, 'Like', '2025-01-12 15:05:00'),
(27, 27, 28, 'Guardado', '2025-01-12 15:10:00'),
(28, 28, 29, 'Reporte', '2025-01-12 15:15:00'),
(29, 29, 30, 'Comentario', '2025-01-12 15:20:00'),
(30, 30, 1, 'Like', '2025-01-12 15:25:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `likes_obra`
--

CREATE TABLE `likes_obra` (
  `id_like` int(11) NOT NULL,
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `tipo_reaccion` varchar(20) DEFAULT NULL,
  `fecha_like` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `likes_obra`
--

INSERT INTO `likes_obra` (`id_like`, `id_publicacion`, `id_usuario`, `tipo_reaccion`, `fecha_like`) VALUES
(1, 1, 2, 'me gusta', '2025-01-11 08:00:00'),
(2, 2, 3, 'me encanta', '2025-01-11 08:10:00'),
(3, 3, 4, 'wow', '2025-01-11 08:20:00'),
(4, 4, 5, 'me gusta', '2025-01-11 08:30:00'),
(5, 5, 6, 'me encanta', '2025-01-11 08:40:00'),
(6, 6, 7, 'wow', '2025-01-11 08:50:00'),
(7, 7, 8, 'me gusta', '2025-01-11 09:00:00'),
(8, 8, 9, 'me encanta', '2025-01-11 09:10:00'),
(9, 9, 10, 'wow', '2025-01-11 09:20:00'),
(10, 10, 11, 'me gusta', '2025-01-11 09:30:00'),
(11, 11, 12, 'me encanta', '2025-01-11 09:40:00'),
(12, 12, 13, 'wow', '2025-01-11 09:50:00'),
(13, 13, 14, 'me gusta', '2025-01-11 10:00:00'),
(14, 14, 15, 'me encanta', '2025-01-11 10:10:00'),
(15, 15, 16, 'wow', '2025-01-11 10:20:00'),
(16, 16, 17, 'me gusta', '2025-01-11 10:30:00'),
(17, 17, 18, 'me encanta', '2025-01-11 10:40:00'),
(18, 18, 19, 'wow', '2025-01-11 10:50:00'),
(19, 19, 20, 'me gusta', '2025-01-11 11:00:00'),
(20, 20, 21, 'me encanta', '2025-01-11 11:10:00'),
(21, 21, 22, 'wow', '2025-01-11 11:20:00'),
(22, 22, 23, 'me gusta', '2025-01-11 11:30:00'),
(23, 23, 24, 'me encanta', '2025-01-11 11:40:00'),
(24, 24, 25, 'wow', '2025-01-11 11:50:00'),
(25, 25, 26, 'me gusta', '2025-01-11 12:00:00'),
(26, 26, 27, 'me encanta', '2025-01-11 12:10:00'),
(27, 27, 28, 'wow', '2025-01-11 12:20:00'),
(28, 28, 29, 'me gusta', '2025-01-11 12:30:00'),
(29, 29, 30, 'me encanta', '2025-01-11 12:40:00'),
(30, 30, 1, 'wow', '2025-01-11 12:50:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id_mensaje` int(11) NOT NULL,
  `id_chat` int(11) NOT NULL,
  `id_emisor` int(11) NOT NULL,
  `contenido` text NOT NULL,
  `tipo` varchar(20) DEFAULT 'texto',
  `archivo_url` varchar(500) DEFAULT NULL,
  `fecha_envio` timestamp NOT NULL DEFAULT current_timestamp(),
  `leido` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id_mensaje`, `id_chat`, `id_emisor`, `contenido`, `tipo`, `archivo_url`, `fecha_envio`, `leido`) VALUES
(1, 1, 56, 'siisi', 'texto', NULL, '2025-11-28 06:59:20', 0),
(2, 1, 56, 'ffv', 'texto', NULL, '2025-11-28 07:07:16', 0),
(5, 1, 56, 'si', 'texto', NULL, '2025-12-01 00:55:37', 0),
(7, 1, 56, 'dccdc', 'texto', NULL, '2025-12-01 00:59:06', 0),
(34, 4, 58, 'si', 'texto', NULL, '2025-12-01 03:02:23', 0),
(35, 5, 58, 'ddd', 'texto', NULL, '2025-12-01 03:02:27', 0),
(40, 6, 56, 'eded', 'texto', NULL, '2025-12-01 03:15:38', 1),
(42, 6, 58, '📎 video 1 pruebas.mp4', 'video', '/static/chat_files/videos/bbb1ae99-91a9-4e8f-8c36-4168a9f0c215.mp4', '2025-12-01 03:34:24', 1),
(45, 6, 56, '📎 video 1 pruebas.mp4', 'video', '/static/chat_files/videos/28109ab2-6b9d-4d5f-903a-62d317f6b598.mp4', '2025-12-01 03:35:10', 1),
(47, 7, 56, 'hola', 'texto', NULL, '2025-12-01 06:15:25', 0),
(48, 6, 58, '📎 6.jpg', 'imagen', '/static/chat_files/images/8a84f21a-889a-4cfa-96c0-189659646f03.jpg', '2025-12-01 06:16:42', 1),
(49, 6, 58, 'si', 'texto', NULL, '2025-12-01 06:16:42', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_eliminados`
--

CREATE TABLE `mensajes_eliminados` (
  `id` int(11) NOT NULL,
  `id_mensaje` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mensajes_eliminados`
--

INSERT INTO `mensajes_eliminados` (`id`, `id_mensaje`, `id_usuario`, `fecha_eliminacion`) VALUES
(2, 40, 58, '2025-11-30 22:31:35'),
(3, 42, 58, '2025-11-30 22:34:27'),
(4, 42, 56, '2025-11-30 22:34:45'),
(7, 40, 56, '2025-11-30 22:34:49'),
(11, 7, 56, '2025-12-01 01:15:59'),
(12, 45, 58, '2025-12-01 01:16:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `me_gusta`
--

CREATE TABLE `me_gusta` (
  `id_megusta` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_publicacion` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `me_gusta`
--

INSERT INTO `me_gusta` (`id_megusta`, `id_usuario`, `id_publicacion`, `fecha`) VALUES
(2, 57, 22, '2025-11-12 16:52:55'),
(3, 56, 15, '2025-11-12 16:56:31'),
(5, 56, 13, '2025-11-12 16:56:33'),
(6, 56, 12, '2025-11-12 16:56:35'),
(13, 56, 21, '2025-11-14 00:59:27'),
(14, 56, 7, '2025-11-14 01:04:44'),
(17, 57, 18, '2025-11-16 17:20:00'),
(18, 57, 4, '2025-11-16 17:20:32'),
(27, 57, 21, '2025-11-23 14:27:56'),
(30, 56, 22, '2025-11-25 02:20:56'),
(36, 57, 16, '2025-11-25 23:40:53'),
(41, 57, 66, '2025-11-27 20:31:39'),
(42, 56, 66, '2025-11-28 02:07:39'),
(45, 56, 18, '2025-11-30 21:58:12'),
(46, 56, 16, '2025-12-01 00:05:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `me_gusta_comentarios`
--

CREATE TABLE `me_gusta_comentarios` (
  `id_megusta_comentario` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_comentario` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `mensaje` varchar(255) NOT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha` datetime DEFAULT current_timestamp(),
  `tipo` varchar(100) DEFAULT NULL,
  `id_referencia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id_notificacion`, `id_usuario`, `mensaje`, `leido`, `fecha`, `tipo`, `id_referencia`) VALUES
(1, 57, 'El usuario 1 te ha comenzado a seguir', 1, '2025-10-12 01:04:58', 'nuevo_seguidor', NULL),
(2, 24, 'ozuna el real comenzó a seguirte', 0, '2025-10-12 21:37:39', 'nuevo_seguidor', 3),
(3, 56, 'witer365 comenzó a seguirte', 1, '2025-10-12 22:02:11', 'nuevo_seguidor', 4),
(4, 57, 'and comenzó a seguirte', 1, '2025-10-12 22:08:08', 'nuevo_seguidor', 5),
(5, 57, 'ozuna el real comenzó a seguirte', 1, '2025-10-12 23:20:59', 'nuevo_seguidor', 6),
(6, 22, 'and comenzó a seguirte', 1, '2025-10-24 12:08:58', 'nuevo_seguidor', 7),
(7, 56, 'ozuna el real comenzó a seguirte', 1, '2025-10-24 12:13:00', 'nuevo_seguidor', 8),
(8, 57, 'laurapintora comenzó a seguirte', 1, '2025-10-24 14:19:16', 'nuevo_seguidor', 9),
(9, 58, 'and comenzó a seguirte', 1, '2025-10-24 17:04:07', 'nuevo_seguidor', 10),
(10, 58, 'and comenzó a seguirte', 1, '2025-10-24 17:05:04', 'nuevo_seguidor', 11),
(11, 58, 'witer365 comenzó a seguirte', 1, '2025-10-24 17:10:10', 'nuevo_seguidor', 12),
(12, 57, 'laurapintora comenzó a seguirte', 1, '2025-10-24 17:11:31', 'nuevo_seguidor', 13),
(13, 58, 'and comenzó a seguirte', 1, '2025-10-24 17:44:46', 'nuevo_seguidor', 14),
(14, 56, 'witer365 comenzó a seguirte', 1, '2025-10-24 17:54:01', 'nuevo_seguidor', 15),
(15, 57, 'laurapintora comenzó a seguirte', 1, '2025-10-24 18:11:08', 'nuevo_seguidor', 16),
(16, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-10-24 18:19:51', 'solicitud_amistad', 4),
(17, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-24 18:28:02', 'amistad_aceptada', 4),
(18, 58, 'and te ha enviado una solicitud de amistad', 1, '2025-10-24 18:29:47', 'solicitud_amistad', 5),
(19, 56, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-24 18:30:19', 'amistad_aceptada', 5),
(20, 22, 'laurapintora comenzó a seguirte', 1, '2025-10-24 18:37:04', 'nuevo_seguidor', 17),
(21, 58, ' te ha enviado una solicitud de amistad', 1, '2025-10-24 18:38:22', 'solicitud_amistad', 6),
(22, 56, 'laurapintora te ha enviado una solicitud de amistad', 1, '2025-10-24 18:48:26', 'solicitud_amistad', 7),
(23, 22, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-24 18:54:56', 'amistad_aceptada', 6),
(24, 22, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-10-24 18:56:01', 'solicitud_amistad', 8),
(25, 57, ' aceptó tu solicitud de amistad', 1, '2025-10-24 18:56:50', 'amistad_aceptada', 8),
(26, 56, ' te ha enviado una solicitud de amistad', 1, '2025-10-24 18:57:31', 'solicitud_amistad', 9),
(27, 58, 'and aceptó tu solicitud de amistad', 1, '2025-10-24 18:57:54', 'amistad_aceptada', 7),
(28, 22, 'and rechazó tu solicitud de amistad', 1, '2025-10-24 18:57:55', 'amistad_rechazada', 9),
(29, 56, ' te ha enviado una solicitud de amistad', 1, '2025-10-24 18:58:33', 'solicitud_amistad', 10),
(30, 22, 'and aceptó tu solicitud de amistad', 1, '2025-10-24 18:59:01', 'amistad_aceptada', 10),
(31, 57, 'laurapintora te ha enviado una solicitud de amistad', 1, '2025-10-24 19:07:46', 'solicitud_amistad', 11),
(32, 58, 'witer365 aceptó tu solicitud de amistad', 1, '2025-10-24 19:26:42', 'amistad_aceptada', 11),
(33, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-10-24 19:27:24', 'solicitud_amistad', 12),
(34, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-24 19:27:56', 'amistad_aceptada', 12),
(35, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-10-24 19:28:42', 'solicitud_amistad', 13),
(36, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-24 19:36:56', 'amistad_aceptada', 13),
(37, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-10-24 19:42:13', 'solicitud_amistad', 14),
(38, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-24 19:48:41', 'amistad_aceptada', 14),
(39, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-10-25 19:52:53', 'solicitud_amistad', 15),
(40, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-25 19:53:17', 'amistad_aceptada', 15),
(41, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-10-25 20:54:27', 'solicitud_amistad', 16),
(42, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-10-25 20:54:56', 'amistad_aceptada', 16),
(43, 58, 'ozuna el real te ha enviado una solicitud de amistad', 1, '2025-10-25 20:55:53', 'solicitud_amistad', 17),
(44, 1, 'laurapintora aceptó tu solicitud de amistad', 0, '2025-10-25 20:56:10', 'amistad_aceptada', 17),
(45, 58, 'witer365 comenzó a seguirte', 1, '2025-10-26 20:21:38', 'nuevo_seguidor', 18),
(46, 57, 'seba comenzó a seguirte', 1, '2025-10-26 22:15:04', 'nuevo_seguidor', 19),
(47, 57, 'seba comenzó a seguirte', 1, '2025-10-26 22:16:21', 'nuevo_seguidor', 20),
(48, 55, 'witer365 comenzó a seguirte', 0, '2025-10-26 23:11:29', 'nuevo_seguidor', 21),
(49, 49, 'witer365 comenzó a seguirte', 0, '2025-10-27 18:40:39', 'nuevo_seguidor', 22),
(50, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-11-01 22:36:01', 'solicitud_amistad', 18),
(51, 58, 'witer365 comenzó a seguirte', 1, '2025-11-01 22:36:23', 'nuevo_seguidor', 23),
(52, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-11-01 22:37:38', 'amistad_aceptada', 18),
(53, 58, 'and te ha enviado una solicitud de amistad', 1, '2025-11-04 23:38:23', 'solicitud_amistad', 19),
(54, 56, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-11-04 23:39:26', 'amistad_aceptada', 19),
(55, 58, 'and comenzó a seguirte', 1, '2025-11-06 00:21:35', 'nuevo_seguidor', 24),
(56, 58, 'and comenzó a seguirte', 1, '2025-11-06 00:24:06', 'nuevo_seguidor', 25),
(57, 58, 'and te ha enviado una solicitud de amistad', 1, '2025-11-06 01:20:58', 'solicitud_amistad', 20),
(58, 58, 'and comenzó a seguirte', 1, '2025-11-06 01:21:02', 'nuevo_seguidor', 26),
(59, 58, 'and comenzó a seguirte', 1, '2025-11-06 01:22:44', 'nuevo_seguidor', 27),
(60, 56, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-11-06 01:23:20', 'amistad_aceptada', 20),
(61, 56, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-11-06 19:51:51', 'solicitud_amistad', 21),
(62, 56, 'witer365 comenzó a seguirte', 1, '2025-11-06 19:52:00', 'nuevo_seguidor', 28),
(63, 57, 'and aceptó tu solicitud de amistad', 1, '2025-11-06 19:53:03', 'amistad_aceptada', 21),
(64, 56, 'A witer365 le gusta tu publicación', 1, '2025-11-12 16:52:54', 'me_gusta', 25),
(65, 58, 'A witer365 le gusta tu publicación', 1, '2025-11-12 16:52:55', 'me_gusta', 22),
(66, 57, 'A and le gusta tu publicación', 1, '2025-11-12 16:56:31', 'me_gusta', 15),
(67, 57, 'A and le gusta tu publicación', 1, '2025-11-12 16:56:31', 'me_gusta', 14),
(68, 22, 'A and le gusta tu publicación', 1, '2025-11-12 16:56:33', 'me_gusta', 13),
(69, 24, 'A and le gusta tu publicación', 0, '2025-11-12 16:56:35', 'me_gusta', 12),
(70, 58, 'and comenzó a seguirte', 1, '2025-11-12 16:57:19', 'nuevo_seguidor', 29),
(71, 58, 'and te ha enviado una solicitud de amistad', 1, '2025-11-12 16:57:22', 'solicitud_amistad', 22),
(72, 58, '@and compartió tu publicación', 1, '2025-11-12 17:06:31', 'compartido', 22),
(73, 57, '@and te compartió una publicación', 1, '2025-11-12 17:06:31', 'compartido_amigo', 22),
(74, 58, 'witer365 comentó tu publicación', 1, '2025-11-12 17:34:42', 'comentario', 1),
(75, 58, 'witer365 respondió a tu comentario', 1, '2025-11-12 17:34:46', 'comentario_respuesta', 2),
(76, 58, 'and comentó tu publicación', 1, '2025-11-12 17:34:59', 'comentario', 3),
(77, 58, 'and respondió a tu comentario', 1, '2025-11-12 17:35:06', 'comentario_respuesta', 4),
(78, 58, 'A and le gusta tu publicación', 1, '2025-11-12 17:35:10', 'me_gusta', 18),
(81, 58, '@witer365 compartió tu publicación', 1, '2025-11-12 17:45:07', 'compartido', 22),
(82, 56, '@witer365 te compartió una publicación', 1, '2025-11-12 17:45:07', 'compartido_amigo', 22),
(85, 58, '@and compartió tu publicación', 1, '2025-11-12 18:33:38', 'compartido', 22),
(86, 57, '@and te compartió una publicación', 1, '2025-11-12 18:33:38', 'compartido_amigo', 22),
(87, 58, '@witer365 compartió tu publicación', 1, '2025-11-12 19:09:18', 'compartido', 22),
(88, 56, '@witer365 te compartió una publicación', 1, '2025-11-12 19:09:18', 'compartido_amigo', 22),
(89, 58, 'A and le gusta tu publicación', 1, '2025-11-12 20:08:00', 'me_gusta', 22),
(90, 58, 'A and le gusta tu publicación', 1, '2025-11-12 21:07:35', 'me_gusta', 22),
(91, 58, 'and respondió a tu comentario', 1, '2025-11-12 21:13:08', 'comentario_respuesta', 5),
(92, 58, 'and respondió a tu comentario', 1, '2025-11-12 21:13:12', 'comentario_respuesta', 6),
(93, 58, 'and respondió a tu comentario', 1, '2025-11-12 21:13:20', 'comentario_respuesta', 7),
(94, 58, 'and respondió a tu comentario', 1, '2025-11-12 21:13:26', 'comentario_respuesta', 8),
(95, 58, 'and respondió a tu comentario', 1, '2025-11-12 21:13:33', 'comentario_respuesta', 9),
(96, 58, 'and comenzó a seguirte', 1, '2025-11-12 21:13:55', 'nuevo_seguidor', 30),
(97, 58, 'and te ha enviado una solicitud de amistad', 1, '2025-11-12 21:13:59', 'solicitud_amistad', 23),
(98, 58, '@and compartió tu publicación', 1, '2025-11-12 22:11:18', 'compartido', 22),
(99, 57, '@and te compartió una publicación', 1, '2025-11-12 22:11:18', 'compartido_amigo', 22),
(100, 58, 'witer365 comenzó a seguirte', 1, '2025-11-12 22:13:03', 'nuevo_seguidor', 31),
(101, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-11-12 22:13:05', 'solicitud_amistad', 24),
(102, 58, 'witer365 comentó tu publicación', 1, '2025-11-12 22:13:14', 'comentario', 10),
(103, 58, 'witer365 comentó tu publicación', 1, '2025-11-12 22:13:18', 'comentario', 11),
(104, 58, '@witer365 compartió tu publicación', 1, '2025-11-12 22:13:28', 'compartido', 22),
(105, 56, '@witer365 te compartió una publicación', 1, '2025-11-12 22:13:28', 'compartido_amigo', 22),
(106, 58, '@witer365 compartió tu publicación', 1, '2025-11-13 20:19:46', 'compartido', 22),
(107, 56, '@witer365 te compartió una publicación', 1, '2025-11-13 20:19:46', 'compartido_amigo', 22),
(110, 58, '@witer365 compartió tu publicación', 1, '2025-11-13 20:32:19', 'compartido', 22),
(111, 56, '@witer365 te compartió una publicación', 1, '2025-11-13 20:32:19', 'compartido_amigo', 22),
(112, 58, '@witer365 compartió tu publicación', 1, '2025-11-13 21:28:21', 'compartido', 22),
(113, 56, '@witer365 te compartió una publicación', 1, '2025-11-13 21:28:21', 'compartido_amigo', 22),
(114, 58, 'A and le gusta tu publicación', 1, '2025-11-13 23:02:28', 'me_gusta', 22),
(120, 55, 'and comenzó a seguirte', 0, '2025-11-14 00:59:17', 'nuevo_seguidor', 32),
(121, 55, 'and te ha enviado una solicitud de amistad', 0, '2025-11-14 00:59:21', 'solicitud_amistad', 25),
(122, 55, 'A and le gusta tu publicación', 0, '2025-11-14 00:59:27', 'me_gusta', 21),
(123, 55, '@and compartió tu publicación', 0, '2025-11-14 00:59:45', 'compartido', 4),
(124, 57, '@and te compartió una publicación', 1, '2025-11-14 00:59:45', 'compartido_amigo', 4),
(125, 55, 'and comentó tu publicación', 0, '2025-11-14 01:03:13', 'comentario', 13),
(126, 55, 'and comentó tu publicación', 0, '2025-11-14 01:03:35', 'comentario', 14),
(127, 55, 'and respondió a tu comentario', 0, '2025-11-14 01:03:39', 'comentario_respuesta', 15),
(128, 55, 'and respondió a tu comentario', 0, '2025-11-14 01:03:41', 'comentario_respuesta', 16),
(134, 55, 'and comentó tu publicación', 0, '2025-11-14 01:31:56', 'comentario', 17),
(137, 58, 'and comenzó a seguirte', 1, '2025-11-14 22:37:57', 'nuevo_seguidor', 33),
(138, 57, 'and te ha enviado una solicitud de amistad', 1, '2025-11-14 22:43:46', 'solicitud_amistad', 26),
(139, 56, 'witer365 aceptó tu solicitud de amistad', 1, '2025-11-14 22:44:13', 'amistad_aceptada', 26),
(140, 55, 'A witer365 le gusta tu publicación', 0, '2025-11-16 17:19:58', 'me_gusta', 21),
(142, 1, 'A witer365 le gusta tu publicación', 0, '2025-11-16 17:20:32', 'me_gusta', 4),
(217, 55, 'A witer365 le gusta tu publicación', 0, '2025-11-23 14:27:56', 'me_gusta', 21),
(268, 24, '@and compartió tu publicación', 0, '2025-11-24 16:53:24', 'compartido', 38),
(269, 58, '@and te compartió una publicación', 1, '2025-11-24 16:53:24', 'compartido_amigo', 38),
(270, 57, '@and te compartió una publicación', 1, '2025-11-24 16:53:24', 'compartido_amigo', 38),
(271, 56, '@witer365 te compartió una publicación', 1, '2025-11-24 16:53:40', 'compartido_amigo', 39),
(272, 49, '@laurapintora compartió tu publicación', 0, '2025-11-24 16:54:15', 'compartido', 40),
(273, 1, '@laurapintora te compartió una publicación', 0, '2025-11-24 16:54:15', 'compartido_amigo', 40),
(274, 56, '@laurapintora te compartió una publicación', 1, '2025-11-24 16:54:15', 'compartido_amigo', 40),
(275, 58, 'witer365 comentó tu publicación', 1, '2025-11-24 20:03:04', 'comentario', 34),
(276, 56, 'witer365 comentó tu publicación', 1, '2025-11-24 20:03:09', 'comentario', 35),
(277, 56, 'A witer365 le gusta tu publicación', 1, '2025-11-24 20:03:15', 'me_gusta', 29),
(278, 58, '@and te compartió una publicación', 1, '2025-11-24 20:33:34', 'compartido_amigo', 42),
(279, 58, 'and comenzó a seguirte', 1, '2025-11-24 20:40:25', 'nuevo_seguidor', 36),
(280, 58, '@and compartió tu publicación', 1, '2025-11-24 23:57:18', 'compartido', 43),
(281, 58, '@and te compartió una publicación', 1, '2025-11-24 23:57:18', 'compartido_amigo', 43),
(282, 56, 'witer365 comenzó a seguirte', 1, '2025-11-24 23:57:27', 'nuevo_seguidor', 37),
(283, 56, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-11-24 23:57:29', 'solicitud_amistad', 29),
(284, 57, 'and aceptó tu solicitud de amistad', 1, '2025-11-24 23:57:40', 'amistad_aceptada', 29),
(285, 58, 'witer365 te ha enviado una solicitud de amistad', 1, '2025-11-24 23:58:56', 'solicitud_amistad', 30),
(286, 57, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-11-24 23:59:26', 'amistad_aceptada', 30),
(287, 24, '@laurapintora compartió tu publicación', 0, '2025-11-24 23:59:38', 'compartido', 44),
(288, 1, '@laurapintora te compartió una publicación', 0, '2025-11-24 23:59:38', 'compartido_amigo', 44),
(289, 56, '@laurapintora te compartió una publicación', 1, '2025-11-24 23:59:38', 'compartido_amigo', 44),
(290, 57, '@laurapintora te compartió una publicación', 1, '2025-11-24 23:59:38', 'compartido_amigo', 44),
(291, 56, '@witer365 te compartió una publicación', 1, '2025-11-25 00:00:45', 'compartido_amigo', 45),
(292, 58, '@witer365 te compartió una publicación', 1, '2025-11-25 00:00:45', 'compartido_amigo', 45),
(293, 58, '@and te compartió una publicación', 1, '2025-11-25 01:24:19', 'compartido_amigo', 46),
(294, 57, '@and te compartió una publicación', 1, '2025-11-25 01:24:19', 'compartido_amigo', 46),
(295, 58, '@and compartió tu publicación', 1, '2025-11-25 01:38:59', 'compartido', 47),
(296, 58, '@and te compartió una publicación', 1, '2025-11-25 01:38:59', 'compartido_amigo', 47),
(297, 57, '@and te compartió una publicación', 1, '2025-11-25 01:38:59', 'compartido_amigo', 47),
(298, 58, 'A and le gusta tu publicación', 1, '2025-11-25 02:20:56', 'me_gusta', 22),
(299, 22, 'and comenzó a seguirte', 1, '2025-11-25 02:21:08', 'nuevo_seguidor', 38),
(300, 58, '@and te compartió una publicación', 1, '2025-11-25 02:23:05', 'compartido_amigo', 49),
(301, 57, '@and te compartió una publicación', 1, '2025-11-25 02:23:05', 'compartido_amigo', 49),
(302, 58, '@and te compartió una publicación', 1, '2025-11-25 16:27:23', 'compartido_amigo', 50),
(303, 57, '@and te compartió una publicación', 1, '2025-11-25 16:27:23', 'compartido_amigo', 50),
(304, 58, '@and compartió tu publicación', 1, '2025-11-25 16:27:49', 'compartido', 51),
(305, 58, '@and te compartió una publicación', 1, '2025-11-25 16:27:49', 'compartido_amigo', 51),
(306, 57, '@and te compartió una publicación', 1, '2025-11-25 16:27:49', 'compartido_amigo', 51),
(307, 58, '@and te compartió una publicación', 1, '2025-11-25 20:49:45', 'compartido_amigo', 52),
(308, 57, '@and te compartió una publicación', 1, '2025-11-25 20:49:45', 'compartido_amigo', 52),
(309, 57, '@and te compartió una publicación', 1, '2025-11-25 21:02:43', 'compartido_amigo', 53),
(310, 58, '@and te compartió una publicación', 1, '2025-11-25 21:02:43', 'compartido_amigo', 53),
(311, 58, '@and te compartió una publicación', 1, '2025-11-25 21:06:15', 'compartido_amigo', 54),
(312, 57, '@and te compartió una publicación', 1, '2025-11-25 21:06:15', 'compartido_amigo', 54),
(313, 58, '@and compartió tu publicación', 1, '2025-11-25 22:33:10', 'compartido', 55),
(314, 58, '@and te compartió una publicación', 1, '2025-11-25 22:33:10', 'compartido_amigo', 55),
(315, 57, '@and te compartió una publicación', 1, '2025-11-25 22:33:10', 'compartido_amigo', 55),
(316, 58, '@and te compartió una publicación', 1, '2025-11-25 23:07:17', 'compartido_amigo', 56),
(317, 57, '@and te compartió una publicación', 1, '2025-11-25 23:07:17', 'compartido_amigo', 56),
(318, 58, 'and comentó tu publicación', 1, '2025-11-25 23:24:57', 'comentario', 39),
(319, 58, '@and te compartió una publicación', 1, '2025-11-25 23:25:45', 'compartido_amigo', 57),
(320, 57, '@and te compartió una publicación', 1, '2025-11-25 23:25:45', 'compartido_amigo', 57),
(321, 58, '@and te compartió una publicación', 1, '2025-11-25 23:26:31', 'compartido_amigo', 58),
(322, 57, '@and te compartió una publicación', 1, '2025-11-25 23:26:32', 'compartido_amigo', 58),
(323, 58, 'and comenzó a seguirte', 1, '2025-11-25 23:28:04', 'nuevo_seguidor', 39),
(324, 55, 'and comenzó a seguirte', 0, '2025-11-25 23:28:09', 'nuevo_seguidor', 40),
(325, 56, 'A witer365 le gusta tu publicación', 1, '2025-11-25 23:40:53', 'me_gusta', 16),
(326, 56, 'A witer365 le gusta tu publicación', 1, '2025-11-25 23:41:09', 'me_gusta', 62),
(327, 56, 'witer365 comentó tu publicación', 1, '2025-11-25 23:41:15', 'comentario', 40),
(328, 57, '@and te compartió una publicación', 1, '2025-11-25 23:42:08', 'compartido_amigo', 59),
(329, 57, '@and te compartió una publicación', 1, '2025-11-25 23:55:19', 'compartido_amigo', 60),
(330, 57, '@and compartió tu publicación', 1, '2025-11-25 23:55:44', 'compartido', 61),
(331, 57, '@and te compartió una publicación', 1, '2025-11-25 23:55:44', 'compartido_amigo', 61),
(332, 57, '@and compartió tu publicación', 1, '2025-11-25 23:56:03', 'compartido', 62),
(333, 58, '@and compartió tu publicación', 1, '2025-11-27 20:17:25', 'compartido', 63),
(334, 57, '@and te compartió una publicación', 1, '2025-11-27 20:17:25', 'compartido_amigo', 63),
(335, 58, 'and comentó tu publicación', 1, '2025-11-27 20:17:31', 'comentario', 41),
(336, 58, 'A and le gusta tu publicación', 1, '2025-11-27 20:17:33', 'me_gusta', 18),
(337, 58, 'A and le gusta tu publicación', 1, '2025-11-27 20:17:40', 'me_gusta', 18),
(338, 56, 'A witer365 le gusta tu publicación', 1, '2025-11-27 20:31:39', 'me_gusta', 66),
(339, 24, 'witer365 comenzó a seguirte', 0, '2025-11-27 20:37:01', 'nuevo_seguidor', 41),
(340, 56, '@witer365 compartió tu publicación', 1, '2025-11-27 21:09:45', 'compartido', 64),
(341, 57, 'Tienes un nuevo mensaje de and', 0, '2025-11-28 01:59:20', 'nuevo_mensaje', 1),
(342, 58, 'and comenzó a seguirte', 1, '2025-11-28 02:02:37', 'nuevo_seguidor', 42),
(343, 58, 'and te ha enviado una solicitud de amistad', 1, '2025-11-28 02:02:39', 'solicitud_amistad', 31),
(344, 56, 'laurapintora aceptó tu solicitud de amistad', 1, '2025-11-28 02:03:20', 'amistad_aceptada', 31),
(345, 57, 'Tienes un nuevo mensaje de and', 0, '2025-11-28 02:07:16', 'nuevo_mensaje', 1),
(346, 57, 'and comenzó a seguirte', 0, '2025-11-28 02:09:05', 'nuevo_seguidor', 43),
(347, 2, 'and comenzó a seguirte', 0, '2025-11-28 02:09:15', 'nuevo_seguidor', 44),
(348, 57, '@and te compartió una publicación', 0, '2025-11-28 02:11:16', 'compartido_amigo', 65),
(349, 58, '@and te compartió una publicación', 1, '2025-11-28 02:11:16', 'compartido_amigo', 65),
(350, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-28 02:11:56', 'nuevo_mensaje', 2),
(351, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 19:54:36', 'nuevo_mensaje', 2),
(352, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 20:00:18', 'nuevo_mensaje', 2),
(353, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 20:29:22', 'nuevo_mensaje', 2),
(354, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 21:17:30', 'nuevo_mensaje', 2),
(355, 22, 'and te ha enviado una solicitud de amistad', 1, '2025-11-30 21:20:20', 'solicitud_amistad', 32),
(356, 56, 'si aceptó tu solicitud de amistad', 1, '2025-11-30 21:21:02', 'amistad_aceptada', 32),
(357, 22, 'Tienes un nuevo mensaje de and', 0, '2025-11-30 21:21:35', 'nuevo_mensaje', 3),
(358, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 21:27:53', 'nuevo_mensaje', 2),
(359, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 21:33:49', 'nuevo_mensaje', 2),
(360, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 21:43:46', 'nuevo_mensaje', 2),
(361, 58, 'A and le gusta tu publicación', 1, '2025-11-30 21:58:02', 'me_gusta', 18),
(362, 58, 'A and le gusta tu publicación', 1, '2025-11-30 21:58:12', 'me_gusta', 18),
(363, 22, 'Tienes un nuevo mensaje de and', 0, '2025-11-30 21:59:23', 'nuevo_mensaje', 3),
(364, 22, 'Tienes un nuevo mensaje de and', 0, '2025-11-30 21:59:32', 'nuevo_mensaje', 3),
(365, 22, 'Tienes un nuevo mensaje de and', 0, '2025-11-30 21:59:46', 'nuevo_mensaje', 3),
(366, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-11-30 22:00:50', 'nuevo_mensaje', 2),
(367, 1, 'Tienes un nuevo mensaje de laurapintora', 0, '2025-11-30 22:02:23', 'nuevo_mensaje', 4),
(368, 57, 'Tienes un nuevo mensaje de laurapintora', 0, '2025-11-30 22:02:27', 'nuevo_mensaje', 5),
(369, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-11-30 22:14:43', 'nuevo_mensaje', 6),
(370, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-11-30 22:14:44', 'nuevo_mensaje', 6),
(371, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-11-30 22:14:46', 'nuevo_mensaje', 6),
(372, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-11-30 22:14:47', 'nuevo_mensaje', 6),
(373, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 22:15:38', 'nuevo_mensaje', 6),
(374, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-11-30 22:33:33', 'nuevo_mensaje', 6),
(375, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-11-30 22:34:24', 'nuevo_mensaje', 6),
(376, 58, 'Tienes un nuevo mensaje de and', 1, '2025-11-30 22:34:58', 'nuevo_mensaje', 6),
(377, 22, '@and te compartió una publicación', 0, '2025-12-01 00:12:50', 'compartido_amigo', 66),
(378, 58, 'and respondió a tu comentario', 1, '2025-12-01 00:13:23', 'comentario_respuesta', 43),
(379, 58, 'and respondió a tu comentario', 1, '2025-12-01 00:13:30', 'comentario_respuesta', 44),
(380, 58, 'and comentó tu publicación', 1, '2025-12-01 00:13:39', 'comentario', 45),
(381, 58, 'and comentó tu publicación', 1, '2025-12-01 00:13:46', 'comentario', 46),
(382, 58, 'Tienes un nuevo mensaje de and', 1, '2025-12-01 00:43:20', 'nuevo_mensaje', 6),
(383, 22, 'Tienes un nuevo mensaje de and', 0, '2025-12-01 01:15:25', 'nuevo_mensaje', 7),
(384, 56, 'Tienes un nuevo mensaje de laurapintora', 1, '2025-12-01 01:16:42', 'nuevo_mensaje', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `no_me_interesa`
--

CREATE TABLE `no_me_interesa` (
  `id_no_me_interesa` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_publicacion` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfiles`
--

CREATE TABLE `perfiles` (
  `id_perfil` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL,
  `biografia` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `perfiles`
--

INSERT INTO `perfiles` (`id_perfil`, `id_usuario`, `descripcion`, `foto_perfil`, `biografia`) VALUES
(1, 1, NULL, 'http://localhost:8000/static/perfiles/perfil_1.jpg', NULL),
(2, 2, NULL, 'http://localhost:8000/static/perfiles/perfil_2.jpg', NULL),
(3, 3, NULL, NULL, NULL),
(4, 4, NULL, NULL, NULL),
(5, 5, NULL, NULL, NULL),
(6, 6, NULL, NULL, NULL),
(7, 7, NULL, NULL, NULL),
(8, 8, NULL, NULL, NULL),
(9, 9, NULL, NULL, NULL),
(10, 10, NULL, NULL, NULL),
(11, 11, NULL, NULL, NULL),
(12, 12, NULL, NULL, NULL),
(13, 13, NULL, NULL, NULL),
(14, 14, NULL, NULL, NULL),
(15, 15, NULL, NULL, NULL),
(16, 16, NULL, NULL, NULL),
(17, 17, NULL, NULL, NULL),
(18, 18, NULL, NULL, NULL),
(19, 19, NULL, NULL, NULL),
(20, 20, NULL, NULL, NULL),
(21, 21, NULL, NULL, NULL),
(22, 22, 'si', 'http://localhost:8000/static/perfiles/perfil_22.jpg', 'si'),
(23, 23, NULL, NULL, NULL),
(24, 24, NULL, 'http://localhost:8000/static/perfiles/perfil_24.png', NULL),
(25, 25, NULL, NULL, NULL),
(26, 26, NULL, NULL, NULL),
(27, 27, NULL, NULL, NULL),
(28, 28, NULL, NULL, NULL),
(29, 29, NULL, NULL, NULL),
(30, 30, NULL, NULL, NULL),
(31, 31, NULL, NULL, NULL),
(32, 32, NULL, NULL, NULL),
(33, 33, NULL, NULL, NULL),
(35, 35, NULL, NULL, NULL),
(36, 36, NULL, NULL, NULL),
(37, 37, NULL, NULL, NULL),
(38, 38, NULL, NULL, NULL),
(39, 39, NULL, NULL, NULL),
(40, 40, NULL, NULL, NULL),
(41, 41, NULL, NULL, NULL),
(42, 46, NULL, NULL, NULL),
(43, 49, NULL, NULL, NULL),
(44, 51, NULL, NULL, NULL),
(45, 52, NULL, NULL, NULL),
(46, 53, NULL, NULL, NULL),
(47, 54, NULL, NULL, NULL),
(48, 55, NULL, 'http://localhost:8000/static/perfiles/perfil_55_1761516857.jpg', NULL),
(49, 56, 'tan poco se', 'http://localhost:8000/static/perfiles/perfil_56_1764539818.jpg', 'me gusta el arte y dormi\r\n'),
(50, 57, 'me gusta dormir SI', 'http://localhost:8000/static/perfiles/perfil_57_1762299627.jpg', 'tengo hambre SI'),
(51, 58, '\"Artista digital especializado en surrealismo moderno.\"', 'http://localhost:8000/static/perfiles/perfil_58_1761516762.jpg', '\"Desde 2015 exploro el arte digital fusionando elementos de fantasía y tecnología.\"'),
(52, 59, NULL, NULL, NULL),
(53, 60, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preferencias_arte`
--

CREATE TABLE `preferencias_arte` (
  `id_preferencia` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `categoria` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preferencias_arte`
--

INSERT INTO `preferencias_arte` (`id_preferencia`, `id_usuario`, `categoria`) VALUES
(1, 1, 'Pintura'),
(2, 2, 'Escultura'),
(3, 3, 'Dibujo'),
(4, 4, 'Fotografía'),
(5, 5, 'Arte digital'),
(6, 6, 'Instalación'),
(7, 7, 'Arte urbano'),
(8, 8, 'Caligrafía'),
(9, 9, 'Performance'),
(10, 10, 'Literatura visual'),
(11, 11, 'Tatuaje'),
(12, 12, 'Diseño gráfico'),
(13, 13, 'Cine experimental'),
(14, 14, 'Ilustración'),
(15, 15, 'Collage'),
(16, 16, 'Videoarte'),
(17, 17, 'Acuarela'),
(18, 18, 'Graffiti'),
(19, 19, 'Arte conceptual'),
(20, 20, 'Animación 2D'),
(21, 21, 'Arte textil'),
(22, 22, 'Arte sonoro'),
(23, 23, 'Diseño UX/UI'),
(24, 24, 'Arte indígena'),
(25, 25, 'Arte abstracto'),
(26, 26, 'Arte político'),
(27, 27, 'Diseño de modas'),
(28, 28, 'Cerámica'),
(29, 29, 'Arte interactivo'),
(30, 30, 'Arquitectura artística'),
(31, 1, 'Impresionismo'),
(32, 2, 'Escultura clásica'),
(33, 3, 'Fotografía urbana'),
(34, 4, 'Música instrumental'),
(35, 5, 'Danza contemporánea'),
(36, 6, 'Poesía romántica'),
(37, 7, 'Teatro experimental'),
(38, 8, 'Cine independiente'),
(39, 9, 'Diseño industrial'),
(40, 10, 'Ilustración digital');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones`
--

CREATE TABLE `publicaciones` (
  `id_publicacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `contenido` varchar(255) NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `tipo_medio` varchar(20) DEFAULT 'texto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `publicaciones`
--

INSERT INTO `publicaciones` (`id_publicacion`, `id_usuario`, `contenido`, `imagen`, `fecha_creacion`, `tipo_medio`) VALUES
(1, 1, 'Esta es una publicación de prueba', 'imagen1.jpg', '2025-10-05 15:00:28', 'texto'),
(2, 1, 'hola', NULL, '2025-10-05 20:09:32', 'texto'),
(3, 1, 'hola', NULL, '2025-10-05 20:11:58', 'texto'),
(4, 1, '', 'http://localhost:8000/static/posts\\1_1.png', '2025-10-05 20:12:19', 'texto'),
(5, 51, 'hola si', 'http://localhost:8000/static/posts\\51_ARTIVERSE.drawio.png', '2025-10-05 20:16:42', 'texto'),
(6, 49, 'HOLA COMO ESTAN EPERO QUE BIEN ', 'http://localhost:8000/static/posts\\49_8d3bec423a4c16808c32fdb6f28a44e8.jpg', '2025-10-05 20:59:16', 'texto'),
(7, 56, 'bgbgbgb', 'http://localhost:8000/static/posts\\56_Gráfico de Línea de Tiempo Profesional Moderno Multicolor.png', '2025-10-06 21:48:48', 'texto'),
(12, 24, 'hola ', 'http://localhost:8000/static/posts/24_Captura de pantalla 2025-10-10 183230.png', '2025-10-11 19:55:53', 'texto'),
(13, 22, 'ya casi', 'http://localhost:8000/static/posts/22_Gráfico de Línea de Tiempo Profesional Moderno Multicolor.png', '2025-10-11 20:05:30', 'texto'),
(14, 57, 'ya casi se logra', 'http://localhost:8000/static/posts/57_3.jpg', '2025-10-11 20:06:46', 'texto'),
(15, 57, 'bvbvbvb', 'http://localhost:8000/static/posts/57_2.jpg', '2025-10-11 20:27:39', 'texto'),
(16, 56, 'vhgghg', 'http://localhost:8000/static/posts/56_3.jpg', '2025-10-11 23:10:03', 'texto'),
(18, 58, 'Primera publicación de prueba desde Artenity', 'http://localhost:8000/static/posts/58_4.avif', '2025-10-24 13:59:55', 'texto'),
(21, 55, 'hola ahí esperanza', NULL, '2025-10-26 22:14:46', 'texto'),
(22, 58, 'AHI HAMBRE GENTE ', NULL, '2025-11-01 22:38:01', 'texto'),
(66, 56, '', 'http://localhost:8000/static/videos/9325cde1-4972-4594-830c-5261774655a4_video 1 pruebas.mp4', '2025-11-27 20:17:58', 'video');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_actividad`
--

CREATE TABLE `registro_actividad` (
  `id_actividad` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `accion` varchar(255) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_actividad`
--

INSERT INTO `registro_actividad` (`id_actividad`, `id_usuario`, `accion`, `fecha`) VALUES
(1, 1, 'Inicio de sesión', '2025-01-08 05:05:31'),
(2, 2, 'Edición de perfil', '2025-01-09 11:43:12'),
(3, 3, 'Publicación de obra', '2025-01-10 08:23:44'),
(4, 4, 'Comentario en obra', '2025-01-11 14:01:09'),
(5, 5, 'Cierre de sesión', '2025-01-12 17:45:22'),
(6, 6, 'Cambio de contraseña', '2025-01-13 20:33:15'),
(7, 7, 'Exploración de galería', '2025-01-14 10:10:05'),
(8, 8, 'Guardado de obra', '2025-01-15 09:09:45'),
(9, 9, 'Reacción a publicación', '2025-01-16 18:30:21'),
(10, 10, 'Edición de configuración', '2025-01-17 06:55:11'),
(11, 11, 'Inicio de sesión', '2025-01-18 12:25:03'),
(12, 12, 'Eliminación de comentario', '2025-01-19 16:14:37'),
(13, 13, 'Publicación en blog', '2025-01-20 19:00:00'),
(14, 14, 'Visualización de perfil', '2025-01-21 21:30:14'),
(15, 15, 'Reinicio de contraseña', '2025-01-22 23:10:45'),
(16, 16, 'Suscripción a taller', '2025-01-23 13:14:28'),
(17, 17, 'Inicio de sesión', '2025-01-24 08:48:36'),
(18, 18, 'Cambio de idioma', '2025-01-25 10:20:52'),
(19, 19, 'Edición de biografía', '2025-01-26 11:15:09'),
(20, 20, 'Reacción a comentario', '2025-01-27 13:33:17'),
(21, 21, 'Guardado de obra', '2025-01-28 17:45:25'),
(22, 22, 'Envío de mensaje privado', '2025-01-29 19:19:00'),
(23, 23, 'Exploración de comunidades', '2025-01-30 15:40:08'),
(24, 24, 'Cambio de foto de perfil', '2025-02-01 07:08:47'),
(25, 25, 'Edición de obra', '2025-02-02 09:15:20'),
(26, 26, 'Comentario en obra', '2025-02-03 20:32:45'),
(27, 27, 'Bloqueo de usuario', '2025-02-04 18:17:12'),
(28, 28, 'Denuncia de contenido', '2025-02-05 16:05:30'),
(29, 29, 'Publicación de obra', '2025-02-06 14:59:01'),
(30, 30, 'Inicio de sesión', '2025-02-07 06:25:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes_usuarios`
--

CREATE TABLE `reportes_usuarios` (
  `id_reporte` int(11) NOT NULL,
  `id_reportante` int(11) NOT NULL,
  `id_reportado` int(11) NOT NULL,
  `motivo` varchar(255) NOT NULL,
  `evidencia_url` varchar(255) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reportes_usuarios`
--

INSERT INTO `reportes_usuarios` (`id_reporte`, `id_reportante`, `id_reportado`, `motivo`, `evidencia_url`, `fecha`) VALUES
(1, 57, 55, 'si', NULL, '2025-10-27 14:41:57'),
(2, 57, 55, 'CONTENIDO OFENSIVO ', NULL, '2025-10-27 15:22:03'),
(3, 57, 55, '🚫 Contenido ofensivo o inapropiado (violencia, odio, lenguaje vulgar)', NULL, '2025-10-27 15:22:30'),
(4, 57, 55, '🚫 Contenido ofensivo o inapropiado (violencia, odio, lenguaje vulgar)', 'http://localhost:8000/static/reportes/reporte_57_55_1761596595.jpg', '2025-10-27 15:23:15'),
(5, 57, 55, '🖼️ Plagio o uso no autorizado de obras', 'http://localhost:8000/static/reportes/reporte_57_55_1761600922.jpg', '2025-10-27 16:35:22'),
(6, 57, 58, '🔞 Contenido obsceno o inapropiado', 'http://localhost:8000/static/reportes/reporte_57_58_1762036616.jpg', '2025-11-01 17:36:56'),
(7, 56, 58, 'xsxsxsxsx', 'http://localhost:8000/static/reportes/reporte_56_58_1762389172.jpg', '2025-11-05 19:32:52'),
(8, 57, 56, '🎭 Suplantación de identidad', NULL, '2025-11-06 14:52:17'),
(9, 56, 58, '🧠 Acoso o comportamiento abusivo', NULL, '2025-11-12 16:14:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reset_password_tokens`
--

CREATE TABLE `reset_password_tokens` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiracion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reset_password_tokens`
--

INSERT INTO `reset_password_tokens` (`id`, `id_usuario`, `token`, `expiracion`) VALUES
(18, 59, '224ccb4f-211b-47e2-a3d4-c0cc1900337f', '2025-11-01 23:15:25'),
(31, 57, 'a8b1c4b8-a305-4875-9d2b-3175b8b6cdf1', '2025-11-14 02:02:35');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguir_usuario`
--

CREATE TABLE `seguir_usuario` (
  `id_seguimiento` int(11) NOT NULL,
  `id_seguidor` int(11) DEFAULT NULL,
  `id_seguido` int(11) DEFAULT NULL,
  `fecha_seguimiento` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `seguir_usuario`
--

INSERT INTO `seguir_usuario` (`id_seguimiento`, `id_seguidor`, `id_seguido`, `fecha_seguimiento`) VALUES
(6, 1, 57, '2025-10-12 23:20:59'),
(8, 1, 56, '2025-10-24 12:13:00'),
(17, 58, 22, '2025-10-24 18:37:04'),
(20, 55, 57, '2025-10-26 22:16:21'),
(21, 57, 55, '2025-10-26 23:11:29'),
(22, 57, 49, '2025-10-27 18:40:39'),
(31, 57, 58, '2025-11-12 22:13:03'),
(37, 57, 56, '2025-11-24 23:57:27'),
(38, 56, 22, '2025-11-25 02:21:08'),
(41, 57, 24, '2025-11-27 20:37:00'),
(42, 56, 58, '2025-11-28 02:02:37'),
(43, 56, 57, '2025-11-28 02:09:05'),
(44, 56, 2, '2025-11-28 02:09:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_de_amistad`
--

CREATE TABLE `solicitud_de_amistad` (
  `id_solicitud` int(11) NOT NULL,
  `id_emisor` int(11) DEFAULT NULL,
  `id_receptor` int(11) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `fecha_envio` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo_electronico` varchar(100) NOT NULL,
  `contrasena` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` varchar(20) DEFAULT NULL,
  `tipo_arte_preferido` varchar(100) DEFAULT NULL,
  `telefono` varchar(50) NOT NULL,
  `nombre_usuario` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `apellido`, `correo_electronico`, `contrasena`, `fecha_nacimiento`, `genero`, `tipo_arte_preferido`, `telefono`, `nombre_usuario`) VALUES
(1, 'Adelaida Arregui ', 'Anglada', 'user1@correo.com', 'nVQdhWXb^2E)', '1989-08-19', 'Otro', 'Danza', '+34 741 783 162', 'ozuna el real'),
(2, 'Faustino Vallejo ', 'Real', 'user2@correo.com', 'pLqHtVn#7aFX', '1987-10-12', 'Masculino', 'Teatro', '+34 607 215 905', 'nose'),
(3, 'Ignacio Figueroa Gomariz', '', 'user3@correo.com', 'byGuAFm*3uLn', '1979-06-21', 'Masculino', 'Música', '+34 625 349 764', 'sida\r\n'),
(4, 'Sebastián Almagro Vico', '', 'user4@correo.com', 'Vh*qfY$UJ2j1', '1988-07-01', 'Masculino', 'Pintura', '+34 612 137 508', ''),
(5, 'Aurelia Utrera Castañón', '', 'user5@correo.com', 'NL8suYgx+Fj%', '1971-12-30', 'Femenino', 'Literatura', '+34 686 733 265', ''),
(6, 'Bartolomé Gallego Torrente', '', 'user6@correo.com', 'E&M4dWY!kPKc', '1982-02-24', 'Masculino', 'Danza', '+34 688 415 310', ''),
(7, 'Álvaro Ibáñez Martos', '', 'user7@correo.com', 'ZX2F%bt8qae#', '1986-05-06', 'Masculino', 'Teatro', '+34 639 938 370', ''),
(8, 'Gabriela Collado Lara', '', 'user8@correo.com', '2Tvg+!hC5Vje', '1984-11-13', 'Femenino', 'Pintura', '+34 642 748 855', ''),
(9, 'Bautista Velasco Montalt', '', 'user9@correo.com', 'mK9AKnH@P47Y', '1976-04-10', 'Masculino', 'Música', '+34 690 825 418', 'hay hambre\r\n'),
(10, 'Elena Baeza Andrada', '', 'user10@correo.com', 'J2+eZLGU38pn', '1985-01-19', 'Femenino', 'Literatura', '+34 622 434 504', ''),
(11, 'Isidro Monforte Bravo', '', 'user11@correo.com', 'YvKx@eLMg7rT', '1983-10-07', 'Masculino', 'Teatro', '+34 678 695 273', ''),
(12, 'Rosaura Viana Villegas', '', 'user12@correo.com', 'sAqX$wK3EYN!', '1990-09-05', 'Femenino', 'Pintura', '+34 655 171 391', ''),
(13, 'Benjamín Arrieta Sanjuan', '', 'user13@correo.com', '9!HtUMpvycAe', '1978-03-27', 'Masculino', 'Danza', '+34 684 130 920', ''),
(14, 'Rocío Oltra Pascual', '', 'user14@correo.com', 'L!Eex5tzRMm7', '1991-11-02', 'Femenino', 'Literatura', '+34 609 582 423', 'no hay hambre\r\n'),
(15, 'Julián Cardiel Peñalver', '', 'user15@correo.com', 'AQ6bZMpE&9Xu', '1975-08-15', 'Masculino', 'Música', '+34 615 978 350', ''),
(16, 'Daniela Pizarro Sempere', '', 'user16@correo.com', 'TwR*fqgUz23!', '1986-03-17', 'Femenino', 'Pintura', '+34 664 357 229', ''),
(17, 'Eugenio Balsalobre Cánovas', '', 'user17@correo.com', 'eMv&k3UcBN#d', '1980-05-29', 'Masculino', 'Teatro', '+34 695 382 590', ''),
(18, 'Jimena Carreras Roca', '', 'user18@correo.com', 'x5B$dnMAZ4^f', '1992-06-10', 'Femenino', 'Música', '+34 670 981 472', ''),
(19, 'Fernando Monasterio Cuesta', '', 'user19@correo.com', '93TwzE8!gHVu', '1983-09-09', 'Masculino', 'Danza', '+34 648 751 340', ''),
(20, 'Tatiana Rojano Sáenz', '', 'user20@correo.com', 'fbvZHt$4MXq3', '1987-02-03', 'Femenino', 'Literatura', '+34 691 389 712', ''),
(21, 'Ulises Naranjo Goicoechea', '', 'user21@correo.com', 'cJZW@yEL8N5*', '1989-04-22', 'Masculino', 'Teatro', '+34 618 451 913', ''),
(22, 'Beatriz Luján Ochoa', '', 'user22@correo.com', 'F!qgTpbvWY7u', '1990-10-08', 'Femenino', 'Pintura', '+34 684 252 472', 'si'),
(23, 'Guillermo Lerín Santamaría', '', 'user23@correo.com', 'A@cvKz4YM3uP', '1981-06-03', 'Masculino', 'Danza', '+34 625 783 145', ''),
(24, 'Natalia Cevallos Muñiz', '', 'user24@correo.com', 'Mf^yPzGu9EAK', '1993-01-25', 'Femenino', 'Música', '+34 672 423 987', 'sueño 201'),
(25, 'Lázaro Fonseca Viñas', '', 'user25@correo.com', 'NctKv@pmW3R$', '1979-07-11', 'Masculino', 'Literatura', '+34 637 705 199', ''),
(26, 'Inés Moyano del Río', '', 'user26@correo.com', 'XR#nFbPW3a&L', '1985-09-17', 'Femenino', 'Pintura', '+34 633 201 843', ''),
(27, 'Ángel Domenech Cotilla', '', 'user27@correo.com', 'eZ9WyEXr!J6q', '1984-11-23', 'Masculino', 'Teatro', '+34 694 852 137', ''),
(28, 'Leticia Mínguez Paredes', '', 'user28@correo.com', 'rG&uJc93NAv*', '1982-02-06', 'Femenino', 'Música', '+34 676 428 099', ''),
(29, 'Fidel Robledo Garijo', '', 'user29@correo.com', '7Tf$VqgkXuNp', '1986-06-20', 'Masculino', 'Literatura', '+34 689 375 842', ''),
(30, 'Melina Pardo Revilla', '', 'user30@correo.com', 'UnqPw4&eXB2$', '1991-05-14', 'Femenino', 'Danza', '+34 649 172 356', ''),
(31, 'Ana Torres', '', 'ana.torres@example.com', 'pass123', '1995-04-12', 'Femenino', 'Pintura', '3001112233', ''),
(32, 'Carlos Gómez', '', 'carlos.gomez@example.com', 'pass123', '1990-07-22', 'Masculino', 'Escultura', '3002223344', ''),
(33, 'María López', '', 'maria.lopez@example.com', 'pass123', '1998-02-18', 'Femenino', 'Fotografía', '3003334455', ''),
(35, 'Lucía Fernández', '', 'lucia.fernandez@example.com', 'pass123', '1993-06-30', 'Femenino', 'Danza', '3005556677', ''),
(36, 'David Morales', '', 'david.morales@example.com', 'pass123', '1992-01-15', 'Masculino', 'Poesía', '3006667788', ''),
(37, 'Paula Ramírez', '', 'paula.ramirez@example.com', 'pass123', '1997-12-09', 'Femenino', 'Teatro', '3007778899', ''),
(38, 'Sofía Herrera', '', 'sofia.herrera@example.com', 'pass123', '2000-09-20', 'Femenino', 'Cine', '3008889900', ''),
(39, 'Andrés Ríos', '', 'andres.rios@example.com', 'pass123', '1994-03-25', 'Masculino', 'Diseño', '3009990011', ''),
(40, 'Valentina Cruz', '', 'valentina.cruz@example.com', 'pass123', '1996-05-17', 'Femenino', 'Arte digital', '3011112233', ''),
(41, 'string', 'string', 'string', 'string', '2025-09-14', 'string', 'string', 'string', 'string'),
(46, 'ozuna', 'Roldán', 'ozuna@test.com', '123456', '2000-05-20', 'femenino', 'pintura', '3201234567', 'ozunaR'),
(49, 'nolan', 'sin ', 'wrf@gmail.com', '1234ewrt', '2025-09-15', 'Delfin', 'rock', '31431735', '57'),
(51, 'artenity', 'sexo v', 'wtr.falso1@gmail.com', 'qa1122222', '2007-06-20', 'Hombre', 'jazz', '31232303546', 'wtr123'),
(52, 'sebastian', 'reduro', 'sbd@gmail.com', 'sbd44', '2006-07-21', 'Hombre', 'jazz', '31232303543333', 'sbd33'),
(53, 'anderson', 'dcdcdcd', 'cdcdcdcdc@gmail.com', 'cscscscsc', '2025-10-13', 'Hombre', 'circo', '3197255375', 'cscs'),
(54, 'anderson', 'roldan', 'roldan@gmail.com', '12345', '2018-05-30', 'Hombre', 'dibujo', '314315545445', 'roldan'),
(55, 'seba', 'rodriguez', 'seba@gmail.com', '123456', '2018-06-12', 'Hombre', 'circo', '65365436546354364', 'seba'),
(56, 'wáter', 'sena2', 'anderson.17cardenas@gmail.com', '1234', '2010-10-06', 'Personalizado', 'circo', '223232323', 'and'),
(57, 'witer365', 'real', 'anderson@gmail.com', '12345', '2006-07-09', 'Hombre', 'dibujo', '653654365463543645', 'witer365'),
(58, 'Laura', 'Pérez', 'laura.perez@example.com', 'Laura123*', '1998-05-10', 'Mujer', 'pintura', '3005678910', 'laurapintora'),
(59, 'artenity', 'agirre', 'w59345907@gmail.com', 'wtr#56789', '2009-02-18', 'Hombre', 'escultura', '3232025652', 'wtr856'),
(60, 'erca', 'asassa', 'and@gmail.com', 'and3', '2007-09-11', 'Hombre', 'ballet', '321455698225', 'and2');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `amistades`
--
ALTER TABLE `amistades`
  ADD PRIMARY KEY (`id_amistad`),
  ADD KEY `id_usuario1` (`id_usuario1`),
  ADD KEY `id_usuario2` (`id_usuario2`);

--
-- Indices de la tabla `bloqueos_usuarios`
--
ALTER TABLE `bloqueos_usuarios`
  ADD PRIMARY KEY (`id_bloqueo`),
  ADD KEY `id_bloqueador` (`id_bloqueador`),
  ADD KEY `id_bloqueado` (`id_bloqueado`),
  ADD KEY `ix_bloqueos_usuarios_id_bloqueo` (`id_bloqueo`);

--
-- Indices de la tabla `categorias_obra`
--
ALTER TABLE `categorias_obra`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id_chat`),
  ADD UNIQUE KEY `unique_chat` (`id_usuario1`,`id_usuario2`),
  ADD KEY `idx_chats_usuario1` (`id_usuario1`),
  ADD KEY `idx_chats_usuario2` (`id_usuario2`);

--
-- Indices de la tabla `colecciones_arte`
--
ALTER TABLE `colecciones_arte`
  ADD PRIMARY KEY (`id_coleccion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `colecciones_obras`
--
ALTER TABLE `colecciones_obras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_coleccion` (`id_coleccion`),
  ADD KEY `id_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `id_comentario_padre` (`id_comentario_padre`),
  ADD KEY `ix_comentarios_id_comentario` (`id_comentario`);

--
-- Indices de la tabla `comentarios_obra`
--
ALTER TABLE `comentarios_obra`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `id_comentario_padre` (`id_comentario_padre`);

--
-- Indices de la tabla `compartidos`
--
ALTER TABLE `compartidos`
  ADD PRIMARY KEY (`id_compartido`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `ix_compartidos_id_compartido` (`id_compartido`);

--
-- Indices de la tabla `configuraciones_chat`
--
ALTER TABLE `configuraciones_chat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_chat_usuario` (`id_chat`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `ix_configuraciones_chat_id` (`id`);

--
-- Indices de la tabla `configuracion_usuario`
--
ALTER TABLE `configuracion_usuario`
  ADD PRIMARY KEY (`id_configuracion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `galeria_arte`
--
ALTER TABLE `galeria_arte`
  ADD PRIMARY KEY (`id_galeria`),
  ADD KEY `id_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `guardados`
--
ALTER TABLE `guardados`
  ADD PRIMARY KEY (`id_guardado`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `ix_guardados_id_guardado` (`id_guardado`);

--
-- Indices de la tabla `guardados_obra`
--
ALTER TABLE `guardados_obra`
  ADD PRIMARY KEY (`id_guardado`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`,`id_publicacion`),
  ADD KEY `id_publicacion` (`id_publicacion`);

--
-- Indices de la tabla `historial_interacciones_obra`
--
ALTER TABLE `historial_interacciones_obra`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `likes_obra`
--
ALTER TABLE `likes_obra`
  ADD PRIMARY KEY (`id_like`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id_mensaje`),
  ADD KEY `idx_mensajes_chat` (`id_chat`),
  ADD KEY `idx_mensajes_emisor` (`id_emisor`),
  ADD KEY `idx_mensajes_fecha` (`fecha_envio`);

--
-- Indices de la tabla `mensajes_eliminados`
--
ALTER TABLE `mensajes_eliminados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_mensaje` (`id_mensaje`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `ix_mensajes_eliminados_id` (`id`);

--
-- Indices de la tabla `me_gusta`
--
ALTER TABLE `me_gusta`
  ADD PRIMARY KEY (`id_megusta`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `ix_me_gusta_id_megusta` (`id_megusta`);

--
-- Indices de la tabla `me_gusta_comentarios`
--
ALTER TABLE `me_gusta_comentarios`
  ADD PRIMARY KEY (`id_megusta_comentario`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_comentario` (`id_comentario`),
  ADD KEY `ix_me_gusta_comentarios_id_megusta_comentario` (`id_megusta_comentario`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `idx_id_usuario` (`id_usuario`);

--
-- Indices de la tabla `no_me_interesa`
--
ALTER TABLE `no_me_interesa`
  ADD PRIMARY KEY (`id_no_me_interesa`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_publicacion` (`id_publicacion`),
  ADD KEY `ix_no_me_interesa_id_no_me_interesa` (`id_no_me_interesa`);

--
-- Indices de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  ADD PRIMARY KEY (`id_perfil`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`),
  ADD KEY `idx_id_perfil` (`id_perfil`);

--
-- Indices de la tabla `preferencias_arte`
--
ALTER TABLE `preferencias_arte`
  ADD PRIMARY KEY (`id_preferencia`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD PRIMARY KEY (`id_publicacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `registro_actividad`
--
ALTER TABLE `registro_actividad`
  ADD PRIMARY KEY (`id_actividad`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `reportes_usuarios`
--
ALTER TABLE `reportes_usuarios`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `fk_reportante` (`id_reportante`),
  ADD KEY `fk_reportado` (`id_reportado`);

--
-- Indices de la tabla `reset_password_tokens`
--
ALTER TABLE `reset_password_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_token` (`token`),
  ADD KEY `idx_id_usuario` (`id_usuario`);

--
-- Indices de la tabla `seguir_usuario`
--
ALTER TABLE `seguir_usuario`
  ADD PRIMARY KEY (`id_seguimiento`),
  ADD KEY `id_seguidor` (`id_seguidor`),
  ADD KEY `id_seguido` (`id_seguido`),
  ADD KEY `ix_seguir_usuario_id_seguimiento` (`id_seguimiento`);

--
-- Indices de la tabla `solicitud_de_amistad`
--
ALTER TABLE `solicitud_de_amistad`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `id_emisor` (`id_emisor`),
  ADD KEY `id_receptor` (`id_receptor`),
  ADD KEY `ix_solicitud_de_amistad_id_solicitud` (`id_solicitud`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `amistades`
--
ALTER TABLE `amistades`
  MODIFY `id_amistad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `bloqueos_usuarios`
--
ALTER TABLE `bloqueos_usuarios`
  MODIFY `id_bloqueo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `chats`
--
ALTER TABLE `chats`
  MODIFY `id_chat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `compartidos`
--
ALTER TABLE `compartidos`
  MODIFY `id_compartido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `configuraciones_chat`
--
ALTER TABLE `configuraciones_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `guardados`
--
ALTER TABLE `guardados`
  MODIFY `id_guardado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id_mensaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `mensajes_eliminados`
--
ALTER TABLE `mensajes_eliminados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `me_gusta`
--
ALTER TABLE `me_gusta`
  MODIFY `id_megusta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `me_gusta_comentarios`
--
ALTER TABLE `me_gusta_comentarios`
  MODIFY `id_megusta_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=385;

--
-- AUTO_INCREMENT de la tabla `no_me_interesa`
--
ALTER TABLE `no_me_interesa`
  MODIFY `id_no_me_interesa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `perfiles`
--
ALTER TABLE `perfiles`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  MODIFY `id_publicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `reportes_usuarios`
--
ALTER TABLE `reportes_usuarios`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `reset_password_tokens`
--
ALTER TABLE `reset_password_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `seguir_usuario`
--
ALTER TABLE `seguir_usuario`
  MODIFY `id_seguimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `solicitud_de_amistad`
--
ALTER TABLE `solicitud_de_amistad`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `amistades`
--
ALTER TABLE `amistades`
  ADD CONSTRAINT `amistades_ibfk_1` FOREIGN KEY (`id_usuario1`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `amistades_ibfk_2` FOREIGN KEY (`id_usuario2`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `bloqueos_usuarios`
--
ALTER TABLE `bloqueos_usuarios`
  ADD CONSTRAINT `bloqueos_usuarios_ibfk_1` FOREIGN KEY (`id_bloqueador`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `bloqueos_usuarios_ibfk_2` FOREIGN KEY (`id_bloqueado`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`id_usuario1`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`id_usuario2`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE CASCADE,
  ADD CONSTRAINT `comentarios_ibfk_3` FOREIGN KEY (`id_comentario_padre`) REFERENCES `comentarios` (`id_comentario`);

--
-- Filtros para la tabla `compartidos`
--
ALTER TABLE `compartidos`
  ADD CONSTRAINT `compartidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `compartidos_ibfk_2` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `configuraciones_chat`
--
ALTER TABLE `configuraciones_chat`
  ADD CONSTRAINT `configuraciones_chat_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id_chat`),
  ADD CONSTRAINT `configuraciones_chat_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `guardados`
--
ALTER TABLE `guardados`
  ADD CONSTRAINT `guardados_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `guardados_ibfk_2` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`id_chat`) REFERENCES `chats` (`id_chat`) ON DELETE CASCADE,
  ADD CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`id_emisor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mensajes_eliminados`
--
ALTER TABLE `mensajes_eliminados`
  ADD CONSTRAINT `mensajes_eliminados_ibfk_1` FOREIGN KEY (`id_mensaje`) REFERENCES `mensajes` (`id_mensaje`),
  ADD CONSTRAINT `mensajes_eliminados_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `me_gusta`
--
ALTER TABLE `me_gusta`
  ADD CONSTRAINT `me_gusta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `me_gusta_ibfk_2` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `me_gusta_comentarios`
--
ALTER TABLE `me_gusta_comentarios`
  ADD CONSTRAINT `me_gusta_comentarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `me_gusta_comentarios_ibfk_2` FOREIGN KEY (`id_comentario`) REFERENCES `comentarios` (`id_comentario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `no_me_interesa`
--
ALTER TABLE `no_me_interesa`
  ADD CONSTRAINT `no_me_interesa_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `no_me_interesa_ibfk_2` FOREIGN KEY (`id_publicacion`) REFERENCES `publicaciones` (`id_publicacion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `perfiles`
--
ALTER TABLE `perfiles`
  ADD CONSTRAINT `fk_perfiles_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD CONSTRAINT `publicaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `reportes_usuarios`
--
ALTER TABLE `reportes_usuarios`
  ADD CONSTRAINT `fk_reportado` FOREIGN KEY (`id_reportado`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reportante` FOREIGN KEY (`id_reportante`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reset_password_tokens`
--
ALTER TABLE `reset_password_tokens`
  ADD CONSTRAINT `fk_reset_password_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `seguir_usuario`
--
ALTER TABLE `seguir_usuario`
  ADD CONSTRAINT `seguir_usuario_ibfk_1` FOREIGN KEY (`id_seguidor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `seguir_usuario_ibfk_2` FOREIGN KEY (`id_seguido`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `solicitud_de_amistad`
--
ALTER TABLE `solicitud_de_amistad`
  ADD CONSTRAINT `solicitud_de_amistad_ibfk_1` FOREIGN KEY (`id_emisor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `solicitud_de_amistad_ibfk_2` FOREIGN KEY (`id_receptor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
