-- =============================================================================
-- SISTEMA DE GESTIÓN CLÍNICA (Versión Oracle XE)
-- Oracle XE (18c, 21c, 23c)
-- Autor: Efrén Sánchez
-- =============================================================================

-- 1. LIMPIEZA DE TABLAS (Bloque PL/SQL para evitar errores si no existen)
-- -----------------------------------------------------------------------------
BEGIN
   FOR rec IN (SELECT table_name FROM user_tables WHERE table_name IN 
    ('RECETAS', 'MEDICAMENTOS', 'DIAGNOSTICOS', 'CITAS', 'MEDICOS', 'ESPECIALIDADES', 'PACIENTES'))
   LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
   END LOOP;
END;
/

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE pacientes (
    id_paciente      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR2(50) NOT NULL,
    apellidos        VARCHAR2(100) NOT NULL,
    dni              VARCHAR2(15) UNIQUE NOT NULL,
    fecha_nac        DATE NOT NULL,
    genero           VARCHAR2(10) NOT NULL,
    telefono         VARCHAR2(20),
    email            VARCHAR2(100),
    direccion        VARCHAR2(150),
    grupo_sanguineo  VARCHAR2(5),
    CONSTRAINT ck_genero CHECK (genero IN ('M', 'F', 'Otro')),
    CONSTRAINT ck_sangre CHECK (grupo_sanguineo IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'))
);

CREATE TABLE especialidades (
    id_especialidad  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR2(50) NOT NULL,
    descripcion      VARCHAR2(4000)
);

CREATE TABLE medicos (
    id_medico        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR2(50) NOT NULL,
    apellidos        VARCHAR2(100) NOT NULL,
    licencia_medica  VARCHAR2(20) UNIQUE NOT NULL,
    id_especialidad  NUMBER NOT NULL,
    telefono         VARCHAR2(20),
    email            VARCHAR2(100),
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad)
);

CREATE TABLE citas (
    id_cita          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_paciente      NUMBER NOT NULL,
    id_medico        NUMBER NOT NULL,
    fecha_cita       TIMESTAMP NOT NULL,
    motivo_consulta  VARCHAR2(255),
    estado           VARCHAR2(20) DEFAULT 'Programada',
    costo_consulta   NUMBER(10,2) DEFAULT 0.00,
    CONSTRAINT ck_estado_cita CHECK (estado IN ('Programada', 'Completada', 'Cancelada', 'No asistió')),
    CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

CREATE TABLE diagnosticos (
    id_diagnostico       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cita              NUMBER UNIQUE NOT NULL,
    observaciones        CLOB NOT NULL,
    diagnostico_principal VARCHAR2(255) NOT NULL,
    fecha_registro       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_diag_cita FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
);

CREATE TABLE medicamentos (
    id_medicamento     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_comercial   VARCHAR2(100) NOT NULL,
    componente_activo  VARCHAR2(100),
    presentacion       VARCHAR2(50)
);

CREATE TABLE recetas (
    id_receta        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_diagnostico   NUMBER NOT NULL,
    id_medicamento   NUMBER NOT NULL,
    posologia        VARCHAR2(255) NOT NULL,
    cantidad         NUMBER DEFAULT 1,
    CONSTRAINT fk_receta_diag FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos(id_diagnostico),
    CONSTRAINT fk_receta_med FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------

-- Especialidades
INSERT INTO especialidades (nombre, descripcion) VALUES ('Medicina General', 'Atención primaria');
INSERT INTO especialidades (nombre, descripcion) VALUES ('Cardiología', 'Corazón y sistema circulatorio');
INSERT INTO especialidades (nombre, descripcion) VALUES ('Pediatría', 'Atención infantil');
INSERT INTO especialidades (nombre, descripcion) VALUES ('Dermatología', 'Piel y mucosas');
INSERT INTO especialidades (nombre, descripcion) VALUES ('Traumatología', 'Sistema locomotor');
INSERT INTO especialidades (nombre, descripcion) VALUES ('Oftalmología', 'Salud ocular');
INSERT INTO especialidades (nombre, descripcion) VALUES ('Psiquiatría', 'Salud mental');
INSERT INTO especialidades (nombre, descripcion) VALUES ('Neurología', 'Sistema nervioso');

-- Médicos
INSERT INTO medicos (nombre, apellidos, licencia_medica, id_especialidad, email) VALUES ('Andrés', 'Sarmiento', 'MED-1010', 1, 'andres@clinica.com');
INSERT INTO medicos (nombre, apellidos, licencia_medica, id_especialidad, email) VALUES ('Beatriz', 'Lugo', 'MED-2020', 2, 'beatriz@clinica.com');
INSERT INTO medicos (nombre, apellidos, licencia_medica, id_especialidad, email) VALUES ('Carlos', 'Díaz', 'MED-3030', 3, 'carlos@clinica.com');
INSERT INTO medicos (nombre, apellidos, licencia_medica, id_especialidad, email) VALUES ('Elena', 'Rivas', 'MED-4040', 4, 'elena@clinica.com');
INSERT INTO medicos (nombre, apellidos, licencia_medica, id_especialidad, email) VALUES ('Hugo', 'Torres', 'MED-7070', 6, 'hugo@clinica.com');

-- Inserción masiva de Pacientes (Bloque PL/SQL para llegar a 50 rápido)
BEGIN
   FOR i IN 1..50 LOOP
      INSERT INTO pacientes (nombre, apellidos, dni, fecha_nac, genero, grupo_sanguineo)
      VALUES ('Paciente_' || i, 'Apellido_' || i, 10000000 + i || 'X', 
              TO_DATE('1970-01-01', 'YYYY-MM-DD') + (i * 365 / 2), 
              CASE WHEN MOD(i, 2) = 0 THEN 'M' ELSE 'F' END, 'O+');
   END LOOP;
END;
/

-- Medicamentos
INSERT INTO medicamentos (nombre_comercial, componente_activo, presentacion) VALUES ('Paracetamol', 'Acetaminofén', '500mg');
INSERT INTO medicamentos (nombre_comercial, componente_activo, presentacion) VALUES ('Ibuprofeno', 'Ibuprofeno', '600mg');
INSERT INTO medicamentos (nombre_comercial, componente_activo, presentacion) VALUES ('Amoxicilina', 'Antibiótico', '1g');
INSERT INTO medicamentos (nombre_comercial, componente_activo, presentacion) VALUES ('Omeprazol', 'Protector', '20mg');

-- Inserción masiva de Citas (150 registros)
BEGIN
   FOR i IN 1..150 LOOP
      INSERT INTO citas (id_paciente, id_medico, fecha_cita, motivo_consulta, estado, costo_consulta)
      VALUES (
         MOD(i, 50) + 1, 
         MOD(i, 5) + 1, 
         TO_TIMESTAMP('2023-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS') + i,
         'Consulta número ' || i,
         CASE WHEN i <= 120 THEN 'Completada' ELSE 'Programada' END,
         50.00
      );
   END LOOP;
END;
/

-- Inserción de Diagnósticos para las citas completadas
BEGIN
   FOR i IN 1..120 LOOP
      INSERT INTO diagnosticos (id_cita, observaciones, diagnostico_principal)
      VALUES (i, 'El paciente presenta síntomas leves. Evolución favorable.', 'Gripe común o chequeo');
   END LOOP;
END;
/

-- Inserción de Recetas (100 registros)
BEGIN
   FOR i IN 1..100 LOOP
      INSERT INTO recetas (id_diagnostico, id_medicamento, posologia, cantidad)
      VALUES (i, MOD(i, 4) + 1, 'Cada 8 horas por 5 días', 1);
   END LOOP;
END;
/

COMMIT;

-- 4. CONSULTAS DE EJEMPLO ADAPTADAS A ORACLE
-- -----------------------------------------------------------------------------

-- A. Agenda del día (Próximas 10 citas)
SELECT * FROM (
    SELECT c.fecha_cita, p.nombre AS paciente, m.nombre AS medico, e.nombre AS especialidad
    FROM citas c
    JOIN pacientes p ON c.id_paciente = p.id_paciente
    JOIN medicos m ON c.id_medico = m.id_medico
    JOIN especialidades e ON m.id_especialidad = e.id_especialidad
    WHERE c.estado = 'Programada'
    ORDER BY c.fecha_cita ASC
) WHERE ROWNUM <= 10;

-- B. Historial: Pacientes con su edad (Cálculo de edad en Oracle)
SELECT nombre, apellidos, 
       FLOOR(MONTHS_BETWEEN(SYSDATE, fecha_nac) / 12) AS edad
FROM pacientes
WHERE ROWNUM <= 10;

-- C. Reporte de ingresos por especialidad
SELECT e.nombre AS especialidad, SUM(c.costo_consulta) AS ingresos
FROM especialidades e
JOIN medicos m ON e.id_especialidad = m.id_especialidad
JOIN citas c ON m.id_medico = c.id_medico
WHERE c.estado = 'Completada'
GROUP BY e.nombre;