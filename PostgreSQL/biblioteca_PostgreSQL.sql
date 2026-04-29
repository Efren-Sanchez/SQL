-- =============================================================================
-- SCRIPT SQL: SISTEMA DE GESTIÓN DE BIBLIOTECA EVOLUCIONADO
-- Arquitecto de Bases de Datos: Senior PostgreSQL Developer
-- Optimizado para: PostgreSQL 12+
-- =============================================================================

-- 1. CONFIGURACIÓN E INICIALIZACIÓN (Limpieza con CASCADE)
-- -----------------------------------------------------------------------------
-- En Postgres, CASCADE borra automáticamente las claves foráneas dependientes.
DROP TABLE IF EXISTS sanciones CASCADE;
DROP TABLE IF EXISTS reservas CASCADE;
DROP TABLE IF EXISTS prestamos CASCADE;
DROP TABLE IF EXISTS ejemplares CASCADE;
DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS libros CASCADE;
DROP TABLE IF EXISTS generos CASCADE;
DROP TABLE IF EXISTS editoriales CASCADE;
DROP TABLE IF EXISTS autores CASCADE;

-- Eliminación de tipos personalizados si existen
DROP TYPE IF EXISTS estado_ejemplar CASCADE;

-- 2. DEFINICIÓN DE TIPOS PERSONALIZADOS Y ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TYPE estado_ejemplar AS ENUM (
    'Disponible', 'Prestado', 'Reservado', 'Mantenimiento', 'Extraviado', 'Dañado'
);

CREATE TABLE autores (
    id_autor    INT PRIMARY KEY, -- Se mantiene INT fijo para coincidir con el ID del script original
    nombre      VARCHAR(50) NOT NULL,
    apellido1   VARCHAR(50),
    apellido2   VARCHAR(50),
    nacionalidad VARCHAR(50),
    fecha_nac   DATE NOT NULL,
    fecha_dep   DATE
);

CREATE TABLE editoriales (
    id_editorial INT PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    direccion     VARCHAR(150),
    telefono      VARCHAR(20),
    email         VARCHAR(100)
);

CREATE TABLE generos (
    id_genero INT PRIMARY KEY,
    nombre    VARCHAR(50) NOT NULL
);

CREATE TABLE libros (
    id_libro     INT PRIMARY KEY,
    titulo       VARCHAR(150) NOT NULL,
    id_autor     INT NOT NULL REFERENCES autores(id_autor),
    id_editorial INT NOT NULL REFERENCES editoriales(id_editorial),
    fecha_pub    DATE NOT NULL,
    paginas      INT NOT NULL CHECK (paginas > 0),
    id_genero    INT NOT NULL REFERENCES generos(id_genero),
    isbn         VARCHAR(20) NOT NULL
);

CREATE TABLE usuarios (
    id_usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre     VARCHAR(50) NOT NULL,
    apellidos  VARCHAR(100) NOT NULL,
    dni        VARCHAR(15) UNIQUE NOT NULL,
    email      VARCHAR(100),
    telefono   VARCHAR(20)
);

CREATE TABLE empleados (
    id_empleado INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL,
    apellidos   VARCHAR(100) NOT NULL,
    cargo       VARCHAR(50),
    salario     NUMERIC(10,2) CHECK (salario >= 0)
);

CREATE TABLE ejemplares (
    id_ejemplar INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_libro    INT NOT NULL REFERENCES libros(id_libro),
    estado      estado_ejemplar DEFAULT 'Disponible'
);

CREATE TABLE prestamos (
    id_prestamo               INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario                INT NOT NULL REFERENCES usuarios(id_usuario),
    id_ejemplar               INT NOT NULL REFERENCES ejemplares(id_ejemplar),
    fecha_inicio              DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_devolucion_prevista DATE NOT NULL,
    fecha_devolucion_real     DATE,
    CONSTRAINT check_fechas CHECK (fecha_devolucion_prevista >= fecha_inicio)
);

CREATE TABLE reservas (
    id_reserva    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario    INT NOT NULL REFERENCES usuarios(id_usuario),
    id_libro      INT NOT NULL REFERENCES libros(id_libro),
    fecha_reserva DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE sanciones (
    id_sancion  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario  INT NOT NULL REFERENCES usuarios(id_usuario),
    id_prestamo INT NOT NULL REFERENCES prestamos(id_prestamo),
    motivo      VARCHAR(255),
    monto       NUMERIC(10,2) DEFAULT 0.00,
    pagada      BOOLEAN DEFAULT FALSE,
    fecha_pago  DATE
);

-- 3. INSERCIÓN DE DATOS (DML)
-- -----------------------------------------------------------------------------
BEGIN;

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

INSERT INTO autores (id_autor, nombre, apellido1, apellido2, nacionalidad, fecha_nac, fecha_dep) VALUES
(1, 'Miguel', 'de Cervantes', 'Saavedra', 'España', '1547-09-29', '1616-04-22'),
(11,'Arturo', 'Pérez-Reverte', '', 'España', '1951-11-25', NULL),
(12,'Carlos', 'Ruiz', 'Zafón', 'España', '1964-09-25', '2020-06-19'),
(18,'John Ronald Reuel', 'Tolkien', '', 'Reino Unido', '1892-01-03', '1973-09-02'),
(42,'Liu', 'Cixin', '', 'China', '1963-06-23', NULL);

INSERT INTO libros (id_libro, titulo, id_autor, id_editorial, fecha_pub, paginas, id_genero, isbn) VALUES
(1, 'Don Quijote de la Mancha', 1, 1, '1605-01-16', 1056, 2, '9788491050294'),
(69, 'La sombra del viento', 12, 3, '2001-01-01', 576, 3, '9788408172173'),
(108, 'El hobbit', 18, 6, '1937-01-01', 320, 4, '9788445000683'),
(164, 'El problema de los tres cuerpos', 42, 2, '2006-01-01', 416, 5, '9780765377067');

INSERT INTO usuarios (nombre, apellidos, dni, email, telefono) VALUES
('Juan', 'García Pérez', '12345678A', 'juan.garcia@email.com', '600111222'),
('María', 'López Martínez', '87654321B', 'maria.lopez@email.com', '600333444');

INSERT INTO ejemplares (id_libro, estado) VALUES
(1, 'Disponible'), (69, 'Prestado'), (108, 'Disponible'), (164, 'Reservado');

INSERT INTO prestamos (id_usuario, id_ejemplar, fecha_inicio, fecha_devolucion_prevista) VALUES
(1, 2, '2024-04-20', '2024-05-04');

INSERT INTO sanciones (id_usuario, id_prestamo, motivo, monto, pagada) VALUES
(1, 1, 'Retraso en devolución', 5.00, FALSE);

COMMIT;

-- 4. CONSULTAS DE COMPROBACIÓN (POSTGRES)
-- -----------------------------------------------------------------------------

-- A. Estado actual de ejemplares con nombres de libros
SELECT l.titulo, e.estado 
FROM ejemplares e 
JOIN libros l USING (id_libro)
ORDER BY e.estado;

-- B. Usuarios con sanciones pendientes (Uso de BOOLEAN nativo)
SELECT nombre, apellidos, motivo, monto 
FROM sanciones 
JOIN usuarios USING (id_usuario) 
WHERE NOT pagada;

-- C. Libros por género (Utilizando ILIKE para búsqueda insensible a mayúsculas)
SELECT l.titulo, g.nombre as genero
FROM libros l
JOIN generos g USING (id_genero)
WHERE g.nombre ILIKE '%narrativa%';