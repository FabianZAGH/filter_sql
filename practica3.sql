--ENUNCIADO 1: Crear un select que liste  los registros cuyos números de teléfono inicien con (0 -  5 - 2) y que finalice en 1 o 8 además que la tercera letra del nombre sea una vocal.--
SELECT *
FROM EMPLOYEES
WHERE 
    SUBSTR(PHONE_NUMBER, 1, 1) IN ('0', '2', '5')
    AND SUBSTR(PHONE_NUMBER, -1) IN ('1', '8')
    AND SUBSTR(FIRST_NAME, 3, 1) IN ('a', 'e', 'i', 'o', 'u');

*--ENUNCIADO 2: Realice una consulta de muestre el nombre, el apellido y nombre de departamento de los empleados cuyo número telefónico consta 12 caracteres (código de país (3), código de área (3), # tel. (4)) el código de país inicia con 0 y tiene números impares en la posición 2y3 , el código de área solo números impares y el  número de teléfono debe de terminar con los números del 1  al 9--
SELECT e.FIRST_NAME AS NOMBRE, 
e.LAST_NAME AS APELLIDO, 
d.DEPARTMENT_NAME AS NOMBRE_DEPARTAMENTO
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE LENGTH(e.PHONE_NUMBER) = 12
AND SUBSTR(e.PHONE_NUMBER, 1, 1) = '0'
AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 2, 1)) MOD 2 = 1
AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 3, 1)) MOD 2 = 1
AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 4, 1)) MOD 2 = 1
AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 5, 1)) MOD 2 = 1
AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 6, 1)) MOD 2 = 1
AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 7, 1)) MOD 2 = 1
AND TO_NUMBER(SUBSTR(e.PHONE_NUMBER, 8, 1)) MOD 2 = 1
AND SUBSTR(e.PHONE_NUMBER, -1) IN ('1', '3', '5', '7', '9');

--ENUNCIADO 3: Dada la siguiente hilera cambie los espacios en blanco por comas, utilice REGEXP_REPLACE Elizabeth   Bishop   36736-36738   976.063  02/08/1911 --
SELECT REGEXP_REPLACE('Elizabeth   Bishop   36736-36738   976.063  02/08/1911', ' +', ',') AS NUEVA_HILERA
FROM DUAL;


--ENUNCIADO 4: Dada la siguiente hilera, proceda a dejar eliminar los espacios repetidos y deje solo un espacio entre palabra y palabra, utilice REGEXP_REPLACE. 500    Oracle     Parkway,    Redwood  Shores,    CA--
SELECT REGEXP_REPLACE('500    Oracle     Parkway,    Redwood  Shores,    CA', ' +', ' ') AS NUEVA_HILERA
FROM DUAL;


--ENUNCIADO 5: En la tabla employees por medio de una expresión regular separe por medio de un espacio cada una de las letras de la columna Country_name, utilice REGEXP_REPLACE Australia  ? A u s t r a l i a--
SELECT
REGEXP_REPLACE(COUNTRY_NAME, '([A-Za-z])', ' \1', 1, 0, 'i') AS NOMBRE_SEPARADO
FROM COUNTRIES;


--ENUNCIADO 6: Desarrolle una consulta que liste los países por región, los datos que debe mostrar son: el código de la región y nombre de la región con los nombres de sus países.--
SELECT r.REGION_ID, r.REGION_NAME, c.COUNTRY_NAME
FROM REGIONS r
INNER JOIN COUNTRIES c ON r.REGION_ID = c.REGION_ID
ORDER BY r.REGION_ID, c.COUNTRY_NAME;


--ENUNCIADO 7: Realice una consulta que muestre el código, nombre, apellido, inicio y fin del historial de trabajo de los empleados.--
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, jh.START_DATE, jh.END_DATE
FROM EMPLOYEES e
INNER JOIN JOB_HISTORY jh ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID, jh.START_DATE;


--ENUNCIADO 8: Realice una consulta que muestres el código de la región, nombre de la región y el nombre de los países que se encuentran en “Asia”.--
SELECT r.REGION_ID AS CODIGO_REGION, 
r.REGION_NAME AS NOMBRE_REGION, 
c.COUNTRY_NAME AS NOMBRE_PAIS
FROM REGIONS r
JOIN COUNTRIES c ON r.REGION_ID = c.REGION_ID
WHERE r.REGION_NAME = 'Asia';


--ENUNCIADO 9: Crea un select que presente en pantalla el nombre y apellido del empleado, el departamento donde trabaja, el salario y utilizando la sentencia DECODE escriba el mensaje “Con comisión” para los empleados que tienen comisión y “Sin comisión” para los que no tienen.--
SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, e.SALARY,
DECODE(e.COMMISSION_PCT, NULL, 'Sin comisión', 'Con comisión') AS ESTADO_COMISION
FROM EMPLOYEES e
INNER JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 19.	Crear un select donde liste el nombre, nombre de departamento y 
--ciudad a la que pertenece cada empleado.

SELECT e.first_name || ' ' || e.last_name AS nombre_empleado,
       d.department_name AS nombre_departamento,
       l.city AS ciudad
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
JOIN hr.locations l ON d.location_id = l.location_id;

--20.	Hacer un select donde muestre el nombre, salario, fecha de contrataci?n 
--y fecha de finalizaci?n para cada empleado del departamento 80.

SELECT e.first_name || ' ' || e.last_name AS nombre_empleado,
       e.salary AS salario,
       e.hire_date AS fecha_contratacion,
       j.end_date AS fecha_finalizacion
FROM hr.employees e
LEFT JOIN hr.job_history j ON e.employee_id = j.employee_id
WHERE e.department_id = 80;

--21.	Crear un select utilizando para traer todos los departamentos 
--que no tengan  locaciones

SELECT d.department_id, d.department_name
FROM hr.departments d
LEFT JOIN hr.locations l ON d.location_id = l.location_id
WHERE l.location_id IS NULL;

-- 22.	Crear un select donde traiga todos los empleados que ganen m?s que el 
--empleado con el promedio del salario de la tabla empleados.

SELECT e.first_name || ' ' || e.last_name AS nombre_empleado,
       e.salary AS salario
FROM hr.employees e
WHERE e.salary > (SELECT AVG(salary) FROM hr.employees);

-- 23.	Crear un select que traiga los empleados y puestos de los est?n en 
--por encima de los salario m?ximo para los departamentos 80,50,70

SELECT e.first_name || ' ' || e.last_name AS nombre_empleado,
       d.department_name AS nombre_departamento,
       j.job_title AS puesto
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
JOIN hr.job_history jh ON e.employee_id = jh.employee_id
JOIN hr.jobs j ON jh.job_id = j.job_id
WHERE e.salary > (
    SELECT MAX(salary)
    FROM hr.employees
    WHERE department_id IN (80, 50, 70));

--24.	Crear un select que extraiga los empleados y puestos de los est?n en
--dentro del rango de salario de todos los empleados del departamento 50

SELECT e.first_name || ' ' || e.last_name AS nombre_empleado,
       j.job_title AS puesto
FROM hr.employees e
JOIN hr.jobs j ON e.job_id = j.job_id
WHERE e.salary BETWEEN (
    SELECT MIN(salary)
    FROM hr.employees
    WHERE department_id = 50
) AND (
    SELECT MAX(salary)
    FROM hr.employees
    WHERE department_id = 50);
    
-- 25.	Listar el departamento , el salario total de los departamentos que  
--la suma de sus salario sea mayor a 20000 

SELECT d.department_name AS nombre_departamento,
       SUM(e.salary) AS salario_total
FROM hr.departments d
JOIN hr.employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 20000;

-- 26.	Crear un select que presente el id del puesto, la descripci?n del 
--puesto, la cantidad de empleados para departamentos que tengan de 4 empleados.

SELECT j.job_id AS id_puesto,
       j.job_title AS descripcion_puesto,
       COUNT(e.employee_id) AS cantidad_empleados
FROM hr.jobs j
JOIN hr.employees e ON j.job_id = e.job_id
JOIN hr.departments d ON e.department_id = d.department_id
GROUP BY j.job_id, j.job_title
HAVING COUNT(e.employee_id) >= 4;

-- 27.	Desplegar un select donde desplegu? los puestos donde el promedio de 
--los salario sea mayor a 10000.

SELECT j.job_id AS id_puesto,
       j.job_title AS descripcion_puesto,
       AVG(e.salary) AS promedio_salario
FROM hr.jobs j
JOIN hr.employees e ON j.job_id = e.job_id
GROUP BY j.job_id, j.job_title
HAVING AVG(e.salary) > 10000;