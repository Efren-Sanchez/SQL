-- =============================================================================
-- SISTEMA DE GESTIÓN DE ACTIVOS TECNOLÓGICOS
-- MySQL / MariaDB
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

CREATE DATABASE IF NOT EXISTS gestion_it
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE gestion_it;

-- 1. CONFIGURACIÓN E INICIALIZACIÓN
-- -----------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS mantenimientos;
DROP TABLE IF EXISTS asignaciones;
DROP TABLE IF EXISTS licencias;
DROP TABLE IF EXISTS hardware;
DROP TABLE IF EXISTS software;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS fabricantes;
DROP TABLE IF EXISTS ubicaciones;

SET FOREIGN_KEY_CHECKS = 1;

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE ubicaciones (
    id_ubicacion INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    edificio VARCHAR(50),
    planta TINYINT,
    PRIMARY KEY (id_ubicacion)
) ENGINE=InnoDB;

CREATE TABLE fabricantes (
    id_fabricante INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    soporte_email VARCHAR(100),
    PRIMARY KEY (id_fabricante)
) ENGINE=InnoDB;

CREATE TABLE categorias (
    id_categoria INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    tipo ENUM('Hardware', 'Software') NOT NULL,
    PRIMARY KEY (id_categoria)
) ENGINE=InnoDB;

CREATE TABLE empleados (
    id_empleado INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    departamento ENUM('IT', 'Ventas', 'RRHH', 'Finanzas', 'Marketing', 'Operaciones', 'Legal'),
    email VARCHAR(100) UNIQUE NOT NULL,
    PRIMARY KEY (id_empleado)
) ENGINE=InnoDB;

CREATE TABLE software (
    id_software INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    id_fabricante INT UNSIGNED,
    id_categoria INT UNSIGNED,
    version VARCHAR(20),
    PRIMARY KEY (id_software),
    CONSTRAINT fk_soft_fab FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id_fabricante),
    CONSTRAINT fk_soft_cat FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
) ENGINE=InnoDB;

CREATE TABLE hardware (
    id_hardware INT UNSIGNED AUTO_INCREMENT,
    modelo VARCHAR(150) NOT NULL,
    n_serie VARCHAR(50) UNIQUE NOT NULL,
    id_fabricante INT UNSIGNED,
    id_categoria INT UNSIGNED,
    fecha_compra DATE NOT NULL,
    costo DECIMAL(12,2) NOT NULL,
    estado ENUM('Stock', 'Asignado', 'Reparacion', 'Retirado') DEFAULT 'Stock',
    id_ubicacion INT UNSIGNED,
    PRIMARY KEY (id_hardware),
    CONSTRAINT fk_hard_fab FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id_fabricante),
    CONSTRAINT fk_hard_cat FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    CONSTRAINT fk_hard_ubi FOREIGN KEY (id_ubicacion) REFERENCES ubicaciones(id_ubicacion)
) ENGINE=InnoDB;

CREATE TABLE licencias (
    id_licencia INT UNSIGNED AUTO_INCREMENT,
    id_software INT UNSIGNED NOT NULL,
    clave_activacion VARCHAR(255) UNIQUE,
    fecha_expira DATE,
    tipo_licencia ENUM('OEM', 'Retail', 'Suscripción', 'Volumen'),
    PRIMARY KEY (id_licencia),
    CONSTRAINT fk_lic_soft FOREIGN KEY (id_software) REFERENCES software(id_software)
) ENGINE=InnoDB;

CREATE TABLE asignaciones (
    id_asignacion INT UNSIGNED AUTO_INCREMENT,
    id_empleado INT UNSIGNED NOT NULL,
    id_hardware INT UNSIGNED DEFAULT NULL,
    id_licencia INT UNSIGNED DEFAULT NULL,
    fecha_entrega DATE NOT NULL,
    fecha_devolucion DATE DEFAULT NULL,
    comentarios TEXT,
    PRIMARY KEY (id_asignacion),
    CONSTRAINT fk_asig_emp FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    CONSTRAINT fk_asig_hard FOREIGN KEY (id_hardware) REFERENCES hardware(id_hardware),
    CONSTRAINT fk_asig_lic FOREIGN KEY (id_licencia) REFERENCES licencias(id_licencia)
) ENGINE=InnoDB;

CREATE TABLE mantenimientos (
    id_mantenimiento INT UNSIGNED AUTO_INCREMENT,
    id_hardware INT UNSIGNED NOT NULL,
    fecha_servicio DATE NOT NULL,
    descripcion TEXT,
    costo_reparacion DECIMAL(10,2) DEFAULT 0.00,
    tecnico VARCHAR(100),
    PRIMARY KEY (id_mantenimiento),
    CONSTRAINT fk_mante_hard FOREIGN KEY (id_hardware) REFERENCES hardware(id_hardware)
) ENGINE=InnoDB;

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------
START TRANSACTION;

-- 3.1 Ubicaciones (10)
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

-- 3.2 Fabricantes (10)
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

-- 3.3 Categorías (8)
INSERT INTO categorias (nombre, tipo) VALUES 
('Laptop', 'Hardware'),
('Desktop', 'Hardware'),
('Servidor', 'Hardware'),
('Monitor', 'Hardware'),
('Periférico', 'Hardware'),
('Sistema Operativo', 'Software'),
('IDE Desarrollo', 'Software'),
('Suite Ofimática', 'Software');

-- 3.4 Empleados (50)
-- Generando una lista variada para departamentos
INSERT INTO empleados (nombre, apellidos, departamento, email) VALUES 
('Carlos', 'Mendoza', 'IT', 'c.mendoza@empresa.com'),
('Ana', 'Vidal', 'Marketing', 'a.vidal@empresa.com'),
('Roberto', 'Sanz', 'IT', 'r.sanz@empresa.com'),
('Lucía', 'Fernández', 'RRHH', 'l.fernandez@empresa.com'),
('Diego', 'Gómez', 'Ventas', 'd.gomez@empresa.com'),
('Elena', 'Martínez', 'Finanzas', 'e.martinez@empresa.com'),
('Marcos', 'López', 'Operaciones', 'm.lopez@empresa.com'),
('Sandra', 'Ruiz', 'Legal', 's.ruiz@empresa.com'),
('Javier', 'Pérez', 'IT', 'j.perez@empresa.com'),
('Patricia', 'García', 'Ventas', 'p.garcia@empresa.com'),
('Sergio', 'Romero', 'Marketing', 's.romero@empresa.com'),
('Marta', 'Sánchez', 'Finanzas', 'm.sanchez@empresa.com'),
('Raúl', 'Blanco', 'Operaciones', 'r.blanco@empresa.com'),
('Beatriz', 'Torres', 'RRHH', 'b.torres@empresa.com'),
('Ignacio', 'Gil', 'IT', 'i.gil@empresa.com'),
('Carmen', 'Castro', 'Marketing', 'c.castro@empresa.com'),
('Alberto', 'Ortega', 'Ventas', 'a.ortega@empresa.com'),
('Julia', 'Rubio', 'Legal', 'j.rubio@empresa.com'),
('Víctor', 'Molina', 'IT', 'v.molina@empresa.com'),
('Laura', 'Delgado', 'Finanzas', 'l.delgado@empresa.com'),
('Óscar', 'Morales', 'Operaciones', 'o.morales@empresa.com'),
('Isabel', 'Marín', 'RRHH', 'i.marin@empresa.com'),
('Andrés', 'Soto', 'Ventas', 'a.soto@empresa.com'),
('Paula', 'Navarro', 'Marketing', 'p.navarro@empresa.com'),
('Francisco', 'Diez', 'IT', 'f.diez@empresa.com'),
('Teresa', 'Ibáñez', 'Finanzas', 't.ibañez@empresa.com'),
('Manuel', 'Garrido', 'Operaciones', 'm.garrido@empresa.com'),
('Rocío', 'Cano', 'Legal', 'r.cano@empresa.com'),
('Fernando', 'Prieto', 'IT', 'f.prieto@empresa.com'),
('Alicia', 'Méndez', 'RRHH', 'a.mendez@empresa.com'),
('Jorge', 'Cruz', 'Ventas', 'j.cruz@empresa.com'),
('Cristina', 'Vázquez', 'Marketing', 'c.vazquez@empresa.com'),
('Héctor', 'Beltrán', 'Finanzas', 'h.beltran@empresa.com'),
('Silvia', 'Esteban', 'Operaciones', 's.esteban@empresa.com'),
('Iván', 'Pascual', 'IT', 'i.pascual@empresa.com'),
('Lorena', 'Herrero', 'RRHH', 'l.herrero@empresa.com'),
('Adrián', 'Arias', 'Ventas', 'a.arias@empresa.com'),
('Yolanda', 'Fuentes', 'Marketing', 'y.fuentes@empresa.com'),
('Rubén', 'Pardo', 'Finanzas', 'r.pardo@empresa.com'),
('Clara', 'Hidalgo', 'Operaciones', 'c.hidalgo@empresa.com'),
('Ramiro', 'Campos', 'Legal', 'r.campos@empresa.com'),
('Sonia', 'Ibarra', 'IT', 's.ibarra@empresa.com'),
('Felipe', 'Vega', 'Ventas', 'f.vega@empresa.com'),
('Gloria', 'Ferrer', 'RRHH', 'g.ferrer@empresa.com'),
('David', 'Muñoz', 'Marketing', 'd.muñoz@empresa.com'),
('Natalia', 'Reyes', 'Finanzas', 'n.reyes@empresa.com'),
('Luis', 'Guerra', 'Operaciones', 'l.guerra@empresa.com'),
('Esther', 'Luna', 'Legal', 'e.luna@empresa.com'),
('Mateo', 'Soler', 'IT', 'm.soler@empresa.com'),
('Ariadna', 'Expósito', 'Marketing', 'a.exposito@empresa.com');

-- 3.5 Software (15)
INSERT INTO software (nombre, id_fabricante, id_categoria, version) VALUES 
('Windows 11 Pro', 3, 6, '23H2'),
('Windows 10 Pro', 3, 6, '22H2'),
('macOS Sonoma', 2, 6, '14.0'),
('Office 365 Business', 3, 8, 'v16'),
('Visual Studio 2022', 3, 7, 'Enterprise'),
('IntelliJ IDEA', 9, 7, '2023.3'),
('Adobe Creative Cloud', 7, 8, '2024'),
('Photoshop', 7, 8, 'v25'),
('PyCharm Professional', 9, 7, '2023.3'),
('Windows Server 2022', 3, 6, 'Standard'),
('Adobe Acrobat DC', 7, 8, 'Pro'),
('Slack Desktop', 3, 8, '4.35'),
('Zoom Client', 1, 8, '5.17'),
('Xcode', 2, 7, '15.0'),
('Docker Desktop', 1, 7, '4.25');

-- 3.6 Hardware (120 registros aprox)
-- Laptops Dell
INSERT INTO hardware (modelo, n_serie, id_fabricante, id_categoria, fecha_compra, costo, estado, id_ubicacion) VALUES 
('Latitude 5420', 'SN-DELL-001', 1, 1, '2023-01-10', 1100.00, 'Asignado', 2),
('Latitude 5420', 'SN-DELL-002', 1, 1, '2023-01-10', 1100.00, 'Asignado', 2),
('Latitude 5420', 'SN-DELL-003', 1, 1, '2023-01-10', 1100.00, 'Asignado', 3),
('Latitude 5420', 'SN-DELL-004', 1, 1, '2023-01-10', 1100.00, 'Stock', 7),
('Latitude 5420', 'SN-DELL-005', 1, 1, '2023-01-10', 1100.00, 'Asignado', 5),
('Latitude 7430', 'SN-DELL-006', 1, 1, '2023-05-15', 1450.00, 'Asignado', 2),
('Latitude 7430', 'SN-DELL-007', 1, 1, '2023-05-15', 1450.00, 'Reparacion', 6),
('Latitude 7430', 'SN-DELL-008', 1, 1, '2023-05-15', 1450.00, 'Asignado', 3),
('Precision 3581', 'SN-DELL-009', 1, 1, '2023-08-20', 2100.00, 'Asignado', 1),
('Precision 3581', 'SN-DELL-010', 1, 1, '2023-08-20', 2100.00, 'Stock', 7);

-- MacBook Pros
INSERT INTO hardware (modelo, n_serie, id_fabricante, id_categoria, fecha_compra, costo, estado, id_ubicacion) 
SELECT CONCAT('MacBook Pro M', (n%2)+2), CONCAT('SN-APPLE-', n), 2, 1, '2023-03-12', 2500.00, 'Asignado', 9
FROM (SELECT @row := @row + 1 as n FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t1, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2, (SELECT @row := 100) r) numbers
LIMIT 20;

-- Lenovo ThinkPads
INSERT INTO hardware (modelo, n_serie, id_fabricante, id_categoria, fecha_compra, costo, estado, id_ubicacion) 
SELECT 'ThinkPad X1 Carbon', CONCAT('SN-LENO-', n), 4, 1, '2022-11-05', 1600.00, 'Asignado', 5
FROM (SELECT @row2 := @row2 + 1 as n FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t1, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2, (SELECT @row2 := 200) r) numbers
LIMIT 30;

-- Monitores y Servidores
INSERT INTO hardware (modelo, n_serie, id_fabricante, id_categoria, fecha_compra, costo, estado, id_ubicacion) VALUES 
('UltraSharp 27', 'SN-MON-001', 1, 4, '2023-01-10', 450.00, 'Asignado', 2),
('UltraSharp 27', 'SN-MON-002', 1, 4, '2023-01-10', 450.00, 'Asignado', 2),
('UltraSharp 27', 'SN-MON-003', 1, 4, '2023-01-10', 450.00, 'Asignado', 3),
('Samsung Odyssey G7', 'SN-MON-004', 8, 4, '2023-06-15', 600.00, 'Asignado', 9),
('Samsung Odyssey G7', 'SN-MON-005', 8, 4, '2023-06-15', 600.00, 'Asignado', 9),
('PowerEdge R750', 'SN-SRV-001', 1, 3, '2022-05-20', 12000.00, 'Asignado', 1),
('PowerEdge R750', 'SN-SRV-002', 1, 3, '2022-05-20', 12000.00, 'Asignado', 1),
('HP ProLiant DL380', 'SN-SRV-003', 5, 3, '2022-08-10', 11500.00, 'Asignado', 1);

-- Resto de Hardware variado (hasta ~120 total)
INSERT INTO hardware (modelo, n_serie, id_fabricante, id_categoria, fecha_compra, costo, estado, id_ubicacion) 
SELECT 'HP EliteBook 840', CONCAT('SN-HP-', n), 5, 1, '2023-02-15', 1300.00, 'Stock', 7
FROM (SELECT @row3 := @row3 + 1 as n FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t1, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2, (SELECT @row3 := 300) r) numbers
LIMIT 40;

-- 3.7 Licencias (100 registros)
-- Windows
INSERT INTO licencias (id_software, clave_activacion, fecha_expira, tipo_licencia)
SELECT 1, CONCAT('W11-PRO-', UUID()), '2030-12-31', 'OEM'
FROM (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t1, (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t2, (SELECT 1 UNION SELECT 2) t3;

-- Office 365 (Suscripciones)
INSERT INTO licencias (id_software, clave_activacion, fecha_expira, tipo_licencia)
SELECT 4, CONCAT('O365-', UUID()), DATE_ADD(CURDATE(), INTERVAL 1 YEAR), 'Suscripción'
FROM (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t1, (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t2, (SELECT 1 UNION SELECT 2) t3;

-- 3.8 Asignaciones (150 registros)
-- Mezclaremos hardware y software asignado a empleados 1 al 50.

-- Asignaciones de Laptops (IDs 1 al 60 aprox)
INSERT INTO asignaciones (id_empleado, id_hardware, id_licencia, fecha_entrega)
SELECT 
    (n % 50) + 1, 
    n, 
    n, 
    DATE_SUB(CURDATE(), INTERVAL (n * 2) DAY)
FROM (SELECT @row4 := @row4 + 1 as n FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t1, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2, (SELECT 0 UNION SELECT 1 UNION SELECT 2) t3, (SELECT @row4 := 0) r) numbers
LIMIT 80;

-- Asignaciones de Software extra (Licencias 81-100)
INSERT INTO asignaciones (id_empleado, id_hardware, id_licencia, fecha_entrega)
SELECT 
    (n % 50) + 1, 
    NULL, 
    n + 80, 
    CURDATE()
FROM (SELECT @row5 := @row5 + 1 as n FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t1, (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2, (SELECT @row5 := 0) r) numbers
LIMIT 20;

-- Asignaciones históricas ya devueltas (para poder calcular rotación)
INSERT INTO asignaciones (id_empleado, id_hardware, id_licencia, fecha_entrega, fecha_devolucion, comentarios)
VALUES 
(1, 4, NULL, '2022-01-01', '2022-12-31', 'Cambio de equipo por renovación'),
(5, 7, NULL, '2023-01-10', '2023-05-01', 'Empleado causó baja'),
(10, 10, NULL, '2023-01-15', '2023-08-01', 'Equipo enviado a reparación');

-- Completar hasta ~150 asignaciones con datos aleatorios
INSERT INTO asignaciones (id_empleado, id_hardware, id_licencia, fecha_entrega)
SELECT 
    (n % 50) + 1, 
    (n % 100) + 1, 
    NULL, 
    '2024-01-01'
FROM (SELECT @row6 := @row6 + 1 as n FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t1, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t2, (SELECT @row6 := 100) r) numbers
LIMIT 47;

-- 3.9 Mantenimientos (50 registros)
INSERT INTO mantenimientos (id_hardware, fecha_servicio, descripcion, costo_reparacion, tecnico)
SELECT 
    (n % 100) + 1, 
    DATE_SUB(CURDATE(), INTERVAL (n * 5) DAY),
    'Mantenimiento preventivo, limpieza de ventiladores y actualización de firmware.',
    45.50,
    'Soporte Técnico Nivel 1'
FROM (SELECT @row7 := @row7 + 1 as n FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t1, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t2, (SELECT 1 UNION SELECT 2) t3, (SELECT @row7 := 0) r) numbers
LIMIT 50;

COMMIT;

-- 4. CONSULTAS DE PRUEBA SUGERIDAS
-- -----------------------------------------------------------------------------

-- 1. Valor total del inventario de Hardware por Fabricante
-- SELECT f.nombre, SUM(h.costo) as inversion_total 
-- FROM hardware h 
-- JOIN fabricantes f ON h.id_fabricante = f.id_fabricante 
-- GROUP BY f.nombre;

-- 2. Empleados con más de un activo asignado
-- SELECT e.nombre, e.apellidos, COUNT(a.id_asignacion) as total_activos
-- FROM empleados e
-- JOIN asignaciones a ON e.id_empleado = a.id_empleado
-- WHERE a.fecha_devolucion IS NULL
-- GROUP BY e.id_empleado
-- HAVING total_activos > 1;

-- 3. Lista de licencias que vencen en los próximos 6 meses
-- SELECT s.nombre as software, l.clave_activacion, l.fecha_expira
-- FROM licencias l
-- JOIN software s ON l.id_software = s.id_software
-- WHERE l.fecha_expira BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 6 MONTH);