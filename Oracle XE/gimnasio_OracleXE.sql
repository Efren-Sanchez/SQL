-- =============================================================================
-- SISTEMA DE GESTIÓN DE GIMNASIO
-- Oracle XE 
-- Autor: Efrén Sánchez / Optimización de datos: IA
-- =============================================================================

-- 1. LIMPIEZA DE TABLAS (PL/SQL para evitar errores si no existen)
-- -----------------------------------------------------------------------------
BEGIN
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN 
        ('ASISTENCIA', 'PAGOS', 'CLASES_REGISTRO', 'CLASES', 'INSTRUCTORES', 'SOCIOS', 'MEMBRESIAS')) 
    LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

-- Tipos de membresía
CREATE TABLE membresias (
    id_membresia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    precio NUMBER(10,2) NOT NULL,
    duracion_dias NUMBER NOT NULL,
    descripcion VARCHAR2(500)
);

-- Información de los Socios
CREATE TABLE socios (
    id_socio NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    apellidos VARCHAR2(100) NOT NULL,
    dni VARCHAR2(15) UNIQUE NOT NULL,
    email VARCHAR2(100) UNIQUE,
    telefono VARCHAR2(20),
    fecha_nac DATE,
    id_membresia NUMBER,
    estado VARCHAR2(20) DEFAULT 'Pendiente',
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_socio_membresia FOREIGN KEY (id_membresia) REFERENCES membresias(id_membresia) ON DELETE SET NULL,
    CONSTRAINT check_estado CHECK (estado IN ('Activo', 'Inactivo', 'Pendiente'))
);

-- Instructores
CREATE TABLE instructores (
    id_instructor NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    especialidad VARCHAR2(50),
    salario_hora NUMBER(10,2),
    telefono VARCHAR2(20)
);

-- Catálogo de clases
CREATE TABLE clases (
    id_clase NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    id_instructor NUMBER,
    horario VARCHAR2(10) NOT NULL, -- Oracle maneja mejor el formato texto o DATE para horarios específicos
    dia_semana VARCHAR2(15) NOT NULL,
    capacidad_max NUMBER DEFAULT 20,
    CONSTRAINT fk_clase_instructor FOREIGN KEY (id_instructor) REFERENCES instructores(id_instructor) ON DELETE SET NULL,
    CONSTRAINT check_dia CHECK (dia_semana IN ('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'))
);

-- Registro de inscripción
CREATE TABLE clases_registro (
    id_registro NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio NUMBER NOT NULL,
    id_clase NUMBER NOT NULL,
    fecha_inscripcion DATE DEFAULT SYSDATE,
    CONSTRAINT fk_reg_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE,
    CONSTRAINT fk_reg_clase FOREIGN KEY (id_clase) REFERENCES clases(id_clase) ON DELETE CASCADE,
    CONSTRAINT unq_socio_clase UNIQUE (id_socio, id_clase)
);

-- Control financiero
CREATE TABLE pagos (
    id_pago NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio NUMBER NOT NULL,
    monto NUMBER(10,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_pago_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE,
    CONSTRAINT check_metodo CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia'))
);

-- Control de acceso
CREATE TABLE asistencia (
    id_asistencia NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_socio NUMBER NOT NULL,
    fecha_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_asistencia_socio FOREIGN KEY (id_socio) REFERENCES socios(id_socio) ON DELETE CASCADE
);

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------

-- Membresías
INSERT INTO membresias (nombre, precio, duracion_dias, descripcion) VALUES ('Básica', 29.90, 30, 'Acceso a sala de máquinas');
INSERT INTO membresias (nombre, precio, duracion_dias, descripcion) VALUES ('Premium', 45.00, 30, 'Máquinas + Clases grupales');
INSERT INTO membresias (nombre, precio, duracion_dias, descripcion) VALUES ('Anual VIP', 450.00, 365, 'Todo incluido pago anual');

-- Instructores
INSERT INTO instructores (nombre, especialidad, salario_hora) VALUES ('Marta Sánchez', 'Yoga', 25.00);
INSERT INTO instructores (nombre, especialidad, salario_hora) VALUES ('Ricardo Tormo', 'Crossfit', 30.00);
INSERT INTO instructores (nombre, especialidad, salario_hora) VALUES ('Sonia Monroy', 'Zumba', 22.00);
INSERT INTO instructores (nombre, especialidad, salario_hora) VALUES ('Julián Expósito', 'Musculación', 18.00);

-- Clases
INSERT INTO clases (nombre, id_instructor, horario, dia_semana) VALUES ('Yoga Flow', 1, '09:00', 'Lunes');
INSERT INTO clases (nombre, id_instructor, horario, dia_semana) VALUES ('Crossfit', 2, '18:30', 'Martes');
INSERT INTO clases (nombre, id_instructor, horario, dia_semana) VALUES ('Zumba', 3, '20:00', 'Viernes');
INSERT INTO clases (nombre, id_instructor, horario, dia_semana) VALUES ('Spinning', 4, '08:00', 'Miércoles');

-- Inserción de 40 Socios (Usando un bloque anónimo para rapidez)
BEGIN
    FOR i IN 1..40 LOOP
        INSERT INTO socios (nombre, apellidos, dni, email, id_membresia, estado)
        VALUES ('Socio_' || i, 'Apellido_' || i, 'DNI' || i || 'X', 'correo' || i || '@gym.com', 
                MOD(i, 3) + 1, 'Activo');
    END LOOP;
END;
/

-- 4. CARGA MASIVA DE DATOS RELACIONADOS (150+ registros)
-- -----------------------------------------------------------------------------

-- Generar 100 Pagos (Simulando 3 meses de cuotas para los socios)
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO pagos (id_socio, monto, fecha_pago, metodo_pago)
        VALUES (
            MOD(i, 40) + 1, 
            CASE WHEN MOD(i, 3) = 0 THEN 450.00 ELSE 35.00 END, 
            SYSDATE - MOD(i, 90), 
            CASE WHEN MOD(i, 2) = 0 THEN 'Tarjeta' ELSE 'Efectivo' END
        );
    END LOOP;
END;
/

-- Generar 150 Asistencias (Simulando entradas aleatorias en los últimos 15 días)
BEGIN
    FOR i IN 1..150 LOOP
        INSERT INTO asistencia (id_socio, fecha_entrada)
        VALUES (
            MOD(i, 40) + 1, 
            SYSDATE - (MOD(i, 15) + (i/240))
        );
    END LOOP;
END;
/

-- Registro de Clases (Inscribir socios a clases aleatoriamente)
BEGIN
    FOR i IN 1..30 LOOP
        BEGIN
            INSERT INTO clases_registro (id_socio, id_clase)
            VALUES (i, MOD(i, 4) + 1);
        EXCEPTION WHEN OTHERS THEN NULL; -- Evitar errores por el UNIQUE si se repite
        END;
    END LOOP;
END;
/

COMMIT;

-- 5. CONSULTAS DE PRUEBA PARA ORACLE
-- -----------------------------------------------------------------------------

-- A. Conteo de registros para verificar volumen
SELECT 'Socios' como_tabla, COUNT(*) total FROM socios
UNION ALL
SELECT 'Pagos', COUNT(*) FROM pagos
UNION ALL
SELECT 'Asistencias', COUNT(*) FROM asistencia;

-- B. Top 5 socios que más han pagado (Uso de sintaxis Oracle 12c FETCH)
SELECT s.nombre, s.apellidos, SUM(p.monto) as total_invertido
FROM socios s
JOIN pagos p ON s.id_socio = p.id_socio
GROUP BY s.nombre, s.apellidos
ORDER BY total_invertido DESC
FETCH FIRST 5 ROWS ONLY;

-- C. Ocupación de clases
SELECT c.nombre, COUNT(r.id_registro) as inscritos, c.capacidad_max
FROM clases c
LEFT JOIN clases_registro r ON c.id_clase = r.id_clase
GROUP BY c.nombre, c.capacidad_max;