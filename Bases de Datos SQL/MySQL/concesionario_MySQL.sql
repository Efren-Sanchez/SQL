-- =============================================================================
-- SISTEMA DE GESTIÓN DE CONCESIONARIO
-- MySQL / MariaDB 
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

CREATE DATABASE IF NOT EXISTS concesionario
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE concesionario;

-- 1. CONFIGURACIÓN E INICIALIZACIÓN
-- -----------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS revisiones, ventas, coches, modelos, marcas, vendedores, clientes;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE marcas (
    id_marca INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    pais_origen VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE modelos (
    id_modelo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_marca INT UNSIGNED NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    segmento ENUM('SUV', 'Sedán', 'Compacto', 'Deportivo', 'Pick-up', 'Eléctrico') NOT NULL,
    CONSTRAINT fk_modelo_marca FOREIGN KEY (id_marca) REFERENCES marcas(id_marca)
) ENGINE=InnoDB;

CREATE TABLE coches (
    id_coche INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_modelo INT UNSIGNED NOT NULL,
    vin VARCHAR(17) UNIQUE NOT NULL,
    color VARCHAR(30),
    anio INT UNSIGNED NOT NULL,
    precio_base DECIMAL(12,2) NOT NULL,
    estado ENUM('Disponible', 'Reservado', 'Vendido', 'Mantenimiento') DEFAULT 'Disponible',
    tipo ENUM('Nuevo', 'Ocasión') DEFAULT 'Nuevo',
    kilometraje INT UNSIGNED DEFAULT 0,
    CONSTRAINT fk_coche_modelo FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo)
) ENGINE=InnoDB;

CREATE TABLE clientes (
    id_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(15) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    ciudad VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE vendedores (
    id_vendedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    comision_pct DECIMAL(4,2) DEFAULT 1.00
) ENGINE=InnoDB;

CREATE TABLE ventas (
    id_venta INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_coche INT UNSIGNED NOT NULL,
    id_cliente INT UNSIGNED NOT NULL,
    id_vendedor INT UNSIGNED NOT NULL,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    precio_final DECIMAL(12,2) NOT NULL,
    metodo_pago ENUM('Contado', 'Financiado', 'Leasing') NOT NULL,
    CONSTRAINT fk_venta_coche FOREIGN KEY (id_coche) REFERENCES coches(id_coche),
    CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_venta_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
) ENGINE=InnoDB;

CREATE TABLE revisiones (
    id_revision INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_coche INT UNSIGNED NOT NULL,
    fecha_revision DATE NOT NULL,
    descripcion TEXT,
    coste DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_revision_coche FOREIGN KEY (id_coche) REFERENCES coches(id_coche)
) ENGINE=InnoDB;

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------
START TRANSACTION;

-- Inserción de Marcas
INSERT INTO marcas (nombre, pais_origen) VALUES 
('Toyota', 'Japón'), ('BMW', 'Alemania'), ('Ford', 'USA'), ('Tesla', 'USA'), 
('Hyundai', 'Corea del Sur'), ('Audi', 'Alemania'), ('Mercedes-Benz', 'Alemania'), 
('Kia', 'Corea del Sur'), ('Renault', 'Francia'), ('Volkswagen', 'Alemania');

-- Inserción de Modelos (Aprox 3 por marca)
INSERT INTO modelos (id_marca, nombre, segmento) VALUES 
(1, 'Corolla', 'Sedán'), (1, 'RAV4', 'SUV'), (1, 'Yaris', 'Compacto'),
(2, 'Serie 3', 'Sedán'), (2, 'X5', 'SUV'), (2, 'M4', 'Deportivo'),
(3, 'Mustang', 'Deportivo'), (3, 'F-150', 'Pick-up'), (3, 'Focus', 'Compacto'),
(4, 'Model 3', 'Eléctrico'), (4, 'Model Y', 'Eléctrico'), (4, 'Model S', 'Eléctrico'),
(5, 'Tucson', 'SUV'), (5, 'Ioniq 5', 'Eléctrico'), (5, 'i30', 'Compacto'),
(6, 'A3', 'Compacto'), (6, 'Q7', 'SUV'), (6, 'e-tron', 'Eléctrico'),
(7, 'Clase C', 'Sedán'), (7, 'GLC', 'SUV'), (7, 'AMG GT', 'Deportivo'),
(8, 'Sportage', 'SUV'), (8, 'EV6', 'Eléctrico'), (8, 'Ceed', 'Compacto'),
(9, 'Clio', 'Compacto'), (9, 'Megane E-Tech', 'Eléctrico'), (9, 'Austral', 'SUV'),
(10, 'Golf', 'Compacto'), (10, 'Tiguan', 'SUV'), (10, 'ID.4', 'Eléctrico');

-- Inserción de Vendedores (8)
INSERT INTO vendedores (nombre, apellidos, fecha_ingreso, comision_pct) VALUES 
('Javier', 'Gómez Martín', '2020-05-15', 1.50),
('Lucía', 'Fernández Ruiz', '2022-01-10', 1.20),
('Marcos', 'Pérez Soria', '2023-03-01', 1.00),
('Elena', 'Blanco Ortiz', '2021-11-20', 1.30),
('Roberto', 'Sánchez Cano', '2019-06-14', 1.80),
('Ana', 'García Valles', '2022-08-05', 1.10),
('David', 'Mora Jiménez', '2023-01-15', 1.00),
('Sara', 'Torres Leal', '2024-01-10', 1.00);

-- Inserción de Clientes (50 ejemplos iniciales)
INSERT INTO clientes (nombre, apellidos, dni, telefono, email, ciudad) VALUES 
('Antonio', 'Ramírez Soler', '12345678X', '600111222', 'antonio.ram@email.com', 'Madrid'),
('Beatriz', 'Luna Méndez', '87654321Y', '600333444', 'b.luna@email.com', 'Barcelona'),
('Carlos', 'Sanz Vega', '45678901Z', '600555666', 'csanz@email.com', 'Sevilla'),
('Laura', 'García Mohedano', '23456789A', '611000999', 'laura.gar@email.com', 'Valencia'),
('Miguel', 'Hernández Gil', '34567890B', '622888777', 'm.gil@email.com', 'Zaragoza'),
('Isabel', 'Domínguez Paz', '56789012C', '633777666', 'isabel.paz@email.com', 'Málaga'),
('Pedro', 'Rojas Marcos', '67890123D', '644666555', 'p.rojas@email.com', 'Murcia'),
('Julia', 'Navarro Sanchis', '78901234E', '655555444', 'j.navarro@email.com', 'Alicante'),
('Sergio', 'Díaz Castillo', '89012345F', '666444333', 's.diaz@email.com', 'Bilbao'),
('Marta', 'Prieto Luque', '90123456G', '677333222', 'm.prieto@email.com', 'Valladolid');
-- (Podemos añadir más clientes de forma similar si es necesario)

-- Inserción de Coches (~150 registros)
-- Generamos una mezcla de nuevos y ocasión con estados variados
INSERT INTO coches (id_modelo, vin, color, anio, precio_base, estado, tipo, kilometraje) VALUES 
(1, 'VIN00000000000001', 'Blanco', 2024, 25000.00, 'Vendido', 'Nuevo', 0),
(2, 'VIN00000000000002', 'Gris', 2023, 32000.00, 'Vendido', 'Nuevo', 10),
(3, 'VIN00000000000003', 'Negro', 2021, 15000.00, 'Disponible', 'Ocasión', 45000),
(4, 'VIN00000000000004', 'Azul', 2024, 38000.00, 'Vendido', 'Nuevo', 0),
(5, 'VIN00000000000005', 'Rojo', 2022, 45000.00, 'Mantenimiento', 'Ocasión', 25000),
(6, 'VIN00000000000006', 'Blanco', 2024, 85000.00, 'Reservado', 'Nuevo', 0),
(7, 'VIN00000000000007', 'Verde', 2023, 55000.00, 'Vendido', 'Nuevo', 5),
(8, 'VIN00000000000008', 'Gris', 2021, 40000.00, 'Disponible', 'Ocasión', 60000),
(9, 'VIN00000000000009', 'Azul', 2020, 18000.00, 'Vendido', 'Ocasión', 85000),
(10, 'VIN00000000000010', 'Blanco', 2024, 42000.00, 'Vendido', 'Nuevo', 0),
(11, 'VIN00000000000011', 'Negro', 2023, 48000.00, 'Vendido', 'Nuevo', 100),
(12, 'VIN00000000000012', 'Rojo', 2022, 90000.00, 'Disponible', 'Nuevo', 0),
(13, 'VIN00000000000013', 'Gris', 2023, 31000.00, 'Vendido', 'Nuevo', 0),
(14, 'VIN00000000000014', 'Azul', 2024, 46000.00, 'Disponible', 'Nuevo', 0),
(15, 'VIN00000000000015', 'Blanco', 2019, 12000.00, 'Disponible', 'Ocasión', 110000);

-- Inserción masiva simplificada para completar los 150 coches
-- Usamos un procedimiento o múltiples inserts para simular volumen
INSERT INTO coches (id_modelo, vin, color, anio, precio_base, estado, tipo, kilometraje)
SELECT 
    (FLOOR(1 + RAND() * 29)), 
    CONCAT('VIN_EXTRA_', id_c), 
    ELT(FLOOR(1 + RAND() * 5), 'Blanco', 'Negro', 'Plata', 'Rojo', 'Azul'),
    (2018 + FLOOR(RAND() * 7)),
    (15000 + RAND() * 50000),
    ELT(FLOOR(1 + RAND() * 4), 'Disponible', 'Vendido', 'Reservado', 'Mantenimiento'),
    ELT(FLOOR(1 + RAND() * 2), 'Nuevo', 'Ocasión'),
    (IF(RAND() > 0.5, 0, FLOOR(RAND() * 100000)))
FROM (SELECT @row := @row + 1 AS id_c FROM (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t1, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) t2, (SELECT 0 UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) t3, (SELECT @row := 15) r) AS temp
LIMIT 135;

-- Inserción de Ventas (~100 registros)
-- IMPORTANTE: Relacionamos con coches que tengan estado 'Vendido'
INSERT INTO ventas (id_coche, id_cliente, id_vendedor, fecha_venta, precio_final, metodo_pago)
SELECT 
    id_coche, 
    (FLOOR(1 + RAND() * 10)), 
    (FLOOR(1 + RAND() * 8)), 
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY),
    precio_base * 0.95, -- Simulamos un 5% de descuento medio
    ELT(FLOOR(1 + RAND() * 3), 'Contado', 'Financiado', 'Leasing')
FROM coches 
WHERE estado = 'Vendido'
LIMIT 100;

-- Inserción de Revisiones (~100 registros)
INSERT INTO revisiones (id_coche, fecha_revision, descripcion, coste)
SELECT 
    (FLOOR(1 + RAND() * 150)), 
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 200) DAY),
    ELT(FLOOR(1 + RAND() * 4), 'Cambio de aceite y filtros', 'Revisión frenos', 'Mantenimiento general', 'Cambio neumáticos'),
    (100 + RAND() * 500)
FROM (SELECT @r2 := @r2 + 1 FROM (SELECT 0 UNION ALL SELECT 1) a, (SELECT 0 UNION ALL SELECT 1) b, (SELECT 0 UNION ALL SELECT 1) c, (SELECT 0 UNION ALL SELECT 1) d, (SELECT 0 UNION ALL SELECT 1) e, (SELECT 0 UNION ALL SELECT 1) f, (SELECT @r2 := 0) g) AS temp
LIMIT 100;

COMMIT;

-- 4. CONSULTAS DE COMPROBACIÓN
-- -----------------------------------------------------------------------------

-- A. Resumen de inventario actual por marca
SELECT m.nombre AS Marca, COUNT(c.id_coche) AS Total_Vehiculos, ROUND(AVG(c.precio_base), 2) AS Precio_Medio
FROM marcas m
JOIN modelos mo ON m.id_marca = mo.id_marca
JOIN coches c ON mo.id_modelo = c.id_modelo
GROUP BY m.nombre;

-- B. Top 5 Vendedores por facturación total
SELECT v.nombre, v.apellidos, COUNT(ve.id_venta) AS Ventas_Realizadas, SUM(ve.precio_final) AS Total_Facturado
FROM vendedores v
JOIN ventas ve ON v.id_vendedor = ve.id_vendedor
GROUP BY v.id_vendedor
ORDER BY Total_Facturado DESC
LIMIT 5;

-- C. Historial de revisiones de coches que han costado más de 300€
SELECT c.vin, mo.nombre AS Modelo, r.fecha_revision, r.descripcion, r.coste
FROM revisiones r
JOIN coches c ON r.id_coche = c.id_coche
JOIN modelos mo ON c.id_modelo = mo.id_modelo
WHERE r.coste > 300
ORDER BY r.coste DESC;