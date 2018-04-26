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
-- 12.  Crea una tabla llamada log_altas_clientes que contendrá un número de orden,
-- código cliente, usuario (que lo ha creado), fecha-hora. Esta tabla se rellenará
-- automáticamente con cada inserción en la tabla de clientes.
/*
CREATE TABLE IF NOT EXISTS log_altas_clientes (
	orden INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	codCliente INT(11),
	usuario VARCHAR(100),
	fechaHora DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER alInsertarCliente AFTER INSERT ON clientes
FOR EACH ROW 
BEGIN    
	INSERT INTO log_altas_clientes (codCliente, usuario) VALUES (
		NEW.CodigoCliente,
        CURRENT_USER
    );    
END$$

*/
-- 13.  Crea una tabla llamada log_bajas_clientes que contendrá un número de orden,
-- código cliente, usuario (que lo ha borrado), fecha-hora. Esta tabla se rellenará
-- automáticamente con cada borrado en la tabla de clientes.
/*
CREATE TABLE IF NOT EXISTS log_bajas_clientes (
	orden INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	codCliente INT(11),
	usuario VARCHAR(100),
	fechaHora DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER alBorrarCliente AFTER DELETE ON clientes
FOR EACH ROW 
BEGIN    
	INSERT INTO log_bajas_clientes (codCliente, usuario) VALUES (
		OLD.CodigoCliente,
        CURRENT_USER
    );    
END$$

*/
-- 14.  Crea una tabla llamada log_modifica_clientes que contendrá un número de orden,
-- código cliente, nombre cliente antes de la modificación, nuevo nombre, usuario 
-- (que lo ha modificado), fecha-hora. Esta tabla se rellenará automáticamente con 
-- cada modificación del campo nombre en la tabla de clientes.
/*
CREATE TABLE IF NOT EXISTS log_modifica_clientes (
	orden INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	codCliente INT(11),
    nombreAnterior VARCHAR(50),
    nombreNuevo VARCHAR(50),
	usuario VARCHAR(100),
	fechaHora DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER alModificarCliente AFTER UPDATE ON clientes
FOR EACH ROW 
BEGIN
	IF NEW.NombreCliente <> OLD.NombreCliente
    THEN
		INSERT INTO log_modifica_clientes (codCliente, nombreAnterior, nombreNuevo, usuario) VALUES (
			OLD.CodigoCliente,
			OLD.NombreCliente,
			NEW.NombreCliente,
			CURRENT_USER
		);
	END IF;
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
-- 17_B. Añadir al ejercicio anterior la opción de pasar lengua ING, que devolverá
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
-- 19.   Crea un procedimiento llamado crear_sorteo que cree la tabla numeros_sorteo
-- con dos campos: número y país (la tabla se ha de borrar cada vez que se llame al
-- procedimiento). El procedimiento recibirá dos parámetros: el número inicial y el
-- número final del sorteo. Partiendo de estos dos números, inserta un registro por
-- cada número comprendido entre ambos (sin especificar país).
/*
DELIMITER $$

DROP PROCEDURE IF EXISTS crear_sorteo$$

CREATE PROCEDURE crear_sorteo (
	p_numeroInicial INT(3),
    p_numeroFinal INT(3)
)

BEGIN
	DECLARE v_contador INT(3) DEFAULT 0;
    
    DROP TABLE IF EXISTS numeros_sorteo;
    
	CREATE TABLE numeros_sorteo (
		numero INT(3),
		pais VARCHAR(40)
	);
    
    SET v_contador = p_numeroInicial;
    
    START TRANSACTION;
    
	bucle: LOOP     
		INSERT INTO numeros_sorteo VALUES (
			v_contador,
			"España"
		);   
        
		SET v_contador = v_contador + 1;
                
		IF (v_contador > p_numeroFinal)THEN
			LEAVE bucle;
		END IF;
    END LOOP;
    
    COMMIT;
END$$
*/
-- 20.   Crea un procedimiento llamado sorteo que, sobre la tabla
-- numeros_sorteo asigne la localidad así: ESPAÑA para los números
-- de dos cifras, FRANCIA para los números de tres cifras e ITALIA para el resto.
/*
DELIMITER $$

DROP PROCEDURE IF EXISTS sorteo$$

CREATE PROCEDURE sorteo ()

BEGIN    
    START TRANSACTION;
		UPDATE numeros_sorteo
		SET
			pais = "España"
		WHERE
			numero BETWEEN 10 AND 99;
            
		UPDATE numeros_sorteo
		SET
			pais = "Francia"
		WHERE
			numero BETWEEN 100 AND 999;
            
		UPDATE numeros_sorteo
		SET
			pais = "Italia"
		WHERE
			numero > 999 OR numero < 10;            
    COMMIT;
END$$
*/
-- 22.   Crea una función llamada cuantos_por_letra donde a partir de una letra,
-- devuelva cuántos clientes tienen nombre que comienza por esa letra.
/*
DELIMITER $$

DROP FUNCTION IF EXISTS cuantos_por_letra$$

CREATE FUNCTION cuantos_por_letra (
	p_letra VARCHAR(1)
) RETURNS INT(3)

BEGIN

RETURN (
	SELECT
		count(*)
	FROM
		clientes
	WHERE
		NombreCliente LIKE concat(p_letra, "%")
);
    
END$$
*/
-- 22_B. Crea una función llamada resultado en la que se parta de un palabra de 5 letras
-- y devuelva la cantidad total de clientes cuyos nombres empiezan por cada una de las letras
-- de la palabra.
/*
DELIMITER $$

CREATE FUNCTION resultado (
	p_palabra VARCHAR(5)
) RETURNS INT(3)

BEGIN

DECLARE v_contador INT(3) DEFAULT 0;
DECLARE v_suma INT(3) DEFAULT 0;

WHILE v_contador < length(p_palabra) DO
	SET v_suma = v_suma + cuantos_por_letra(substring(p_palabra, v_contador, 1));
    SET v_contador = v_contador + 1;
END WHILE;

RETURN v_suma;

END$$
*/
-- 23.   Crea una función llamada telefono_oficina que, a partir de un código de cliente,
-- devuelva el número de teléfono de la oficina que le corresponde.
/*
DELIMITER $$

DROP FUNCTION IF EXISTS telefono_oficina$$

CREATE FUNCTION telefono_oficina (
	p_codCliente INT(11)
) RETURNS VARCHAR(20)

BEGIN

RETURN (
	SELECT
		Telefono
	FROM
		oficinas
	WHERE
		CodigoOficina IN (
			SELECT
				CodigoOficina
            FROM
				empleados
			WHERE
				CodigoEmpleado IN (
					SELECT
						CodigoEmpleadoRepVentas
					FROM
						clientes
					WHERE
						CodigoCliente = p_codCliente
                )
        )
);
    
END$$
*/
-- 24.   Crea un procedimiento llamado fraccionar_pagos en el que, a partir del
-- identificador del pago y el número de pagos en que se quiere fraccionar, inserte
-- tantos pagos cómo se quiera fraccionar el pago inicial y elimine el pago inicial. 
-- Los nuevos pagos tendrán el importe original fraccionado y las fechas de pago con una
-- cadencia de 30 días (el código de cliente y la forma de pago se respetan).
/*
DELIMITER $$

DROP PROCEDURE IF EXISTS fraccionar_pagos$$

CREATE PROCEDURE fraccionar_pagos (
	p_idTransaccion VARCHAR(50),
    p_CodigoCliente INT(11),
	p_numeroDePagos INT(3) UNSIGNED
)

BEGIN
	DECLARE v_parte DECIMAL(15,2);
    DECLARE v_nuevaFecha DATE;
    
    DECLARE v_dato_CodigoCliente INT(11);
    DECLARE v_dato_FormaPago VARCHAR(40);
	DECLARE v_dato_IDTransaccion VARCHAR(50);
    DECLARE v_dato_FechaPago DATE;
    DECLARE v_dato_Cantidad DECIMAL(15,2);
    
    DECLARE v_contador INT(3) DEFAULT 1;
    
    START TRANSACTION;
    
		SELECT
			CodigoCliente,
			FormaPago,
			IDTransaccion,
			FechaPago,
			Cantidad
		INTO
			v_dato_CodigoCliente,
			v_dato_FormaPago,
			v_dato_IDTransaccion,
			v_dato_FechaPago,
			v_dato_Cantidad
		FROM
			pagos
		WHERE
			IDTransaccion = p_idTransaccion
				AND
			CodigoCliente = p_CodigoCliente;
                
		-- si el numero de fracciones es correcto Y se ha encontrado el pago
		IF p_numeroDePagos > 0 AND v_dato_IDTransaccion IS NOT NULL
		THEN			
			SET v_parte = v_dato_Cantidad / p_numeroDePagos;

			SET v_nuevaFecha = v_dato_FechaPago;
			
			WHILE v_contador <= p_numeroDePagos DO
				SET v_nuevaFecha = adddate(v_nuevaFecha, 30);
				INSERT INTO pagos
				VALUES (
					v_dato_CodigoCliente,
					v_dato_FormaPago,
					concat(v_dato_IDTransaccion, '_', v_contador),
					v_nuevaFecha,
					v_parte
				);
				SET v_contador = v_contador + 1;
			END WHILE;
			
			DELETE FROM pagos 
			WHERE
				IDTransaccion = v_dato_IDTransaccion
					AND
				CodigoCliente = v_dato_CodigoCliente;
		END IF;
    COMMIT;
END$$
*/
-- 34.  Similar al ejercicio anterior, diseña una BD llamada RED_SOCIAL,
-- en la que los usuarios identificados por un nick único establezcan relaciones
-- de seguimiento (un usuario es seguido por muchos usuarios, y un usuario es
-- seguidor de muchos usuarios). Debemos almacenar por cada usuario y mantener
-- permanentemente actualizados dos datos: “número de usuarios seguidores” y
-- “número de usuarios seguidos”.
/*
CREATE DEFINER=`root`@`localhost` TRIGGER `red_social`.`seguimientos_BEFORE_INSERT` AFTER INSERT ON `seguimientos` FOR EACH ROW
BEGIN
	UPDATE usuarios 
		SET seguidores = seguidores + 1
		WHERE nick = NEW.nickSeguido;
    
	UPDATE usuarios 
		SET seguidos = seguidos + 1
		WHERE nick = NEW.nickSeguidor;
END

CREATE DEFINER=`root`@`localhost` TRIGGER `red_social`.`seguimientos_BEFORE_DELETE` AFTER DELETE ON `seguimientos` FOR EACH ROW
BEGIN
	UPDATE usuarios 
		SET seguidores = seguidores - 1
		WHERE nick = OLD.nickSeguido;
    
	UPDATE usuarios 
		SET seguidos = seguidos - 1
		WHERE nick = OLD.nickSeguidor;
END
*/