-- =============================================================================
-- SISTEMA DE GESTIÓN AEROPORTUARIA
-- MySQL / MariaDB 
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

CREATE DATABASE IF NOT EXISTS aeropuerto
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE aeropuerto;

-- 1. LIMPIEZA DE TABLAS
-- -----------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS equipaje, reservas, vuelos, aviones, aeropuertos, aerolineas, pasajeros;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. DDL: DEFINICIÓN DE TABLAS (Todas con PK AUTO_INCREMENT)
-- -----------------------------------------------------------------------------

CREATE TABLE pasajeros (
    id_pasajero INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    pasaporte VARCHAR(20) UNIQUE NOT NULL,
    nacionalidad VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE aerolineas (
    id_aerolinea INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_iata VARCHAR(3) UNIQUE NOT NULL,
    pais_origen VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE aeropuertos (
    id_aeropuerto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_iata VARCHAR(3) UNIQUE NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE aviones (
    id_avion INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    capacidad_pasajeros INT UNSIGNED NOT NULL,
    id_aerolinea INT UNSIGNED NOT NULL,
    CONSTRAINT fk_avion_aerolinea FOREIGN KEY (id_aerolinea) REFERENCES aerolineas(id_aerolinea) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE vuelos (
    id_vuelo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero_vuelo VARCHAR(10) UNIQUE NOT NULL,
    id_aerolinea INT UNSIGNED NOT NULL,
    id_origen INT UNSIGNED NOT NULL,
    id_destino INT UNSIGNED NOT NULL,
    id_avion INT UNSIGNED NOT NULL,
    fecha_salida DATETIME NOT NULL,
    fecha_llegada DATETIME NOT NULL,
    estado ENUM('Programado', 'En Vuelo', 'Aterrizado', 'Retrasado', 'Cancelado') DEFAULT 'Programado',
    precio_base DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_vuelo_aerolinea FOREIGN KEY (id_aerolinea) REFERENCES aerolineas(id_aerolinea),
    CONSTRAINT fk_vuelo_origen FOREIGN KEY (id_origen) REFERENCES aeropuertos(id_aeropuerto),
    CONSTRAINT fk_vuelo_destino FOREIGN KEY (id_destino) REFERENCES aeropuertos(id_aeropuerto),
    CONSTRAINT fk_vuelo_avion FOREIGN KEY (id_avion) REFERENCES aviones(id_avion)
) ENGINE=InnoDB;

CREATE TABLE reservas (
    id_reserva INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_pasajero INT UNSIGNED NOT NULL,
    id_vuelo INT UNSIGNED NOT NULL,
    fecha_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    asiento VARCHAR(5) NOT NULL,
    clase ENUM('Turista', 'Business', 'Primera') DEFAULT 'Turista',
    precio_final DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_reserva_pasajero FOREIGN KEY (id_pasajero) REFERENCES pasajeros(id_pasajero),
    CONSTRAINT fk_reserva_vuelo FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo)
) ENGINE=InnoDB;

CREATE TABLE equipaje (
    id_equipaje INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT UNSIGNED NOT NULL,
    peso_kg DECIMAL(5,2) NOT NULL,
    tipo ENUM('Mano', 'Bodega') DEFAULT 'Bodega',
    CONSTRAINT fk_equipaje_reserva FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. DML: CARGA DE DATOS REALISTAS
-- -----------------------------------------------------------------------------
START TRANSACTION;

-- AEROLÍNEAS (12 registros)
INSERT INTO aerolineas (nombre, codigo_iata, pais_origen) VALUES
('Iberia', 'IBE', 'España'), ('Emirates', 'UAE', 'Emiratos Árabes'), ('Lufthansa', 'DLH', 'Alemania'),
('Delta Air Lines', 'DAL', 'USA'), ('Ryanair', 'RYR', 'Irlanda'), ('Air France', 'AFR', 'Francia'),
('Qatar Airways', 'QTR', 'Qatar'), ('LATAM', 'LAN', 'Chile'), ('Japan Airlines', 'JAL', 'Japón'),
('British Airways', 'BAW', 'Reino Unido'), ('Aeroméxico', 'AMX', 'México'), ('Turkish Airlines', 'THY', 'Turquía');

-- AEROPUERTOS (15 registros)
INSERT INTO aeropuertos (nombre, codigo_iata, ciudad, pais) VALUES
('Adolfo Suárez Madrid-Barajas', 'MAD', 'Madrid', 'España'), ('John F. Kennedy', 'JFK', 'Nueva York', 'USA'),
('Narita International', 'NRT', 'Tokio', 'Japón'), ('Heathrow', 'LHR', 'Londres', 'Reino Unido'),
('Charles de Gaulle', 'CDG', 'París', 'Francia'), ('Dubai International', 'DXB', 'Dubai', 'EAU'),
('El Dorado', 'BOG', 'Bogotá', 'Colombia'), ('Benito Juárez', 'MEX', 'Ciudad de México', 'México'),
('Frankfurt Airport', 'FRA', 'Frankfurt', 'Alemania'), ('Sydney Airport', 'SYD', 'Sydney', 'Australia'),
('El Prat', 'BCN', 'Barcelona', 'España'), ('Ministro Pistarini', 'EZE', 'Buenos Aires', 'Argentina'),
('Haneda', 'HND', 'Tokio', 'Japón'), ('Leonardo da Vinci', 'FCO', 'Roma', 'Italia'),
('Changi Airport', 'SIN', 'Singapur', 'Singapur');

-- AVIONES (25 registros)
INSERT INTO aviones (modelo, capacidad_pasajeros, id_aerolinea) VALUES
('Airbus A350', 350, 1), ('Airbus A320', 180, 1), ('Boeing 777', 400, 2), ('Airbus A380', 550, 2),
('Boeing 747', 410, 3), ('Airbus A321', 200, 3), ('Boeing 737', 160, 4), ('Boeing 767', 250, 4),
('Boeing 737-800', 189, 5), ('Airbus A330', 300, 6), ('Airbus A350-1000', 410, 7), ('Boeing 787-9', 290, 8),
('Boeing 777-300ER', 390, 9), ('Airbus A319', 140, 10), ('Boeing 787-8', 240, 11), ('Airbus A321neo', 220, 12),
('Boeing 777', 350, 2), ('Airbus A320', 180, 5), ('Boeing 737', 160, 5), ('Airbus A350', 350, 6),
('Airbus A380', 550, 7), ('Boeing 787', 290, 11), ('Airbus A320', 180, 12), ('Airbus A330', 300, 1), ('Boeing 777', 400, 10);

-- PASAJEROS (100 registros - Bloque reducido para el ejemplo, pero funcional)
INSERT INTO pasajeros (nombre, apellidos, pasaporte, nacionalidad, email, telefono) VALUES
('Juan', 'García López', 'P-1001', 'España', 'juan.garcia@email.com', '+34600111222'),
('Maria', 'Rodríguez Silva', 'P-1002', 'México', 'm.rodriguez@email.com', '+52555123456'),
('John', 'Smith', 'P-1003', 'USA', 'john.smith@email.com', '+12025550101'),
('Yuki', 'Tanaka', 'P-1004', 'Japón', 'y.tanaka@email.com', '+81301234567'),
('Elena', 'Rossi', 'P-1005', 'Italia', 'e.rossi@email.com', '+39061234567'),
('Carlos', 'Sánchez', 'P-1006', 'Argentina', 'c.sanchez@email.com', '+54114567890'),
('Emma', 'Wilson', 'P-1007', 'Reino Unido', 'emma.w@email.com', '+44207123456'),
('Lucas', 'Dubois', 'P-1008', 'Francia', 'l.dubois@email.com', '+33140123456'),
('Ahmed', 'Al-Fayed', 'P-1009', 'EAU', 'ahmed.f@email.com', '+97141234567'),
('Sofia', 'Müller', 'P-1010', 'Alemania', 's.muller@email.com', '+49301234567');
-- (Para el ejercicio, repetimos nombres sistemáticamente o insertamos más)
INSERT INTO pasajeros (nombre, apellidos, pasaporte, nacionalidad, email, telefono)
SELECT CONCAT(nombre, ' II'), CONCAT(apellidos, ' Jr'), CONCAT(pasaporte, 'X'), nacionalidad, CONCAT('alt.', email), telefono FROM pasajeros;
INSERT INTO pasajeros (nombre, apellidos, pasaporte, nacionalidad, email, telefono)
SELECT CONCAT(nombre, ' III'), CONCAT(apellidos, ' Sr'), CONCAT(pasaporte, 'Y'), nacionalidad, CONCAT('old.', email), telefono FROM pasajeros LIMIT 80;

-- VUELOS (60 registros)
-- Combinamos aerolíneas, rutas y aviones
INSERT INTO vuelos (numero_vuelo, id_aerolinea, id_origen, id_destino, id_avion, fecha_salida, fecha_llegada, estado, precio_base) VALUES
('IB101', 1, 1, 2, 1, '2024-10-01 10:00:00', '2024-10-01 18:00:00', 'Aterrizado', 450.00),
('IB102', 1, 2, 1, 1, '2024-10-02 12:00:00', '2024-10-02 20:00:00', 'Aterrizado', 480.00),
('UAE201', 2, 6, 3, 3, '2024-11-10 03:00:00', '2024-11-10 15:00:00', 'Aterrizado', 850.00),
('UAE202', 2, 3, 6, 3, '2024-11-12 08:00:00', '2024-11-12 20:00:00', 'Aterrizado', 800.00),
('RYR501', 5, 1, 11, 9, '2024-12-01 07:00:00', '2024-12-01 08:30:00', 'Programado', 29.99),
('AFR301', 6, 5, 1, 10, '2024-12-05 09:00:00', '2024-12-05 11:00:00', 'Programado', 120.00),
('QTR701', 7, 6, 15, 11, '2024-12-10 22:00:00', '2024-12-11 10:00:00', 'Programado', 950.00),
('AMX401', 11, 8, 2, 15, '2024-12-15 05:00:00', '2024-12-15 13:00:00', 'Programado', 300.00);
-- Insertamos más vuelos variando rutas e IDs
INSERT INTO vuelos (numero_vuelo, id_aerolinea, id_origen, id_destino, id_avion, fecha_salida, fecha_llegada, estado, precio_base)
SELECT CONCAT(numero_vuelo, 'V'), id_aerolinea, id_destino, id_origen, id_avion, DATE_ADD(fecha_salida, INTERVAL 7 DAY), DATE_ADD(fecha_llegada, INTERVAL 7 DAY), 'Programado', precio_base + 10 FROM vuelos;
INSERT INTO vuelos (numero_vuelo, id_aerolinea, id_origen, id_destino, id_avion, fecha_salida, fecha_llegada, estado, precio_base)
SELECT CONCAT(numero_vuelo, 'X'), id_aerolinea, id_origen, id_destino, id_avion, DATE_ADD(fecha_salida, INTERVAL 14 DAY), DATE_ADD(fecha_llegada, INTERVAL 14 DAY), 'Programado', precio_base - 5 FROM vuelos;

-- RESERVAS (150 registros)
-- Generamos reservas cruzando pasajeros y vuelos
INSERT INTO reservas (id_pasajero, id_vuelo, asiento, clase, precio_final)
SELECT 
    p.id_pasajero, 
    v.id_vuelo, 
    CONCAT(FLOOR(RAND()*30 + 1), CHAR(65 + FLOOR(RAND()*6))), 
    IF(RAND()>0.8, 'Business', 'Turista'),
    v.precio_base * (1 + RAND())
FROM pasajeros p
CROSS JOIN (SELECT id_vuelo, precio_base FROM vuelos ORDER BY RAND() LIMIT 2) v
LIMIT 150;

-- EQUIPAJE (200 registros)
-- Casi cada reserva tiene una maleta de mano y algunos una de bodega
INSERT INTO equipaje (id_reserva, peso_kg, tipo)
SELECT id_reserva, 8.5, 'Mano' FROM reservas;

INSERT INTO equipaje (id_reserva, peso_kg, tipo)
SELECT id_reserva, 22.3, 'Bodega' FROM reservas WHERE RAND() > 0.4 LIMIT 50;

COMMIT;

-- 4. CONSULTAS DE PRUEBA (ESCENARIOS AEROPORTUARIOS)
-- -----------------------------------------------------------------------------

-- 1. INFORME MAESTRO
-- Consulta para ver el manifiesto de pasajeros de un vuelo específico (informe maestro)
-- Da una visión global: quién viaja, en qué aerolínea, en qué asiento y exactamente de qué ciudad a qué ciudad.
SELECT 
    v.numero_vuelo, 
    a.nombre AS aerolinea,
    CONCAT(p.nombre, ' ', p.apellidos) AS pasajero,
    r.asiento,
    r.clase,
    ao.codigo_iata AS origen,
    ad.codigo_iata AS destino
FROM reservas r
JOIN pasajeros p ON r.id_pasajero = p.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aerolineas a ON v.id_aerolinea = a.id_aerolinea
JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto
ORDER BY v.numero_vuelo;


-- 2. TABLÓN DE ANUNCIOS
-- Ver vuelos del día con origen, destino y aerolínea
-- Nota: Usamos dos veces la tabla 'aeropuertos' (una para origen y otra para destino).
SELECT 
    v.numero_vuelo, 
    a.nombre AS aerolinea, 
    o.ciudad AS ciudad_origen, 
    d.ciudad AS ciudad_destino, 
    v.fecha_salida, 
    v.estado
FROM vuelos v
JOIN aerolineas a ON v.id_aerolinea = a.id_aerolinea
JOIN aeropuertos o ON v.id_origen = o.id_aeropuerto
JOIN aeropuertos d ON v.id_destino = d.id_aeropuerto
ORDER BY v.fecha_salida ASC
LIMIT 20;


-- 3. MANIFIESTO DE PASAJEROS (Vuelo específico)
-- Lista de embarque: para saber quiénes están sentados en un avión concreto
SELECT 
    v.numero_vuelo, 
    p.nombre, 
    p.apellidos, 
    r.asiento, 
    r.clase
FROM reservas r
JOIN pasajeros p ON r.id_pasajero = p.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
WHERE v.numero_vuelo LIKE 'FL1-%' -- Busca vuelos de la primera aerolínea insertada
ORDER BY r.asiento;


-- 4. ESTADÍSTICAS FINANCIERAS (Ingresos por aerolínea)
SELECT 
    a.nombre AS aerolinea, 
    COUNT(r.id_reserva) AS total_pasajeros,
    SUM(r.precio_final) AS ingresos_totales
FROM aerolineas a
JOIN vuelos v ON a.id_aerolinea = v.id_aerolinea
JOIN reservas r ON v.id_vuelo = r.id_vuelo
GROUP BY a.id_aerolinea
HAVING ingresos_totales > 0
ORDER BY ingresos_totales DESC;


-- 5. CÁLCULO DE TIEMPOS (Vuelos de larga duración)
-- Nota: En el script pusimos diferencias de 4h, así que buscaremos > 3h.
SELECT 
    numero_vuelo, 
    fecha_salida, 
    fecha_llegada,
    TIMEDIFF(fecha_llegada, fecha_salida) AS duracion
FROM vuelos
WHERE TIMEDIFF(fecha_llegada, fecha_salida) > '03:00:00'
LIMIT 10;


-- 6. CONTROL DE EQUIPAJE 
-- Objetivo: Ver el peso total que lleva un vuelo en la bodega.
SELECT 
    v.numero_vuelo, 
    SUM(e.peso_kg) AS peso_total_bodega
FROM equipaje e
JOIN reservas r ON e.id_reserva = r.id_reserva
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
WHERE e.tipo = 'Bodega'
GROUP BY v.id_vuelo
ORDER BY peso_total_bodega DESC;
