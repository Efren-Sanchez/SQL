-- =============================================================================
-- SISTEMA DE GESTIÓN DE GIMNASIO
-- PostgreSQL 12+
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

-- 1. LIMPIEZA E INICIALIZACIÓN
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS asistencia CASCADE;
DROP TABLE IF EXISTS pagos CASCADE;
DROP TABLE IF EXISTS clases_registro CASCADE;
DROP TABLE IF EXISTS clases CASCADE;
DROP TABLE IF EXISTS instructores CASCADE;
DROP TABLE IF EXISTS socios CASCADE;
DROP TABLE IF EXISTS membresias CASCADE;

-- Eliminación de tipos ENUM si ya existen
DROP TYPE IF EXISTS estado_socio;
DROP TYPE IF EXISTS dia_semana;
DROP TYPE IF EXISTS metodo_pago;

-- 2. DEFINICIÓN DE TIPOS Y ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TYPE estado_socio AS ENUM ('Activo', 'Inactivo', 'Pendiente');
CREATE TYPE dia_semana AS ENUM ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo');
CREATE TYPE metodo_pago AS ENUM ('Efectivo', 'Tarjeta', 'Transferencia');

CREATE TABLE membresias (
    id_membresia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    duracion_dias INT NOT NULL,
    descripcion TEXT
);

CREATE TABLE socios (
    id_socio INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_nac DATE,
    id_membresia INT,
    estado estado_socio DEFAULT 'Pendiente',
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_socio_membresia FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia) ON DELETE SET NULL
);

CREATE TABLE instructores (
    id_instructor INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especialidad VARCHAR(50),
    salario_hora DECIMAL(10,2),
    telefono VARCHAR(20)
);

CREATE TABLE clases (
    id_clase INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_instructor INT,
    horario TIME NOT NULL,
    dia_semana dia_semana NOT NULL,
    capacidad_max INT DEFAULT 20,
    CONSTRAINT fk_clase_instructor FOREIGN KEY (id_instructor) REFERENCES instructores(id_instructor) ON DELETE SET NULL
);

CREATE TABLE clases_registro (
    id_registro INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio INT NOT NULL,
    id_clase INT NOT NULL,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_reg_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE,
    CONSTRAINT fk_reg_clase FOREIGN KEY (id_clase) REFERENCES clases(id_clase) ON DELETE CASCADE,
    UNIQUE (id_socio, id_clase)
);

CREATE TABLE pagos (
    id_pago INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago metodo_pago NOT NULL,
    CONSTRAINT fk_pago_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE
);

CREATE TABLE asistencia (
    id_asistencia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio INT NOT NULL,
    fecha_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_asistencia_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE
);

-- 3. CARGA DE DATOS COHERENTES (DML)
-- -----------------------------------------------------------------------------
BEGIN;

-- Membresías
INSERT INTO membresias (nombre, precio, duracion_dias, descripcion) VALUES
('Básica', 29.90, 30, 'Acceso a sala de máquinas únicamente'),
('Premium', 45.00, 30, 'Máquinas + Clases grupales ilimitadas'),
('Anual VIP', 450.00, 365, 'Todo incluido con descuento por pago anual');

-- Instructores
INSERT INTO instructores (nombre, especialidad, salario_hora) VALUES
('Marta Sánchez', 'Yoga y Pilates', 25.00),
('Ricardo Tormo', 'Crossfit e HIIT', 30.00),
('Sonia Monroy', 'Zumba y Baile', 22.00),
('Julián Expósito', 'Musculación', 18.00),
('Elena Cano', 'Spinning', 24.00);

-- Clases
INSERT INTO clases (nombre, id_instructor, horario, dia_semana, capacidad_max) VALUES
('Yoga Flow', 1, '09:00:00', 'Lunes', 15),
('Crossfit WOD', 2, '18:30:00', 'Martes', 12),
('Zumba Night', 3, '20:00:00', 'Viernes', 25),
('Spinning Pro', 5, '08:00:00', 'Miércoles', 20),
('Musculación', 4, '11:00:00', 'Sábado', 15);

-- Inserción masiva de 50 Socios con datos realistas
INSERT INTO socios (nombre, apellidos, dni, email, id_membresia, estado, fecha_nac)
SELECT 
    (ARRAY['Juan', 'Ana', 'Luis', 'Maria', 'Pedro', 'Laura', 'Carlos', 'Elena', 'Pablo', 'Sofia'])[floor(random() * 10 + 1)] as nombre,
    (ARRAY['Gomez', 'Rodriguez', 'Perez', 'Sanz', 'Lopez', 'Garcia', 'Martinez', 'Hierro', 'Cano', 'Vila'])[floor(random() * 10 + 1)] || ' ' || 
    (ARRAY['Ruiz', 'Marín', 'Vega', 'Blanco', 'Torres', 'Rubio', 'Medina', 'Soto', 'Castillo', 'Ortega'])[floor(random() * 10 + 1)] as apellidos,
    (10000000 + i)::text || 'X',
    'usuario' || i || '@email.com',
    (i % 3) + 1,
    'Activo'::estado_socio,
    '1980-01-01'::date + (random() * 12000)::int
FROM generate_series(1, 50) i;

-- Inserción masiva de Pagos (120 registros)
-- Generamos 3 meses de pagos para la mayoría de los socios
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT 
    s.id_socio,
    m.precio,
    CURRENT_DATE - (n || ' days')::interval,
    (ARRAY['Tarjeta', 'Efectivo', 'Transferencia'])[floor(random() * 3 + 1)]::metodo_pago
FROM socios s
JOIN membresias m ON s.id_membresia = m.id_membresia
CROSS JOIN generate_series(0, 60, 30) n -- Genera un pago hoy y otro hace 30 y 60 días
WHERE s.id_socio <= 40;

-- Inserción masiva de Asistencia (200 registros)
-- Simulamos entradas aleatorias en los últimos 30 días
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT 
    floor(random() * 50 + 1),
    CURRENT_TIMESTAMP - (random() * 30 || ' days')::interval - (random() * 12 || ' hours')::interval
FROM generate_series(1, 200);

-- Inserción de inscripciones a clases
INSERT INTO clases_registro (id_socio, id_clase, fecha_inscripcion)
SELECT 
    s.id_socio,
    (floor(random() * 5 + 1)),
    CURRENT_DATE - (random() * 10 || ' days')::interval
FROM socios s
WHERE s.id_membresia >= 2 -- Solo socios Premium o VIP
LIMIT 40;

COMMIT;

-- 4. CONSULTAS DE PRUEBA (ESTADÍSTICAS)
-- -----------------------------------------------------------------------------

-- A. Resumen de volumen de datos
SELECT 
    (SELECT COUNT(*) FROM socios) AS total_socios,
    (SELECT COUNT(*) FROM pagos) AS total_pagos,
    (SELECT COUNT(*) FROM asistencia) AS total_asistencias;

-- B. Ingresos totales por tipo de membresía
SELECT m.nombre, SUM(p.monto) as recaudacion
FROM membresias m
JOIN socios s ON m.id_membresia = s.id_membresia
JOIN pagos p ON s.id_socio = p.id_socio
GROUP BY m.nombre;

-- C. Dias de mayor afluencia (Asistencia)
SELECT 
    to_char(fecha_entrada, 'Day') as dia, 
    COUNT(*) as visitas
FROM asistencia
GROUP BY dia
ORDER BY visitas DESC;

-- D. Ocupación de clases actuales
SELECT c.nombre, COUNT(cr.id_socio) as inscritos, c.capacidad_max
FROM clases c
LEFT JOIN clases_registro cr ON c.id_clase = cr.id_clase
GROUP BY c.id_clase, c.nombre, c.capacidad_max;