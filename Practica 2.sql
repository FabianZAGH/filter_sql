/*Integrantes
-ALEJANDRO SOTO SANCHEZ
-Alexander Torres Hernandez
- Fabian Zuniga Aguero
-
*/

--ENUNCIADO 1:Crear un select que concatene el nombre y el apellido dejando un 
--espacio entre ellos debe de presentar los datos en mayúscula.


SELECT UPPER(FIRST_NAME||' '||LAST_NAME) AS nombre_apellido
FROM EMPLOYEES;

--ENUNCIADO 2:Crear una dirección de correo que contenga las dos primeras 
--letras del  nombre,  las 4 últimas del apellido  la “@” y la extensión 'example.com'

SELECT 
    LOWER(SUBSTR(FIRST_NAME, 1, 2)) || LOWER(SUBSTR(LAST_NAME, -4)) || '@example.com' AS direccion_correo
FROM EMPLOYEES;

--ENUNCIADO 3: Utilizando la función LENGTH  proceda a encontrar la longitud de 
--cada uno de los apellidos de la tabla de EMPLOYEES.

SELECT LAST_NAME AS APELLIDO, LENGTH(LAST_NAME) AS "LONGITUD APELLIDO"
FROM EMPLOYEES;

--ENUNCIADO 4:Crear un select donde justifique  a la izquierda con el símbolo –
--(guión), para que la columna devuelva 15 caracteres por registro.

SELECT RPAD(FIRST_NAME, 15, '-') AS columna_justificada
FROM EMPLOYEES;

--ENUNCIADO 5:Crear un select donde justifique  a la derecha con el símbolo – 
--(guión), para que la columna devuelva 15 caracteres por registro.

SELECT LPAD(LAST_NAME, 15, '-') AS columna_justificada
FROM EMPLOYEES;

--ENUNCIADO 6:Crear un select donde se indique la posición de la letra 
--indicada por el usuario en la columna first_name, se debe de presentar en
--pantalla además de la columna first_name y last_name.

SELECT
    FIRST_NAME,
    LAST_NAME,
    INSTR(FIRST_NAME, 'a') AS posicion_letra_a
FROM
    EMPLOYEES;

--ENUNCIADO 7:Crear un select donde cambie todas las letras “a” de los 
--registros first_name y last_name  por la letra X.

-- Solo las "a" minusculas
SELECT
    REPLACE(FIRST_NAME, 'a', 'X') AS nombre_modificado,
    REPLACE(LAST_NAME, 'a', 'X') AS apellido_modificado
FROM
    EMPLOYEES;

-- Mayusculas y minusculas

    SELECT
    REPLACE(REPLACE(first_name, 'a', 'X'), 'A', 'X') AS nombre_modificado,
    REPLACE(REPLACE(last_name, 'a', 'X'), 'A', 'X') AS apellido_modificado
FROM
    EMPLOYEES;

--ENUNCIADO 8.crear un select donde se impriman los apellidos con menos de 5 letras.

SELECT LAST_NAME
FROM EMPLOYEES
WHERE LENGTH(LAST_NAME) < 5;

--ENUNCIADO 9.Crear una select donde se redondee la suma del salario con la columna comisión de todos los empleados que tengan comisión.

SELECT ROUND(SUM(SALARY + COMMISSION_PCT), 2) AS suma_redondeada
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

--ENUNCIADO 10.Crear una select donde se trunque el cálculo de .la antigüedad expresada en meses para los empleados del departamento 80.

SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) AS antiguedad_en_meses
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;


--ENUNCIADO 11.Crear un select donde imprima los nombres con vocales al inicio del nombre y en su penúltima letra.(REGEXP_LIKE)

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(FIRST_NAME, '^[aeiouAEIOU].*([aeiouAEIOU].){1}$');

--ENUNCIADO 12.Crear un select que imprima los apellidos que contengan espacio en cualquier punto de su hilera. (REGEXP_LIKE)

SELECT LAST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(LAST_NAME, ' ');

--ENUNCIADO 13.Crear un expresión regular que muestre los apellidos que inician con D y que tengan como segunda letra una “a” o una “e” y que además no hayan espacios en blanco en el apellido, use REGEXP_LIKE.

SELECT LAST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(LAST_NAME, '^D[aeAE].*$') AND NOT REGEXP_LIKE(LAST_NAME, ' ');

--ENUNCIADO 14.Buscar por medio de un select los nombres que tengan una o ninguna una vocal como segunda letra.

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(FIRST_NAME, '^.[^aeiouAEIOUAEIOU]*[aeiouAEIOU]?[^aeiouAEIOUAEIOU]*$');

--ENUNCIADO 15.Buscar por medio de un select los nombres que tengan una o más vocales como tercera letra

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(SUBSTR(FIRST_NAME, 3, 1), '[AEIOU]', 'i');

--ENUNCIADO 16.Buscar por medio de un select los nombre tengan cero o más vocales como penúltima letra

SELECT FIRST_NAME
FROM EMPLOYEES
WHERE REGEXP_LIKE(FIRST_NAME, '[aeiouAEIOU]*[^aeiouAEIOU][aeiouAEIOU]*$', 'i');

--ENUNCIADO 17.Crear esquema

CREATE TABLE tab_caracteres(
id_caract NUMBER,
caracteres VARCHAR2(60),
tipo_caract VARCHAR2(90));

--ENUNCIADO 18.Crear un select que busque los registros con solo caracteres numéricos de la tabla tab_caracteres use REGEXP_LIKE

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '^[0-9]+$');

--ENUNCIADO 19.Crear un select que busque los registros que solo contengan letras de la tabla tab_caracteres use REGEXP_LIKE

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '^[A-Za-z]+$');

--ENUNCIADO 20.Crea un select que busque los registros que contengan alguna vocal repetida al menos 2 veces en la tabla caracteres use REGEXP_LIKE (utilice[]{m,})

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '([aeiouAEIOU]).*\1');

--ENUNCIADO 21.Crea un select que busque los registros que contengan al menos 2 espacios y máximo espacios en la tabla caracteres use REGEXP_LIKE(utilice {m,})

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '^([^ ]* ){2}[^ ]*');

--ENUNCIADO 22.Crea un select que busque los registros que estén separados por un punto en la tabla caracteres use REGEXP_LIKE

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '[^.]+\.[^.]+');

--ENUNCIADO 23.Crear una expresión regular que valide que el dato que se evalué sea un numero entero, positivo y no tenga decimales, el separador de decimales puede ser un punto o una coma, utilice REGEXP_LIKE

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '^[0-9]+([.,][0-9]*)?$');

--ENUNCIADO 24.Crear una expresión regular que busque tres dígitos consecutivos en una palabra en la tabla de caracteres utilice REGEXP_LIKE. (utilice []{m,})

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '^[0-9]{3}');

--ENUNCIADO 25.Crear una expresión regular que busque tres dígitos consecutivos al inicio en la tabla de caracteres utilice REGEXP_LIKE.. (utilice []{m,})

SELECT * 
FROM tab_caracteres
WHERE REGEXP_LIKE(CARACTERES, '^[0-9]{3}');
