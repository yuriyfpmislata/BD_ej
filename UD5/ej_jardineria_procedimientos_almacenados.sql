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
