-- Ejecutar como SYSTEM o ADMIN
-- 1. Crear el "contenedor" (Usuario/Esquema)
CREATE USER biblioteca IDENTIFIED BY password123;

-- 2. Darle espacio para guardar datos
ALTER USER biblioteca QUOTA UNLIMITED ON USERS;

-- 3. Darle permisos para conectarse y crear cosas
GRANT CONNECT, RESOURCE TO biblioteca;

-- 4. Ahora te conectas como ese usuario y ejecutas el script de las tablas
-- CONNECT biblioteca/password123;