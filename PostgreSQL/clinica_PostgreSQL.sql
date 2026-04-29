-- =============================================================================
-- SISTEMA DE GESTIÓN CLÍNICA 
-- PostgreSQL
-- Autor: Efrén Sánchez
-- =============================================================================

-- 1. LIMPIEZA DE TABLAS
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS recetas CASCADE;
DROP TABLE IF EXISTS medicamentos CASCADE;
DROP TABLE IF EXISTS diagnosticos CASCADE;
DROP TABLE IF EXISTS citas CASCADE;
DROP TABLE IF EXISTS medicos CASCADE;
DROP TABLE IF EXISTS especialidades CASCADE;
DROP TABLE IF EXISTS pacientes CASCADE;

-- 2. DEFINICIÓN DEL ESQUEMA (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE pacientes (
    id_paciente      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR(50) NOT NULL,
    apellidos        VARCHAR(100) NOT NULL,
    dni              VARCHAR(15) UNIQUE NOT NULL,
    fecha_nac        DATE NOT NULL,
    genero           VARCHAR(10) NOT NULL CHECK (genero IN ('M', 'F', 'Otro')),
    telefono         VARCHAR(20),
    email            VARCHAR(100),
    direccion        VARCHAR(150),
    grupo_sanguineo  VARCHAR(5) CHECK (grupo_sanguineo IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'))
);

CREATE TABLE especialidades (
    id_especialidad  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR(50) NOT NULL,
    descripcion      TEXT
);

CREATE TABLE medicos (
    id_medico        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre           VARCHAR(50) NOT NULL,
    apellidos        VARCHAR(100) NOT NULL,
    licencia_medica  VARCHAR(20) UNIQUE NOT NULL,
    id_especialidad  INT NOT NULL,
    telefono         VARCHAR(20),
    email            VARCHAR(100),
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidades(id_especialidad)
);

CREATE TABLE citas (
    id_cita          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_paciente      INT NOT NULL,
    id_medico        INT NOT NULL,
    fecha_cita       TIMESTAMP NOT NULL,
    motivo_consulta  VARCHAR(255),
    estado           VARCHAR(20) DEFAULT 'Programada' CHECK (estado IN ('Programada', 'Completada', 'Cancelada', 'No asistió')),
    costo_consulta   DECIMAL(10,2) DEFAULT 0.00,
    CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

CREATE TABLE diagnosticos (
    id_diagnostico       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cita              INT UNIQUE NOT NULL,
    observaciones        TEXT NOT NULL,
    diagnostico_principal VARCHAR(255) NOT NULL,
    fecha_registro       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_diag_cita FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
);

CREATE TABLE medicamentos (
    id_medicamento     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_comercial   VARCHAR(100) NOT NULL,
    componente_activo  VARCHAR(100),
    presentacion       VARCHAR(50)
);

CREATE TABLE recetas (
    id_receta        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_diagnostico   INT NOT NULL,
    id_medicamento   INT NOT NULL,
    posologia        VARCHAR(255) NOT NULL,
    cantidad         INT DEFAULT 1 CHECK (cantidad > 0),
    CONSTRAINT fk_receta_diag FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos(id_diagnostico),
    CONSTRAINT fk_receta_med FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);

-- 3. CARGA DE DATOS (DML)
-- -----------------------------------------------------------------------------
DO $$
DECLARE
    i INT;
    v_paciente_id INT;
    v_medico_id INT;
    v_cita_id INT;
    v_diag_id INT;
    -- Arrays para datos "aleatorios"
    nombres TEXT[] := ARRAY['Juan', 'Maria', 'Pedro', 'Ana', 'Luis', 'Elena', 'Diego', 'Carmen', 'Pablo', 'Lucia'];
    apellidos TEXT[] := ARRAY['Garcia', 'Martinez', 'Lopez', 'Sanchez', 'Perez', 'Gomez', 'Martin', 'Jimenez', 'Ruiz', 'Hernandez'];
    especialidades_lista TEXT[] := ARRAY['Medicina General', 'Cardiología', 'Pediatría', 'Dermatología', 'Traumatología', 'Ginecología', 'Neurología', 'Oftalmología'];
BEGIN
    -- 1. Insertar Especialidades
    FOR i IN 1..8 LOOP
        INSERT INTO especialidades (nombre, descripcion) 
        VALUES (especialidades_lista[i], 'Departamento especializado en ' || especialidades_lista[i]);
    END LOOP;

    -- 2. Insertar Médicos (15)
    FOR i IN 1..15 LOOP
        INSERT INTO medicos (nombre, apellidos, licencia_medica, id_especialidad, email)
        VALUES (
            nombres[(random()*9)+1], 
            apellidos[(random()*9)+1], 
            'LIC-' || (1000 + i), 
            (i % 8) + 1, 
            'medico' || i || '@clinica.com'
        );
    END LOOP;

    -- 3. Insertar Pacientes (50)
    FOR i IN 1..50 LOOP
        INSERT INTO pacientes (nombre, apellidos, dni, fecha_nac, genero, grupo_sanguineo)
        VALUES (
            nombres[(random()*9)+1], 
            apellidos[(random()*9)+1], 
            (10000000 + i) || 'Z', 
            '1970-01-01'::DATE + (random() * 18000)::INT, 
            (CASE WHEN random() > 0.5 THEN 'M' ELSE 'F' END)::VARCHAR,
            (ARRAY['A+', 'O+', 'B-', 'AB+'])[(random()*3)+1]
        );
    END LOOP;

    -- 4. Insertar Medicamentos (15)
    INSERT INTO medicamentos (nombre_comercial, componente_activo, presentacion) VALUES
    ('Paracetamol', 'Acetaminofén', 'Tabletas 500mg'),
    ('Ibuprofeno', 'Ibuprofeno', 'Cápsulas 600mg'),
    ('Amoxicilina', 'Amoxicilina', 'Sobres 1g'),
    ('Omeprazol', 'Omeprazol', 'Cápsulas 20mg'),
    ('Ventolin', 'Salbutamol', 'Inhalador'),
    ('Ebastina', 'Ebastina', 'Tabletas 10mg'),
    ('Nolotil', 'Metamizol', 'Cápsulas 575mg'),
    ('Voltaren', 'Diclofenaco', 'Gel 60g');

    -- 5. Insertar Citas (150 registros)
    FOR i IN 1..150 LOOP
        INSERT INTO citas (id_paciente, id_medico, fecha_cita, motivo_consulta, estado, costo_consulta)
        VALUES (
            (random() * 49 + 1)::INT,
            (random() * 14 + 1)::INT,
            '2023-01-01'::TIMESTAMP + (random() * interval '450 days'),
            'Consulta recurrente ' || i,
            (CASE 
                WHEN i <= 110 THEN 'Completada' 
                WHEN i <= 130 THEN 'Programada' 
                ELSE 'Cancelada' 
            END)::VARCHAR,
            (40 + (random() * 60))::DECIMAL
        ) RETURNING id_cita INTO v_cita_id;

        -- 6. Para cada cita completada, crear diagnóstico y receta
        IF i <= 110 THEN
            INSERT INTO diagnosticos (id_cita, observaciones, diagnostico_principal)
            VALUES (v_cita_id, 'Paciente presenta mejoría tras examen físico.', 'Gripe común o revisión')
            RETURNING id_diagnostico INTO v_diag_id;

            -- Crear 1 o 2 recetas por diagnóstico
            INSERT INTO recetas (id_diagnostico, id_medicamento, posologia)
            VALUES (v_diag_id, (random() * 7 + 1)::INT, '1 cada 8 horas por 5 días');
        END IF;
    END LOOP;

END $$;

-- 4. CONSULTAS DE PRUEBA
-- -----------------------------------------------------------------------------

-- A. Top 5 médicos con más pacientes atendidos
SELECT m.nombre, m.apellidos, COUNT(c.id_cita) as total_citas
FROM medicos m
JOIN citas c ON m.id_medico = c.id_medico
WHERE c.estado = 'Completada'
GROUP BY m.id_medico, m.nombre, m.apellidos
ORDER BY total_citas DESC
LIMIT 5;

-- B. Ver medicamentos recetados a pacientes mayores de 60 años
SELECT p.nombre, p.apellidos, EXTRACT(YEAR FROM AGE(p.fecha_nac)) as edad, med.nombre_comercial
FROM pacientes p
JOIN citas c ON p.id_paciente = c.id_paciente
JOIN diagnosticos d ON c.id_cita = d.id_cita
JOIN recetas r ON d.id_diagnostico = r.id_diagnostico
JOIN medicamentos med ON r.id_medicamento = med.id_medicamento
WHERE EXTRACT(YEAR FROM AGE(p.fecha_nac)) > 60;

-- C. Reporte de facturación por mes (solo citas completadas)
SELECT date_trunc('month', fecha_cita) as mes, SUM(costo_consulta) as total
FROM citas
WHERE estado = 'Completada'
GROUP BY mes
ORDER BY mes;