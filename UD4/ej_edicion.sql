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
-- 24. Borra todos los hospitales cuyo nombre comience por la letra ʻRʼ
/*
DELETE FROM
	hospitales
WHERE
	nombre LIKE 'R%';
*/
-- Mandado: borra equipos pertenecientes a una division que tenga menos de 2 equipos
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