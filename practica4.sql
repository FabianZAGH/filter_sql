/*Integrantes
-ALEJANDRO SOTO SANCHEZ
-Alexander Torres Hernandez
-
-
*/


/*ENUNCIADO 1: Crear una funci�n que devuelva la cantidad de meses que ha 
laborado el empleado que se env�e por par�metro 
*/

CREATE OR REPLACE FUNCTION calcular_meses_laborados (
    p_id_employee IN NUMBER
) RETURN NUMBER
IS
    v_fecha_contratacion DATE;
    v_meses_laborados NUMBER;
BEGIN
    -- Obtener la fecha de contrataci�n del empleado
    SELECT HIRE_DATE INTO v_fecha_contratacion
    FROM employees
    WHERE employee_id = p_id_employee;

    -- Calcular la cantidad de meses laborados
    v_meses_laborados := MONTHS_BETWEEN(SYSDATE, v_fecha_contratacion);

    -- Redondear a meses enteros
    v_meses_laborados := ROUND(v_meses_laborados);

    -- Retornar el resultado
    RETURN v_meses_laborados;
END;

SELECT calcular_meses_laborados(115) AS meses_laborados FROM dual;
--ID del empleado que desea consultar en este caso el 115

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*ENUNCIADO 2: Crear una funci�n que duplique en valor del n�mero enviado en 
caso de que sea par o que lo triplique en caso de que sea impar.
*/

CREATE OR REPLACE FUNCTION duplicar_o_triplicar (
    p_numero IN NUMBER
) RETURN NUMBER
IS
    v_resultado NUMBER;
BEGIN
    IF MOD(p_numero, 2) = 0 THEN
        -- El n�mero es par, duplicarlo
        v_resultado := p_numero * 2;
    ELSE
        -- El n�mero es impar, triplicarlo
        v_resultado := p_numero * 3;
    END IF;

    -- Retornar el resultado
    RETURN v_resultado;
END;

-- Con n�mero par
SELECT duplicar_o_triplicar(4) AS resultado FROM dual;

--Con n�mero impar
SELECT duplicar_o_triplicar(7) AS resultado FROM dual;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*ENUNCIADO 3: Utilizando un cursor  liste los empleados del job_id que el 
usuario envi� por par�metro. 
*/

CREATE OR REPLACE PROCEDURE listar_empleados_por_job (
    p_job_id IN VARCHAR2
)
IS
    -- Declaraci�n del cursor
    CURSOR empleados_cursor IS
        SELECT employee_id, first_name, job_id
        FROM employees
        WHERE job_id = p_job_id;

    -- Variables para almacenar los resultados del cursor
    v_employee_id employees.employee_id%TYPE;
    v_first_name employees.first_name%TYPE;
    v_job_id employees.job_id%TYPE;
BEGIN
    -- Abrir el cursor
    OPEN empleados_cursor;

    -- Recorrer los resultados del cursor
    LOOP
        -- Fetch los resultados en las variables
        FETCH empleados_cursor INTO v_employee_id, v_first_name, v_job_id;

        -- Salir del bucle si no hay m�s filas
        EXIT WHEN empleados_cursor%NOTFOUND;

        -- Imprimir o hacer algo con la informaci�n del empleado
        DBMS_OUTPUT.PUT_LINE('Empleado ID: ' || v_employee_id || ', Nombre: ' ||
        v_first_name || ', Job ID: ' || v_job_id);
    END LOOP;

    -- Cerrar el cursor
    CLOSE empleados_cursor;
END;

--Listar empleados con job_id 'PU_CLERK'
BEGIN
    listar_empleados_por_job('PU_CLERK');
END;
/
SET SERVEROUTPUT ON

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*ENUNCIADO 4: Desarrolle una funci�n a la que se le envi� por par�metro el 
n�merode departamento e imprima en pantalla la cantidad de empleados que 
integran ese departamento. 
*/

CREATE OR REPLACE FUNCTION cantidad_empleados_por_departamento (
    p_department_id IN NUMBER
) RETURN NUMBER
IS
    -- Variable para almacenar la cantidad de empleados
    v_cantidad_empleados NUMBER;
BEGIN
    -- Obtener la cantidad de empleados para el departamento dado
    SELECT COUNT(*) INTO v_cantidad_empleados
    FROM employees
    WHERE department_id = p_department_id;

    -- Imprimir la cantidad de empleados en pantalla
    DBMS_OUTPUT.PUT_LINE('Cantidad de empleados en el departamento ' ||
    p_department_id || ': ' || v_cantidad_empleados);

    /* Retornar la cantidad de empleados (puedes omitir esta l�nea si no 
    necesitas el valor en el c�digo cliente)*/
    RETURN v_cantidad_empleados;
END;

--Obtener la cantidad de empleados en el departamento 90
DECLARE
    v_resultado NUMBER;
BEGIN
    v_resultado := cantidad_empleados_por_departamento(90);
END;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*ENUNCIADO 5: Utilizando un cursor crear un SP que imprima en pantalla la fecha 
de contrataci�n para la tabla de empleados formateada a la siguiente hilera:
    --------Hoy es mi�rcoles 8 de julio del 2015.
*/

CREATE OR REPLACE PROCEDURE imprimir_fecha_contratacion
IS
    -- Declaraci�n del cursor
    CURSOR fecha_contratacion_cursor IS
        SELECT hire_date
        FROM employees;

    -- Variable para almacenar la fecha de contrataci�n
    v_fecha_contratacion DATE;
BEGIN
    -- Abrir el cursor
    OPEN fecha_contratacion_cursor;

    -- Recorrer los resultados del cursor
    LOOP
        -- Fetch la fecha de contrataci�n en la variable
        FETCH fecha_contratacion_cursor INTO v_fecha_contratacion;

        -- Salir del bucle si no hay m�s filas
        EXIT WHEN fecha_contratacion_cursor%NOTFOUND;

        -- Imprimir la fecha de contrataci�n formateada
        DBMS_OUTPUT.PUT_LINE('Hoy es ' || TO_CHAR(v_fecha_contratacion, 'fmDay 
        DD "de" fmMonth "del" YYYY', 'NLS_DATE_LANGUAGE = Spanish'));
    END LOOP;

    -- Cerrar el cursor
    CLOSE fecha_contratacion_cursor;
END;

-- Ejemplo: Imprimir la fecha de contrataci�n de todos los empleados
BEGIN
    imprimir_fecha_contratacion;
END;

/*ENUNCIADO 6: Crear un procedimiento almacenado con cursor con ciclo FOR que actualice
el salario en un 10% cuando este sea menor al del promedio del departamento que pertenece, 
debe de imprimir en pantalla cuantos salarios se actualizaron*/
CREATE OR REPLACE PROCEDURE actualizar_salarios AS
   v_promedio_salario NUMBER;
   v_total_actualizados NUMBER := 0;
BEGIN
   SELECT AVG(e.salary)
   INTO v_promedio_salario
   FROM employees e;

   FOR emp IN (SELECT employee_id, salary, department_id FROM employees) LOOP
      IF emp.salary < v_promedio_salario THEN
         UPDATE employees
         SET salary = salary * 1.1
         WHERE employee_id = emp.employee_id;

         v_total_actualizados := v_total_actualizados + 1;
      END IF;
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('Se actualizaron ' || v_total_actualizados || ' salarios.');
END actualizar_salarios;


/*Enunciado 7: Crear un SP que utilice un cursor y permita mostrar ordenados 
por el n�mero de empleado, nombre, departamento de todos los empleados de la tabla empleados*/
CREATE OR REPLACE PROCEDURE mostrar_empleados AS
BEGIN
   DECLARE
      CURSOR c_empleados IS
         SELECT employee_id, first_name, departament_id
         FROM employees
         ORDER BY employee_id;
   BEGIN
      OPEN c_empleados;

      DBMS_OUTPUT.PUT_LINE('N�mero de Empleado | Nombre | Departamento');
      DBMS_OUTPUT.PUT_LINE('-------------------|--------|--------------');
      
      FOR emp IN c_empleados LOOP
         DBMS_OUTPUT.PUT_LINE(
            TO_CHAR(emp.employee_id, '999999') || ' | ' ||
            RPAD(emp.first_name, 20) || ' | ' ||
            TO_CHAR(emp.departament_id, '9999')
         );
      END LOOP;

      CLOSE c_empleados;
   END;
END mostrar_empleados;


/*Enunciado 8: Desarrolle un procedimiento almacenado que permita conocer el 
n�mero de departamentos por regi�n y los imprima en pantalla*/
CREATE OR REPLACE PROCEDURE contar_departamentos_por_region AS
BEGIN
   FOR reg IN (SELECT DISTINCT region_id FROM departments) LOOP
      DECLARE
         v_cantidad_departamentos NUMBER;
      BEGIN
         -- Contar la cantidad de departamentos por regi�n
         SELECT COUNT(*) INTO v_cantidad_departamentos
         FROM departments
         WHERE region_id = reg.region_id;
         DBMS_OUTPUT.PUT_LINE('Regi�n ' || TO_CHAR(reg.region_id) || ': ' || v_cantidad_departamentos || ' departamentos');
      END;
   END LOOP;
END contar_departamentos_por_region;


/*Enunciado 9: Desarrolle unas funci�n que devuelva la cantidad de empleados 
del departamento que se env�e por par�metro*/
CREATE OR REPLACE FUNCTION obtener_cantidad_empleados(p_department_id NUMBER) RETURN NUMBER IS
   v_cantidad_empleados NUMBER;
BEGIN
   SELECT COUNT(*) INTO v_cantidad_empleados
   FROM employees
   WHERE department_id = p_department_id;
   RETURN v_cantidad_empleados;
END obtener_cantidad_empleados;


/*Enunciado 10: Crear un procedimiento almacenado que simule una tabla de multiplicar en sentido inverso. El procedimiento recibe por par�metro del multiplicador*/
CREATE OR REPLACE PROCEDURE tabla_multiplicar_inversa(p_multiplicador NUMBER) AS
BEGIN
   IF p_multiplicador <= 0 THEN
      DBMS_OUTPUT.PUT_LINE('Error: El multiplicador debe ser mayor que cero.');
      RETURN;
   END IF;

   DBMS_OUTPUT.PUT_LINE('Tabla de multiplicar del ' || p_multiplicador || ' en sentido inverso:');
   
   FOR i IN REVERSE 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE(p_multiplicador || ' x ' || i || ' = ' || p_multiplicador * i);
   END LOOP;
END tabla_multiplicar_inversa;
/






/*16. Crear un procedimiento que por medio de un cursor de sistema llame a otro
procedimiento y extraiga los datos del c�digo de empleado, nombre 
del departamento para los empleados cuyo nombre inicie con P como segunda 
letra puede tener una (i, a, e) y como pen�ltima una �a� o una �e� haga uso de
excepciones y gu�rdelas en una tabla de auditoria.*/

CREATE TABLE auditoria_empleados (
    id_audit NUMBER PRIMARY KEY,
    empleado_id NUMBER,
    nombre_departamento VARCHAR2(50),
    mensaje_error VARCHAR2(200),
    fecha_audit DATE DEFAULT SYSDATE
);

CREATE OR REPLACE PROCEDURE procesar_empleados AS
BEGIN
    -- Declarar un cursor de sistema
    FOR emp_rec IN (SELECT empleado_id, nombre FROM empleados WHERE SUBSTR(nombre, 2, 1) IN ('i', 'a', 'e') AND (SUBSTR(nombre, -1) = 'a' OR SUBSTR(nombre, -1) = 'e')) 
    LOOP
        -- Llamar al procedimiento secundario
        BEGIN
            procesar_empleado(emp_rec.empleado_id, emp_rec.nombre);
        EXCEPTION
            WHEN OTHERS THEN
                -- Capturar excepciones y guardarlas en la tabla de auditor�a
                INSERT INTO auditoria_empleados (empleado_id, nombre_departamento, mensaje_error)
                VALUES (emp_rec.empleado_id, emp_rec.nombre, SQLERRM);
        END;
    END LOOP;
END procesar_empleados;
/

CREATE OR REPLACE PROCEDURE procesar_empleado(p_empleado_id NUMBER, p_nombre VARCHAR2) AS
    v_departamento VARCHAR2(50);
BEGIN
    -- Realizar alguna l�gica para obtener el nombre del departamento
    -- Supongamos que se obtiene el nombre del departamento de alguna manera
    -- Aqu� simplemente se asigna un valor de ejemplo
    v_departamento := 'Departamento Ejemplo';

    -- Realizar alguna l�gica adicional seg�n tus requisitos

    -- Imprimir o almacenar los resultados
    DBMS_OUTPUT.PUT_LINE('Empleado: ' || p_empleado_id || ', Departamento: ' || v_departamento);
END procesar_empleado;
/

BEGIN
    procesar_empleados;
END;
/

/*17. Crear un procedimiento que por medio de un cursor de sistema llame a otro
procedimiento y extraiga los datos del c�digo de empleado y el nombre.*/

CREATE OR REPLACE PROCEDURE procesar_empleados AS
BEGIN
    -- Declarar un cursor de sistema
    FOR emp_rec IN (SELECT empleado_id, nombre FROM empleados WHERE SUBSTR(nombre, 2, 1) IN ('i', 'a', 'e') AND (SUBSTR(nombre, -1) = 'a' OR SUBSTR(nombre, -1) = 'e')) 
    LOOP
        -- Llamar al procedimiento secundario
        BEGIN
            procesar_empleado(emp_rec.empleado_id, emp_rec.nombre);
        EXCEPTION
            WHEN OTHERS THEN
                -- Capturar excepciones (puedes manejarlas seg�n tus necesidades)
                DBMS_OUTPUT.PUT_LINE('Error al procesar empleado ' || emp_rec.empleado_id || ': ' || SQLERRM);
        END;
    END LOOP;
END procesar_empleados;
/

CREATE OR REPLACE PROCEDURE procesar_empleado(p_empleado_id NUMBER, p_nombre VARCHAR2) AS
BEGIN
    -- Realizar alguna l�gica para procesar los datos del empleado
    -- Aqu� simplemente se imprime el c�digo de empleado y el nombre como ejemplo
    DBMS_OUTPUT.PUT_LINE('Empleado: ' || p_empleado_id || ', Nombre: ' || p_nombre);
END procesar_empleado;
/

BEGIN
    procesar_empleados;
END;
/

/*18. Crear un procedimiento que utilice un cursor de sistema y muestra el 
nombre y fecha de los empleados unieron e la empresa entre 2002 y 2005, el 
llamado de este procedimiento debe de hacerse de otro procedimiento e imprimir 
los resultados en el procedimiento que llama*/

CREATE OR REPLACE PROCEDURE obtener_empleados(p_anio_inicio NUMBER, p_anio_fin NUMBER) AS
BEGIN
    -- Declarar un cursor de sistema
    FOR emp_rec IN (SELECT nombre, fecha_ingreso FROM empleados WHERE EXTRACT
    (YEAR FROM fecha_ingreso) BETWEEN p_anio_inicio AND p_anio_fin) 
    LOOP
        -- Mostrar el nombre y la fecha de los empleados
        DBMS_OUTPUT.PUT_LINE('Nombre: ' || emp_rec.nombre || ', Fecha de Ingreso: ' || TO_CHAR(emp_rec.fecha_ingreso, 'DD-MON-YYYY'));
    END LOOP;
END obtener_empleados;
/

CREATE OR REPLACE PROCEDURE llamar_obtener_empleados AS
BEGIN
    -- Llamar al procedimiento obtener_empleados con el rango de a�os 2002 a 2005
    obtener_empleados(2002, 2005);
END llamar_obtener_empleados;
/

BEGIN
    llamar_obtener_empleados;
END;
/

/*19. Crear un procedimiento almacenado que extraiga por medio de un 
cursor de sistema la informaci�n de id empleado, puesto, salario, a�os de 
laborar en la empresa, tel�fono, ciudad y pa�s donde vive y que lo imprima 
en pantalla.*/

CREATE OR REPLACE PROCEDURE obtener_informacion_empleados AS
BEGIN
    -- Declarar un cursor de sistema
    FOR emp_rec IN (SELECT 
                        e.id_empleado,
                        e.puesto,
                        e.salario,
                        TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecha_ingreso) / 12) AS anos_laborar,
                        e.telefono,
                        d.ciudad,
                        d.pais
                    FROM empleados e
                    JOIN direcciones d ON e.id_direccion = d.id_direccion)
    LOOP
        -- Mostrar la informaci�n del empleado
        DBMS_OUTPUT.PUT_LINE('ID Empleado: ' || emp_rec.id_empleado);
        DBMS_OUTPUT.PUT_LINE('Puesto: ' || emp_rec.puesto);
        DBMS_OUTPUT.PUT_LINE('Salario: ' || emp_rec.salario);
        DBMS_OUTPUT.PUT_LINE('A�os de Laborar en la Empresa: ' || emp_rec.anos_laborar);
        DBMS_OUTPUT.PUT_LINE('Tel�fono: ' || emp_rec.telefono);
        DBMS_OUTPUT.PUT_LINE('Ciudad: ' || emp_rec.ciudad);
        DBMS_OUTPUT.PUT_LINE('Pa�s: ' || emp_rec.pais);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    END LOOP;
END obtener_informacion_empleados;
/

BEGIN
    obtener_informacion_empleados;
END;
/

/*20. Crear un procedimiento almacenado que utilice un cursor para extraer los 
datos y q calcule y le aumente el salario a los empleados en un 15% que est�n 
por debajo del promedio de los salarios de la empresa y que adem�s tengan como 
experiencia tengan m�s de 15 a�os de laborar en la empresa, actualice la tabla 
de empleados..*/

CREATE OR REPLACE PROCEDURE aumentar_salario_empleados AS
DECLARE
    v_salario_promedio NUMBER;
BEGIN
    -- Calcular el salario promedio de la empresa
    SELECT AVG(salario) INTO v_salario_promedio FROM empleados;

    -- Declarar un cursor de sistema
    FOR emp_rec IN (SELECT id_empleado, salario, fecha_ingreso FROM 
    empleados WHERE salario < v_salario_promedio AND TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_ingreso) / 12) > 15) 
    LOOP
        -- Calcular el nuevo salario con un aumento del 15%
        DECLARE
            v_nuevo_salario NUMBER;
        BEGIN
            v_nuevo_salario := emp_rec.salario * 1.15;

            -- Actualizar la tabla de empleados con el nuevo salario
            UPDATE empleados SET salario = v_nuevo_salario WHERE id_empleado = emp_rec.id_empleado;

            -- Mostrar informaci�n sobre el aumento de salario
            DBMS_OUTPUT.PUT_LINE('Empleado ID: ' || emp_rec.id_empleado || ', Salario Anterior: ' || emp_rec.salario || ', Nuevo Salario: ' || v_nuevo_salario);
        END;
    END LOOP;
END aumentar_salario_empleados;
/

BEGIN
    aumentar_salario_empleados;
END;
/


