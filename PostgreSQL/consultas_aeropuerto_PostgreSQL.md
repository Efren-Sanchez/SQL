# Consultas SQL sobre la BD de 'aeropuerto'

## Enunciados

### BLOQUE 1: Consultas Básicas y Filtros (1-20)

1. Seleccionar todos los campos de la tabla pasajeros.
2. Obtener solo el nombre y apellidos de todos los pasajeros.
3. Mostrar los nombres de las ciudades donde hay aeropuertos.
4. Listar las aerolíneas y su país de origen.
5. Seleccionar los pasajeros de nacionalidad 'España'.
6. Mostrar los vuelos cuyo precio_base sea exactamente 500.
7. Listar los aviones con capacidad superior a 300 pasajeros.
8. Mostrar los aeropuertos que no están en 'España'.
9. Obtener los vuelos con estado 'Cancelado'.
10. Mostrar los pasajeros cuyo id_pasajero sea menor que 50.
11. Listar las aerolíneas cuyo nombre contenga la palabra 'Air'.
12. Mostrar los vuelos que salen del aeropuerto con ID 1.
13. Obtener los tipos de equipaje disponibles sin repetir.
14. Listar las reservas realizadas en la clase 'Business'.
15. Mostrar los pasajeros que tienen un pasaporte que empieza por 'P'.
16. Seleccionar los vuelos con precio base menor o igual a 150.
17. Mostrar los aviones cuyo modelo contenga 'Boeing'.
18. Listar aeropuertos cuyo código IATA tenga exactamente 3 caracteres.
19. Mostrar los pasajeros cuyo teléfono termine en '9'.
20. Obtener los vuelos programados para después del mediodía (12:00:00).

### BLOQUE 2: Ordenación, Límites y Operadores (21-40)

21. Listar pasajeros alfabéticamente por apellidos y luego por nombre.
22. Mostrar los 10 vuelos más caros.
23. Mostrar los 5 aviones con menos capacidad.
24. Listar las aerolíneas ordenadas por país descendentemente.
25. Obtener los pasajeros con ID entre 100 y 200 (usando BETWEEN).
26. Listar vuelos que salen en los meses de junio, julio o agosto (usando IN).
27. Mostrar pasajeros de nacionalidad 'Francia', 'Italia' o 'Portugal'.
28. Seleccionar vuelos cuyo precio base esté entre 50 y 150 euros.
29. Mostrar los 3 primeros aeropuertos registrados en la base de datos.
30. Listar pasajeros saltando los 50 primeros y mostrando los siguientes 10.
31. Mostrar vuelos con estado 'Programado' o 'En Vuelo'.
32. Listar pasajeros que NO son de 'España' ni de 'México'.
33. Mostrar aeropuertos cuya ciudad empiece por 'M' y termine por 'd'.
34. Listar aerolíneas cuyo código IATA sea 'IBE', 'UAE' o 'RYR'.
35. Mostrar vuelos ordenados por fecha_salida de más antiguo a más reciente.
36. Seleccionar los 5 equipajes más pesados.
37. Mostrar pasajeros cuyo apellido contenga una doble 's' (como en "Rossi").
38. Listar vuelos cuya llegada sea el mismo día que la salida.
39. Mostrar aeropuertos ordenados por país y luego por nombre de aeropuerto.
40. Seleccionar las 10 reservas más recientes según la fecha_reserva.

### BLOQUE 3: Funciones de Cadena, Matemáticas y Fechas (41-60)

41. Mostrar el nombre de los pasajeros en mayúsculas y apellidos en minúsculas.
42. Calcular la longitud de los nombres de todos los aeropuertos.
43. Concatenar la ciudad y el país del aeropuerto con un guion: "Madrid - España".
44. Redondear el precio_base de los vuelos al entero más cercano.
45. Mostrar el número de vuelo y solo los 2 primeros caracteres de su código IATA.
46. Obtener el día de la semana de todas las fechas de salida de los vuelos.
47. Calcular la diferencia en horas entre la salida y la llegada de los vuelos.
48. Mostrar la fecha actual del sistema.
49. Extraer el año de la fecha de reserva de cada pasaje.
50. Reemplazar todos los espacios en los nombres de aviones por guiones bajos.
51. Mostrar los apellidos de los pasajeros y cuántas letras tienen.
52. Formatear el precio base para que aparezca con el símbolo '€' concatenado.
53. Obtener el trimestre (quarter) en el que se realizó cada reserva.  
54. Calcular el valor absoluto de la diferencia entre el precio base y 500.  
55. Mostrar los correos electrónicos de los pasajeros sustituyendo 'gmail.com' por 'aeropuerto.es'.
56. Mostrar la fecha de salida en formato 'Día dd de Mes de yyyy'.
57. Obtener la hora de salida de los vuelos sin los minutos ni segundos.
58. Calcular la raíz cuadrada de la capacidad de los aviones (ejercicio     matemático).
59. Mostrar los nombres de los pasajeros quitando los posibles espacios en     blanco al principio o final.
60. Obtener cuántos días han pasado desde que se realizó cada reserva hasta hoy.

### BLOQUE 4: Agregación y Agrupamiento (61-80)

61. Contar el número total de pasajeros registrados.
62. Calcular el precio medio de todos los vuelos.
63. Obtener la suma total de todos los precios finales de las reservas.
64. Encontrar la capacidad máxima de la flota de aviones.
65. Mostrar el peso mínimo de un equipaje de tipo 'Bodega'.
66. Contar cuántos pasajeros hay por cada nacionalidad.
67. Calcular el ingreso total obtenido por cada aerolínea (según la tabla vuelos).
68. Mostrar el número de vuelos destinados a cada ciudad.
69. Calcular el promedio de peso del equipaje por cada reserva.
70. Contar cuántos aviones tiene cada aerolínea.
71. Mostrar el precio base más alto y más bajo por cada estado de vuelo.
72. Contar cuántas reservas se han hecho en cada clase (Turista, Business, Primera).
73. Calcular la capacidad total de pasajeros de toda la flota de 'Iberia'.
74. Obtener el número de aeropuertos que hay en cada país.
75. Mostrar cuántos vuelos hay programados por cada mes.
76. Calcular la suma del peso de equipaje por tipo ('Mano' vs 'Bodega').
77. Contar cuántos pasajeros tienen el mismo nombre.
78. Obtener el precio medio de las reservas realizadas en el último mes.
79. Mostrar el número de vuelos realizados por cada avión (ID_avion).
80. Calcular el total de impuestos (simulado como el 21% del precio base) de
    todos los vuelos.

### BLOQUE 5: Filtros de Grupo y Joins Básicos (81-100)

81. Mostrar las nacionalidades con más de 50 pasajeros.
82. Listar las aerolíneas que tienen más de 5 aviones.
83. Mostrar los destinos que han recibido más de 10 vuelos.
84. Listar los meses en los que se han realizado más de 100 reservas.
85. Mostrar los pasajeros que han gastado más de 3000€ en total.
86. Obtener el nombre del pasajero y el número de vuelo para cada reserva.
87. Listar todos los vuelos junto con el nombre de la aerolínea que los opera.
88. Mostrar los aviones y el nombre de su aerolínea propietaria.
89. Obtener el origen y destino (nombres de ciudades) de cada vuelo.
90. Listar las reservas mostrando el nombre del pasajero y el asiento.
91. Mostrar el equipaje junto con el ID de la reserva y el nombre del pasajero.
92. Listar vuelos operados con aviones de capacidad mayor a 200, mostrando el modelo.
93. Mostrar el historial de vuelos de un pasajero específico (nombre y apellidos).
94. Obtener la lista de pasajeros que vuelan en clase 'Primera'.
95. Listar aerolíneas y el nombre de los aeropuertos de su país de origen.
96. Mostrar las reservas realizadas para vuelos que salen de 'Madrid'.
97. Listar los modelos de avión utilizados por la aerolínea 'Emirates'.
98. Mostrar cuántas maletas lleva cada pasajero en un vuelo determinado.
99. Obtener el precio final de las reservas junto con el nombre de la aerolínea.
100. Listar los pasajeros que vuelan hoy (comparando fecha de salida con fecha actual).

### BLOQUE 6: Joins Avanzados y lógica de negocio (101-120)

101. Informe completo: Pasajero, Vuelo, Origen, Destino, Aerolínea y Modelo de
     Avión.
102. Mostrar los pasajeros que nunca han registrado una maleta de bodega.
103. Listar aeropuertos que no han tenido vuelos de salida todavía (LEFT JOIN).
104. Calcular el peso total de equipaje transportado por cada aerolínea.
105. Mostrar el nombre del pasajero que más ha pagado por una reserva.
106. Listar los aviones que están actualmente "En Vuelo" y su aerolínea.
107. Mostrar los pares de aeropuertos que están conectados por vuelos directos.
108. Obtener los pasajeros que han viajado con más de una aerolínea distinta.
109. Listar las aerolíneas y su beneficio total (suma de precio final de reservas).
110. Mostrar los aeropuertos de destino de los pasajeros de nacionalidad 'Japón'.
111. Obtener los nombres de pasajeros que comparten el mismo número de asiento en diferentes vuelos.
112. Mostrar los vuelos que van a un país diferente al país de la aerolínea.
113. Listar los pasajeros y el total que han pagado incluyendo un recargo de 20€ por maleta de bodega.
114. Mostrar qué aerolínea es la que más vuelos tiene en estado 'Retrasado'.
115. Obtener los nombres de pasajeros y sus aerolíneas favoritas (con las que más han volado).
116. Listar todos los aviones y, si han volado, mostrar la fecha del último vuelo.
117. Mostrar los ingresos por clase (Turista/Business) para la aerolínea 'Lufthansa'.
118. Listar los pasajeros cuya maleta supera el peso medio de equipaje del vuelo.
119. Mostrar la ruta (Origen-Destino) más rentable (mayor suma de precio_final).
120. Obtener los pasajeros que tienen reservas en vuelos que salen del mismo aeropuerto que su nacionalidad.

### BLOQUE 7: Subconsultas y Operaciones de Conjunto (121-140)

121. Mostrar los vuelos cuyo precio base es mayor que el precio medio de todos los vuelos.
122. Listar los pasajeros que han realizado más reservas que el pasajero con ID 1.
123. Mostrar los nombres de aerolíneas que tienen aviones con capacidad mayor a la capacidad media global.
124. Obtener los vuelos que salen del aeropuerto con más tráfico de salidas.
125. Listar pasajeros que han volado al menos una vez a 'Nueva York' (usando subconsulta).
126. Mostrar las aerolíneas que no operan ningún vuelo con el modelo 'Airbus A380'.
127. Seleccionar los pasajeros que han pagado por su reserva más que la media de su mismo vuelo.
128. Obtener los vuelos cuyo avión es el más grande de su respectiva aerolínea.
129. Mostrar los nombres de pasajeros que aparecen también como contacto de emergencia (suponiendo una tabla externa o lógica de nombres iguales).
130. Listar los aeropuertos que son tanto origen como destino en el mismo día.
131. Usar UNION para obtener una lista única de todas las ciudades (origen y destino).
132. Obtener los pasajeros que han volado con todas las aerolíneas disponibles (Relacional DIVIDE - Simulación con COUNT DISTINCT).
133. Mostrar el segundo vuelo más caro (usando subconsulta y LIMIT).
134. Listar las reservas cuyo precio final es menor que el precio base del vuelo (ofertas).
135. Seleccionar aeropuertos que tienen vuelos a 'Londres' pero no a 'París' en la misma fecha (EXCEPT o NOT IN).
136. Mostrar los pasajeros que han reservado en el mismo vuelo que el pasajero 'Julian Ross'.
137. Obtener las aerolíneas cuyo promedio de precio de vuelo es menor que el de 'Iberia'.
138. Listar los aviones cuyo ID no aparece en la tabla de vuelos (NOT EXISTS). 
139. Mostrar el nombre de los pasajeros y el número de maletas mediante una subconsulta en el SELECT.
140. Obtener los vuelos que tienen una ocupación superior al 80% (Subconsulta comparando reservas y capacidad_pasajeros).

### BLOQUE 8: DML Avanzado y Transacciones (141-150)

141. Update Masivo: Subir un 5% el precio de todos los vuelos de una aerolínea específica.
142. Update con Join: Cambiar el estado a 'Retrasado' de todos los vuelos que aterrizan en un país en huelga (ej. 'Francia'). 
143. Delete Lógico: Borrar (eliminar) las reservas de pasajeros que no han pagado (precio_final = 0).
144. Insert Select: Crear una tabla 'Pasajeros_VIP' e insertar en ella a todos los que han gastado más de 5000€.
145. Transacción de Reserva: Iniciar transacción, restar 1 a la capacidad (simulado), insertar reserva, insertar equipaje y hacer COMMIT.
146. Rollback: Iniciar una inserción de vuelo, detectar un error de fecha y deshacer los cambios con ROLLBACK.
147. Savepoint: En una transacción larga de carga de datos, crear un punto de control tras insertar aerolíneas antes de insertar aviones.
148. Creación de Vista: Crear una vista llamada v_tablon_anuncios que muestre Vuelo, Aerolínea, Hora y Estado.
149. Mantenimiento: Eliminar todos los aviones de aerolíneas que ya no existen en la tabla aerolineas (Integridad referencial manual).
150. Seguridad: Crear una consulta que concatene el pasaporte ocultando los últimos 4 caracteres con asteriscos (ej. 'AB12****').


## Soluciones

### Versión reducida



### Versión expandida

Aquí tienes las 150 soluciones para **PostgreSQL**, estructuradas con cada cláusula en una línea independiente para facilitar su lectura:

### BLOQUE 1: Consultas Básicas y Filtros (1-20)

1.
```sql
SELECT *
FROM pasajeros;
```
2.
```sql
SELECT nombre, apellidos
FROM pasajeros;
```
3.
```sql
SELECT DISTINCT ciudad
FROM aeropuertos;
```
4.
```sql
SELECT nombre, pais_origen
FROM aerolineas;
```
5.
```sql
SELECT *
FROM pasajeros
WHERE nacionalidad = 'España';
```
6.
```sql
SELECT *
FROM vuelos
WHERE precio_base = 500;
```
7.
```sql
SELECT *
FROM aviones
WHERE capacidad_pasajeros > 300;
```
8.
```sql
SELECT *
FROM aeropuertos
WHERE pais <> 'España';
```
9.
```sql
SELECT *
FROM vuelos
WHERE estado = 'Cancelado';
```
10.
```sql
SELECT *
FROM pasajeros
WHERE id_pasajero < 50;
```
11.
```sql
SELECT *
FROM aerolineas
WHERE nombre LIKE '%Air%';
```
12.
```sql
SELECT *
FROM vuelos
WHERE id_origen = 1;
```
13.
```sql
SELECT DISTINCT tipo
FROM equipaje;
```
14.
```sql
SELECT *
FROM reservas
WHERE clase = 'Business';
```
15.
```sql
SELECT *
FROM pasajeros
WHERE pasaporte LIKE 'P%';
```
16.
```sql
SELECT *
FROM vuelos
WHERE precio_base <= 150;
```
17.
```sql
SELECT *
FROM aviones
WHERE modelo LIKE '%Boeing%';
```
18.
```sql
SELECT *
FROM aeropuertos
WHERE LENGTH(codigo_iata) = 3;
```
19.
```sql
SELECT *
FROM pasajeros
WHERE telefono LIKE '%9';
```
20.
```sql
SELECT *
FROM vuelos
WHERE fecha_salida::time > '12:00:00';
```

---

### BLOQUE 2: Ordenación, Límites y Operadores (21-40)

21.
```sql
SELECT *
FROM pasajeros
ORDER BY apellidos ASC, nombre ASC;
```
22.
```sql
SELECT *
FROM vuelos
ORDER BY precio_base DESC
LIMIT 10;
```
23.
```sql
SELECT *
FROM aviones
ORDER BY capacidad_pasajeros ASC
LIMIT 5;
```
24.
```sql
SELECT *
FROM aerolineas
ORDER BY pais_origen DESC;
```
25.
```sql
SELECT *
FROM pasajeros
WHERE id_pasajero BETWEEN 100 AND 200;
```
26.
```sql
SELECT *
FROM vuelos
WHERE EXTRACT(MONTH FROM fecha_salida) IN (6, 7, 8);
```
27.
```sql
SELECT *
FROM pasajeros
WHERE nacionalidad IN ('Francia', 'Italia', 'Portugal');
```
28.
```sql
SELECT *
FROM vuelos
WHERE precio_base BETWEEN 50 AND 150;
```
29.
```sql
SELECT *
FROM aeropuertos
ORDER BY id_aeropuerto ASC
LIMIT 3;
```
30.
```sql
SELECT *
FROM pasajeros
ORDER BY id_pasajero
OFFSET 50
LIMIT 10;
```
31.
```sql
SELECT *
FROM vuelos
WHERE estado IN ('Programado', 'En Vuelo');
```
32.
```sql
SELECT *
FROM pasajeros
WHERE nacionalidad NOT IN ('España', 'México');
```
33.
```sql
SELECT *
FROM aeropuertos
WHERE ciudad LIKE 'M%d';
```
34.
```sql
SELECT *
FROM aerolineas
WHERE codigo_iata IN ('IBE', 'UAE', 'RYR');
```
35.
```sql
SELECT *
FROM vuelos
ORDER BY fecha_salida ASC;
```
36.
```sql
SELECT *
FROM equipaje
ORDER BY peso_kg DESC
LIMIT 5;
```
37.
```sql
SELECT *
FROM pasajeros
WHERE apellidos ILIKE '%ss%';
```
38.
```sql
SELECT *
FROM vuelos
WHERE fecha_salida::date = fecha_llegada::date;
```
39.
```sql
SELECT *
FROM aeropuertos
ORDER BY pais, nombre;
```
40.
```sql
SELECT *
FROM reservas
ORDER BY fecha_reserva DESC
LIMIT 10;
```

---

### BLOQUE 3: Funciones de Cadena, Matemáticas y Fechas (41-60)

41.
```sql
SELECT UPPER(nombre), LOWER(apellidos)
FROM pasajeros;
```
42.
```sql
SELECT nombre, LENGTH(nombre)
FROM aeropuertos;
```
43.
```sql
SELECT ciudad || ' - ' || pais
FROM aeropuertos;
```
44.
```sql
SELECT ROUND(precio_base)
FROM vuelos;
```
45.
```sql
SELECT numero_vuelo, LEFT(numero_vuelo, 2)
FROM vuelos;
```
46.
```sql
SELECT fecha_salida, TO_CHAR(fecha_salida, 'TMDay')
FROM vuelos;
```
47.
```sql
SELECT numero_vuelo, EXTRACT(EPOCH FROM (fecha_llegada - fecha_salida))/3600 AS horas_duracion
FROM vuelos;
```
48.
```sql
SELECT NOW();
```
49.
```sql
SELECT id_reserva, EXTRACT(YEAR FROM fecha_reserva)
FROM reservas;
```
50.
```sql
SELECT REPLACE(modelo, ' ', '_')
FROM aviones;
```
51.
```sql
SELECT apellidos, LENGTH(apellidos)
FROM pasajeros;
```
52.
```sql
SELECT precio_base || ' €'
FROM vuelos;
```
53.
```sql
SELECT id_reserva, EXTRACT(QUARTER FROM fecha_reserva)
FROM reservas;
```
54.
```sql
SELECT ABS(precio_base - 500)
FROM vuelos;
```
55.
```sql
SELECT REPLACE(email, 'gmail.com', 'aeropuerto.es')
FROM pasajeros;
```
56.
```sql
SELECT TO_CHAR(fecha_salida, '"Día " DD " de " TMMonth " de " YYYY')
FROM vuelos;
```
57.
```sql
SELECT EXTRACT(HOUR FROM fecha_salida)
FROM vuelos;
```
58.
```sql
SELECT modelo, SQRT(capacidad_pasajeros)
FROM aviones;
```
59.
```sql
SELECT TRIM(nombre)
FROM pasajeros;
```
60.
```sql
SELECT id_reserva, CURRENT_DATE - fecha_reserva::date AS dias_pasados
FROM reservas;
```

---

### BLOQUE 4: Agregación y Agrupamiento (61-80)

61.
```sql
SELECT COUNT(*)
FROM pasajeros;
```
62.
```sql
SELECT AVG(precio_base)
FROM vuelos;
```
63.
```sql
SELECT SUM(precio_final)
FROM reservas;
```
64.
```sql
SELECT MAX(capacidad_pasajeros)
FROM aviones;
```
65.
```sql
SELECT MIN(peso_kg)
FROM equipaje
WHERE tipo = 'Bodega';
```
66.
```sql
SELECT nacionalidad, COUNT(*)
FROM pasajeros
GROUP BY nacionalidad;
```
67.
```sql
SELECT id_aerolinea, SUM(precio_base)
FROM vuelos
GROUP BY id_aerolinea;
```
68.
```sql
SELECT ad.ciudad, COUNT(v.id_vuelo)
FROM vuelos v
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto
GROUP BY ad.ciudad;
```
69.
```sql
SELECT id_reserva, AVG(peso_kg)
FROM equipaje
GROUP BY id_reserva;
```
70.
```sql
SELECT id_aerolinea, COUNT(*)
FROM aviones
GROUP BY id_aerolinea;
```
71.
```sql
SELECT estado, MAX(precio_base), MIN(precio_base)
FROM vuelos
GROUP BY estado;
```
72.
```sql
SELECT clase, COUNT(*)
FROM reservas
GROUP BY clase;
```
73.
```sql
SELECT SUM(a.capacidad_pasajeros)
FROM aviones a
JOIN aerolineas ae ON a.id_aerolinea = ae.id_aerolinea
WHERE ae.nombre = 'Iberia';
```
74.
```sql
SELECT pais, COUNT(*)
FROM aeropuertos
GROUP BY pais;
```
75.
```sql
SELECT TO_CHAR(fecha_salida, 'TMMonth') AS mes, COUNT(*)
FROM vuelos
GROUP BY mes;
```
76.
```sql
SELECT tipo, SUM(peso_kg)
FROM equipaje
GROUP BY tipo;
```
77.
```sql
SELECT nombre, COUNT(*)
FROM pasajeros
GROUP BY nombre
HAVING COUNT(*) > 1;
```
78.
```sql
SELECT AVG(precio_final)
FROM reservas
WHERE fecha_reserva >= NOW() - INTERVAL '1 month';
```
79.
```sql
SELECT id_avion, COUNT(*)
FROM vuelos
GROUP BY id_avion;
```
80.
```sql
SELECT SUM(precio_base * 0.21) AS total_iva
FROM vuelos;
```

---

### BLOQUE 5: Filtros de Grupo y Joins Básicos (81-100)

81.
```sql
SELECT nacionalidad
FROM pasajeros
GROUP BY nacionalidad
HAVING COUNT(*) > 50;
```
82.
```sql
SELECT ae.nombre
FROM aerolineas ae
JOIN aviones av ON ae.id_aerolinea = av.id_aerolinea
GROUP BY ae.nombre
HAVING COUNT(av.id_avion) > 5;
```
83.
```sql
SELECT ad.nombre
FROM vuelos v
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto
GROUP BY ad.nombre
HAVING COUNT(v.id_vuelo) > 10;
```
84.
```sql
SELECT TO_CHAR(fecha_reserva, 'TMMonth') AS mes
FROM reservas
GROUP BY mes
HAVING COUNT(*) > 100;
```
85.
```sql
SELECT p.nombre, p.apellidos, SUM(r.precio_final)
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
GROUP BY p.id_pasajero, p.nombre, p.apellidos
HAVING SUM(r.precio_final) > 3000;
```
86.
```sql
SELECT p.nombre, v.numero_vuelo
FROM reservas r
JOIN pasajeros p ON r.id_pasajero = p.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo;
```
87.
```sql
SELECT v.*, ae.nombre AS nombre_aerolinea
FROM vuelos v
JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea;
```
88.
```sql
SELECT av.modelo, ae.nombre AS aerolinea
FROM aviones av
JOIN aerolineas ae ON av.id_aerolinea = ae.id_aerolinea;
```
89.
```sql
SELECT v.numero_vuelo, ao.ciudad AS origen, ad.ciudad AS destino
FROM vuelos v
JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto;
```
90.
```sql
SELECT p.nombre, p.apellidos, r.asiento
FROM reservas r
JOIN pasajeros p ON r.id_pasajero = p.id_pasajero;
```
91.
```sql
SELECT e.*, r.id_reserva, p.nombre
FROM equipaje e
JOIN reservas r ON e.id_reserva = r.id_reserva
JOIN pasajeros p ON r.id_pasajero = p.id_pasajero;
```
92.
```sql
SELECT v.numero_vuelo, av.modelo
FROM vuelos v
JOIN aviones av ON v.id_avion = av.id_avion
WHERE av.capacidad_pasajeros > 200;
```
93.
```sql
SELECT v.*
FROM vuelos v
JOIN reservas r ON v.id_vuelo = r.id_vuelo
JOIN pasajeros p ON r.id_pasajero = p.id_pasajero
WHERE p.nombre = 'Juan' 
AND p.apellidos = 'García López';
```
94.
```sql
SELECT DISTINCT p.*
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
WHERE r.clase = 'Primera';
```
95.
```sql
SELECT ae.nombre AS aerolinea, ap.nombre AS aeropuerto_pais
FROM aerolineas ae
JOIN aeropuertos ap ON ae.pais_origen = ap.pais;
```
96.
```sql
SELECT r.*
FROM reservas r
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto
WHERE ao.ciudad = 'Madrid';
```
97.
```sql
SELECT DISTINCT av.modelo
FROM aviones av
JOIN aerolineas ae ON av.id_aerolinea = ae.id_aerolinea
WHERE ae.nombre = 'Emirates';
```
98.
```sql
SELECT p.nombre, p.apellidos, v.numero_vuelo, COUNT(e.id_equipaje)
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
LEFT JOIN equipaje e ON r.id_reserva = e.id_reserva
GROUP BY p.id_pasajero, v.id_vuelo, p.nombre, p.apellidos, v.numero_vuelo;
```
99.
```sql
SELECT r.precio_final, ae.nombre AS aerolinea
FROM reservas r
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea;
```
100.
```sql
SELECT p.*
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
WHERE v.fecha_salida::date = CURRENT_DATE;
```

---

### BLOQUE 6: Joins Avanzados y Lógica de Negocio (101-120)

101.
```sql
SELECT p.nombre, v.numero_vuelo, ao.nombre AS origen, ad.nombre AS destino, ae.nombre AS aerolinea, av.modelo
FROM reservas r
JOIN pasajeros p ON r.id_pasajero = p.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto
JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea
JOIN aviones av ON v.id_avion = av.id_avion;
```
102.
```sql
SELECT p.*
FROM pasajeros p
WHERE p.id_pasajero NOT IN (
    SELECT r.id_pasajero 
    FROM reservas r 
    JOIN equipaje e ON r.id_reserva = e.id_reserva 
    WHERE e.tipo = 'Bodega'
);
```
103.
```sql
SELECT ao.nombre
FROM aeropuertos ao
LEFT JOIN vuelos v ON ao.id_aeropuerto = v.id_origen
WHERE v.id_vuelo IS NULL;
```
104.
```sql
SELECT ae.nombre, SUM(e.peso_kg)
FROM aerolineas ae
JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea
JOIN reservas r ON v.id_vuelo = r.id_vuelo
JOIN equipaje e ON r.id_reserva = e.id_reserva
GROUP BY ae.nombre;
```
105.
```sql
SELECT p.nombre, p.apellidos, r.precio_final
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
ORDER BY r.precio_final DESC
LIMIT 1;
```
106.
```sql
SELECT av.modelo, ae.nombre
FROM aviones av
JOIN aerolineas ae ON av.id_aerolinea = ae.id_aerolinea
JOIN vuelos v ON av.id_avion = v.id_avion
WHERE v.estado = 'En Vuelo';
```
107.
```sql
SELECT DISTINCT ao.nombre AS origen, ad.nombre AS destino
FROM vuelos v
JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto;
```
108.
```sql
SELECT p.nombre, p.apellidos
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = p.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
GROUP BY p.id_pasajero, p.nombre, p.apellidos
HAVING COUNT(DISTINCT v.id_aerolinea) > 1;
```
109.
```sql
SELECT ae.nombre, SUM(r.precio_final) AS beneficio_total
FROM aerolineas ae
JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea
JOIN reservas r ON v.id_vuelo = r.id_vuelo
GROUP BY ae.nombre;
```
110.
```sql
SELECT DISTINCT ad.nombre AS aeropuerto_destino
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto
WHERE p.nacionalidad = 'Japón';
```
111.
```sql
SELECT r.asiento, COUNT(*)
FROM reservas r
GROUP BY r.asiento
HAVING COUNT(DISTINCT r.id_vuelo) > 1;
```
112.
```sql
SELECT v.numero_vuelo
FROM vuelos v
JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto
WHERE ae.pais_origen <> ad.pais;
```
113.
```sql
SELECT p.nombre, SUM(r.precio_final + (
    SELECT COUNT(*) * 20 
    FROM equipaje e 
    WHERE e.id_reserva = r.id_reserva 
    AND e.tipo = 'Bodega'
)) AS total_con_recargo
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
GROUP BY p.id_pasajero, p.nombre;
```
114.
```sql
SELECT ae.nombre
FROM aerolineas ae
JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea
WHERE v.estado = 'Retrasado'
GROUP BY ae.nombre
ORDER BY COUNT(*) DESC
LIMIT 1;
```
115.
```sql
SELECT DISTINCT ON (p.id_pasajero) p.nombre, ae.nombre AS aerolinea_favorita
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea
GROUP BY p.id_pasajero, p.nombre, ae.id_aerolinea, ae.nombre
ORDER BY p.id_pasajero, COUNT(*) DESC;
```
116.
```sql
SELECT av.modelo, MAX(v.fecha_salida) AS ultimo_vuelo
FROM aviones av
LEFT JOIN vuelos v ON av.id_avion = v.id_avion
GROUP BY av.id_avion, av.modelo;
```
117.
```sql
SELECT r.clase, SUM(r.precio_final)
FROM reservas r
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea
WHERE ae.nombre = 'Lufthansa'
GROUP BY r.clase;
```
118.
```sql
SELECT p.nombre, p.apellidos
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN equipaje e ON r.id_reserva = e.id_reserva
WHERE e.peso_kg > (
    SELECT AVG(peso_kg) 
    FROM equipaje
);
```
119.
```sql
SELECT ao.ciudad AS origen, ad.ciudad AS destino, SUM(r.precio_final) AS rentabilidad
FROM vuelos v
JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto
JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto
JOIN reservas r ON v.id_vuelo = r.id_vuelo
GROUP BY ao.ciudad, ad.ciudad
ORDER BY rentabilidad DESC
LIMIT 1;
```
120.
```sql
SELECT DISTINCT p.nombre
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto
WHERE p.nacionalidad = ao.pais;
```

---

### BLOQUE 7: Subconsultas y Operaciones de Conjunto (121-140)

121.
```sql
SELECT *
FROM vuelos
WHERE precio_base > (
    SELECT AVG(precio_base) 
    FROM vuelos
);
```
122.
```sql
SELECT id_pasajero, COUNT(*)
FROM reservas
GROUP BY id_pasajero
HAVING COUNT(*) > (
    SELECT COUNT(*) 
    FROM reservas 
    WHERE id_pasajero = 1
);
```
123.
```sql
SELECT nombre
FROM aerolineas
WHERE id_aerolinea IN (
    SELECT id_aerolinea 
    FROM aviones 
    WHERE capacidad_pasajeros > (
        SELECT AVG(capacidad_pasajeros) 
        FROM aviones
    )
);
```
124.
```sql
SELECT *
FROM vuelos
WHERE id_origen = (
    SELECT id_origen 
    FROM vuelos 
    GROUP BY id_origen 
    ORDER BY COUNT(*) DESC 
    LIMIT 1
);
```
125.
```sql
SELECT *
FROM pasajeros
WHERE id_pasajero IN (
    SELECT r.id_pasajero 
    FROM reservas r 
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo 
    JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto 
    WHERE ad.ciudad = 'Nueva York'
);
```
126.
```sql
SELECT nombre
FROM aerolineas
WHERE id_aerolinea NOT IN (
    SELECT id_aerolinea 
    FROM aviones 
    WHERE modelo = 'Airbus A380'
);
```
127.
```sql
SELECT p.nombre, r.id_vuelo, r.precio_final
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
WHERE r.precio_final > (
    SELECT AVG(precio_final) 
    FROM reservas r2 
    WHERE r2.id_vuelo = r.id_vuelo
);
```
128.
```sql
SELECT v.*
FROM vuelos v
WHERE v.id_avion = (
    SELECT a.id_avion 
    FROM aviones a 
    WHERE a.id_aerolinea = v.id_aerolinea 
    ORDER BY a.capacidad_pasajeros DESC 
    LIMIT 1
);
```
129.
```sql
SELECT p1.nombre
FROM pasajeros p1
WHERE EXISTS (
    SELECT 1 
    FROM pasajeros p2 
    WHERE p1.nombre = p2.nombre 
    AND p1.id_pasajero <> p2.id_pasajero
);
```
130.
```sql
SELECT id_aeropuerto
FROM aeropuertos
WHERE id_aeropuerto IN (
    SELECT id_origen FROM vuelos WHERE fecha_salida::date = CURRENT_DATE
)
AND id_aeropuerto IN (
    SELECT id_destino FROM vuelos WHERE fecha_llegada::date = CURRENT_DATE
);
```
131.
```sql
SELECT ciudad FROM aeropuertos
UNION
SELECT ciudad FROM aeropuertos; -- UNION ya elimina duplicados por defecto
```
132.
```sql
SELECT p.id_pasajero, p.nombre
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
GROUP BY p.id_pasajero, p.nombre
HAVING COUNT(DISTINCT v.id_aerolinea) = (
    SELECT COUNT(*) FROM aerolineas
);
```
133.
```sql
SELECT *
FROM vuelos
WHERE precio_base < (
    SELECT MAX(precio_base) 
    FROM vuelos
)
ORDER BY precio_base DESC
LIMIT 1;
```
134.
```sql
SELECT r.*
FROM reservas r
JOIN vuelos v ON r.id_vuelo = v.id_vuelo
WHERE r.precio_final < v.precio_base;
```
135.
```sql
SELECT id_origen
FROM vuelos v1
JOIN aeropuertos a1 ON v1.id_destino = a1.id_aeropuerto
WHERE a1.ciudad = 'Londres'
EXCEPT
SELECT id_origen
FROM vuelos v2
JOIN aeropuertos a2 ON v2.id_destino = a2.id_aeropuerto
WHERE a2.ciudad = 'París';
```
136.
```sql
SELECT p.nombre
FROM pasajeros p
JOIN reservas r ON p.id_pasajero = r.id_pasajero
WHERE r.id_vuelo IN (
    SELECT id_vuelo 
    FROM reservas r2 
    JOIN pasajeros p2 ON r2.id_pasajero = p2.id_pasajero 
    WHERE p2.nombre = 'Julian Ross' -- O p2.nombre = 'Julian' AND p2.apellidos = 'Ross'
);
```
137.
```sql
SELECT ae.nombre
FROM aerolineas ae
JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea
GROUP BY ae.id_aerolinea, ae.nombre
HAVING AVG(v.precio_base) < (
    SELECT AVG(v2.precio_base) 
    FROM vuelos v2 
    JOIN aerolineas ae2 ON v2.id_aerolinea = ae2.id_aerolinea 
    WHERE ae2.nombre = 'Iberia'
);
```
138.
```sql
SELECT *
FROM aviones a
WHERE NOT EXISTS (
    SELECT 1 
    FROM vuelos v 
    WHERE v.id_avion = a.id_avion
);
```
139.
```sql
SELECT p.nombre, (
    SELECT COUNT(*) 
    FROM equipaje e 
    JOIN reservas r ON e.id_reserva = r.id_reserva 
    WHERE r.id_pasajero = p.id_pasajero
) AS total_maletas
FROM pasajeros p;
```
140.
```sql
SELECT v.numero_vuelo
FROM vuelos v
JOIN aviones a ON v.id_avion = a.id_avion
WHERE (
    SELECT COUNT(*) 
    FROM reservas r 
    WHERE r.id_vuelo = v.id_vuelo
) > (a.capacidad_pasajeros * 0.8);
```

---

### BLOQUE 8: DML Avanzado y Transacciones (141-150)

141.
```sql
UPDATE vuelos
SET precio_base = precio_base * 1.05
WHERE id_aerolinea = (
    SELECT id_aerolinea 
    FROM aerolineas 
    WHERE nombre = 'Iberia'
);
```
142.
```sql
UPDATE vuelos
SET estado = 'Retrasado'
WHERE id_destino IN (
    SELECT id_aeropuerto 
    FROM aeropuertos 
    WHERE pais = 'Francia'
);
```
143.
```sql
DELETE FROM reservas
WHERE precio_final = 0;
```
144.
```sql
CREATE TABLE Pasajeros_VIP AS
SELECT *
FROM pasajeros
WHERE id_pasajero IN (
    SELECT id_pasajero 
    FROM reservas 
    GROUP BY id_pasajero 
    HAVING SUM(precio_final) > 5000
);
```
145.
```sql
BEGIN;
INSERT INTO reservas (id_pasajero, id_vuelo, asiento, clase, precio_final)
VALUES (1, 1, '12A', 'Turista', 300.00);
INSERT INTO equipaje (id_reserva, peso_kg, tipo)
VALUES (currval('reservas_id_reserva_seq'), 20.0, 'Bodega');
COMMIT;
```
146.
```sql
BEGIN;
INSERT INTO vuelos (numero_vuelo, id_aerolinea, id_origen, id_destino, id_avion, fecha_salida, fecha_llegada, precio_base)
VALUES ('ERR01', 1, 1, 2, 1, '2023-01-01', '2022-01-01', 100);
-- El sistema detecta error de fecha (salida > llegada)
ROLLBACK;
```
147.
```sql
BEGIN;
INSERT INTO aerolineas (nombre, codigo_iata, pais_origen) 
VALUES ('New Air', 'NA1', 'Portugal');
SAVEPOINT sp1;
INSERT INTO aviones (modelo, capacidad_pasajeros, id_aerolinea) 
VALUES ('Error Model', -50, (SELECT id_aerolinea FROM aerolineas WHERE codigo_iata = 'NA1'));
-- Error por capacidad negativa
ROLLBACK TO sp1;
COMMIT;
```
148.
```sql
CREATE VIEW v_tablon_anuncios AS
SELECT v.numero_vuelo, ae.nombre AS aerolinea, v.fecha_salida::time AS hora, v.estado
FROM vuelos v
JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea;
```
149.
```sql
DELETE FROM aviones
WHERE id_aerolinea NOT IN (
    SELECT id_aerolinea 
    FROM aerolineas
);
```
150.
```sql
SELECT nombre, LEFT(pasaporte, LENGTH(pasaporte)-4) || '****' AS pasaporte_protegido
FROM pasajeros;
```