-- =============================================================================
-- SCRIPT SQL INTEGRAL: SISTEMA DE GESTIÓN DE BIBLIOTECA EVOLUCIONADO
-- MySQL / MariaDB
-- Autor: Efrén Sánchez
-- =============================================================================

-- 1. CONFIGURACIÓN E INICIALIZACIÓN DEL ENTORNO
-- -----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS biblioteca
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE biblioteca;

-- Deshabilitar temporalmente restricciones para garantizar un script limpio
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminación de tablas en orden inverso a la jerarquía de dependencias
DROP TABLE IF EXISTS sanciones;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS ejemplares;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS generos;
DROP TABLE IF EXISTS editoriales;
DROP TABLE IF EXISTS autores;

SET FOREIGN_KEY_CHECKS = 1;

-- 2. DEFINICIÓN DEL ESQUEMA DE TABLAS (DDL)
-- -----------------------------------------------------------------------------

-- Tablas Maestras (Lookup Tables)
CREATE TABLE autores (
    id_autor INT(10) UNSIGNED NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) DEFAULT NULL,
    apellido2 VARCHAR(50) DEFAULT NULL,
    nacionalidad VARCHAR(50) DEFAULT NULL,
    fecha_nac DATE NOT NULL,
    fecha_dep DATE DEFAULT NULL,
    PRIMARY KEY (id_autor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE editoriales (
    id_editorial INT(10) UNSIGNED NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(150) DEFAULT NULL,
    telefono VARCHAR(20) DEFAULT NULL,
    email VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (id_editorial)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE generos (
    id_genero INT(10) UNSIGNED NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_genero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla Libros (Modificada: Sin columna 'cantidad' por redundancia)
CREATE TABLE libros (
    id_libro INT(10) UNSIGNED NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    id_autor INT(10) UNSIGNED NOT NULL,
    id_editorial INT(10) UNSIGNED NOT NULL,
    fecha_pub DATE NOT NULL,
    paginas INT(10) UNSIGNED NOT NULL,
    id_genero INT(10) UNSIGNED NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_libro),
    CONSTRAINT fk_libros_autor FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    CONSTRAINT fk_libros_editorial FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial),
    CONSTRAINT fk_libros_genero FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Módulos de Gestión y Transaccionales
CREATE TABLE usuarios (
    id_usuario INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    PRIMARY KEY (id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE empleados (
    id_empleado INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    PRIMARY KEY (id_empleado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ejemplares (
    id_ejemplar INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    id_libro INT(10) UNSIGNED NOT NULL,
    estado ENUM('Disponible', 'Prestado', 'Reservado', 'Mantenimiento', 'Extraviado', 'Dañado') DEFAULT 'Disponible',
    PRIMARY KEY (id_ejemplar),
    CONSTRAINT fk_ejemplares_libro FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE prestamos (
    id_prestamo INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    id_usuario INT(10) UNSIGNED NOT NULL,
    id_ejemplar INT(10) UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_devolucion_prevista DATE NOT NULL,
    fecha_devolucion_real DATE DEFAULT NULL,
    PRIMARY KEY (id_prestamo),
    CONSTRAINT fk_prestamos_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_prestamos_ejemplar FOREIGN KEY (id_ejemplar) REFERENCES ejemplares(id_ejemplar)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE reservas (
    id_reserva INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    id_usuario INT(10) UNSIGNED NOT NULL,
    id_libro INT(10) UNSIGNED NOT NULL,
    fecha_reserva DATE NOT NULL,
    PRIMARY KEY (id_reserva),
    CONSTRAINT fk_reservas_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_reservas_libro FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sanciones (
    id_sancion INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    id_usuario INT(10) UNSIGNED NOT NULL,
    id_prestamo INT(10) UNSIGNED NOT NULL,
    motivo VARCHAR(255),
    monto DECIMAL(10,2),
    pagada BOOLEAN DEFAULT FALSE,
    fecha_pago DATE DEFAULT NULL,
    PRIMARY KEY (id_sancion),
    CONSTRAINT fk_sanciones_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_sanciones_prestamo FOREIGN KEY (id_prestamo) REFERENCES prestamos(id_prestamo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. INSERCIÓN DE DATOS DE REFERENCIA (METADATOS)
-- -----------------------------------------------------------------------------
START TRANSACTION;

INSERT INTO generos (id_genero, nombre) VALUES
(1, 'Teatro'), (2, 'Narrativa clásica'), (3, 'Narrativa contemporánea'),
(4, 'Fantasía'), (5, 'Ciencia ficción'), (6, 'Thriller'), (7, 'Poesía');

INSERT INTO editoriales (id_editorial, nombre, direccion, telefono, email) VALUES
(1, 'Editorial Planeta', 'C/ Juan Ignacio Luca de Tena 17, Madrid', '913000001', 'info@planeta.es'),
(2, 'Penguin Random House', 'Travessera de Gràcia 47, Barcelona', '932000002', 'contacto@penguinrandomhouse.es'),
(3, 'Alfaguara', 'C/ Torrelaguna 60, Madrid', '914000003', 'info@alfaguara.es'),
(4, 'Ediciones SM', 'C/ Impresores 2, Boadilla del Monte, Madrid', '915000004', 'info@edsm.es'),
(5, 'Anagrama', 'C/ Pau Claris 172, Barcelona', '933000005', 'info@anagrama-ed.es'),
(6, 'Ediciones Minotauro', 'Av. Diagonal 662, Barcelona', '934000006', 'info@minotauro.es'),
(7, 'Alianza Editorial', 'C/ Juan Ignacio Luca de Tena 15, Madrid', '913000007', 'contacto@alianzaeditorial.es');

COMMIT;

-- 4. INSERCIÓN DE DATOS DE AUTORES (42 REGISTROS)
-- -----------------------------------------------------------------------------
START TRANSACTION;

INSERT INTO autores (id_autor, nombre, apellido1, apellido2, nacionalidad, fecha_nac, fecha_dep) VALUES
-- Clásicos españoles
(1, 'Miguel', 'de Cervantes', 'Saavedra', 'España', '1547-09-29', '1616-04-22'),
(2, 'Francisco', 'de Quevedo', 'y Villegas', 'España', '1580-09-14', '1645-09-08'),
(3, 'Lope', 'de Vega', 'Carpio', 'España', '1562-11-25', '1635-08-27'),
(4, 'Pedro', 'Calderón', 'de la Barca', 'España', '1600-01-17', '1681-05-25'),
(5, 'Benito', 'Pérez', 'Galdós', 'España', '1843-05-10', '1920-01-04'),
(6, 'Leopoldo', 'Alas', 'Clarín', 'España', '1852-04-25', '1901-06-13'),
(7, 'Gustavo', 'Adolfo', 'Bécquer', 'España', '1836-02-17', '1870-12-22'),
(8, 'Pío', 'Baroja', 'y Nessi', 'España', '1872-12-28', '1956-10-30'),
(9, 'Emilia', 'Pardo', 'Bazán', 'España', '1851-09-16', '1921-05-12'),
(10,'Jorge', 'Manrique', '', 'España', '1440-01-01', '1479-11-24'),
-- Contemporáneos españoles
(11,'Arturo', 'Pérez-Reverte', '', 'España', '1951-11-25', NULL),
(12,'Carlos', 'Ruiz', 'Zafón', 'España', '1964-09-25', '2020-06-19'),
(13,'Javier', 'Marías', '', 'España', '1951-09-20', '2022-09-11'),
(14,'Rosa', 'Montero', '', 'España', '1951-01-03', NULL),
(15,'Almudena', 'Grandes', '', 'España', '1960-05-07', '2021-11-27'),
(16,'Javier', 'Cercas', '', 'España', '1962-04-16', NULL),
-- Fantasía / Sagas
(17,'Andrzej', 'Sapkowski', '', 'Polonia', '1948-06-21', NULL),
(18,'John Ronald Reuel', 'Tolkien', '', 'Reino Unido', '1892-01-03', '1973-09-02'),
(19,'Patrick', 'Rothfuss', '', 'Estados Unidos', '1973-06-06', NULL),
(20,'George Raymond Richard', 'Martin', '', 'Estados Unidos', '1948-09-20', NULL),
(21,'Dan', 'Brown', '', 'Estados Unidos', '1964-06-22', NULL),
(22,'Terry', 'Pratchett', '', 'Reino Unido', '1948-04-28', '2015-03-12'),
-- Ciencia ficción
(23,'Frank', 'Herbert', '', 'Estados Unidos', '1920-10-08', '1986-02-11'),
(24,'Isaac', 'Asimov', '', 'Estados Unidos', '1920-01-02', '1992-04-06'),
(25,'William', 'Gibson', '', 'Estados Unidos', '1948-03-17', NULL),
(26,'Neal', 'Stephenson', '', 'Estados Unidos', '1959-10-31', NULL),
(27,'Dan', 'Simmons', '', 'Estados Unidos', '1948-04-04', NULL),
(28,'Orson Scott', 'Card', '', 'Estados Unidos', '1951-08-24', NULL),
(29,'Ursula K.', 'Le Guin', '', 'Estados Unidos', '1929-10-21', '2018-01-22'),
(30,'Joe', 'Haldeman', '', 'Estados Unidos', '1943-06-09', NULL),
(31,'Arthur C.', 'Clarke', '', 'Reino Unido', '1917-12-16', '2008-03-19'),
(32,'Ray', 'Bradbury', '', 'Estados Unidos', '1920-08-22', '2012-06-05'),
(33,'Aldous', 'Huxley', '', 'Reino Unido', '1894-07-26', '1963-11-22'),
(34,'Philip K.', 'Dick', '', 'Estados Unidos', '1928-12-16', '1982-03-02'),
(35,'Larry', 'Niven', '', 'Estados Unidos', '1938-04-30', NULL),
(36,'Walter M.', 'Miller Jr.', '', 'Estados Unidos', '1923-01-23', '1996-01-09'),
(37,'Douglas', 'Adams', '', 'Reino Unido', '1952-03-11', '2001-05-11'),
(38,'Stanislaw', 'Lem', '', 'Polonia', '1921-09-12', '2006-03-27'),
(39,'H. G.', 'Wells', '', 'Reino Unido', '1866-09-21', '1946-08-13'),
(40,'Connie', 'Willis', '', 'Estados Unidos', '1945-12-31', NULL),
(41,'John', 'Scalzi', '', 'Estados Unidos', '1969-05-10', NULL),
(42,'Liu', 'Cixin', '', 'China', '1963-06-23', NULL);

COMMIT;

-- 5. INSERCIÓN DEL CATÁLOGO DE LIBROS (164 REGISTROS)
-- -----------------------------------------------------------------------------
-- NOTA: Se omite la columna 'cantidad' y se aplica corrección ISBN para ID 72.
START TRANSACTION;

INSERT INTO libros (id_libro, titulo, id_autor, id_editorial, fecha_pub, paginas, id_genero, isbn) VALUES
(1, 'Don Quijote de la Mancha', 1, 1, '1605-01-16', 1056, 2, '9788491050294'),
(2, 'La Galatea', 1, 2, '1585-01-01', 400, 2, '9788497407948'),
(3, 'Novelas ejemplares', 1, 3, '1613-01-01', 640, 2, '9788420412145'),
(4, 'Los trabajos de Persiles y Sigismunda', 1, 5, '1617-01-01', 480, 2, '9788497409102'),
(5, 'La gitanilla', 1, 4, '1613-01-01', 160, 2, '9788420631263'),
(6, 'La casa de los celos y selvas de Ardenia', 1, 1, '1615-01-01', 320, 1, '9788420637000'),
(7, 'El coloquio de los perros', 1, 2, '1613-01-01', 160, 2, '9788420637001'),
(8, 'Los sueños', 2, 3, '1627-01-01', 320, 2, '9788420632086'),
(9, 'La vida del Buscón llamado Don Pablos', 2, 1, '1626-01-01', 280, 2, '9788420633892'),
(10, 'Poesía completa', 2, 5, '1648-01-01', 600, 7, '9788420637944'),
(11, 'Política de Dios', 2, 4, '1626-01-01', 260, 2, '9788420635117'),
(12, 'Sueños y discursos', 2, 2, '1627-01-01', 340, 2, '9788420635902'),
(13, 'Poesía satírica y burlesca', 2, 5, '1630-01-01', 280, 7, '9788420637003'),
(14, 'Fuente Ovejuna', 3, 4, '1619-01-01', 160, 1, '9788420633137'),
(15, 'Peribáñez y el comendador de Ocaña', 3, 3, '1614-01-01', 160, 1, '9788420633151'),
(16, 'El perro del hortelano', 3, 1, '1618-01-01', 160, 1, '9788420633144'),
(17, 'La dama boba', 3, 2, '1613-01-01', 160, 1, '9788420633168'),
(18, 'El caballero de Olmedo', 3, 5, '1620-01-01', 160, 1, '9788420633175'),
(19, 'El castigo sin venganza', 3, 4, '1631-01-01', 180, 1, '9788420637004'),
(20, 'El acero de Madrid', 3, 2, '1608-01-01', 190, 1, '9788420637005'),
(21, 'La vida es sueño', 4, 3, '1635-01-01', 160, 1, '9788420633052'),
(22, 'El alcalde de Zalamea', 4, 4, '1642-01-01', 160, 1, '9788420633069'),
(23, 'El médico de su honra', 4, 1, '1637-01-01', 160, 1, '9788420633076'),
(24, 'Casa con dos puertas mala es de guardar', 4, 2, '1632-01-01', 160, 1, '9788420633083'),
(25, 'La dama duende', 4, 5, '1629-01-01', 160, 1, '9788420633090'),
(26, 'Fortunata y Jacinta', 5, 2, '1887-01-01', 800, 2, '9788420665725'),
(27, 'Misericordia', 5, 1, '1897-01-01', 320, 2, '9788420665688'),
(28, 'Doña Perfecta', 5, 3, '1876-01-01', 320, 2, '9788420665695'),
(29, 'Marianela', 5, 4, '1878-01-01', 240, 2, '9788420665701'),
(30, 'Episodios nacionales: Trafalgar', 5, 5, '1873-01-01', 320, 2, '9788420665718'),
(31, 'Tormento', 5, 3, '1884-01-01', 400, 2, '9788420637006'),
(32, 'La desheredada', 5, 2, '1881-01-01', 480, 2, '9788420637007'),
(33, 'La Regenta', 6, 3, '1884-01-01', 880, 2, '9788420633298'),
(34, 'Su único hijo', 6, 1, '1891-01-01', 320, 2, '9788420633304'),
(35, 'Cuentos morales', 6, 2, '1896-01-01', 280, 2, '9788420633311'),
(36, 'Doña Berta', 6, 4, '1892-01-01', 120, 2, '9788420633328'),
(37, 'Pipá y otros cuentos', 6, 5, '1893-01-01', 200, 2, '9788420633335'),
(38, 'Cuentos completos', 6, 1, '1900-01-01', 450, 2, '9788420637008'),
(39, 'Rimas y leyendas', 7, 4, '1871-01-01', 320, 7, '9788420633571'),
(40, 'Rimas', 7, 1, '1871-01-01', 200, 7, '9788420633588'),
(41, 'Leyendas', 7, 2, '1871-01-01', 200, 7, '9788420633595'),
(42, 'Narraciones', 7, 3, '1871-01-01', 260, 2, '9788420633601'),
(43, 'Cartas desde mi celda', 7, 5, '1871-01-01', 200, 2, '9788420633618'),
(44, 'Obras completas', 7, 4, '1871-01-01', 600, 2, '9788420637009'),
(45, 'El árbol de la ciencia', 8, 5, '1911-01-01', 320, 2, '9788420636343'),
(46, 'La busca', 8, 1, '1904-01-01', 320, 2, '9788420636350'),
(47, 'Mala hierba', 8, 2, '1904-01-01', 320, 2, '9788420636367'),
(48, 'Aurora roja', 8, 3, '1904-01-01', 320, 2, '9788420636374'),
(49, 'Zalacaín el aventurero', 8, 4, '1909-01-01', 280, 2, '9788420636381'),
(50, 'Memorias de un hombre de acción', 8, 5, '1913-01-01', 600, 2, '9788420637010'),
(51, 'Los pazos de Ulloa', 9, 3, '1886-01-01', 400, 2, '9788420635551'),
(52, 'La madre naturaleza', 9, 4, '1887-01-01', 400, 2, '9788420635568'),
(53, 'Cuentos de Marineda', 9, 1, '1892-01-01', 240, 2, '9788420635575'),
(54, 'Insolación', 9, 2, '1889-01-01', 280, 2, '9788420635582'),
(55, 'La tribuna', 9, 5, '1882-01-01', 320, 2, '9788420635599'),
(56, 'Cuentos de Navidad y de Año Nuevo', 9, 3, '1892-01-01', 220, 2, '9788420637011'),
(57, 'Coplas a la muerte de su padre', 10, 4, '1470-01-01', 120, 7, '9788420636008'),
(58, 'Poesía completa', 10, 3, '1479-01-01', 200, 7, '9788420636015'),
(59, 'Cancionero', 10, 2, '1479-01-01', 180, 7, '9788420636022'),
(60, 'Obra poética seleccionada', 10, 1, '1479-01-01', 180, 7, '9788420636039'),
(61, 'Coplas y canciones', 10, 5, '1479-01-01', 200, 7, '9788420636046'),
(62, 'La tabla de Flandes', 11, 1, '1990-01-01', 384, 3, '9788408132214'),
(63, 'El club Dumas', 11, 1, '1993-01-01', 400, 3, '9788408132207'),
(64, 'El capitán Alatriste', 11, 2, '1996-01-01', 240, 3, '9788408197466'),
(65, 'Limpieza de sangre', 11, 2, '1997-01-01', 240, 3, '9788408197473'),
(66, 'Corsarios de Levante', 11, 2, '2006-01-01', 320, 3, '9788408197480'),
(67, 'El húsar', 11, 1, '1986-01-01', 160, 3, '9788408132001'),
(68, 'Territorio Comanche', 11, 1, '1994-01-01', 200, 3, '9788408132002'),
(69, 'La sombra del viento', 12, 3, '2001-01-01', 576, 3, '9788408172173'),
(70, 'El juego del ángel', 12, 3, '2008-01-01', 672, 3, '9788408189980'),
(71, 'El prisionero del cielo', 12, 3, '2011-01-01', 384, 3, '9788408189997'),
(72, 'El laberinto de los espíritus', 12, 3, '2016-01-01', 936, 3, '9788408172174'), -- ISBN Corregido
(73, 'Marina', 12, 4, '1999-01-01', 304, 3, '9788408178885'),
(74, 'El príncipe de la niebla', 12, 4, '1993-01-01', 240, 3, '9788408172003'),
(75, 'Las luces de septiembre', 12, 4, '1995-01-01', 260, 3, '9788408172004'),
(76, 'Corazón tan blanco', 13, 5, '1992-01-01', 352, 3, '9788420469286'),
(77, 'Mañana en la batalla piensa en mí', 13, 5, '1994-01-01', 320, 3, '9788420469293'),
(78, 'Tu rostro mañana I. Fiebre y lanza', 13, 5, '2002-01-01', 448, 3, '9788420469309'),
(79, 'Tu rostro mañana II. Baile y sueño', 13, 5, '2004-01-01', 448, 3, '9788420469316'),
(80, 'Tu rostro mañana III. Veneno y sombra y adiós', 13, 5, '2007-01-01', 640, 3, '9788420469323'),
(81, 'Los enamoramientos', 13, 5, '2011-01-01', 400, 3, '9788420469338'),
(82, 'La loca de la casa', 14, 4, '2003-01-01', 256, 3, '9788432216871'),
(83, 'La hija del caníbal', 14, 4, '1997-01-01', 448, 3, '9788432209514'),
(84, 'La ridícula idea de no volver a verte', 14, 4, '2013-01-01', 240, 3, '9788432221479'),
(85, 'Lágrimas en la lluvia', 14, 4, '2011-01-01', 448, 5, '9788432229963'),
(86, 'El peso del corazón', 14, 4, '2015-01-01', 416, 5, '9788432231485'),
(87, 'Amado amo', 14, 4, '1988-01-01', 280, 3, '9788432216000'),
(88, 'Las edades de Lulú', 15, 3, '1989-01-01', 304, 3, '9788432207183'),
(89, 'Malena es un nombre de tango', 15, 3, '1994-01-01', 560, 3, '9788432207190'),
(90, 'El corazón helado', 15, 3, '2007-01-01', 928, 3, '9788432217731'),
(91, 'Inés y la alegría', 15, 3, '2010-01-01', 768, 3, '9788432214679'),
(92, 'Los pacientes del doctor García', 15, 3, '2017-01-01', 768, 3, '9788432230044'),
(93, 'Atlas de geografía humana', 15, 3, '1998-01-01', 480, 3, '9788432207203'),
(94, 'Soldados de Salamina', 16, 2, '2001-01-01', 240, 3, '9788432214327'),
(95, 'Anatomía de un instante', 16, 2, '2009-01-01', 432, 3, '9788432228690'),
(96, 'El impostor', 16, 2, '2014-01-01', 432, 3, '9788432228683'),
(97, 'Las leyes de la frontera', 16, 2, '2012-01-01', 368, 3, '9788432229130'),
(98, 'Independencia', 16, 2, '2021-01-01', 400, 3, '9788432240784'),
(99, 'El monarca de las sombras', 16, 2, '2017-01-01', 320, 3, '9788432233202'),
(100, 'El último deseo', 17, 6, '1993-01-01', 288, 4, '9788498891340'),
(101, 'La espada del destino', 17, 6, '1992-01-01', 288, 4, '9788498891357'),
(102, 'La sangre de los elfos', 17, 6, '1994-01-01', 320, 4, '9788498891364'),
(103, 'Tiempo de odio', 17, 6, '1995-01-01', 352, 4, '9788498891371'),
(104, 'Bautismo de fuego', 17, 6, '1996-01-01', 400, 4, '9788498891388'),
(105, 'La torre de la golondrina', 17, 6, '1997-01-01', 464, 4, '9788498891395'),
(106, 'La dama del lago', 17, 6, '1999-01-01', 592, 4, '9788498891401'),
(107, 'Estación de tormentas', 17, 6, '2013-01-01', 416, 4, '9788498891418'),
(108, 'El hobbit', 18, 6, '1937-01-01', 320, 4, '9788445000683'),
(109, 'El Señor de los Anillos: La Comunidad del Anillo', 18, 6, '1954-01-01', 576, 4, '9788445000669'),
(110, 'El Señor de los Anillos: Las dos torres', 18, 6, '1954-01-01', 480, 4, '9788445000676'),
(111, 'El Señor de los Anillos: El retorno del Rey', 18, 6, '1955-01-01', 512, 4, '9788445000683'),
(112, 'El Silmarillion', 18, 6, '1977-01-01', 480, 4, '9788445000690'),
(113, 'Cuentos inconclusos de Númenor y la Tierra Media', 18, 6, '1980-01-01', 560, 4, '9788445000706'),
(114, 'El nombre del viento', 19, 1, '2007-01-01', 880, 4, '9788499082471'),
(115, 'El temor de un hombre sabio', 19, 1, '2011-01-01', 1200, 4, '9788499088053'),
(116, 'La música del silencio', 19, 1, '2014-01-01', 176, 4, '9788490627015'),
(117, 'Juego de tronos', 20, 7, '1996-01-01', 800, 4, '9788496208959'),
(118, 'Choque de reyes', 20, 7, '1998-01-01', 864, 4, '9788496208966'),
(119, 'Tormenta de espadas', 20, 7, '2000-01-01', 1216, 4, '9788496208973'),
(120, 'Festín de cuervos', 20, 7, '2005-01-01', 976, 4, '9788496208980'),
(121, 'Danza de dragones', 20, 7, '2011-01-01', 1184, 4, '9788496208997'),
(122, 'Fortaleza digital', 21, 1, '1998-01-01', 384, 6, '9780312263126'),
(123, 'La conspiración', 21, 1, '2001-01-01', 576, 6, '9780671027384'),
(124, 'Ángeles y demonios', 21, 1, '2000-01-01', 736, 6, '9780671027360'),
(125, 'El código Da Vinci', 21, 1, '2003-01-01', 592, 6, '9780385504201'),
(126, 'El símbolo perdido', 21, 1, '2009-01-01', 528, 6, '9780385504225'),
(127, 'Inferno', 21, 1, '2013-01-01', 624, 6, '9780385537858'),
(128, 'Origen', 21, 1, '2017-01-01', 480, 6, '9780385514231'),
(129, 'El color de la magia', 22, 5, '1983-01-01', 288, 4, '9780062225672'),
(130, 'La luz fantástica', 22, 5, '1986-01-01', 288, 4, '9780062225757'),
(131, 'Ritos iguales', 22, 5, '1987-01-01', 288, 4, '9780062225719'),
(132, 'Mort', 22, 5, '1987-01-01', 320, 4, '9780062225710'),
(133, '¡Guardias! ¿Guardias?', 22, 5, '1989-01-01', 416, 4, '9780062225734'),
(134, 'Dioses menores', 22, 5, '1992-01-01', 416, 4, '9780062237355'),
(135, 'Ronda de noche', 22, 5, '2002-01-01', 480, 4, '9780062307393'),
(136, 'Cartas en el asunto', 22, 5, '2004-01-01', 416, 4, '9780062302381'),
(137, 'Dune', 23, 7, '1965-01-01', 688, 5, '9780441172719'),
(138, 'Fundación', 24, 7, '1951-01-01', 296, 5, '9780553293357'),
(139, 'Fundación e Imperio', 24, 7, '1952-01-01', 288, 5, '9780553293371'),
(140, 'Segunda Fundación', 24, 7, '1953-01-01', 288, 5, '9780553293364'),
(141, 'Neuromante', 25, 5, '1984-01-01', 288, 5, '9780441569595'),
(142, 'Snow Crash', 26, 5, '1992-01-01', 480, 5, '9780553380958'),
(143, 'Hyperion', 27, 3, '1989-01-01', 496, 5, '9780553283686'),
(144, 'La caída de Hyperion', 27, 3, '1990-01-01', 624, 5, '9780553288209'),
(145, 'El juego de Ender', 28, 4, '1985-01-01', 352, 5, '9780812550702'),
(146, 'La mano izquierda de la oscuridad', 29, 5, '1969-01-01', 304, 5, '9780441478125'),
(147, 'Los desposeídos', 29, 5, '1974-01-01', 400, 5, '9780060512751'),
(148, 'La guerra interminable', 30, 3, '1974-01-01', 336, 5, '9780060976256'),
(149, 'El fin de la infancia', 31, 2, '1953-01-01', 224, 5, '9780345444059'),
(150, '2001: Una odisea espacial', 31, 2, '1968-01-01', 256, 5, '9780451457998'),
(151, 'Fahrenheit 451', 32, 4, '1953-01-01', 192, 5, '9781451673319'),
(152, 'Crónicas marcianas', 32, 4, '1950-01-01', 256, 5, '9781451678192'),
(153, 'Un mundo feliz', 33, 1, '1932-01-01', 288, 5, '9780060850525'),
(154, '¿Sueñan los androides con ovejas eléctricas?', 34, 5, '1968-01-01', 256, 5, '9780345404473'),
(155, 'El hombre en el castillo', 34, 5, '1962-01-01', 272, 5, '9780547572482'),
(156, 'Mundo Anillo', 35, 3, '1970-01-01', 352, 5, '9780345333926'),
(157, 'Cántico por Leibowitz', 36, 2, '1959-01-01', 368, 5, '9780060892990'),
(158, 'Guía del autoestopista galáctico', 37, 4, '1979-01-01', 224, 5, '9780345391803'),
(159, 'Solaris', 38, 3, '1961-01-01', 224, 5, '9780156027601'),
(160, 'La máquina del tiempo', 39, 1, '1895-01-01', 160, 5, '9780451528551'),
(161, 'Yo, robot', 24, 7, '1950-01-01', 304, 5, '9780553294385'),
(162, 'El libro del día del juicio final', 40, 3, '1992-01-01', 608, 5, '9780553562736'),
(163, 'La vieja guardia', 41, 1, '2005-01-01', 320, 5, '9780765348272'),
(164, 'El problema de los tres cuerpos', 42, 2, '2006-01-01', 416, 5, '9780765377067');

COMMIT;

-- 6. MÓDULOS DE TRANSACCIONES Y CARGA DE DATOS DE GESTIÓN
-- -----------------------------------------------------------------------------
START TRANSACTION;

-- Carga Inicial de Usuarios
INSERT INTO usuarios (nombre, apellidos, dni, email, telefono) VALUES
('Juan', 'García Pérez', '12345678A', 'juan.garcia@email.com', '600111222'),
('María', 'López Martínez', '87654321B', 'maria.lopez@email.com', '600333444'),
('Carlos', 'Sánchez Ruiz', '45678901C', 'carlos.san@email.com', '600555666'),
('Elena', 'Belmonte Sanz', '23456789D', 'elena.b@email.com', '611222333'),
('Lucía', 'Fernández Sanz', '54321098E', 'lucia.fer@gmail.com', '622334455'),
('Marcos', 'Pérez Molino', '34567890F', 'm.perez.m@outlook.com', '655998877'),
('Sofía', 'Garrido Ortiz', '11223344G', 'sofia_garrido@universidad.es', '677112233'),
('Javier', 'Torres Noguera', '99887766H', 'javi.torres@empresa.com', '600445566'),
('Carmen', 'Jiménez Ruiz', '55443322I', 'carmen.jim@gmail.com', '633889900'),
('David', 'Vázquez Costa', '66778899J', 'david_v@protonmail.com', '688554433'),
('Isabel', 'Cano Benítez', '22334455K', 'isabel.cano@icloud.com', '611009988'),
('Roberto', 'Méndez López', '77665544L', 'robert.mendez@gmail.com', '644776655'),
('Adriana', 'Soto Mayor', '88990011M', 'adri.soto@yahoo.es', '699223344'),
('Fernando', 'Ramos Gil', '12121212N', 'fer.ramos@gmail.com', '655667788'),
('Laura', 'Blanco Suero', '34343434O', 'lblanco_88@gmail.com', '600123456'),
('Diego', 'Navarro Prieto', '56565656P', 'd.navarro@gmail.com', '610987654'),
('Marta', 'Castillo Rey', '78787878Q', 'marta.cast@hotmail.com', '620112233'),
('Raúl', 'Heredia Pousa', '90909090R', 'raul.heredia@gmail.com', '630445566'),
('Beatriz', 'Pascual Domínguez', '13579246S', 'bea.pascual@me.com', '640778899'),
('Álvaro', 'Marín Valero', '24680135T', 'alvaro.marin@gmail.com', '650001122');

-- Carga Inicial de Empleados
INSERT INTO empleados (nombre, apellidos, cargo, salario) VALUES
('Ana', 'Rodríguez Soler', 'Bibliotecaria Jefe', 2500.00),
('Pedro', 'Gómez Faz', 'Auxiliar de Sala', 1500.00),
('Ricardo', 'Luna Mendez', 'Técnico de Archivo', 1850.00),
('Patricia', 'Serrano Vega', 'Responsable de Adquisiciones', 2100.00),
('Miguel', 'Ángel Guerrero', 'Seguridad y Conserjería', 1300.00),
('Sonia', 'Reyes Calvo', 'Catalogadora', 1750.00);

-- Gestión de Ejemplares (Normalización de Stock)
INSERT INTO ejemplares (id_libro, estado) VALUES
(1, 'Disponible'), (1, 'Disponible'), (1, 'Prestado'), -- El Quijote
(69, 'Disponible'), (69, 'Reservado'),  -- La Sombra del Viento
(72, 'Disponible'), (108, 'Disponible'),
(137, 'Mantenimiento'), (164, 'Disponible'), 
(1, 'Disponible'), (1, 'Disponible'), -- Más Quijotes
(69, 'Prestado'), (69, 'Dañado'),      -- La Sombra del Viento
(100, 'Disponible'), (100, 'Prestado'), -- El Último Deseo (The Witcher)
(109, 'Disponible'), (110, 'Disponible'), (111, 'Disponible'), -- ESDLA
(114, 'Prestado'), (114, 'Reservado'),  -- El Nombre del Viento
(117, 'Disponible'), (117, 'Prestado'), -- Juego de Tronos
(137, 'Disponible'), (137, 'Prestado'), -- Dune
(151, 'Mantenimiento'),                 -- Fahrenheit 451
(164, 'Disponible'), (164, 'Prestado'), -- Tres Cuerpos
(12, 'Extraviado'),                     -- Un libro de Quevedo
(138, 'Disponible'), (138, 'Disponible'), -- Fundación
(153, 'Disponible'),                    -- Un mundo feliz
(73, 'Prestado'),                       -- Marina
(114, 'Prestado'), (114, 'Disponible'), -- El nombre del viento (Rothfuss)
(164, 'Prestado'), (164, 'Reservado'),  -- El problema de los tres cuerpos (Liu Cixin)
(138, 'Prestado'), (139, 'Disponible'), -- Saga Fundación (Asimov)
(151, 'Dañado'), (151, 'Disponible'),   -- Fahrenheit 451 (Bradbury)
(108, 'Prestado'), (109, 'Prestado'),   -- Tolkien
(110, 'Disponible'), (111, 'Disponible'),
(69, 'Prestado'), (70, 'Prestado'),     -- Zafón
(125, 'Prestado'),                      -- Dan Brown
(1, 'Mantenimiento'),                   -- El Quijote (Edición antigua)
(145, 'Disponible');                    -- El juego de Ender

-- Transacciones de Préstamos (Corrección de Sintaxis Aplicada)
INSERT INTO prestamos (id_usuario, id_ejemplar, fecha_inicio, fecha_devolucion_prevista, fecha_devolucion_real) VALUES
(1, 3, '2024-05-01', '2024-05-15', NULL),
(2, 5, '2024-05-10', '2024-05-25', '2024-05-20'),
(3, 8, '2024-05-12', '2024-05-26', NULL),
(5, 12, '2024-06-01', '2024-06-15', '2024-06-14'), -- Devolución a tiempo
(6, 15, '2024-06-05', '2024-06-20', NULL),         -- En curso
(7, 19, '2024-06-10', '2024-06-25', '2024-07-02'), -- Devolución tardía
(8, 21, '2024-06-12', '2024-06-26', NULL),         -- En curso
(9, 23, '2024-06-15', '2024-06-30', NULL),         -- En curso
(10, 27, '2024-06-20', '2024-07-04', '2024-07-04'),-- Justo a tiempo
(11, 31, '2024-06-22', '2024-07-06', NULL),        -- En curso
(12, 1, '2024-06-25', '2024-07-10', NULL),         -- En curso (Quijote)
(1, 33, '2024-06-28', '2024-07-12', NULL),         -- Segundo préstamo para Juan

-- Préstamos ya finalizados con retraso (generarán sanciones)
(13, 35, '2024-06-01', '2024-06-15', '2024-06-25'), -- 10 días tarde
(14, 37, '2024-06-05', '2024-06-19', '2024-06-20'), -- 1 día tarde
(15, 39, '2024-06-10', '2024-06-24', '2024-07-05'), -- Dañado y tarde

-- Préstamos activos (Aún no devueltos)
(16, 41, '2024-07-01', '2024-07-15', NULL),
(17, 43, '2024-07-02', '2024-07-16', NULL),
(18, 44, '2024-07-05', '2024-07-19', NULL),
(19, 45, '2024-07-08', '2024-07-22', NULL),
(20, 46, '2024-07-10', '2024-07-24', NULL),
(5, 47, '2024-07-12', '2024-07-26', NULL),
(6, 48, '2024-07-14', '2024-07-28', NULL),
(7, 36, '2024-07-15', '2024-07-29', NULL),

-- Préstamo que terminó en extravío
(1, 23, '2024-05-20', '2024-06-03', NULL); 

INSERT INTO reservas (id_usuario, id_libro, fecha_reserva) VALUES
(13, 69, '2024-06-15'), -- Reserva La Sombra del Viento
(14, 114, '2024-06-18'), -- Reserva El Nombre del Viento
(15, 117, '2024-06-20'), -- Reserva Juego de Tronos
(16, 164, '2024-06-22'), -- Reserva El Problema de los Tres Cuerpos
(5, 137, '2024-06-25'),  -- Reserva Dune
(8, 100, '2024-06-26'),  -- Reserva El Último Deseo
(2, 114, '2024-07-15'), -- Esperando Rothfuss
(3, 164, '2024-07-16'), -- Esperando Liu Cixin
(4, 138, '2024-07-17'), -- Esperando Asimov
(8, 69, '2024-07-18'),  -- Esperando Zafón
(9, 70, '2024-07-18'),  -- Esperando Zafón
(10, 109, '2024-07-20'),-- Esperando Tolkien
(11, 108, '2024-07-20'),-- Esperando Tolkien
(12, 125, '2024-07-21');-- Esperando Dan Brown

-- Gestión de Sanciones (Lógica Evolucionada)
INSERT INTO sanciones (id_usuario, id_prestamo, motivo, monto, pagada, fecha_pago) VALUES
(1, 1, 'Retraso en devolución Quijote', 5.50, FALSE, NULL),
(2, 2, 'Daño leve en portada', 2.00, TRUE, '2024-05-21'),
(7, 6, 'Retraso de 7 días en la entrega', 3.50, TRUE, '2024-07-03'),
(8, 7, 'Pendiente - Retraso en curso', 1.50, FALSE, NULL),
(12, 4, 'Libro devuelto con manchas de café', 12.00, FALSE, NULL),
(2, 2, 'Pérdida de separador original (ajuste de inventario)', 0.50, TRUE, '2024-05-21'),

-- Sanción por los 10 días de retraso del usuario 13 (id_prestamo 13 aprox)
(13, 10, 'Demora de 10 días en la devolución (2024-06-25)', 5.00, TRUE, '2024-06-25'),

-- Sanción por retraso leve del usuario 14
(14, 11, 'Demora de 1 día en la devolución', 0.50, TRUE, '2024-06-20'),

-- Sanción por daño grave y retraso del usuario 15
(15, 12, 'Hojas subrayadas y devolución tardía', 15.00, FALSE, NULL),

-- Sanción por extravío (Usuario 1, id_prestamo 18 aprox)
(1, 18, 'Libro declarado como extraviado por el usuario', 25.00, FALSE, NULL),

-- Una sanción antigua no pagada
(12, 5, 'Retraso acumulado mes anterior', 3.20, FALSE, NULL);


COMMIT;

-- Reestablecer estado operativo de restricciones
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================================
-- FIN DEL SCRIPT SQL: BASE DE DATOS 'BIBLIOTECA' LISTA PARA PRODUCCIÓN
-- =============================================================================

-- =============================================================================
-- VISTA RÁPIDA DE CONTROL 
-- =============================================================================
-- SELECT u.nombre, l.titulo, p.fecha_inicio FROM usuarios u 
-- JOIN prestamos p ON u.id_usuario = p.id_usuario 
-- JOIN ejemplares e ON p.id_ejemplar = e.id_ejemplar
-- JOIN libros l ON e.id_libro = l.id_libro;

-- =============================================================================
-- CONSULTAS DE COMPROBACIÓN RECOMENDADAS
-- =============================================================================

-- 1. Ver qué libros están más reservados:
-- SELECT l.titulo, COUNT(r.id_reserva) AS total_reservas 
-- FROM libros l JOIN reservas r ON l.id_libro = r.id_libro 
-- GROUP BY l.titulo ORDER BY total_reservas DESC;

-- 2. Ver usuarios con sanciones pendientes:
-- SELECT u.nombre, u.apellidos, s.motivo, s.monto 
-- FROM usuarios u JOIN sanciones s ON u.id_usuario = s.id_usuario 
-- WHERE s.pagada = FALSE;

-- 3. Libros que deberían haber sido devueltos ya (Retrasos actuales)
-- SELECT 
--     u.nombre, 
--     u.apellidos, 
--     u.telefono, 
--     l.titulo, 
--     p.fecha_devolucion_prevista,
--     DATEDIFF(CURDATE(), p.fecha_devolucion_prevista) AS dias_de_retraso
-- FROM prestamos p
-- JOIN usuarios u ON p.id_usuario = u.id_usuario
-- JOIN ejemplares e ON p.id_ejemplar = e.id_ejemplar
-- JOIN libros l ON e.id_libro = l.id_libro
-- WHERE p.fecha_devolucion_real IS NULL 
--   AND p.fecha_devolucion_prevista < CURDATE();

-- 4. Listado de libros reservados que ya están disponibles
-- SELECT 
--     u.nombre AS usuario, 
--     u.email, 
--     l.titulo AS libro_esperado,
--     r.fecha_reserva
-- FROM reservas r
-- JOIN usuarios u ON r.id_usuario = u.id_usuario
-- JOIN libros l ON r.id_libro = l.id_libro
-- JOIN ejemplares e ON l.id_libro = e.id_libro
-- WHERE e.estado = 'Disponible'
-- GROUP BY u.id_usuario, l.id_libro;

-- 5. El "Top 10" de libros más prestados
-- SELECT 
--     l.titulo, 
--     a.nombre AS autor, 
--     COUNT(p.id_prestamo) AS total_prestamos
-- FROM libros l
-- JOIN autores a ON l.id_autor = a.id_autor
-- JOIN ejemplares e ON l.id_libro = e.id_libro
-- JOIN prestamos p ON e.id_ejemplar = p.id_ejemplar
-- GROUP BY l.id_libro
-- ORDER BY total_prestamos DESC
-- LIMIT 10;

-- 6. Géneros literarios más demandados
-- SELECT 
--     g.nombre AS genero, 
--     COUNT(p.id_prestamo) AS veces_prestado
-- FROM generos g
-- JOIN libros l ON g.id_genero = l.id_genero
-- JOIN ejemplares e ON l.id_libro = e.id_libro
-- JOIN prestamos p ON e.id_ejemplar = p.id_ejemplar
-- GROUP BY g.id_genero
-- ORDER BY veces_prestado DESC;

-- 7. Ranking de "deudores" (Usuarios con más sanciones pendientes)
-- SELECT 
--     u.nombre, 
--     u.apellidos, 
--     SUM(s.monto) AS deuda_total,
--     COUNT(s.id_sancion) AS numero_sanciones
-- FROM usuarios u
-- JOIN sanciones s ON u.id_usuario = s.id_usuario
-- WHERE s.pagada = FALSE
-- GROUP BY u.id_usuario
-- HAVING deuda_total > 0
-- ORDER BY deuda_total DESC;

-- 8. Resumen de ingresos mensuales por sanciones
-- SELECT 
--     DATE_FORMAT(fecha_pago, '%Y-%m') AS mes, 
--     SUM(monto) AS total_recaudado
-- FROM sanciones
-- WHERE pagada = TRUE
-- GROUP BY mes;

-- 9. Libros que no tienen ningún ejemplar físico registrado
-- SELECT l.id_libro, l.titulo
-- FROM libros l
-- LEFT JOIN ejemplares e ON l.id_libro = e.id_libro
-- WHERE e.id_ejemplar IS NULL;

-- 10. Estado actual del inventario (Resumen de stock)
-- SELECT 
--     estado, 
--     COUNT(*) AS cantidad,
--     ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ejemplares), 2) AS porcentaje
-- FROM ejemplares
-- GROUP BY estado;

-- 11. Usuarios "estrella" (Los que más leen)
-- SELECT 
--     u.nombre, 
--     u.apellidos, 
--     COUNT(p.id_prestamo) AS libros_leidos
-- FROM usuarios u
-- JOIN prestamos p ON u.id_usuario = p.id_usuario
-- GROUP BY u.id_usuario
-- ORDER BY libros_leidos DESC
-- LIMIT 5;

