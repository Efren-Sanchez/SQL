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

BLOQUE 1: Consultas Básicas (1-20)

    1.  
    
    SELECT *  
    FROM pasajeros;  
    
    2.  
    
    SELECT nombre, apellidos  
    FROM pasajeros;  
    
    3.  
    
    SELECT DISTINCT ciudad  
    FROM aeropuertos;  
    
    4.  
    
    SELECT nombre, pais_origen  
    FROM aerolineas;  
    
    5.  
    
    SELECT *  
    FROM pasajeros  
    WHERE nacionalidad = 'España';  
    
    6.  
    
    SELECT *  
    FROM vuelos  
    WHERE precio_base = 500;  
    
    7.  
    
    SELECT *  
    FROM aviones  
    WHERE capacidad_pasajeros > 300;  
    
    8.  
    
    SELECT *  
    FROM aeropuertos  
    WHERE pais <> 'España';  
    
    9.  
    
    SELECT *  
    FROM vuelos  
    WHERE estado = 'Cancelado';  
    
    10.  
    
    SELECT *  
    FROM pasajeros  
    WHERE id_pasajero < 50;  
    
    11.  
    
    SELECT *  
    FROM aerolineas  
    WHERE nombre LIKE '%Air%';  
    
    12.  
    
    SELECT *  
    FROM vuelos  
    WHERE id_origen = 1;  
    
    13.  
    
    SELECT DISTINCT tipo  
    FROM equipaje;  
    
    14.  
    
    SELECT *  
    FROM reservas  
    WHERE clase = 'Business';  
    
    15.  
    
    SELECT *  
    FROM pasajeros  
    WHERE pasaporte LIKE 'P%';  
    
    16.  
    
    SELECT *  
    FROM vuelos  
    WHERE precio_base <= 150;  
    
    17.  
    
    SELECT *  
    FROM aviones  
    WHERE modelo LIKE '%Boeing%';  
    
    18.  
    
    SELECT *  
    FROM aeropuertos  
    WHERE LENGTH(codigo_iata) = 3;  
    
    19.  
    
    SELECT *  
    FROM pasajeros  
    WHERE telefono LIKE '%9';  
    
    20.  
    
    SELECT *  
    FROM vuelos  
    WHERE TO_CHAR(fecha_salida, 'HH24:MI:SS') > '12:00:00';  
    
BLOQUE 2: Ordenación y Paginación (21-40)  
    
    Nota: Oracle 12c y superiores utilizan el estándar ANSI OFFSET/FETCH.  
    
    21.  
    
    SELECT *  
    FROM pasajeros  
    ORDER BY apellidos ASC, nombre ASC;  
    
    22.  
    
    SELECT *  
    FROM vuelos  
    ORDER BY precio_base DESC  
    FETCH NEXT 10 ROWS ONLY;  
    
    23.  
    
    SELECT *  
    FROM aviones  
    ORDER BY capacidad_pasajeros ASC  
    FETCH NEXT 5 ROWS ONLY;  
    
    24.  
    
    SELECT *  
    FROM aerolineas  
    ORDER BY pais_origen DESC;  
    
    25.  
    
    SELECT *  
    FROM pasajeros  
    WHERE id_pasajero BETWEEN 100 AND 200;  
    
    26.  
    
    SELECT *  
    FROM vuelos  
    WHERE EXTRACT(MONTH FROM fecha_salida) IN (6, 7, 8);  
    
    27.  
    
    SELECT *  
    FROM pasajeros  
    WHERE nacionalidad IN ('Francia', 'Italia', 'Portugal');  
    
    28.  
    
    SELECT *  
    FROM vuelos  
    WHERE precio_base BETWEEN 50 AND 150;  
    
    29.  
    
    SELECT *  
    FROM aeropuertos  
    ORDER BY id_aeropuerto ASC  
    FETCH NEXT 3 ROWS ONLY;  
    
    30.  
    
    SELECT *  
    FROM pasajeros  
    OFFSET 50 ROWS  
    FETCH NEXT 10 ROWS ONLY;  
    
    31.  
    
    SELECT *  
    FROM vuelos  
    WHERE estado IN ('Programado', 'En Vuelo');  
    
    32.  
    
    SELECT *  
    FROM pasajeros  
    WHERE nacionalidad NOT IN ('España', 'México');  
    
    33.  
    
    SELECT *  
    FROM aeropuertos  
    WHERE ciudad LIKE 'M%d';  
    
    34.  
    
    SELECT *  
    FROM aerolineas  
    WHERE codigo_iata IN ('IBE', 'UAE', 'RYR');  
    
    35.  
    
    SELECT *  
    FROM vuelos  
    ORDER BY fecha_salida ASC;  
    
    36.  
    
    SELECT *  
    FROM equipaje  
    ORDER BY peso_kg DESC  
    FETCH NEXT 5 ROWS ONLY;  
    
    37.  
    
    SELECT *  
    FROM pasajeros  
    WHERE apellidos LIKE '%ssi%';  
    
    38.  
    
    SELECT *  
    FROM vuelos  
    WHERE TRUNC(fecha_salida) = TRUNC(fecha_llegada);  
    
    39.  
    
    SELECT *  
    FROM aeropuertos  
    ORDER BY pais ASC, nombre ASC;  
    
    40.  
    
    SELECT *  
    FROM reservas  
    ORDER BY fecha_reserva DESC  
    FETCH NEXT 10 ROWS ONLY;  
    
BLOQUE 3: Funciones Oracle (41-60)  
    
    41.  
    
    SELECT UPPER(nombre), LOWER(apellidos)  
    FROM pasajeros;  
    
    42.  
    
    SELECT nombre, LENGTH(nombre)  
    FROM aeropuertos;  
    
    43.  
    
    SELECT ciudad || ' - ' || pais  
    FROM aeropuertos;  
    
    44.  
    
    SELECT numero_vuelo, ROUND(precio_base)  
    FROM vuelos;  
    
    45.  
    
    SELECT numero_vuelo, SUBSTR(numero_vuelo, 1, 2)  
    FROM vuelos;  
    
    46.  
    
    SELECT fecha_salida, TO_CHAR(fecha_salida, 'DAY')  
    FROM vuelos;  
    
    47.  
    
    SELECT numero_vuelo, (fecha_llegada - fecha_salida) * 24 AS horas  
    FROM vuelos;  
    
    48.  
    
    SELECT SYSDATE  
    FROM DUAL;  
    
    49.  
    
    SELECT id_reserva, EXTRACT(YEAR FROM fecha_reserva)  
    FROM reservas;  
    
    50.  
    
    SELECT REPLACE(modelo, ' ', '_')  
    FROM aviones;  
    
    51.  
    
    SELECT apellidos, LENGTH(apellidos)  
    FROM pasajeros;  
    
    52.  
    
    SELECT precio_base || ' €'  
    FROM vuelos;  
    
    53.  
    
    SELECT id_reserva, TO_CHAR(fecha_reserva, 'Q')  
    FROM reservas;  
    
    54.  
    
    SELECT ABS(precio_base - 500)  
    FROM vuelos;  
    
    55.  
    
    SELECT REPLACE(email, 'gmail.com', 'aeropuerto.es')  
    FROM pasajeros;  
    
    56.  
    
    SELECT TO_CHAR(fecha_salida, '"Día " DD " de " Month " de " YYYY')  
    FROM vuelos;  
    
    57.  
    
    SELECT TO_CHAR(fecha_salida, 'HH24')  
    FROM vuelos;  
    
    58.  
    
    SELECT modelo, SQRT(capacidad_pasajeros)  
    FROM aviones;  
    
    59.  
    
    SELECT TRIM(nombre)  
    FROM pasajeros;  
    
    60.  
    
    SELECT id_reserva, TRUNC(SYSDATE) - TRUNC(fecha_reserva)  
    FROM reservas;  
    
BLOQUE 4: Agregación y Agrupamiento (61-80)  
    
    61.  
    
    SELECT COUNT(*)  
    FROM pasajeros;  
    
    62.  
    
    SELECT AVG(precio_base)  
    FROM vuelos;  
    
    63.  
    
    SELECT SUM(precio_final)  
    FROM reservas;  
    
    64.  
    
    SELECT MAX(capacidad_pasajeros)  
    FROM aviones;  
    
    65.  
    
    SELECT MIN(peso_kg)  
    FROM equipaje  
    WHERE tipo = 'Bodega';  
    
    66.  
    
    SELECT nacionalidad, COUNT(*)  
    FROM pasajeros  
    GROUP BY nacionalidad;  
    
    67.  
    
    SELECT id_aerolinea, SUM(precio_base)  
    FROM vuelos  
    GROUP BY id_aerolinea;  
    
    68.  
    
    SELECT id_destino, COUNT(*)  
    FROM vuelos  
    GROUP BY id_destino;  
    
    69.  
    
    SELECT id_reserva, AVG(peso_kg)  
    FROM equipaje  
    GROUP BY id_reserva;  
    
    70.  
    
    SELECT id_aerolinea, COUNT(*)  
    FROM aviones  
    GROUP BY id_aerolinea;  
    
    71.  
    
    SELECT estado, MAX(precio_base), MIN(precio_base)  
    FROM vuelos  
    GROUP BY estado;  
    
    72.  
    
    SELECT clase, COUNT(*)  
    FROM reservas  
    GROUP BY clase;  
    
    73.  
    
    SELECT SUM(capacidad_pasajeros)  
    FROM aviones a  
    JOIN aerolineas ae  
    ON a.id_aerolinea = ae.id_aerolinea  
    WHERE ae.nombre = 'Iberia';  
    
    74.  
    
    SELECT pais, COUNT(*)  
    FROM aeropuertos  
    GROUP BY pais;  
    
    75.  
    
    SELECT EXTRACT(MONTH FROM fecha_salida), COUNT(*)  
    FROM vuelos  
    GROUP BY EXTRACT(MONTH FROM fecha_salida);  
    
    76.  
    
    SELECT tipo, SUM(peso_kg)  
    FROM equipaje  
    GROUP BY tipo;  
    
    77.  
    
    SELECT nombre, COUNT(*)  
    FROM pasajeros  
    GROUP BY nombre;  
    
    78.  
    
    SELECT AVG(precio_final)  
    FROM reservas  
    WHERE fecha_reserva >= ADD_MONTHS(SYSDATE, -1);  
    
    79.  
    
    SELECT id_avion, COUNT(*)  
    FROM vuelos  
    GROUP BY id_avion;  
    
    80.  
    
    SELECT SUM(precio_base * 0.21)  
    FROM vuelos;  
    
BLOQUE 5: Filtros de Grupo y Joins (81-100)  
    
    81.  
    
    SELECT nacionalidad, COUNT(*)  
    FROM pasajeros  
    GROUP BY nacionalidad  
    HAVING COUNT(*) > 50;  
    
    82.  
    
    SELECT id_aerolinea, COUNT(*)  
    FROM aviones  
    GROUP BY id_aerolinea  
    HAVING COUNT(*) > 5;  
    
    83.  
    
    SELECT id_destino, COUNT(*)  
    FROM vuelos  
    GROUP BY id_destino  
    HAVING COUNT(*) > 10;  
    
    84.  
    
    SELECT TO_CHAR(fecha_reserva, 'MM'), COUNT(*)  
    FROM reservas  
    GROUP BY TO_CHAR(fecha_reserva, 'MM')  
    HAVING COUNT(*) > 100;  
    
    85.  
    
    SELECT id_pasajero, SUM(precio_final)  
    FROM reservas  
    GROUP BY id_pasajero  
    HAVING SUM(precio_final) > 3000;  
    
    86.  
    
    SELECT p.nombre, v.numero_vuelo  
    FROM reservas r  
    JOIN pasajeros p  
    ON r.id_pasajero = p.id_pasajero  
    JOIN vuelos v  
    ON r.id_vuelo = v.id_vuelo;  
    
    87.  
    
    SELECT v.numero_vuelo, a.nombre  
    FROM vuelos v  
    JOIN aerolineas a  
    ON v.id_aerolinea = a.id_aerolinea;  
    
    88.  
    
    SELECT av.modelo, ae.nombre  
    FROM aviones av  
    JOIN aerolineas ae  
    ON av.id_aerolinea = ae.id_aerolinea;  
    
    89.  
    
    SELECT v.numero_vuelo, ao.ciudad AS origen, ad.ciudad AS destino  
    FROM vuelos v  
    JOIN aeropuertos ao  
    ON v.id_origen = ao.id_aeropuerto  
    JOIN aeropuertos ad  
    ON v.id_destino = ad.id_aeropuerto;  
    
    90.  
    
    SELECT p.nombre, r.asiento  
    FROM reservas r  
    JOIN pasajeros p  
    ON r.id_pasajero = p.id_pasajero;  
    
    91.  
    
    SELECT e.id_equipaje, r.id_reserva, p.nombre  
    FROM equipaje e  
    JOIN reservas r  
    ON e.id_reserva = r.id_reserva  
    JOIN pasajeros p  
    ON r.id_pasajero = p.id_pasajero;  
    
    92.  
    
    SELECT v.numero_vuelo, a.modelo  
    FROM vuelos v  
    JOIN aviones a  
    ON v.id_avion = a.id_avion  
    WHERE a.capacidad_pasajeros > 200;  
    
    93.  
    
    SELECT v.numero_vuelo  
    FROM reservas r  
    JOIN pasajeros p  
    ON r.id_pasajero = p.id_pasajero  
    JOIN vuelos v  
    ON r.id_vuelo = v.id_vuelo  
    WHERE p.nombre = 'Juan'  
    AND p.apellidos = 'García';  
    
    94.  
    
    SELECT DISTINCT p.nombre, p.apellidos  
    FROM reservas r  
    JOIN pasajeros p  
    ON r.id_pasajero = p.id_pasajero  
    WHERE r.clase = 'Primera';  
    
    95.  
    
    SELECT ae.nombre, ap.nombre  
    FROM aerolineas ae  
    JOIN aeropuertos ap  
    ON ae.pais_origen = ap.pais;  
    
    96.  
    
    SELECT r.*  
    FROM reservas r  
    JOIN vuelos v  
    ON r.id_vuelo = v.id_vuelo  
    JOIN aeropuertos a  
    ON v.id_origen = a.id_aeropuerto  
    WHERE a.ciudad = 'Madrid';  
    
    97.  
    
    SELECT DISTINCT a.modelo  
    FROM aviones a  
    JOIN aerolineas ae  
    ON a.id_aerolinea = ae.id_aerolinea  
    WHERE ae.nombre = 'Emirates';  
    
    98.  
    
    SELECT r.id_vuelo, r.id_pasajero, COUNT(e.id_equipaje)  
    FROM reservas r  
    JOIN equipaje e  
    ON r.id_reserva = e.id_reserva  
    GROUP BY r.id_vuelo, r.id_pasajero;  
    
    99.  
    
    SELECT r.precio_final, ae.nombre  
    FROM reservas r  
    JOIN vuelos v  
    ON r.id_vuelo = v.id_vuelo  
    JOIN aerolineas ae  
    ON v.id_aerolinea = ae.id_aerolinea;  
    
    100.  
    
    SELECT p.*  
    FROM pasajeros p  
    JOIN reservas r  
    ON p.id_pasajero = r.id_pasajero  
    JOIN vuelos v  
    ON r.id_vuelo = v.id_vuelo  
    WHERE TRUNC(v.fecha_salida) = TRUNC(SYSDATE);  
    
BLOQUE 6: Lógica Avanzada (101-120)  
    
    101.  
    
    SELECT p.nombre, v.numero_vuelo, ao.ciudad, ad.ciudad, ae.nombre, av.modelo  
    FROM reservas r  
    JOIN pasajeros p ON r.id_pasajero = p.id_pasajero  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto  
    JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto  
    JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea  
    JOIN aviones av ON v.id_avion = av.id_avion;  
    
    102.  
    
    SELECT p.*  
    FROM pasajeros p  
    WHERE p.id_pasajero NOT IN (  
        SELECT r.id_pasajero  
        FROM reservas r  
        JOIN equipaje e ON r.id_reserva = e.id_reserva  
        WHERE e.tipo = 'Bodega'  
    );  
    
    103.  
    
    SELECT a.nombre  
    FROM aeropuertos a  
    LEFT JOIN vuelos v ON a.id_aeropuerto = v.id_origen  
    WHERE v.id_vuelo IS NULL;  
    
    104.  
    
    SELECT ae.nombre, SUM(e.peso_kg)  
    FROM aerolineas ae  
    JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea  
    JOIN reservas r ON v.id_vuelo = r.id_vuelo  
    JOIN equipaje e ON r.id_reserva = e.id_reserva  
    GROUP BY ae.nombre;  
    
    105.  
    
    SELECT p.nombre, p.apellidos  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = p.id_pasajero  
    WHERE r.precio_final = (  
        SELECT MAX(precio_final)  
        FROM reservas  
    );  
    
    106.  
    
    SELECT a.modelo, ae.nombre  
    FROM aviones a  
    JOIN aerolineas ae ON a.id_aerolinea = ae.id_aerolinea  
    JOIN vuelos v ON a.id_avion = v.id_avion  
    WHERE v.estado = 'En Vuelo';  
    
    107.  
    
    SELECT DISTINCT ao.ciudad, ad.ciudad  
    FROM vuelos v  
    JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto  
    JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto;  
    
    108.  
    
    SELECT p.nombre, p.apellidos  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    GROUP BY p.id_pasajero, p.nombre, p.apellidos  
    HAVING COUNT(DISTINCT v.id_aerolinea) > 1;  
    
    109.  
    
    SELECT ae.nombre, SUM(r.precio_final)  
    FROM aerolineas ae  
    JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea  
    JOIN reservas r ON v.id_vuelo = r.id_vuelo  
    GROUP BY ae.nombre;  
    
    110.  
    
    SELECT DISTINCT ad.ciudad  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto  
    WHERE p.nacionalidad = 'Japón';  
    
    111.  
    
    SELECT asiento, COUNT(DISTINCT id_vuelo)  
    FROM reservas  
    GROUP BY asiento  
    HAVING COUNT(DISTINCT id_vuelo) > 1;  
    
    112.  
    
    SELECT v.numero_vuelo  
    FROM vuelos v  
    JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea  
    JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto  
    WHERE ae.pais_origen <> ad.pais;  
    
    113.  
    
    SELECT p.nombre, (SUM(r.precio_final) + COUNT(CASE WHEN e.tipo = 'Bodega' THEN 1 END) * 20)  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    LEFT JOIN equipaje e ON r.id_reserva = e.id_reserva  
    GROUP BY p.id_pasajero, p.nombre;  
    
    114.  
    
    SELECT ae.nombre  
    FROM aerolineas ae  
    JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea  
    WHERE v.estado = 'Retrasado'  
    GROUP BY ae.nombre  
    ORDER BY COUNT(*) DESC  
    FETCH NEXT 1 ROWS ONLY;  
    
    115.  
    
    SELECT p.nombre, ae.nombre  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea  
    GROUP BY p.id_pasajero, p.nombre, ae.nombre  
    ORDER BY COUNT(*) DESC;  
    
    116.  
    
    SELECT a.modelo, MAX(v.fecha_salida)  
    FROM aviones a  
    LEFT JOIN vuelos v ON a.id_avion = v.id_avion  
    GROUP BY a.id_avion, a.modelo;  
    
    117.  
    
    SELECT clase, SUM(precio_final)  
    FROM reservas r  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea  
    WHERE ae.nombre = 'Lufthansa'  
    GROUP BY clase;  
    
    118.  
    
    SELECT p.nombre  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    JOIN equipaje e ON r.id_reserva = e.id_reserva  
    WHERE e.peso_kg > (  
        SELECT AVG(peso_kg)  
        FROM equipaje  
    );  
    
    119.  
    
    SELECT ao.ciudad, ad.ciudad, SUM(r.precio_final) AS total  
    FROM vuelos v  
    JOIN reservas r ON v.id_vuelo = r.id_vuelo  
    JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto  
    JOIN aeropuertos ad ON v.id_destino = ad.id_aeropuerto  
    GROUP BY ao.ciudad, ad.ciudad  
    ORDER BY total DESC  
    FETCH NEXT 1 ROWS ONLY;  
    
    120.  
    
    SELECT p.nombre  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    JOIN aeropuertos ao ON v.id_origen = ao.id_aeropuerto  
    WHERE p.nacionalidad = ao.pais;  
    
BLOQUE 7: Subconsultas y Conjuntos (121-140)  
    
    121.  
    
    SELECT *  
    FROM vuelos  
    WHERE precio_base > (  
        SELECT AVG(precio_base)  
        FROM vuelos  
    );  
    
    122.  
    
    SELECT p.nombre  
    FROM pasajeros p  
    WHERE (  
        SELECT COUNT(*)  
        FROM reservas r  
        WHERE r.id_pasajero = p.id_pasajero  
    ) > (  
        SELECT COUNT(*)  
        FROM reservas r2  
        WHERE r2.id_pasajero = 1  
    );  
    
    123.  
    
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
    
    124.  
    
    SELECT *  
    FROM vuelos  
    WHERE id_origen = (  
        SELECT id_origen  
        FROM (  
            SELECT id_origen  
            FROM vuelos  
            GROUP BY id_origen  
            ORDER BY COUNT(*) DESC  
        ) WHERE ROWNUM = 1  
    );  
    
    125.  
    
    SELECT nombre, apellidos  
    FROM pasajeros  
    WHERE id_pasajero IN (  
        SELECT id_pasajero  
        FROM reservas r  
        JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
        JOIN aeropuertos a ON v.id_destino = a.id_aeropuerto  
        WHERE a.ciudad = 'Nueva York'  
    );  
    
    126.  
    
    SELECT nombre  
    FROM aerolineas  
    WHERE id_aerolinea NOT IN (  
        SELECT id_aerolinea  
        FROM aviones  
        WHERE modelo = 'Airbus A380'  
    );  
    
    127.  
    
    SELECT p.nombre  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    WHERE r.precio_final > (  
        SELECT AVG(precio_final)  
        FROM reservas r2  
        WHERE r2.id_vuelo = r.id_vuelo  
    );  
    
    128.  
    
    SELECT *  
    FROM vuelos v  
    WHERE id_avion = (  
        SELECT id_avion  
        FROM (  
            SELECT id_avion  
            FROM aviones a  
            WHERE a.id_aerolinea = v.id_aerolinea  
            ORDER BY capacidad_pasajeros DESC  
        ) WHERE ROWNUM = 1  
    );  
    
    129.  
    
    SELECT nombre  
    FROM pasajeros  
    WHERE nombre IN (  
        SELECT nombre  
        FROM pasajeros  
        GROUP BY nombre  
        HAVING COUNT(*) > 1  
    );  
    
    130.  
    
    SELECT DISTINCT a.nombre  
    FROM aeropuertos a  
    WHERE a.id_aeropuerto IN (  
        SELECT id_origen  
        FROM vuelos  
        WHERE TRUNC(fecha_salida) = TRUNC(SYSDATE)  
    )  
    AND a.id_aeropuerto IN (  
        SELECT id_destino  
        FROM vuelos  
        WHERE TRUNC(fecha_llegada) = TRUNC(SYSDATE)  
    );  
    
    131.  
    
    SELECT ciudad FROM aeropuertos  
    UNION  
    SELECT ciudad FROM aeropuertos;  
    
    132.  
    
    SELECT p.nombre  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    GROUP BY p.id_pasajero, p.nombre  
    HAVING COUNT(DISTINCT v.id_aerolinea) = (  
        SELECT COUNT(*) FROM aerolineas  
    );  
    
    133.  
    
    SELECT *  
    FROM vuelos  
    ORDER BY precio_base DESC  
    OFFSET 1 ROWS  
    FETCH NEXT 1 ROWS ONLY;  
    
    134.  
    
    SELECT r.*  
    FROM reservas r  
    JOIN vuelos v ON r.id_vuelo = v.id_vuelo  
    WHERE r.precio_final < v.precio_base;  
    
    135.  
    
    SELECT id_aeropuerto  
    FROM aeropuertos  
    WHERE id_aeropuerto IN (  
        SELECT id_origen  
        FROM vuelos v  
        JOIN aeropuertos a ON v.id_destino = a.id_aeropuerto  
        WHERE a.ciudad = 'Londres'  
    )  
    AND id_aeropuerto NOT IN (  
        SELECT id_origen  
        FROM vuelos v  
        JOIN aeropuertos a ON v.id_destino = a.id_aeropuerto  
        WHERE a.ciudad = 'París'  
    );  
    
    136.  
    
    SELECT DISTINCT p.nombre  
    FROM pasajeros p  
    JOIN reservas r ON p.id_pasajero = r.id_pasajero  
    WHERE r.id_vuelo IN (  
        SELECT id_vuelo  
        FROM reservas r2  
        JOIN pasajeros p2 ON r2.id_pasajero = p2.id_pasajero  
        WHERE p2.nombre = 'Julian'  
        AND p2.apellidos = 'Ross'  
    );  
    
    137.  
    
    SELECT ae.nombre  
    FROM aerolineas ae  
    JOIN vuelos v ON ae.id_aerolinea = v.id_aerolinea  
    GROUP BY ae.id_aerolinea, ae.nombre  
    HAVING AVG(v.precio_base) < (  
        SELECT AVG(precio_base)  
        FROM vuelos v2  
        JOIN aerolineas ae2 ON v2.id_aerolinea = ae2.id_aerolinea  
        WHERE ae2.nombre = 'Iberia'  
    );  
    
    138.  
    
    SELECT *  
    FROM aviones a  
    WHERE NOT EXISTS (  
        SELECT 1  
        FROM vuelos v  
        WHERE v.id_avion = a.id_avion  
    );  
    
    139.  
    
    SELECT p.nombre, (  
        SELECT COUNT(*)  
        FROM equipaje e  
        JOIN reservas r ON e.id_reserva = r.id_reserva  
        WHERE r.id_pasajero = p.id_pasajero  
    ) AS num_maletas  
    FROM pasajeros p;  
    
    140.  
    
    SELECT v.*  
    FROM vuelos v  
    WHERE (  
        SELECT COUNT(*)  
        FROM reservas r  
        WHERE r.id_vuelo = v.id_vuelo  
    ) > (  
        SELECT capacidad_pasajeros * 0.8  
        FROM aviones a  
        WHERE a.id_avion = v.id_avion  
    );  
    
BLOQUE 8: DML y Transacciones (141-150)  
    
    141.  
    
    UPDATE vuelos  
    SET precio_base = precio_base * 1.05  
    WHERE id_aerolinea = (  
        SELECT id_aerolinea  
        FROM aerolineas  
        WHERE nombre = 'Iberia'  
    );  
    
    142.  
    
    UPDATE vuelos  
    SET estado = 'Retrasado'  
    WHERE id_destino IN (  
        SELECT id_aeropuerto  
        FROM aeropuertos  
        WHERE pais = 'Francia'  
    );  
    
    143.  
    
    DELETE FROM reservas  
    WHERE precio_final = 0;  
    
    144.  
    
    CREATE TABLE Pasajeros_VIP AS  
    SELECT *  
    FROM pasajeros  
    WHERE id_pasajero IN (  
        SELECT id_pasajero  
        FROM reservas  
        GROUP BY id_pasajero  
        HAVING SUM(precio_final) > 5000  
    );  
    
    145.  
    
    -- En Oracle se suele usar una secuencia o Identity  
    INSERT INTO reservas (id_pasajero, id_vuelo, asiento, clase, precio_final)  
    VALUES (1, 1, '10A', 'Turista', 250);  
    -- El COMMIT es manual  
    COMMIT;  
    
    146.  
    
    INSERT INTO vuelos (numero_vuelo, id_aerolinea, id_origen, id_destino, id_avion, fecha_salida, fecha_llegada, precio_base)  
    VALUES ('ERROR01', 1, 1, 2, 1, SYSDATE, SYSDATE, 10);  
    ROLLBACK;  
    
    147.  
    
    INSERT INTO aerolineas (nombre, codigo_iata)  
    VALUES ('Temp Air', 'TMP');  
    SAVEPOINT sp1;  
    -- ... otras operaciones ...  
    ROLLBACK TO sp1;  
    COMMIT;  
    
    148.  
    
    CREATE VIEW v_tablon_anuncios AS  
    SELECT v.numero_vuelo, ae.nombre AS aerolinea, v.fecha_salida, v.estado  
    FROM vuelos v  
    JOIN aerolineas ae ON v.id_aerolinea = ae.id_aerolinea;  
    
    149.  
    
    DELETE FROM aviones  
    WHERE id_aerolinea NOT IN (  
        SELECT id_aerolinea  
        FROM aerolineas  
    );  
    
    150.  
    
    SELECT nombre, SUBSTR(pasaporte, 1, LENGTH(pasaporte)-4) || '****'  
    FROM pasajeros;  
    