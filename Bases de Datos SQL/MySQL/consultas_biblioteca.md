# Consultas SQL sobre la BD "biblioteca"

## Enunciados

1. Autores vivos
2. Autores fallecidos
3. Autores que vivieron en el S. XVIII
4. Autores que empiece su apellido por V
5. Autores que tengan como segunda letra del nombre la C
6. Autores españoles
7. Autores extranjeros
8. Último autor en fallecer
9. Autores ordenados por apellido

## Soluciones

1. Autores vivos

    ```
    SELECT * 
    FROM autores
    WHERE fecha_dep IS NULL;
    ```

2. Autores fallecidos

    ```
    SELECT * 
    FROM autores
    WHERE fecha_dep IS NOT NULL;
    ```

3. Autores que vivieron en el S. XVIII

    ```
    /*  
    SELECT *  
    FROM autores  
    WHERE (YEAR(fecha_nac) BETWEEN 1500 AND 1599) OR   
        (YEAR(fecha_dep) BETWEEN 1500 AND 1599);  
    */  
    
    SELECT *  
    FROM autores  
    WHERE (fecha_nac BETWEEN "1500-01-01" AND "1599-01-01") OR   
        (fecha_dep BETWEEN "1500-01-01" AND "1599-01-01");  
    ```

4. Autores que empiece su apellido por V

    ```
    SELECT * 
    FROM autores
    WHERE apellido1 LIKE "V%";
    ```

5. Autores que tengan como segunda letra del nombre la C

    ```
    SELECT * 
    FROM autores
    WHERE nombre LIKE "__c%";
    ```

6. Autores españoles

    ```
    SELECT * 
    FROM autores
    WHERE nacionalidad="España";
    ```

7. Autores extranjeros`

    ```
    /*
    SELECT * 
    FROM autores
    WHERE NOT (nacionalidad="España");
    */
    SELECT * 
    FROM autores
    WHERE nacionalidad<>"España";
    ```

8. Último autor en fallecer

    ```
    SELECT * 
    FROM autores
    ORDER BY fecha_dep DESC
    LIMIT 1;
    ```

9. Autores ordenados por apellido

    ```
    SELECT * 
    FROM autores
    ORDER BY apellido1;
    ```

10. Libro y autor

    ```
    SELECT l.titulo, a.nombre, a.apellido1
    FROM libros l
    INNER JOIN autores a
    ON l.id_autor = a.id_autor;
    ```

11. Libro y editorial

    ```
    SELECT l.titulo, e.nombre
    FROM libros l
    INNER JOIN editoriales e
    ON l.id_editorial = e.id_editorial
    LIMIT 0, 25;
    ```

12. Libro y género

    ```
    SELECT l.titulo, g.nombre
    FROM libros l
    INNER JOIN generos g
    ON l.id_genero = g.id_genero;
    ```

13. Libro, autor y género

    ```
    SELECT l.titulo, a.nombre, a.apellido1, g.nombre
    FROM libros l
    INNER JOIN autores a
    ON l.id_autor = a.id_autor
    INNER JOIN generos g
    ON l.id_genero = g.id_genero;
    ```

14. Libro, autor, género y editorial

    ```
    SELECT l.titulo, a.nombre, a.apellido1, g.nombre, e.nombre
    FROM libros l
    INNER JOIN autores a
    ON l.id_autor = a.id_autor
    INNER JOIN generos g
    ON l.id_genero = g.id_genero
    INNER JOIN editoriales e
    ON l.id_editorial = e.id_editorial
    ```

    ```
    SELECT l.titulo "Título", 
            CONCAT_WS(" ", a.nombre, a.apellido1, a.apellido2) "Autor", 
            g.nombre "Género", 
            e.nombre "Editorial"
    FROM libros l
    INNER JOIN autores a
    ON l.id_autor = a.id_autor
    INNER JOIN generos g
    ON l.id_genero = g.id_genero
    INNER JOIN editoriales e
    ON l.id_editorial = e.id_editorial;
    ```

15. -----------------------

    ```
    SELECT a.nombre, a.apellido1, l.titulo, p1.pais AS "Pais del autor", p2.pais AS "Pais de la editorial"
    FROM autores a
    INNER JOIN libros l
    ON a.id_autor = l.id_autor
    INNER JOIN editorales e
    ON l.id_editorial = e.id_editorial
    INNER JOIN Paises p1
    ON a.id_pais = p1.id_pais
    INNER JOIN Paises p2
    ON e.id_pais = p2.id_pais;
    ```