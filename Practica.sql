/*PRACTICA #1 GRUPO -Lenguaje de Base de Datos
INTEGRANTES: ROOSEMBERG OBANDO HIDALGO
             ALEXANDER TORRES HERNANDEZ
             ALEJANDRO SOTO SANCHEZ
             FABI??N ZÚÑIGA AGÜERO
             
 A CONTINUACION SE PRESENTA LA SOLUCION DE LA PRACTICA 1:         
*/

--ENUNCIADO 1.Crear un tabla  TEST de dos columnas ( Nombre varchar2(80), puesto varchar2(10))
CREATE TABLE TEST (
Nombre VARCHAR2(80),
Puesto VARCHAR2(10)
);

--ENUNCIADO 2.Hacer la inserción de 2 registros a la tabla creada.
INSERT INTO TEST (Nombre, Puesto)
VALUES ('Empleado1', 'Puesto1');

INSERT INTO TEST (Nombre, Puesto)
VALUES ('Empleado2', 'Puesto2');


--ENUNCIADO 3.Hacer la inserción de los todos los  registros concatenados de la tabla employees en la tabla test.

INSERT INTO TEST (Nombre, puesto)
SELECT First_Name || ' ' || Last_Name, JOB_ID
FROM HR.EMPLOYEES;

/*Este es si el campo de Puesto fuera mayor a 10 caracteres
Para que tome la descripcion completa del puesto de trabajo*/
    /*INSERT INTO TEST (Nombre, puesto)
    SELECT e.First_Name || ' ' || e.Last_Name, j.JOB_TITLE
    FROM HR.EMPLOYEES e
    INNER JOIN HR.JOBS j ON e.JOB_ID = j.JOB_ID;*/

--ENUNCIADO 4.Modificar la tabla creada añadiendo una columna(nombre de departamento varchar 2(20))

ALTER TABLE TEST
ADD NOMBRE_DEPARTAMENTO VARCHAR2(20);

--ENUNCIADO 5.Crear una tabla test1 basado en un select de la tabla de empleados, escoja las columnas que guste.

CREATE TABLE TEST1 AS
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, JOB_ID, SALARY
FROM HR.EMPLOYEES;

--ENUNCIADO 6.Crear una selección del nombre utilizando la cláusula de distinct en la tabla de employees esquema HR.
SELECT DISTINCT FIRST_NAME
FROM HR.EMPLOYEES;

--ENUNCIADO 7.Hacer un update a un registro subiendo el salario en un 10% a los empleados que no tienen comisión
UPDATE HR.EMPLOYEES
SET Salary = Salary * 1.1
WHERE Commission_pct IS NULL;

 /* 
--ENUNCIADO 8.Hacer un update en employees al salario en un  10%  de aumento  cuando el salario  sea  menor a 5000 y 
 el departamento no sea 30
 */
 UPDATE HR.EMPLOYEES
SET Salary = Salary * 1.1
WHERE Salary < 5000 AND Department_id <> 30;

--ENUNCIADO 9.Hacer un borrado de un registro de la tabla creada donde el empleado se llame Peter
DELETE FROM TEST1
WHERE first_name = 'Peter';

--ENUNCIADO 10.Eliminar la tabla test1 creada utilizando el comando DROP
DROP TABLE TEST1;

--ENUNCIADO 11.Crear una concatenación de la columna de nombre y apellido  con el alias NOMBRE
SELECT First_Name || ' ' || Last_Name AS NOMBRE
FROM HR.EMPLOYEES;

--ENUNCIADO 12.	Ejecute un select donde se impriman en pantalla los tres tipos de alias que podemos usar.

SELECT 
  First_Name as "Nombre",
  Last_Name "Segundo Nombre",
  Salary Salario
FROM HR.EMPLOYEES;


 /* 
--ENUNCIADO 13.Ejecutar un select de los puestos de la tabla employees donde sea presentado en pantalla 
     un único registro por puesto.
 */
SELECT DISTINCT E.JOB_ID, J.JOB_TITLE
FROM HR.EMPLOYEES E
JOIN HR.JOBS J ON E.JOB_ID = J.JOB_ID;

--ENUNCIADO 14:Crear una tabla de TEST con los siguientes campos ( ID_EMP, NOMBRE, ID_PUESTO,FECHA, ID_DEPARTAMENTO).

CREATE TABLE TEST (
    ID_EMP NUMBER,
    NOMBRE VARCHAR2(50),
    ID_PUESTO NUMBER,
    FECHA DATE DEFAULT SYSDATE,
    ID_DEPARTAMENTO NUMBER
);

--ENUNCIADO 15:Crear una llave primaria en el campo ID_EMP.

ALTER TABLE TEST
ADD CONSTRAINT PK_TEST PRIMARY KEY (ID_EMP);

--ENUNCIADO 16:Crear una llave UNICA en el campo ID_PUESTO.

ALTER TABLE TEST
ADD CONSTRAINT UK_ID_PUESTO UNIQUE (ID_PUESTO);

--ENUNCIADO 17:Crear un constraint de fecha tipo default para el campo FECHA.

ALTER TABLE TEST
MODIFY FECHA DEFAULT SYSDATE;

--ENUNCIADO 18:Crear una tabla llamada departamentos que contenga (id_departamento,descripción), poblarla mediante un select con los datos de la tabla DEPARTMENTS.

CREATE TABLE DEPARTAMENTOS 
SELECT DEPARTMENT_ID AS ID_DEPARTAMENTO, DEPARTMENT_NAME AS DESCRIPCION
FROM DEPARTMENTS;

ALTER TABLE DEPARTAMENTOS
ADD CONSTRAINT PK_DEPARTAMENTOS PRIMARY KEY (ID_DEPARTAMENTO);



/*CREATE TABLE departamentos (
    id_departamento NUMBER,
    descripción VARCHAR2(255)
);

INSERT INTO departamentos (id_departamento, descripción)
SELECT department_id, department_name FROM hr.departments;*/

--ENUNCIADO 19:Crear una llave foránea entre la tabla de DEPARTAMENTOS y la tabla de TEST

ALTER TABLE TEST
ADD CONSTRAINT FK_TEST_DEPT FOREIGN KEY (ID_DEPARTAMENTO)
REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO);

--ENUNCIADO 20:Por medio de INSERT poblar la tabla test con los campos requeridos al menos 5 registros.

INSERT INTO TEST (ID_EMP, NOMBRE, ID_PUESTO, ID_DEPARTAMENTO)
VALUES (1, 'Alex', 101, 10);
INSERT INTO TEST (ID_EMP, NOMBRE, ID_PUESTO, ID_DEPARTAMENTO)
VALUES (2, 'Pedro', 100, 30);
INSERT INTO TEST (ID_EMP, NOMBRE, ID_PUESTO, ID_DEPARTAMENTO)
VALUES (3, 'Edgar', 102, 15);
INSERT INTO TEST (ID_EMP, NOMBRE, ID_PUESTO, ID_DEPARTAMENTO)
VALUES (4, 'Maria', 111, 9);
INSERT INTO TEST (ID_EMP, NOMBRE, ID_PUESTO, ID_DEPARTAMENTO)
VALUES (5, 'Lucia', 121, 13);

--ENUNCIADO 21:Anadir una columna a la tabla test llamada nueva_columna (varchar2 (12)).

ALTER TABLE TEST
ADD nueva_columna VARCHAR2(12);

--ENUNCIADO 22:Modificar a number el tipo de nueva_columna.

ALTER TABLE TEST
MODIFY nueva_columna NUMBER;

--ENUNCIADO 23:Crear una tabla de PRACTICA  con los siguientes campos ( ID EMPLEADO, NOMBRE EMPLEADO, ID_PUESTO,ID_DEPARTAMENTO)

CREATE TABLE PRACTICA (
    ID_EMPLEADO NUMBER,
    NOMBRE_EMPLEADO VARCHAR2(50),
    ID_PUESTO NUMBER,
    ID_DEPARTAMENTO NUMBER
);

--ENUNCIADO 24:Crear un llave compuesta primaria compuesta  por los campos 1 y 2 de la tabla PRACTICA

ALTER TABLE PRACTICA
ADD CONSTRAINT PK_PRACTICA PRIMARY KEY (ID_EMPLEADO, NOMBRE_EMPLEADO);

--ENUNCIADO 25:Crear una llave de chequeo para que trabajadores del departamento 50 no puedan ser insertados en la tabla.

ALTER TABLE PRACTICA
ADD CONSTRAINT CHK_DEPT CHECK (ID_DEPARTAMENTO != 50);

--ENUNCIADO 26:Anadir una columna llamada CN en la tabla PRACTICA.

ALTER TABLE PRACTICA
ADD CN NUMBER;

--ENUNCIADO 27:Por medio de INSERTS llenar la tabla con los datos solicitados e ingresándolos por el department_id.

INSERT INTO practica (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO)
SELECT TEST.ID_EMP, TEST.NOMBRE, TEST.ID_PUESTO, test.id_departamento
FROM TEST;

--ENUNCIADO 28:Agregar un valor al SALARIO por defecto para  esa columna. 

ALTER TABLE PRACTICA
ADD SALARIO DECIMAL(10, 2) DEFAULT 0;

--ENUNCIADO 29:Hacer una inserción de  nuevos datos en la tabla nueva 

INSERT INTO PRACTICA (ID_EMPLEADO, NOMBRE_EMPLEADO, ID_PUESTO, ID_DEPARTAMENTO, CN)
VALUES (1, 'John Doe', 1, 30, 001);

--ENUNCIADO 30:Crear una selección de los empleado cuyo puesto sea ST_CLERK

SELECT e.employee_id, e.first_name, e.last_name, j.job_title
FROM hr.employees e
JOIN hr.jobs j ON e.job_id = j.job_id
WHERE j.job_title = 'ST_CLERK';

--ENUNCIADO 31:Hacer una modificación de datos en la Tabla PRACTICA utilizando el comando UPDATE

UPDATE PRACTICA
SET SALARIO = 50000  -- Nuevo salario
WHERE ID_EMPLEADO = 2;

--ENUNCIADO 32:Borrar datos de la tabla PRACTICA con el comando DELETE.

DELETE FROM PRACTICA
WHERE ID_DEPARTAMENTO = 30;

--ENUNCIADO 33:Crear un select de la tabla EMPLOYEES en el cual incluya las tres variaciones de alias.
/*•	Mayúscula - Minúscula
•	Dos palabras
•	Minúsculas*/

-- Variación 1: Mayúscula - Minúscula
SELECT employee_id AS EmployeeID_Mixed,
       first_name AS FirstName_Mixed,
       last_name AS LastName_Mixed
FROM employees;

-- Variación 2: Dos palabras
SELECT employee_id AS Employee_ID,
       first_name AS First_Name,
       last_name AS Last_Name
FROM employees;

-- Variación 3: Minúsculas
SELECT employee_id AS employeeid_lower,
       first_name AS firstname_lower,
       last_name AS lastname_lower
FROM employees;

--ENUNCIADO 34: Crea un select donde concatene de las columnas (LAST_NAME, FIRST_NAME) bajo el alias de nombre. 
		--Ej.: John Smith

SELECT (LAST_NAME || ', ' || FIRST_NAME) AS "Nombre Completo"
FROM employees;

--ENUNCIADO 35:Crear un select donde concatene dos columnas y haga uso de literales, haga uso de un alias.

SELECT (FIRST_NAME || ', ' || LAST_NAME || ' trabaja en el departamento ' || DEPARTMENT_ID) AS informacion_empleado
FROM employees;

--ENUNCIADO 36:Crear un select de la tabla EMPLOYEES tengan una vocal en la tercera letra del nombre

SELECT first_name
  FROM employees
  where first_name LIKE '__a%'
  or first_name like '__e%'
  or first_name like '__i%'
  or first_name like '__o%'
  or first_name like '__u%';
  
/*  SELECT *
FROM employees
WHERE first_name LIKE '__[AEIOU]%' OR first_name LIKE '__[aeiou]%';*/

--ENUNCIADO 37:Proceda a implementar un select donde incluya los salarios que estén por abajo de 20000 y que sean mayores a 5000.

SELECT SALARY ||' '|| FIRST_NAME AS NOMBRE_Y_SALARIO
FROM employees
WHERE SALARY < 20000 AND SALARY > 5000;

/*ENUNCIADO 38:Crear un select que muestre la cantidad de caracteres, el nombre 
y apellido de los empleados que tienen la letra “b?? después del tercer carácter*/

SELECT LENGTH(first_name || ' ' || last_name) AS cantidad_de_caracteres,
       first_name AS nombre,
       last_name AS apellido
FROM employees
WHERE SUBSTR(first_name, 4, 1) = 'b' OR SUBSTR(last_name, 4, 1) = 'b';

/*ENUNCIADO 39:Se desea conocer los empleados que tengan como puestos las 
siguientes categorías (st_clerk,sa_rep, it_prog) de la tabla de empleados.*/

SELECT (FIRST_NAME ||', '|| LAST_NAME || ' tiene el puesto de ' || JOB_ID) AS "Nombre Completo y Puesto"
FROM employees
WHERE job_id IN ('ST_CLERK', 'SA_REP', 'IT_PROG');

/*ENUNCIADO 40:Se desea conocer los empleados que tengan un salario mayor
a 5000 y menor a 15000 de la tabla de empleados y que la letra inicial de su apellido de P*/

SELECT *
FROM employees
WHERE SALARY > 5000 AND SALARY < 15000 AND UPPER(SUBSTR(last_name, 1, 1)) = 'P';

/*ENUNCIADO 41: Busque los empleados que tengan como letra inicial la letra N 
de la tabla de empleados*/

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'N%';

/*ENUNCIADO 42: Liste por medio de un select los empleados que tengan la 
comisión en NULL*/

SELECT * 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

/*ENUNCIADO 43: Crear un listado de los empleados que no gane comisión 
y que su salario sea menor a 20000*/

SELECT * 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL AND SALARY < 20000;

/*ENUNCIADO 44: Crear un Select de la tabla de EMPLOYEES  donde el puesto 
sea ST_CLERK o que el salario sea mayor a 40000*/

SELECT *
FROM EMPLOYEES e, DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID AND d.DEPARTMENT_ID='ST_CLERK' OR
SALARY > 4000;

/*ENUNCIADO 45: Busque los empleados que tengan la letra “e” en la segunda 
posición del nombre y que la penúltima letra del apellido sea  una vocal*/

SELECT * 
F(FIRST_NAME, 2,1

/*ENUNCIADO 46: Crear un select de los empleados que no trabajen en 
los departamentos (80,70,90)*/

SELECT * 
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN (80, 70, 90);

/*ENUNCIADO 47: Crear un select que de un reporte de los salarios 
ordenados de mayos a menor en orden descendente*/

SELECT * 
FROM EMPLOYEES
ORDER BY SALARY DESC;

/*ENUNCIADO 48: Crear un select que de un reporte de los empleados ordenados 
por nombre  de en forma alfabética  en orden ascendente y por  departamento 
en orden descendente */

SELECT * 
FROM EMPLOYEES
ORDER BY FIRST_NAME ASC, DEPARTMENT_ID DESC;

/*ENUNCIADO 49: Haga una consulta de la tabla de empleados donde presente los 
datos del nombre, apellido, puesto de trabajo utilizando la función LOWER*/

SELECT LOWER(FIRST_NAME) AS NOMBRE_MINUSCULA, LOWER(LAST_NAME) AS APELLIDO_MINUSCULAS,
LOWER(JOB_ID) AS TRABAJO_MINUSCULAS 
FROM EMPLOYEES;

/*ENUNCIADO 50: Haga una consulta de la tabla de empleados donde presente los 
datos del nombre, apellido, puesto de trabajo utilizando la función UPPER*/

SELECT UPPER(FIRST_NAME) AS NOMBRE_MAYUSCULA, UPPER(LAST_NAME) AS APELLIDO_MAYUSCULA,
UPPER(JOB_ID) AS TRABAJO_MAYUSCULA 
FROM EMPLOYEES;

/*ENUNCIADO 51: Haga una consulta de la tabla de empleados donde presente los 
datos concatenados del nombre, apellido, en otra columna el puesto de trabajo 
utilizando la función INITCAP */

SELECT CONCAT(INITCAP(FIRST_NAME), ' ',(LAST_NAME) AS NOMBRE_Y_APELLIDOS
FROM EMPLOYEES;

/*ENUNCIADO 52: Crear un código de empleado que contenga los siguiente:
Letras del nombre 2,3,4 
Letras del apellido las tres ultimas 
Job_id*/

SELECT SUBSTR(FIRST_NAME,2,3) || SUBSTR(LAST_NAME, 3,3) AS CODIGO
FROM EMPLOYEES;
