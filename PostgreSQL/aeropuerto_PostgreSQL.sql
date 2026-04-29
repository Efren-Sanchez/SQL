-- =============================================================================
-- SISTEMA DE GESTIÓN AEROPORTUARIA
-- PostgreSQL
-- Autor: Efrén Sánchez / Optimización: IA
-- =============================================================================

-- 1. LIMPIEZA DE TABLAS
-- -----------------------------------------------------------------------------
-- En PostgreSQL usamos CASCADE para eliminar las tablas y sus dependencias (FKs)
DROP TABLE IF EXISTS equipaje, reservas, vuelos, aviones, aeropuertos, aerolineas, pasajeros CASCADE;

-- 2. DDL: DEFINICIÓN DE TABLAS
-- -----------------------------------------------------------------------------

CREATE TABLE pasajeros (
    id_pasajero SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    pasaporte VARCHAR(20) UNIQUE NOT NULL,
    nacionalidad VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20)
);

CREATE TABLE aerolineas (
    id_aerolinea SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_iata VARCHAR(3) UNIQUE NOT NULL,
    pais_origen VARCHAR(50)
);

CREATE TABLE aeropuertos (
    id_aeropuerto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_iata VARCHAR(3) UNIQUE NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

CREATE TABLE aviones (
    id_avion SERIAL PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    capacidad_pasajeros INT NOT NULL,
    id_aerolinea INT NOT NULL,
    CONSTRAINT fk_avion_aerolinea FOREIGN KEY (id_aerolinea) REFERENCES aerolineas(id_aerolinea) ON DELETE CASCADE
);

CREATE TABLE vuelos (
    id_vuelo SERIAL PRIMARY KEY,
    numero_vuelo VARCHAR(10) UNIQUE NOT NULL,
    id_aerolinea INT NOT NULL,
    id_origen INT NOT NULL,
    id_destino INT NOT NULL,
    id_avion INT NOT NULL,
    fecha_salida TIMESTAMP NOT NULL,
    fecha_llegada TIMESTAMP NOT NULL,
    estado VARCHAR(20) DEFAULT 'Programado' CHECK (estado IN ('Programado', 'En Vuelo', 'Aterrizado', 'Retrasado', 'Cancelado')),
    precio_base DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_vuelo_aerolinea FOREIGN KEY (id_aerolinea) REFERENCES aerolineas(id_aerolinea),
    CONSTRAINT fk_vuelo_origen FOREIGN KEY (id_origen) REFERENCES aeropuertos(id_aeropuerto),
    CONSTRAINT fk_vuelo_destino FOREIGN KEY (id_destino) REFERENCES aeropuertos(id_aeropuerto),
    CONSTRAINT fk_vuelo_avion FOREIGN KEY (id_avion) REFERENCES aviones(id_avion)
);

CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_pasajero INT NOT NULL,
    id_vuelo INT NOT NULL,
    fecha_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    asiento VARCHAR(5) NOT NULL,
    clase VARCHAR(20) DEFAULT 'Turista' CHECK (clase IN ('Turista', 'Business', 'Primera')),
    precio_final DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_reserva_pasajero FOREIGN KEY (id_pasajero) REFERENCES pasajeros(id_pasajero),
    CONSTRAINT fk_reserva_vuelo FOREIGN KEY (id_vuelo) REFERENCES vuelos(id_vuelo)
);

CREATE TABLE equipaje (
    id_equipaje SERIAL PRIMARY KEY,
    id_reserva INT NOT NULL,
    peso_kg DECIMAL(5,2) NOT NULL,
    tipo VARCHAR(20) DEFAULT 'Bodega' CHECK (tipo IN ('Mano', 'Bodega')),
    CONSTRAINT fk_equipaje_reserva FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva) ON DELETE CASCADE
);

-- 3. DML: CARGA DE DATOS
-- -----------------------------------------------------------------------------
BEGIN;

-- AEROLÍNEAS
INSERT INTO aerolineas (nombre, codigo_iata, pais_origen) VALUES
('Iberia', 'IBE', 'España'), ('Emirates', 'UAE', 'Emiratos Árabes'), ('Lufthansa', 'DLH', 'Alemania'),
('Delta Air Lines', 'DAL', 'USA'), ('Ryanair', 'RYR', 'Irlanda'), ('Air France', 'AFR', 'Francia'),
('Qatar Airways', 'QTR', 'Qatar'), ('LATAM', 'LAN', 'Chile'), ('Japan Airlines', 'JAL', 'Japón'),
('British Airways', 'BAW', 'Reino Unido'), ('Aeroméxico', 'AMX', 'México'), ('Turkish Airlines', 'THY', 'Turquía');

-- AEROPUERTOS
INSERT INTO aeropuertos (nombre, codigo_iata, ciudad, pais) VALUES
('Adolfo Suárez Madrid-Barajas', 'MAD', 'Madrid', 'España'), ('John F. Kennedy', 'JFK', 'Nueva York', 'USA'),
('Narita International', 'NRT', 'Tokio', 'Japón'), ('Heathrow', 'LHR', 'Londres', 'Reino Unido'),
('Charles de Gaulle', 'CDG', 'París', 'Francia'), ('Dubai International', 'DXB', 'Dubai', 'EAU'),
('El Dorado', 'BOG', 'Bogotá', 'Colombia'), ('Benito Juárez', 'MEX', 'Ciudad de México', 'México'),
('Frankfurt Airport', 'FRA', 'Frankfurt', 'Alemania'), ('Sydney Airport', 'SYD', 'Sydney', 'Australia'),
('El Prat', 'BCN', 'Barcelona', 'España'), ('Ministro Pistarini', 'EZE', 'Buenos Aires', 'Argentina'),
('Haneda', 'HND', 'Tokio', 'Japón'), ('Leonardo da Vinci', 'FCO', 'Roma', 'Italia'),
('Changi Airport', 'SIN', 'Singapur', 'Singapur');

-- AVIONES
INSERT INTO aviones (modelo, capacidad_pasajeros, id_aerolinea) VALUES
('Airbus A350', 350, 1), ('Airbus A320', 180, 1), ('Boeing 777', 400, 2), ('Airbus A380', 550, 2),
('Boeing 747', 410, 3), ('Airbus A321', 200, 3), ('Boeing 737', 160, 4), ('Boeing 767', 250, 4),
('Boeing 737-800', 189, 5), ('Airbus A330', 300, 6), ('Airbus A350-1000', 410, 7), ('Boeing 787-9', 290, 8),
('Boeing 777-300ER', 390, 9), ('Airbus A319', 140, 10), ('Boeing 787-8', 240, 11), ('Airbus A321neo', 220, 12);

-- PASAJEROS
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

-- Multiplicación de pasajeros (Lógica PostgreSQL)
INSERT INTO pasajeros (nombre, apellidos, pasaporte, nacionalidad, email, telefono)
SELECT nombre || ' II', apellidos || ' Jr', pasaporte || 'X', nacionalidad, 'alt.' || email, telefono FROM pasajeros;

-- VUELOS
INSERT INTO vuelos (numero_vuelo, id_aerolinea, id_origen, id_destino, id_avion, fecha_salida, fecha_llegada, estado, precio_base) VALUES
('IB101', 1, 1, 2, 1, '2024-10-01 10:00:00', '2024-10-01 18:00:00', 'Aterrizado', 450.00),
('IB102', 1, 2, 1, 1, '2024-10-02 12:00:00', '2024-10-02 20:00:00', 'Aterrizado', 480.00),
('UAE201', 2, 6, 3, 3, '2024-11-10 03:00:00', '2024-11-10 15:00:00', 'Aterrizado', 850.00),
('UAE202', 2, 3, 6, 3, '2024-11-12 08:00:00', '2024-11-12 20:00:00', 'Aterrizado', 800.00),
('RYR501', 5, 1, 11, 9, '2024-12-01 07:00:00', '2024-12-01 08:30:00', 'Programado', 29.99);

-- Vuelos adicionales con intervalos (Aritmética de fechas PG)
INSERT INTO vuelos (numero_vuelo, id_aerolinea, id_origen, id_destino, id_avion, fecha_salida, fecha_llegada, estado, precio_base)
SELECT numero_vuelo || 'V', id_aerolinea, id_destino, id_origen, id_avion, fecha_salida + interval '7 days', fecha_llegada + interval '7 days', 'Programado', precio_base + 10 FROM vuelos;

-- RESERVAS (Lógica random PostgreSQL)
INSERT INTO reservas (id_pasajero, id_vuelo, asiento, clase, precio_final)
SELECT 
    p.id_pasajero, 
    v.id_vuelo, 
    (floor(random()*30 + 1))::text || chr(65 + floor(random()*6)::int), 
    CASE WHEN random() > 0.8 THEN 'Business' ELSE 'Turista' END,
    v.precio_base * (1 + random())
FROM pasajeros p
CROSS JOIN (SELECT id_vuelo, precio_base FROM vuelos ORDER BY random() LIMIT 2) v
LIMIT 150;

-- EQUIPAJE
INSERT INTO equipaje (id_reserva, peso_kg, tipo)
SELECT id_reserva, 8.5, 'Mano' FROM reservas;

INSERT INTO equipaje (id_reserva, peso_kg, tipo)
SELECT id_reserva, 22.3, 'Bodega' FROM reservas WHERE random() > 0.4 LIMIT 50;

COMMIT;

-- 4. CONSULTAS DE PRUEBA
-- -----------------------------------------------------------------------------

-- 1. INFORME MAESTRO
SELECT 
    v.numero_vuelo, 
    a.nombre AS aerolinea,
    p.nombre || ' ' || p.apellidos AS pasajero,
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

-- 2. CÁLCULO DE TIEMPOS (Uso de INTERVAL en PostgreSQL)
SELECT 
    numero_vuelo, 
    fecha_salida, 
    fecha_llegada,
    (fecha_llegada - fecha_salida) AS duracion
FROM vuelos
WHERE (fecha_llegada - fecha_salida) > interval '3 hours'
LIMIT 10;

-- 3. ESTADÍSTICAS FINANCIERAS
SELECT 
    a.nombre AS aerolinea, 
    COUNT(r.id_reserva) AS total_pasajeros,
    SUM(r.precio_final) AS ingresos_totales
FROM aerolineas a
JOIN vuelos v ON a.id_aerolinea = v.id_aerolinea
JOIN reservas r ON v.id_vuelo = r.id_vuelo
GROUP BY a.id_aerolinea, a.nombre
HAVING SUM(r.precio_final) > 0
ORDER BY ingresos_totales DESC;