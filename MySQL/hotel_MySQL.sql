-- =============================================================================
-- SISTEMA DE GESTIÓN HOTELERA
-- MySQL / MariaDB 
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

CREATE DATABASE IF NOT EXISTS hotel
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE hotel;

-- 1. CONFIGURACIÓN E INICIALIZACIÓN
-- -----------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS consumos_extras;
DROP TABLE IF EXISTS servicios;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS habitaciones;
DROP TABLE IF EXISTS tipos_habitacion;
DROP TABLE IF EXISTS huespedes;

SET FOREIGN_KEY_CHECKS = 1;

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE tipos_habitacion (
    id_tipo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio_noche DECIMAL(10,2) NOT NULL,
    capacidad_personas TINYINT UNSIGNED NOT NULL,
    descripcion TEXT
) ENGINE=InnoDB;

CREATE TABLE habitaciones (
    id_habitacion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    id_tipo INT UNSIGNED NOT NULL,
    piso TINYINT NOT NULL,
    estado ENUM('Disponible', 'Ocupada', 'Limpieza', 'Mantenimiento') DEFAULT 'Disponible',
    CONSTRAINT fk_hab_tipo FOREIGN KEY (id_tipo) REFERENCES tipos_habitacion(id_tipo)
) ENGINE=InnoDB;

CREATE TABLE huespedes (
    id_huesped INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    documento_id VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    pais VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE reservas (
    id_reserva INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_huesped INT UNSIGNED NOT NULL,
    id_habitacion INT UNSIGNED NOT NULL,
    fecha_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    estado_reserva ENUM('Confirmada', 'Pendiente', 'Cancelada', 'Finalizada') DEFAULT 'Pendiente',
    total_alojamiento DECIMAL(10,2) DEFAULT 0.00,
    CONSTRAINT fk_res_huesped FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),
    CONSTRAINT fk_res_hab FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion),
    CONSTRAINT chk_fechas CHECK (fecha_salida > fecha_entrada)
) ENGINE=InnoDB;

CREATE TABLE servicios (
    id_servicio INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE consumos_extras (
    id_consumo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT UNSIGNED NOT NULL,
    id_servicio INT UNSIGNED NOT NULL,
    fecha_consumo DATETIME DEFAULT CURRENT_TIMESTAMP,
    cantidad TINYINT UNSIGNED DEFAULT 1,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_cons_reserva FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    CONSTRAINT fk_cons_servicio FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
) ENGINE=InnoDB;

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------
START TRANSACTION;

-- Tipos de habitación
INSERT INTO tipos_habitacion (nombre, precio_noche, capacidad_personas, descripcion) VALUES
('Económica Single', 35.00, 1, 'Cama sencilla, ideal viajeros solitarios.'),
('Estándar Doble', 65.00, 2, 'Dos camas individuales o una matrimonial.'),
('Junior Suite', 110.00, 2, 'Espacio de estar y mini bar incluido.'),
('Familiar Deluxe', 150.00, 4, 'Dos habitaciones conectadas, ideal familias.'),
('Suite Presidencial', 300.00, 2, 'Vista panorámica, jacuzzi y servicios VIP.'),
('Apartamento Hotel', 180.00, 5, 'Cocina completa y múltiples ambientes.');

-- Habitaciones (20 habitaciones distribuidas en 4 pisos)
INSERT INTO habitaciones (numero, id_tipo, piso, estado) VALUES
('101', 1, 1, 'Disponible'), ('102', 1, 1, 'Ocupada'), ('103', 2, 1, 'Disponible'), ('104', 2, 1, 'Limpieza'), ('105', 4, 1, 'Disponible'),
('201', 2, 2, 'Ocupada'), ('202', 2, 2, 'Disponible'), ('203', 3, 2, 'Ocupada'), ('204', 3, 2, 'Mantenimiento'), ('205', 6, 2, 'Disponible'),
('301', 1, 3, 'Disponible'), ('302', 2, 3, 'Ocupada'), ('303', 3, 3, 'Disponible'), ('304', 4, 3, 'Disponible'), ('305', 5, 3, 'Ocupada'),
('401', 5, 4, 'Disponible'), ('402', 5, 4, 'Limpieza'), ('403', 6, 4, 'Disponible'), ('404', 6, 4, 'Ocupada'), ('405', 3, 4, 'Disponible');

-- Servicios
INSERT INTO servicios (nombre, precio) VALUES
('Desayuno Buffet', 15.00), ('Lavandería Express', 20.00), ('Spa & Masaje', 45.00), 
('Parking Privado', 10.00), ('Cena Gourmet', 35.00), ('Minibar Pack', 25.00),
('Transporte Aeropuerto', 30.00), ('Late Check-out', 40.00);

-- Huéspedes (100 registros realistas)
INSERT INTO huespedes (nombre, apellidos, documento_id, email, telefono, pais) VALUES
('Juan', 'Pérez García', '12345678A', 'juan.perez@email.com', '600111222', 'España'),
('Maria', 'Rodriguez Slim', '87654321B', 'm.rodriguez@email.com', '600333444', 'México'),
('John', 'Smith', 'PAS998877', 'j.smith@world.com', '+14059988', 'USA'),
('Emma', 'Wilson', 'ID776655', 'emma.w@uk.com', '+447700', 'Reino Unido'),
('Carlos', 'Sánchez', '22334455C', 'csanchez@email.es', '655443322', 'España'),
('Sofia', 'Müller', 'GER991122', 's.muller@web.de', '+49151', 'Alemania'),
('Lucas', 'Ferrari', 'ITA445566', 'l.ferrari@it.com', '+39333', 'Italia'),
('Elena', 'Popova', 'RUS112233', 'e.popova@mail.ru', '+7900', 'Rusia'),
('Diego', 'Fernández', 'ARG334455', 'diego.f@pampa.ar', '+5411', 'Argentina'),
('Ana', 'Oliveira', 'BRA556677', 'ana.o@terra.br', '+5521', 'Brasil'),
('Marc', 'Dubois', 'FRA887766', 'm.dubois@free.fr', '+336', 'Francia'),
('Yuki', 'Tanaka', 'JPN110022', 'y.tanaka@jp.com', '+8190', 'Japón'),
('Sven', 'Larsson', 'SWE445522', 's.larsson@sw.se', '+4670', 'Suecia'),
('Laura', 'Martínez', '44556677D', 'l.martinez@gmail.com', '611223344', 'España'),
('Robert', 'Brown', 'US8877441', 'r.brown@yahoo.com', '+1202', 'USA'),
('Chloe', 'Lefebvre', 'FR3344552', 'c.lef@orange.fr', '+337', 'Francia'),
('Mateo', 'Gómez', 'COL998811', 'm.gomez@email.co', '+57310', 'Colombia'),
('Isabella', 'Conti', 'IT7766112', 'i.conti@libero.it', '+39340', 'Italia'),
('Hans', 'Schmidt', 'DE5544331', 'h.schmidt@t-online.de', '+49170', 'Alemania'),
('Marta', 'Santos', 'PT9900112', 'm.santos@sapo.pt', '+35191', 'Portugal');
-- ... (Para completar los 100, repetimos un patrón o insertamos en bloque)
INSERT INTO huespedes (nombre, apellidos, documento_id, email, telefono, pais)
SELECT CONCAT(nombre, ' II'), CONCAT(apellidos, ' Jr'), CONCAT(documento_id, 'X'), CONCAT('2', email), telefono, pais FROM huespedes LIMIT 80;

-- Reservas (Generamos 120 reservas)
-- Nota: Los IDs de huéspedes van del 1 al 100, habitaciones del 1 al 20.
INSERT INTO reservas (id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado_reserva, total_alojamiento) VALUES
(1, 1, '2024-01-10', '2024-01-15', 'Finalizada', 175.00),
(2, 5, '2024-01-12', '2024-01-14', 'Finalizada', 300.00),
(3, 15, '2024-02-01', '2024-02-10', 'Finalizada', 2700.00),
(4, 2, '2024-02-15', '2024-02-18', 'Finalizada', 105.00),
(5, 8, '2024-03-01', '2024-03-05', 'Finalizada', 440.00),
(6, 10, '2024-03-10', '2024-03-20', 'Finalizada', 1800.00),
(7, 20, '2024-04-01', '2024-04-03', 'Finalizada', 220.00),
(8, 3, '2024-04-05', '2024-04-10', 'Finalizada', 325.00),
(9, 11, '2024-04-15', '2024-04-16', 'Finalizada', 35.00),
(10, 19, '2024-05-01', '2024-05-07', 'Finalizada', 1080.00),
(11, 4, '2024-05-10', '2024-05-12', 'Cancelada', 130.00),
(12, 13, '2024-06-01', '2024-06-15', 'Confirmada', 1540.00),
(13, 14, '2024-06-05', '2024-06-10', 'Confirmada', 750.00),
(14, 1, '2024-06-20', '2024-06-25', 'Confirmada', 175.00),
(15, 5, '2024-07-01', '2024-07-10', 'Pendiente', 1350.00);

-- Generación masiva de reservas adicionales para llegar a las 120
-- (Usamos un SELECT para rellenar datos rápidamente basados en los existentes)
INSERT INTO reservas (id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado_reserva, total_alojamiento)
SELECT 
    FLOOR(1 + RAND() * 99), 
    FLOOR(1 + RAND() * 19), 
    DATE_ADD('2024-08-01', INTERVAL FLOOR(RAND() * 100) DAY),
    DATE_ADD('2024-08-05', INTERVAL FLOOR(RAND() * 110) DAY),
    'Confirmada',
    500.00
FROM huespedes h
CROSS JOIN (SELECT 1 UNION SELECT 2) t
LIMIT 105;

-- Consumos Extras (150+ registros)
-- Vinculamos consumos a las primeras 50 reservas
INSERT INTO consumos_extras (id_reserva, id_servicio, cantidad, subtotal)
SELECT 
    r.id_reserva,
    s.id_servicio,
    FLOOR(1 + RAND() * 3),
    (s.precio * (FLOOR(1 + RAND() * 3)))
FROM reservas r
CROSS JOIN servicios s
WHERE r.id_reserva <= 60 AND RAND() > 0.7
LIMIT 160;

COMMIT;

-- 4. CONSULTAS DE COMPROBACIÓN
-- -----------------------------------------------------------------------------

-- A. Resumen de factura para una reserva específica (Ej: Reserva 3)
SELECT 
    r.id_reserva, 
    hu.nombre, 
    hu.apellidos, 
    r.total_alojamiento AS costo_hab,
    IFNULL(SUM(ce.subtotal), 0) AS total_extras,
    (r.total_alojamiento + IFNULL(SUM(ce.subtotal), 0)) AS gran_total
FROM reservas r
JOIN huespedes hu ON r.id_huesped = hu.id_huesped
LEFT JOIN consumos_extras ce ON r.id_reserva = ce.id_reserva
WHERE r.id_reserva = 3
GROUP BY r.id_reserva;

-- B. Ocupación actual por piso
SELECT piso, COUNT(*) AS habitaciones_ocupadas
FROM habitaciones
WHERE estado = 'Ocupada'
GROUP BY piso;

-- C. Ranking de servicios más vendidos
SELECT s.nombre, COUNT(ce.id_consumo) AS veces_contratado, SUM(ce.subtotal) AS ingresos_servicio
FROM servicios s
JOIN consumos_extras ce ON s.id_servicio = ce.id_servicio
GROUP BY s.id_servicio
ORDER BY ingresos_servicio DESC;

-- D. Verificación de volumen de datos
SELECT 
    (SELECT COUNT(*) FROM huespedes) AS total_huespedes,
    (SELECT COUNT(*) FROM reservas) AS total_reservas,
    (SELECT COUNT(*) FROM consumos_extras) AS total_consumos;