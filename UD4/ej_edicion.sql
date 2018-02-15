-- 1. Dada la tabla PERSONAS insertar a un persona de apellidos y nombre
-- 	ʻQuiroga Rojas, Leopoldoʼ, cuya función sea ʻCONSERJEʼ, con DNI
-- 	456788999 y con el código de hospital 4.
/*
INSERT INTO
	personas
VALUES
	(4, 456788999, "Quiroga Rojas, Leopoldo", 'CONSERJE', NULL);
*/
-- 2. Inserta en la tabla PERSONAS una persona de nombre ʻSerrano Ruiz,
-- Antonioʼ, con DNI 111333222 perteneciente al hospital número 3.
/*
INSERT INTO
	personas
VALUES
	(3, 111333222, "Serrano Ruiz, Antonio", NULL, NULL);
*/
-- 3. Inserta en la tabla PERSONAS1 los datos de las personas que trabajan en
-- el hospital número 1 (INSERT con SELECT).
/*
INSERT INTO
	personas1
(SELECT
	*
FROM
	personas
WHERE
	cod_hospital = 1);
*/
-- 4. Se ha creado una nueva tabla llamada PERSONAS2. Esta tabla tiene los
-- siguientes campos (DNI, APELLIDOS, FUNCIÓN). ¿Cómo podremos
-- introducir en esa tabla los datos de las PERSONAS del código de hospital
-- 4?
/*
-- *crear tabla personas2
INSERT INTO
	personas2
(SELECT
	dni,
    apellidos,
    funcion
FROM
	personas
WHERE
	cod_hospital = 4);
*/
-- 5. Inserta en la tabla PERSONAS una persona con DNI 99887766 y apellidos
-- ʻMartínez Martínez, Alejandroʼ en el hospital que tiene tan sólo 1 persona
-- (INSERT con SELECT).
/*
INSERT INTO
	personas (cod_hospital, dni, apellidos)
(SELECT
	cod_hospital,
    99887766,
    'Martínez Martínez, Alejandro'
FROM
	personas
-- *no hay hospitales con solo 1 persona, por lo que no se inserta nada
GROUP BY cod_hospital HAVING count(*) = 1);
*/
-- 6. En la tabla HOSPITALES cambiar el código de los hospitales que tienen el
-- código 3 al código 4. (Utilizar UPDATE).
/*
UPDATE hospitales
SET cod_hospital = 4
WHERE
	cod_hospital = 3;
*/
-- 7.- Insertar en la tabla EMPLE un empleado con código 9999, apellido
-- ʻGONZÁLEZʼ y código de departamento 10.
/*
INSERT INTO
	emple (emp_no, apellido, dept_no)
VALUES
	(9999, 'GONZÁLEZ', 10);
*/
-- 8. Insertar en la tabla EMPLE un empleado con código 5000, apellido
-- ʻMORAGAʼ, oficio ʻEMPLEADOʼ, su director es el empleado 7902, la fecha de
-- alta en la empresa es ʻ17/10/99ʼ, su salario es 100000, no tiene comisión y
-- pertenece al departamento número 20. (para indicar que no tiene comisión
-- deberás poner NULL en el campo comisión).
/*
INSERT INTO
	emple
VALUES
	(5000, 'MORAGA', 'EMPLEADO', 7902, str_to_date('17/10/99', '%d/%m/%y'), 100000, NULL, 20);
*/
-- 9. Insertar en la tabla DEPART un departamento cuyo número sea 50, de
-- nombre ʻGENERALʼ y cuya localización sea ʻSEVILLAʼ.
/*
INSERT INTO
	depart
VALUES
	(50, 'GENERAL', 'SEVILLA');
*/
-- 10. Insertar en la tabla DEPART un departamento cuyo número sea 60 y de
-- nombre ʻPRUEBASʼ.
/*
INSERT INTO
	depart
VALUES
	(60, 'PRUEBAS', NULL);
*/
-- 11. Insertar en la tabla EMPLE30 los datos de los empleados que pertenecen al
-- departamento número 30.
/*
INSERT INTO
	emple30
(SELECT
	*
FROM
	emple
WHERE
	dept_no = 30);
*/
-- 12. Insertar en la tabla EMPLE20 el numero de empleado, número de departamento y salario de
-- los empleados que pertenecen al departamento número 20.
/*
INSERT INTO
	emple20
(SELECT
	emp_no,
    salario,
    dept_no
FROM
	emple
);
*/
-- 13. Doblar el salario a todos los empleados del departamento 30. (Utilizar
-- UPDATE).
/*
UPDATE emple
SET
	salario = salario * 2
WHERE
	dept_no = 30;
*/
-- 14. Cambiar todos los empleados del departamento número 30 al
-- departamento número 20.
/*
UPDATE
	emple
SET
	dept_no = 20
WHERE
	dept_no = 30;
*/
-- 15. Incrementar en un 10% el sueldo de los empleados del departamento 10.
-- (salario*1.1).
/*
UPDATE emple
SET
	salario = salario * 1.1
WHERE
	dept_no = 10;
*/
-- 16. Cambiar la localidad del departamento número 10 a ʻBILBAOʼ.
/*
UPDATE depart
SET
	loc = 'BILBAO'
WHERE
	dept_no = 10;
*/
-- 17. Igualar el salario de ʻARROYOʼ al salario de ʻNEGROʼ, de la tabla
-- EMPLE30.
/*
UPDATE emple
SET
	salario = (
		SELECT
			salario
		FROM
			emple30
		WHERE
			apellido = 'NEGRO'
    )
WHERE
	apellido = 'ARROYO';
*/
-- 18. Igualar el salario y oficio de ʻMUÑOZʼ al salario y oficio de ʻJIMENOʼ, de la
-- tabla EMPLE30.
/*
UPDATE emple
SET
	salario = (
		SELECT
			salario
		FROM
			emple30
		WHERE
			apellido = 'JIMENO'
    ),
    oficio = (
		SELECT
			oficio
		FROM
			emple30
		WHERE
			apellido = 'JIMENO'
    )
WHERE
	apellido = 'MUÑOZ';
*/
-- 19. En la tabla DEPART borrar el departamento número 50.
/*
DELETE FROM
	depart
WHERE dept_no = 50;
*/
-- 20. En la tabla EMPLE borrar todos los empleados que sean del departamento
-- 20 y sean ʻANALISTASʼ.
/*
DELETE FROM
	emple
WHERE
	dept_no = 20
		AND
	oficio = 'ANALISTA';
*/
-- 21. Borrar de la tabla EMPLE todos los empleados que no tengan comisión
/*
DELETE FROM
	emple
WHERE
	comision IS NULL;
*/
-- 22. Establecer el número de plazas de todos los hospitales a 250.
/*
UPDATE hospitales
SET
	num_plazas = 250;
*/
-- 23. Poner en 2000 el número de plazas del hospital número 3.
/*
UPDATE hospitales
SET
	num_plazas = 2000
WHERE cod_hospital = 1;
*/
-- 24. Borra todos los hospitales cuyo nombre comience por la letra ʻRʼ
/*
DELETE FROM
	hospitales
WHERE
	nombre LIKE 'R%';
*/
-- Mandado: [nba] borra equipos pertenecientes a una division que tenga menos de 2 equipos
/*
DELETE FROM
	equipos
WHERE Division IN (
	SELECT
		Division
	FROM
		equipos
	GROUP BY Division
	HAVING count(*) < 2
);
*/
-- 25. Con una sentencia UPDATE dobla el número de plazas de todos los
-- hospitales.
/*
UPDATE hospitales
SET
	num_plazas = num_plazas * 2;
*/
-- 26. Por cada departamento de la tabla EMPLE y DEPART obtener el nombre
-- del departamento, salario medio, salario máximo y media de salarios. 
/*
SELECT
	depart.dnombre AS 'Nombre',
    MIN(emple.salario) AS 'Salario mínimo',
    MAX(emple.salario) AS 'Salario máximo',
    AVG(emple.salario) AS 'Media de salarios'
FROM
	emple
		RIGHT OUTER JOIN
	depart ON emple.dept_no = depart.dept_no
GROUP BY depart.dept_no;
*/
-- 27. Visualizar el nombre y número de empleados de cada departamento.
/*
SELECT
	depart.dnombre AS 'Nombre',
    count(emple.emp_no) AS 'Nº de empleados'
FROM
	emple
		RIGHT OUTER JOIN
	depart ON emple.dept_no = depart.dept_no
GROUP BY depart.dept_no;
*/
-- 28. Visualizar el nombre y número de empleados de los departamentos que
-- tengan más de 3 empleados.
/*
SELECT
	depart.dnombre AS 'Nombre',
    count(emple.emp_no) AS 'Nº de empleados'
FROM
	emple
		RIGHT OUTER JOIN
	depart ON emple.dept_no = depart.dept_no
GROUP BY depart.dept_no
HAVING count(emple.emp_no) > 3;
*/
-- 29. Apellidos de los empleados que tengan el mismo oficio que ʻARROYOʼ.
/*
SELECT
	apellido
FROM
	emple
WHERE
	oficio = (
		SELECT
			oficio
		FROM
			emple
		WHERE
			apellido = 'ARROYO'
    );
*/
-- 30. Apellidos de los empleados que pertenezcan al mismo departamento que
-- ʻARROYOʼ o ʻREYʼ.
/*
SELECT
	apellido
FROM
	emple
WHERE
	dept_no = (
		SELECT
			dept_no
		FROM
			emple
		WHERE
			apellido = 'ARROYO'
    );
*/
-- Extra: crear tabla basada en un select
-- nba: crear tabla llamada jugadoreswest con los datos de los jugadores de la conferencia west
/*
CREATE TABLE jugadoreswest AS (
	SELECT
		jug.*
	FROM
		jugadores AS jug
			INNER JOIN
		equipos AS eq ON jug.Nombre_equipo = eq.Nombre
	WHERE
		eq.Conferencia = 'West'
);
*/