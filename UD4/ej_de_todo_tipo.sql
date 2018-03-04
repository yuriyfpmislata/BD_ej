-- 1. Obtener el nombre de los conductores con categoría 15.
/*
SELECT
	Nombre
FROM
	conductores
WHERE
	Categ = 15;
*/
-- 2. Obtener la descripción de los proyectos en los que se haya realizado trabajos durante los días 11 al 15 de septiembre de 2002.
/*
SELECT
	Descrip
FROM
	proyectos
WHERE
	CodP IN (
	SELECT
		CodP
	FROM
		trabajos
	WHERE
		Fecha BETWEEN date('2002-09-11') AND date('2002-09-15')
);
*/
-- 3. Obtener el nombre de los conductores que hayan trabajado con una Hormigonera, ordenados descendentemente.
/*
SELECT
	Nombre
FROM
	conductores
WHERE
	CodC IN (
		SELECT DISTINCT
			CodC
		FROM
			trabajos
		WHERE
			CodM IN (
				SELECT
					CodM
				FROM
					maquinas
				WHERE
					Nombre = 'Hormigonera'
			)
	)
ORDER BY Nombre DESC;
*/
-- 4. Obtener el nombre de los conductores que hayan trabajado con una Hormigonera en proyectos de Arganda.
/*
SELECT
	con.Nombre
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	maq.Nombre = 'Hormigonera'
		AND
	pro.Localidad = 'Arganda';
*/
-- 5. Obtener el nombre de los conductores y descripción del proyecto, para aquellos conductores que hayan trabajado con una Hormigonera
-- en proyectos de Arganda durante los días 12 al 17 de Septiembre de 2002.
/*
SELECT
	con.Nombre
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	maq.Nombre = 'Hormigonera'
		AND
	pro.Localidad = 'Arganda'
		AND
	tra.Fecha BETWEEN date('2002-09-12') AND date('2002-09-17');
*/
-- 6. Obtener los conductores que trabajan en los proyectos de José Pérez.
/*
SELECT DISTINCT
	con.*
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	pro.Cliente = 'José Pérez';
*/
-- 7. Obtener el nombre y localidad de los conductores que NO trabajan en los proyectos de José Pérez
/*
SELECT DISTINCT
	con.Nombre,
    con.Localidad
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	pro.Cliente <> 'José Pérez';
*/
-- 8. Obtener todos los datos de los proyectos realizados en Rivas o que sean de un cliente llamado José.
/*
SELECT
	*
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	pro.Localidad = 'Rivas'
		OR
	pro.Cliente LIKE 'José%';
*/
-- 9. Obtener los conductores que habiendo trabajado en algún proyecto, figuren sin horas trabajadas.
/*
SELECT DISTINCT
	con.*
FROM
	conductores AS con
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            pro.CodP = tra.CodP
WHERE tra.Tiempo IS NULL;
*/
-- 10. Obtener los conductores que tengan como apellido Pérez y hayan trabajado en proyectos de localidades diferentes a las suyas
/*
SELECT DISTINCT
	con.*
FROM
	conductores AS con
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            pro.CodP = tra.CodP
WHERE
	con.Nombre LIKE '%Pérez'
		AND
	pro.Localidad <> con.Localidad;
*/
-- 11. Obtener el nombre de los conductores y la localidad del proyecto, para aquellos conductores que hayan trabajado con máquinas
-- con precio hora comprendido entre 10000 y 15000 ptas.
/*
SELECT
	con.Nombre,
    pro.Localidad
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	maq.PrecioHora BETWEEN 10000 AND 15000;
*/
-- 12. Obtener el nombre y localidad de los conductores, y la localidad del proyecto para aquellos proyectos
-- que sean de Rivas y en los que no se haya utilizado una máquina de tipo Excavadora o una máquina de tipo Hormigonera.
/*
SELECT
	con.Nombre,
    con.Localidad
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	pro.Localidad = 'Rivas'
		AND
	maq.Nombre NOT IN ('Excavadora', 'Hormigonera');
*/
-- 13. Obtener todos los datos de los proyectos, y para aquellos proyectos realizados el día 15 de Septiembre de 2002,
-- además incluir el nombre y localidad de los conductores que hayan trabajado en dicho proyecto.
/*
(SELECT
	pro.*,
    '-'AS 'Nombre conductor',
    '-' AS 'Localidad conductor'
FROM
	conductores AS con
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
			pro.CodP = tra.CodP
WHERE
	pro.CodP NOT IN (
		SELECT
			pro.CodP
		FROM
			conductores AS con
				INNER JOIN
			proyectos AS pro
				INNER JOIN
			trabajos AS tra
				ON
					con.CodC = tra.CodC
						AND
					pro.CodP = tra.CodP
		WHERE
			tra.Fecha = date('2002-09-15')
	)
)
	UNION
(SELECT
	pro.*,
    con.Nombre,
    con.Localidad
FROM
	conductores AS con
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
			pro.CodP = tra.CodP
WHERE
	tra.Fecha = date('2002-09-15')
);
*/
-- 14. Obtener el nombre de los conductores y el nombre y localidad de los clientes, en los que se haya utilizado la máquina con precio hora más elevado.
/*
SELECT
	con.Nombre,
    pro.Localidad
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	maq.PrecioHora = (
		SELECT
			max(PrecioHora)
		FROM
			maquinas
    );
*/
-- 15. Obtener todos los datos de los proyectos que siempre han utilizado la máquina de precio más bajo.
/*
SELECT
	pro.*
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
GROUP BY pro.CodP
HAVING maq.PrecioHora = (
		SELECT
			min(PrecioHora)
		FROM
			maquinas
    )
*/
-- 16. Obtener los proyectos en los que haya trabajado el conductor de categoría más alta menos dos puntos, con la máquina de precio hora más bajo.
/*
SELECT
	pro.*
FROM
	conductores AS con
		INNER JOIN
	maquinas AS maq
		INNER JOIN
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON
			con.CodC = tra.CodC
				AND
            maq.CodM = tra.CodM
				AND
            pro.CodP = tra.CodP
WHERE
	con.Categ > ((
		SELECT
			max(Categ)
		FROM
			conductores
    ) - 2)
		AND
	maq.PrecioHora = (
		SELECT
			min(PrecioHora)
		FROM
			maquinas
    
	);
*/
-- 17. Obtener por cada uno de los clientes el tiempo total empleado en sus proyectos.
/*
SELECT
	pro.Cliente,
    sum(tra.Tiempo) AS 'Tiempo total empleado'
FROM
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON tra.CodP = pro.CodP
GROUP BY pro.Cliente;
*/
-- 18. Obtener por cada uno de los proyectos existentes en la BD, la descripción del proyecto,
-- el cliente y el total a facturar en ptas y en euros. Ordenar el resultado por uno de los totales y por cliente.
/*
SELECT
	pro.CodP,
	pro.Descrip,
    pro.Cliente,
    sum(maq.PrecioHora * tra.Tiempo) AS 'Total ptas',
    sum(maq.PrecioHora * tra.Tiempo) * 0.006009976 AS 'Total Euros'
FROM
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		INNER JOIN
	maquinas AS maq
		ON tra.CodP = pro.CodP AND tra.CodM = maq.CodM
GROUP BY pro.CodP
ORDER BY sum(maq.PrecioHora * tra.Tiempo), pro.Cliente;
*/
-- 19. Obtener para el proyecto que más se vaya a facturar la descripción del proyecto, el cliente y el total a facturar en Ptas. y en euros
/*
SELECT
	pro.CodP,
	pro.Descrip,
    pro.Cliente,
    sum(maq.PrecioHora * tra.Tiempo) AS 'Total ptas',
    sum(maq.PrecioHora * tra.Tiempo) * 0.006009976 AS 'Total Euros'
FROM
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		INNER JOIN
	maquinas AS maq
		ON tra.CodP = pro.CodP AND tra.CodM = maq.CodM
GROUP BY pro.CodP
	HAVING
		sum(maq.PrecioHora * tra.Tiempo) >= ALL (
			SELECT
				sum(maq.PrecioHora * tra.Tiempo)
			FROM
				proyectos AS pro
					INNER JOIN
				trabajos AS tra
					INNER JOIN
				maquinas AS maq
					ON tra.CodP = pro.CodP AND tra.CodM = maq.CodM
			GROUP BY pro.CodP
        )
ORDER BY sum(maq.PrecioHora * tra.Tiempo), pro.Cliente;
*/
-- 20. Obtener los conductores que hayan trabajado en todos los proyectos de la localidad de Arganda.
/*
*/
-- 21. Obtener el tiempo máximo dedicado a cada proyecto para aquellos proyectos en los que haya participado más de un conductor diferente.
/*
SELECT
	pro.CodP,
	max(tra.Tiempo)
FROM
	proyectos AS pro
		INNER JOIN
	trabajos AS tra
		ON tra.CodP = pro.CodP
GROUP BY tra.CodP
HAVING count(DISTINCT tra.CodC) > 1;
*/
-- 22. Obtener el número de partes de trabajo, código del proyecto, descripción y cliente para aquél proyecto que figure con más partes de trabajo.
/*
SELECT
	count(*) AS 'Nº de partes de trabajo',
    proyectos.CodP AS 'Codigo proyecto',
    proyectos.Descrip AS 'Descripcion',
    proyectos.Cliente
FROM
	trabajos
		INNER JOIN
	proyectos ON trabajos.CodP = proyectos.CodP
GROUP BY proyectos.CodP
HAVING count(*) >= ALL (
	SELECT
		count(*)
	FROM
		trabajos
	GROUP BY CodP
);
*/
-- 23. Obtener la localidad cuyos conductores (al menos uno) haya participado en más de dos proyectos diferentes.
/*
SELECT DISTINCT
	conductores.Localidad
FROM
	trabajos
		INNER JOIN
	conductores
GROUP BY trabajos.CodC
HAVING count(DISTINCT trabajos.CodP) > 1;
*/
-- 24. Subir el precio por hora en un 10% del precio por hora más bajo para todas las máquinas excepto para aquella que tenga el valor más alto.
/*
UPDATE maquinas
	SET PrecioHora = PrecioHora * 0.9
WHERE PrecioHora < ALL (
	SELECT
		max(temporal.PrecioHora)
	FROM
		(SELECT * FROM maquinas) AS temporal
	);
*/
-- 25. Subir la categoría un 15% a los conductores que no hayan trabajado con Volquete y hayan trabajado en más de un proyecto distinto.
/*
UPDATE conductores
	SET Categ = Categ * 1.15
WHERE CodC IN (
	SELECT
		CodC
	FROM
		trabajos
	WHERE
		CodM NOT IN (SELECT CodM FROM maquinas WHERE Nombre = 'Volquete')
	GROUP BY CodC
	HAVING count(DISTINCT CodP) > 1
	);
*/
-- 26. Eliminar el proyecto Solado de José Pérez.
/*
DELETE FROM proyectos
WHERE
	Descrip = 'Solado'
		AND
	Cliente = 'José Pérez';
-- No se puede ya que la tabla trabajos tiene una restriccion ON DELETE RESTRICT
*/
-- 27. Modificar la estructura de la base de datos, añadiendo las claves foráneas, sin ninguna opción de integridad referencial.
/*
-- Hecho
*/
-- 28. Insertar en la tabla trabajos la fila ‘C01’, ‘M04’,’P07’,’19/09/02’,100.
/*
INSERT INTO trabajos
VALUES ('C01', 'M04', 'P07', '19/09/02', 100);
*/
-- 29. Eliminar el conductor ‘C01’ de la tabla conductores.
/*
DELETE FROM conductores
WHERE
	CodC = 'C01';
*/
-- 30. Modificar el código del conductor ‘C01’ de la tabla conductores, por el código ‘C05’.
/*
UPDATE conductores
SET
	CodC = 'C05'
WHERE
	CodC = 'C01';
*/
-- 31. Modificar el código del conductor ‘C01’ de la tabla conductores, por el código ‘C07’.
/*
UPDATE conductores
SET
	CodC = 'C07'
WHERE
	CodC = 'C01';
*/
-- 32. Modificar la estructura de la base de datos, para que las claves foráneas tengan condiciones de integridad referencial en borrado y modificación.
-- Especificar todas las opciones de integridad referencial, y ejecutar sentencias de actualización para comprobar su funcionamiento.
/*
*/
-- 33. Crear una vista que contenga el nombre del conductor, la descripción del proyecto y la media aritmética del tiempo trabajado.
/*
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `new_view` AS
    SELECT 
        `con`.`Nombre` AS `Nombre`,
        `pro`.`Descrip` AS `Descrip`,
        ROUND((SUM(`tra`.`Tiempo`) / COUNT(`tra`.`Tiempo`)),
                2) AS `Media tiempo trabajado`
    FROM
        ((`trabajos` `tra`
        JOIN `proyectos` `pro`)
        JOIN `conductores` `con` ON (((`tra`.`CodP` = `pro`.`CodP`)
            AND (`tra`.`CodC` = `con`.`CodC`))))
    GROUP BY `tra`.`CodC`
*/
-- 34. Crear una vista sobre la tabla trabajos, para los trabajos realizados después del 15 de septiembre de 2002.
-- Crearla sin la cláusula “With Check Option” y sin ella, comprobando su funcionamiento.
/*
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `new_view` AS
    SELECT 
        `trabajos`.`CodP` AS `CodP`,
        `trabajos`.`CodC` AS `CodC`,
        `trabajos`.`CodM` AS `CodM`,
        `trabajos`.`Fecha` AS `Fecha`,
        `trabajos`.`Tiempo` AS `Tiempo`
    FROM
        `trabajos`
    WHERE
        (`trabajos`.`Fecha` > CAST('2002-09-15' AS DATE)) WITH CASCADED CHECK OPTION

-- Funciona igual tanto con la opción, como sin ella
*/
-- 35. Eliminar las tablas de la base de datos.
/*
DROP tables conductores, maquinas, proyectos, trabajos
*/