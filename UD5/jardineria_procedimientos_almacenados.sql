-- 10.  Se desea saber la edad actual de cada empleado. 
-- Añade la columna necesaria en la tabla adecuada.
-- Crea una función genérica llamada calculo_edad en la que, enviando este tipo de dato, se calcule la edad.
-- Lista los empleados con su nombre y edad, ordenado de más viejo a más joven.
-- Haz un listado por edades con el número de empleados que tienen la misma edad.

/*
ALTER TABLE `jardineria`.`empleados` 
ADD COLUMN `FechaNac` DATE NULL AFTER `Puesto`;


DELIMITER $$
DROP FUNCTION IF EXISTS calculo_edad$$

CREATE FUNCTION calculo_edad (
	fechaNac DATE
) RETURNS INT

BEGIN
	RETURN timestampdiff(YEAR, fechaNac, now());
END$$
DELIMITER ;

SELECT
	Nombre,
	calculo_edad((SELECT fechaNac)) AS Edad
FROM
	empleados
WHERE
	FechaNac IS NOT NULL
ORDER BY Edad DESC;

SELECT
	calculo_edad((SELECT fechaNac)) AS 'Edad',
	count(calculo_edad((SELECT fechaNac))) AS 'Nº de empleados'
FROM
	empleados
WHERE
	FechaNac IS NOT NULL
GROUP BY calculo_edad((SELECT fechaNac));
*/

-- 11.  Crea el procedimiento crear_nueva_tarifa que, a partir de un porcentaje,
-- cree una tabla llamada nueva_tarifa (y la borre previamente si ya existía)
-- que contenga el código y nombre del producto, así como el precio de proveedor
-- incrementado en el porcentaje dado (redondeado a dos decimales, es el precio_tarifa). Utiliza alguna variable local.
/*
DELIMITER $$

DROP PROCEDURE IF EXISTS crear_nueva_tarifa$$

CREATE PROCEDURE crear_nueva_tarifa (
	v_porc DECIMAL(5,2)
)

BEGIN
	DROP TABLE IF EXISTS nueva_tarifa;
    CREATE TABLE nueva_tarifa AS (
	SELECT
		CodigoProducto,
        Nombre,
        round(PrecioProveedor + (PrecioProveedor * (v_porc / 100)), 2) AS PrecioProveedor
	FROM
		productos
	);
END$$
*/
