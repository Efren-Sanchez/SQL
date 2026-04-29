-- =============================================================================
-- SISTEMA DE GESTIÓN DE GIMNASIO
-- MySQL / MariaDB 
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

CREATE DATABASE IF NOT EXISTS gimnasio
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE gimnasio;

-- 1. CONFIGURACIÓN E INICIALIZACIÓN
-- -----------------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS asistencia;
DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS clases_registro;
DROP TABLE IF EXISTS clases;
DROP TABLE IF EXISTS instructores;
DROP TABLE IF EXISTS socios;
DROP TABLE IF EXISTS membresias;

SET FOREIGN_KEY_CHECKS = 1;

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE membresias (
    id_membresia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    duracion_dias INT NOT NULL,
    descripcion TEXT
) ENGINE=InnoDB;

CREATE TABLE socios (
    id_socio INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_nac DATE,
    id_membresia INT UNSIGNED,
    estado ENUM('Activo', 'Inactivo', 'Pendiente') DEFAULT 'Pendiente',
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_socio_membresia FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE instructores (
    id_instructor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    especialidad VARCHAR(50),
    salario_hora DECIMAL(10,2),
    telefono VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE clases (
    id_clase INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_instructor INT UNSIGNED,
    horario TIME NOT NULL,
    dia_semana ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') NOT NULL,
    capacidad_max INT DEFAULT 20,
    CONSTRAINT fk_clase_instructor FOREIGN KEY (id_instructor) REFERENCES instructores(id_instructor) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE clases_registro (
    id_registro INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_socio INT UNSIGNED NOT NULL,
    id_clase INT UNSIGNED NOT NULL,
    fecha_inscripcion DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_reg_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE,
    CONSTRAINT fk_reg_clase FOREIGN KEY (id_clase) REFERENCES clases(id_clase) ON DELETE CASCADE,
    UNIQUE (id_socio, id_clase)
) ENGINE=InnoDB;

CREATE TABLE pagos (
    id_pago INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_socio INT UNSIGNED NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia') NOT NULL,
    CONSTRAINT fk_pago_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE asistencia (
    id_asistencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_socio INT UNSIGNED NOT NULL,
    fecha_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_asistencia_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------
START TRANSACTION;

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
('Yoga Flow', 1, '09:00:00', 'Miércoles', 15),
('Crossfit WOD', 2, '18:30:00', 'Martes', 12),
('Crossfit WOD', 2, '18:30:00', 'Jueves', 12),
('Zumba Night', 3, '20:00:00', 'Viernes', 25),
('Spinning Pro', 5, '08:00:00', 'Lunes', 20),
('Spinning Pro', 5, '08:00:00', 'Miércoles', 20),
('Musculación Dirigida', 4, '11:00:00', 'Sábado', 10);

-- Socios (Carga de 40 socios para generar relaciones suficientes)
INSERT INTO socios (nombre, apellidos, dni, email, telefono, id_membresia, estado) VALUES
('Carlos', 'González', '12345678A', 'carlos@mail.com', '600000001', 2, 'Activo'),
('Lucía', 'Fernández', '23456789B', 'lucia@mail.com', '600000002', 1, 'Activo'),
('Sergio', 'Ramírez', '34567890C', 'sergio@mail.com', '600000003', 3, 'Activo'),
('Ana', 'Pérez', '45678901D', 'ana@mail.com', '600000004', 2, 'Activo'),
('David', 'Martínez', '56789012E', 'david@mail.com', '600000005', 1, 'Inactivo'),
('María', 'García', '67890123F', 'maria@mail.com', '600000006', 2, 'Activo'),
('Javier', 'López', '78901234G', 'javier@mail.com', '600000007', 3, 'Activo'),
('Carmen', 'Sánchez', '89012345H', 'carmen@mail.com', '600000008', 1, 'Activo'),
('Hugo', 'Torres', '90123456I', 'hugo@mail.com', '600000009', 2, 'Pendiente'),
('Sara', 'Ruiz', '01234567J', 'sara@mail.com', '600000010', 2, 'Activo'),
-- Generamos más socios para volumen
('Laura', 'Vázquez', '11111111A', 'laura1@mail.com', '611000001', 1, 'Activo'),
('Pedro', 'Jiménez', '22222222B', 'pedro2@mail.com', '611000002', 2, 'Activo'),
('Marta', 'Heredia', '33333333C', 'marta3@mail.com', '611000003', 3, 'Activo'),
('Raúl', 'Castro', '44444444D', 'raul4@mail.com', '611000004', 2, 'Activo'),
('Sofía', 'Ortiz', '55555555E', 'sofia5@mail.com', '611000005', 1, 'Inactivo'),
('Iker', 'Molina', '66666666F', 'iker6@mail.com', '611000006', 2, 'Activo'),
('Nerea', 'Delgado', '77777777G', 'nerea7@mail.com', '611000007', 2, 'Activo'),
('Álvaro', 'Blanco', '88888888H', 'alvaro8@mail.com', '611000008', 3, 'Activo'),
('Paula', 'Suárez', '99999999I', 'paula9@mail.com', '611000009', 1, 'Activo'),
('Jorge', 'Rubio', '00000000Z', 'jorge10@mail.com', '611000010', 2, 'Activo'),
('Luis', 'Medina', '12121212K', 'luis@mail.com', '622000001', 1, 'Activo'),
('Elena', 'Cano', '34343434L', 'elena@mail.com', '622000002', 2, 'Activo'),
('Roberto', 'Sanz', '56565656M', 'roberto@mail.com', '622000003', 3, 'Activo'),
('Mónica', 'Gil', '78787878N', 'monica@mail.com', '622000004', 2, 'Activo'),
('Teresa', 'Prieto', '90909090O', 'teresa@mail.com', '622000005', 1, 'Activo'),
('Fernando', 'Reyes', '13131313P', 'fernando@mail.com', '622000006', 2, 'Activo'),
('Berta', 'Navarro', '24242424Q', 'berta@mail.com', '622000007', 3, 'Activo'),
('Víctor', 'Crespo', '35353535R', 'victor@mail.com', '622000008', 1, 'Activo'),
('Isabel', 'Guerra', '46464646S', 'isabel@mail.com', '622000009', 2, 'Activo'),
('Andrés', 'León', '57575757T', 'andres@mail.com', '622000010', 2, 'Activo');

-- Registro de Clases (clases_registro) - (Aprox 50 registros)
INSERT INTO clases_registro (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 1, '2024-01-10' FROM socios WHERE id_socio BETWEEN 1 AND 15;
INSERT INTO clases_registro (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 3, '2024-01-12' FROM socios WHERE id_socio BETWEEN 10 AND 25;
INSERT INTO clases_registro (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 5, '2024-01-15' FROM socios WHERE id_socio BETWEEN 5 AND 20;
INSERT INTO clases_registro (id_socio, id_clase, fecha_inscripcion)
SELECT id_socio, 6, '2024-01-20' FROM socios WHERE id_socio BETWEEN 20 AND 30;

-- Pagos (pagos) - (Aprox 100 registros: cuotas mensuales simuladas)
-- Enero
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT id_socio, 29.90, '2024-01-05 10:00:00', 'Tarjeta' FROM socios WHERE id_membresia = 1;
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT id_socio, 45.00, '2024-01-05 11:30:00', 'Transferencia' FROM socios WHERE id_membresia = 2;
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT id_socio, 450.00, '2024-01-02 09:00:00', 'Efectivo' FROM socios WHERE id_membresia = 3;
-- Febrero
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT id_socio, 29.90, '2024-02-05 10:00:00', 'Tarjeta' FROM socios WHERE id_membresia = 1;
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT id_socio, 45.00, '2024-02-05 11:30:00', 'Tarjeta' FROM socios WHERE id_membresia = 2;
-- Marzo
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT id_socio, 29.90, '2024-03-05 10:00:00', 'Transferencia' FROM socios WHERE id_membresia = 1;
INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
SELECT id_socio, 45.00, '2024-03-05 11:30:00', 'Efectivo' FROM socios WHERE id_membresia = 2;

-- Asistencias (asistencia) - (Aprox 160 registros simulados)
-- Simulamos entradas de varios días para los primeros 30 socios
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, '2024-03-01 08:00:00' FROM socios WHERE id_socio % 2 = 0;
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, '2024-03-02 09:15:00' FROM socios WHERE id_socio % 3 = 0;
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, '2024-03-03 10:30:00' FROM socios WHERE id_socio BETWEEN 1 AND 25;
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, '2024-03-04 18:00:00' FROM socios WHERE id_socio BETWEEN 10 AND 30;
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, '2024-03-05 07:45:00' FROM socios WHERE id_socio % 2 != 0;
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, '2024-03-06 19:00:00' FROM socios WHERE id_socio BETWEEN 5 AND 30;
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, '2024-03-07 12:00:00' FROM socios WHERE id_socio % 4 = 0;
INSERT INTO asistencia (id_socio, fecha_entrada)
SELECT id_socio, NOW() FROM socios WHERE estado = 'Activo';

COMMIT;

-- 4. CONSULTAS DE VALIDACIÓN
-- -----------------------------------------------------------------------------

-- Total de registros por tabla para verificar volumen
SELECT 
    (SELECT COUNT(*) FROM socios) AS total_socios,
    (SELECT COUNT(*) FROM pagos) AS total_pagos,
    (SELECT COUNT(*) FROM asistencia) AS total_asistencias,
    (SELECT COUNT(*) FROM clases_registro) AS total_inscripciones_clases;

-- Ejemplo de consulta de ingresos por mes
SELECT 
    MONTHNAME(fecha_pago) AS Mes, 
    SUM(monto) AS Ingresos 
FROM pagos 
GROUP BY Mes;