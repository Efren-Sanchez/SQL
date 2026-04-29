-- =============================================================================
-- SISTEMA DE GESTIÓN DE ACTIVOS TECNOLÓGICOS
-- PostgreSQL
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

-- 1. LIMPIEZA DE ESQUEMA
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS mantenimientos CASCADE;
DROP TABLE IF EXISTS asignaciones CASCADE;
DROP TABLE IF EXISTS licencias CASCADE;
DROP TABLE IF EXISTS hardware CASCADE;
DROP TABLE IF EXISTS software CASCADE;
DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS fabricantes CASCADE;
DROP TABLE IF EXISTS ubicaciones CASCADE;

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE ubicaciones (
    id_ubicacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edificio VARCHAR(50),
    planta SMALLINT
);

CREATE TABLE fabricantes (
    id_fabricante INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    soporte_email VARCHAR(100)
);

CREATE TABLE categorias (
    id_categoria INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(10) CHECK (tipo IN ('Hardware', 'Software'))
);

CREATE TABLE empleados (
    id_empleado INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    departamento VARCHAR(50) CHECK (departamento IN ('IT', 'Ventas', 'RRHH', 'Finanzas', 'Marketing', 'Operaciones', 'Legal')),
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE software (
    id_software INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    id_fabricante INT REFERENCES fabricantes(id_fabricante),
    id_categoria INT REFERENCES categorias(id_categoria),
    version VARCHAR(20)
);

CREATE TABLE hardware (
    id_hardware INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    modelo VARCHAR(150) NOT NULL,
    n_serie VARCHAR(50) UNIQUE NOT NULL,
    id_fabricante INT REFERENCES fabricantes(id_fabricante),
    id_categoria INT REFERENCES categorias(id_categoria),
    fecha_compra DATE NOT NULL DEFAULT CURRENT_DATE,
    costo DECIMAL(12,2) NOT NULL,
    estado VARCHAR(15) DEFAULT 'Stock' CHECK (estado IN ('Stock', 'Asignado', 'Reparacion', 'Retirado')),
    id_ubicacion INT REFERENCES ubicaciones(id_ubicacion)
);

CREATE TABLE licencias (
    id_licencia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_software INT NOT NULL REFERENCES software(id_software),
    clave_activacion VARCHAR(255) UNIQUE,
    fecha_expira DATE,
    tipo_licencia VARCHAR(20) CHECK (tipo_licencia IN ('OEM', 'Retail', 'Suscripción', 'Volumen'))
);

CREATE TABLE asignaciones (
    id_asignacion INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_empleado INT NOT NULL REFERENCES empleados(id_empleado),
    id_hardware INT REFERENCES hardware(id_hardware),
    id_licencia INT REFERENCES licencias(id_licencia),
    fecha_entrega DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_devolucion DATE,
    comentarios TEXT
);

CREATE TABLE mantenimientos (
    id_mantenimiento INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_hardware INT NOT NULL REFERENCES hardware(id_hardware),
    fecha_servicio DATE NOT NULL,
    descripcion TEXT,
    costo_reparacion DECIMAL(10,2) DEFAULT 0,
    tecnico VARCHAR(100)
);

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------
BEGIN;

-- Ubicaciones
INSERT INTO ubicaciones (nombre, edificio, planta) VALUES 
('Data Center Principal', 'Edificio A', 0),
('Oficina Desarrollo 1', 'Edificio B', 1),
('Oficina Desarrollo 2', 'Edificio B', 2),
('Sala de Juntas', 'Edificio A', 3),
('Departamento Ventas', 'Edificio C', 1),
('Soporte Técnico', 'Edificio B', 0),
('Almacén General', 'Edificio D', 0),
('RRHH y Legal', 'Edificio A', 2),
('Marketing Creative Lab', 'Edificio C', 2),
('Recepción', 'Edificio A', 1);

-- Fabricantes
INSERT INTO fabricantes (nombre, pais, soporte_email) VALUES 
('Dell', 'USA', 'support@dell.com'),
('Apple', 'USA', 'enterprise@apple.com'),
('Microsoft', 'USA', 'license@microsoft.com'),
('Lenovo', 'China', 'service@lenovo.com'),
('HP', 'USA', 'pro_support@hp.com'),
('Cisco', 'USA', 'tac@cisco.com'),
('Adobe', 'USA', 'creative_care@adobe.com'),
('Samsung', 'Corea del Sur', 'b2b.support@samsung.com'),
('JetBrains', 'República Checa', 'sales@jetbrains.com'),
('Logitech', 'Suiza', 'business@logitech.com');

-- Categorías
INSERT INTO categorias (nombre, tipo) VALUES 
('Laptop', 'Hardware'), ('Desktop', 'Hardware'), ('Servidor', 'Hardware'), 
('Monitor', 'Hardware'), ('Periférico', 'Hardware'), ('Sistema Operativo', 'Software'), 
('IDE Desarrollo', 'Software'), ('Suite Ofimática', 'Software');

-- Empleados (50 registros usando generate_series)
INSERT INTO empleados (nombre, apellidos, departamento, email)
SELECT 
    'Empleado_' || i, 
    'Apellido_' || i, 
    (ARRAY['IT', 'Ventas', 'RRHH', 'Finanzas', 'Marketing', 'Operaciones', 'Legal'])[MOD(i, 7) + 1],
    'user' || i || '@empresa.com'
FROM generate_series(1, 50) s(i);

-- Software
INSERT INTO software (nombre, id_fabricante, id_categoria, version) VALUES 
('Windows 11 Pro', 3, 6, '23H2'),
('macOS Sonoma', 2, 6, '14.0'),
('Office 365 Business', 3, 8, 'v16'),
('Visual Studio 2022', 3, 7, 'Enterprise'),
('Adobe Creative Cloud', 7, 8, '2024');

-- Hardware (120 registros)
INSERT INTO hardware (modelo, n_serie, id_fabricante, id_categoria, fecha_compra, costo, estado, id_ubicacion)
SELECT 
    (ARRAY['Latitude 5420', 'MacBook Pro', 'ThinkPad X1', 'Precision 3581', 'HP EliteBook'])[MOD(i, 5) + 1],
    'SN-' || i || '-' || (LPAD(floor(random()*1000)::text, 4, '0')),
    MOD(i, 10) + 1,
    CASE WHEN MOD(i, 4) = 0 THEN 4 ELSE 1 END, -- Mezcla Laptops y Monitores
    CURRENT_DATE - (i || ' days')::interval,
    800 + (random() * 2000),
    (ARRAY['Stock', 'Asignado', 'Reparacion'])[MOD(i, 3) + 1],
    MOD(i, 10) + 1
FROM generate_series(1, 120) s(i);

-- Licencias (100 registros)
INSERT INTO licencias (id_software, clave_activacion, fecha_expira, tipo_licencia)
SELECT 
    MOD(i, 5) + 1,
    'KEY-' || i || '-' || gen_random_uuid(),
    CURRENT_DATE + (i || ' days')::interval,
    (ARRAY['OEM', 'Retail', 'Suscripción', 'Volumen'])[MOD(i, 4) + 1]
FROM generate_series(1, 100) s(i);

-- Asignaciones (150 registros)
INSERT INTO asignaciones (id_empleado, id_hardware, id_licencia, fecha_entrega, comentarios)
SELECT 
    (MOD(i, 50) + 1),
    (CASE WHEN i <= 120 THEN i ELSE NULL END),
    (CASE WHEN i <= 100 THEN i ELSE NULL END),
    CURRENT_DATE - (MOD(i, 60) || ' days')::interval,
    'Asignación automatizada de prueba ' || i
FROM generate_series(1, 150) s(i);

-- Mantenimientos (50 registros)
INSERT INTO mantenimientos (id_hardware, fecha_servicio, descripcion, costo_reparacion, tecnico)
SELECT 
    (MOD(i, 120) + 1),
    CURRENT_DATE - (MOD(i, 30) || ' days')::interval,
    'Mantenimiento preventivo número ' || i,
    50.00 + (i * 2),
    'Técnico PG-Admin'
FROM generate_series(1, 50) s(i);

COMMIT;

-- 4. CONSULTAS DE CONTROL (QUERIES)
-- -----------------------------------------------------------------------------

-- A. Informe de activos con sus empleados actuales
-- SELECT e.nombre, e.apellidos, h.modelo, h.n_serie, a.fecha_entrega
-- FROM asignaciones a
-- JOIN empleados e ON a.id_empleado = e.id_empleado
-- JOIN hardware h ON a.id_hardware = h.id_hardware
-- WHERE a.fecha_devolucion IS NULL;

-- B. Costo total de hardware por departamento
-- SELECT e.departamento, SUM(h.costo) as inversion_total
-- FROM asignaciones a
-- JOIN empleados e ON a.id_empleado = e.id_empleado
-- JOIN hardware h ON a.id_hardware = h.id_hardware
-- GROUP BY e.departamento;