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
-- 15.   Crea una función llamada calificación, que a partir de una nota numérica,
-- devuelva la calificación alfabética
/*
DELIMITER $$

DROP FUNCTION IF EXISTS calificacion$$

CREATE FUNCTION calificacion (
	nota DECIMAL(4,2)
) RETURNS VARCHAR(30)

BEGIN
	DECLARE calAlfabetica VARCHAR(30);
    
    CASE
		WHEN
			nota >= 0 AND nota < 5
			THEN
				SET calAlfabetica = "Insuficiente";
		WHEN
			nota >= 5 AND nota < 6
			THEN
				SET calAlfabetica = "Suficiente";
		WHEN
			nota >= 6 AND nota < 7
			THEN
				SET calAlfabetica = "Bien";
		WHEN
			nota >= 7 AND nota < 9
			THEN
				SET calAlfabetica = "Notable";
		WHEN
			nota >= 9 AND nota <= 10
			THEN
				SET calAlfabetica = "Sobresaliente";
		ELSE
			SET
				calAlfabetica = "???";
	END CASE;
    
	RETURN calAlfabetica;
END$$
*/
-- 16.   Crea una función llamada nombre_mes en la que partiendo de un número de mes,
-- devuelva el nombre del mes en castellano
/*
DELIMITER $$

DROP FUNCTION IF EXISTS nombre_mes$$

CREATE FUNCTION nombre_mes (
	p_numeroMes INT(2)
) RETURNS VARCHAR(30)

BEGIN
	DECLARE v_nombre VARCHAR(30);
    
    CASE p_numeroMes
		WHEN 1 THEN
			SET v_nombre = "Enero";
		WHEN 2 THEN
			SET v_nombre = "Febrero";
		WHEN 3 THEN
			SET v_nombre = "Marzo";
		WHEN 4 THEN
			SET v_nombre = "Abril";
		WHEN 5 THEN
			SET v_nombre = "Mayo";
		WHEN 6 THEN
			SET v_nombre = "Junio";
		WHEN 7 THEN
			SET v_nombre = "Julio";
		WHEN 8 THEN
			SET v_nombre = "Agosto";
		WHEN 9 THEN
			SET v_nombre = "Septiembre";
		WHEN 10 THEN
			SET v_nombre = "Octubre";
		WHEN 11 THEN
			SET v_nombre = "Noviembre";
		WHEN 12 THEN
			SET v_nombre = "Diciembre";
		ELSE
			SET v_nombre = "!! Fuera de rango";
	END CASE;
    
	RETURN v_nombre;
END$$
*/
-- 17.   Crea una función llamada nombre_mes_cv a la que se envíe un número de mes y
-- las siglas de la lengua en que se desea (CAS será castellano, VAL será valenciano).
-- La función devolverá el nombre del mes en la lengua elegida. 
/*
DELIMITER $$

DROP FUNCTION IF EXISTS nombre_mes_cv$$

CREATE FUNCTION nombre_mes_cv (
	p_numeroMes INT(2),
    p_lengua VARCHAR(3)
) RETURNS VARCHAR(50)

BEGIN
	DECLARE v_nombre VARCHAR(50);
    
    IF p_lengua = "CAS" THEN
		CASE p_numeroMes
			WHEN 1 THEN
					SET v_nombre = "Enero";
			WHEN 2 THEN
					SET v_nombre = "Febrero";
			WHEN 3 THEN
					SET v_nombre = "Marzo";
			WHEN 4 THEN
					SET v_nombre = "Abril";
			WHEN 5 THEN
					SET v_nombre = "Mayo";
			WHEN 6 THEN
					SET v_nombre = "Junio";
			WHEN 7 THEN
					SET v_nombre = "Julio";
			WHEN 8 THEN
					SET v_nombre = "Agosto";
			WHEN 9 THEN
					SET v_nombre = "Septiembre";
			WHEN 10 THEN
					SET v_nombre = "Octubre";
			WHEN 11 THEN
					SET v_nombre = "Noviembre";
			WHEN 12 THEN
					SET v_nombre = "Diciembre";
			ELSE
				SET v_nombre = NULL;
		END CASE;
	ELSEIF p_lengua = "VAL" THEN
		CASE p_numeroMes
			WHEN 1 THEN
					SET v_nombre = "Gener";
			WHEN 2 THEN
					SET v_nombre = "Febrer";
			WHEN 3 THEN
					SET v_nombre = "Març";
			WHEN 4 THEN
					SET v_nombre = "Abril";
			WHEN 5 THEN
					SET v_nombre = "Maig";
			WHEN 6 THEN
					SET v_nombre = "Juny";
			WHEN 7 THEN
					SET v_nombre = "Juliol";
			WHEN 8 THEN
					SET v_nombre = "Agost";
			WHEN 9 THEN
					SET v_nombre = "Setembre";
			WHEN 10 THEN
					SET v_nombre = "Octubre";
			WHEN 11 THEN
					SET v_nombre = "Novembre";
			WHEN 12 THEN
					SET v_nombre = "Decembre";
			ELSE
				SET v_nombre = NULL;
		END CASE;
	ELSE
		SET v_nombre = NULL;
    END IF;
    
	RETURN v_nombre;
END$$
*/
-- 17B. Añadir al ejercicio anterior la opción de pasar lengua ING, que devolverá
-- el nombre del mes usando una función nativa de MySQL.
/*
DELIMITER $$

DROP FUNCTION IF EXISTS nombre_mes_cv$$

CREATE FUNCTION nombre_mes_cv (
	p_numeroMes INT(2),
    p_lengua VARCHAR(3)
) RETURNS VARCHAR(50)

BEGIN
	DECLARE v_nombre VARCHAR(50);
    
    IF p_lengua = "CAS" THEN
		CASE p_numeroMes
			WHEN 1 THEN
					SET v_nombre = "Enero";
			WHEN 2 THEN
					SET v_nombre = "Febrero";
			WHEN 3 THEN
					SET v_nombre = "Marzo";
			WHEN 4 THEN
					SET v_nombre = "Abril";
			WHEN 5 THEN
					SET v_nombre = "Mayo";
			WHEN 6 THEN
					SET v_nombre = "Junio";
			WHEN 7 THEN
					SET v_nombre = "Julio";
			WHEN 8 THEN
					SET v_nombre = "Agosto";
			WHEN 9 THEN
					SET v_nombre = "Septiembre";
			WHEN 10 THEN
					SET v_nombre = "Octubre";
			WHEN 11 THEN
					SET v_nombre = "Noviembre";
			WHEN 12 THEN
					SET v_nombre = "Diciembre";
			ELSE
				SET v_nombre = NULL;
		END CASE;
	ELSEIF p_lengua = "VAL" THEN
		CASE p_numeroMes
			WHEN 1 THEN
					SET v_nombre = "Gener";
			WHEN 2 THEN
					SET v_nombre = "Febrer";
			WHEN 3 THEN
					SET v_nombre = "Març";
			WHEN 4 THEN
					SET v_nombre = "Abril";
			WHEN 5 THEN
					SET v_nombre = "Maig";
			WHEN 6 THEN
					SET v_nombre = "Juny";
			WHEN 7 THEN
					SET v_nombre = "Juliol";
			WHEN 8 THEN
					SET v_nombre = "Agost";
			WHEN 9 THEN
					SET v_nombre = "Setembre";
			WHEN 10 THEN
					SET v_nombre = "Octubre";
			WHEN 11 THEN
					SET v_nombre = "Novembre";
			WHEN 12 THEN
					SET v_nombre = "Decembre";
			ELSE
				SET v_nombre = NULL;
		END CASE;
	ELSEIF p_lengua = "ING" THEN
		SET v_nombre = monthname(str_to_date(p_numeroMes, "%m"));
	ELSE
		SET v_nombre = NULL;
    END IF;
    
	RETURN v_nombre;
END$$
*/