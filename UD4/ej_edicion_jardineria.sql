-- 1. Crea y ejecuta un script llamado “actualiza.sql” que realice las siguientes acciones:
-- a) Inserta una oficina con sede en Fuenlabrada
/*
INSERT INTO oficinas
	VALUES ('FNB-ES', 'Fuenlabrada', 'España', 'Fuenlabrada', 24252, '+3412345898', 'Av. Inexistente 33', 'A, 3');
*/
-- b) Inserta un empleado para la oficina de Fuenlabrada que sea representante de ventas
/*
INSERT INTO empleados
	VALUES (32, 'Alberto', 'Albertez', NULL, 32, 'a@email.com', 'FNB-ES', NULL, 'Representante Ventas');
*/
-- c) Inserta un cliente del representante de ventas insertado en el punto anterior
/*
INSERT INTO clientes
	VALUES (39, 'Berto S.L.', NULL, NULL, '998871487', '5294894984', 'C/Noexisto 12', NULL, 'Barcelona', NULL, NULL, NULL, 32, NULL);
*/
-- d) Inserta un pedido del cliente anterior (con su detalle) de al menos dos productos
/*
INSERT INTO pedidos
	VALUES (129, current_date(), current_date(), NULL, 'Pendiente', NULL, 39);

INSERT INTO detallepedidos
	VALUES (129, 11679, 1, 14.00, 1),
		   (129, 21636, 3, 14.00, 2);
*/
-- e) Cambia en la tabla de clientes el código del cliente insertado en el punto c), y averigua la repercusión en las tablas relacionadas
/*
UPDATE clientes
	SET CodigoCliente = 40
WHERE
	CodigoCliente = 39;
    
-- Comentario:
-- 		No permite cambiar el codigo, ya que en pedidos esta puesto
-- 		ON UPDATE RESTRICT

*/
-- f) Borra dicho cliente de la tabla clientes y comenta los cambios 
/*
DELETE FROM clientes
WHERE
	CodigoCliente = 39;
    
-- Comentario:
-- 		No permite borrar el cliente, ya que en pedidos esta puesto
-- 		ON DELETE RESTRICT

*/
-- 2. Borra los clientes que no tengan pedidos
/*
DELETE FROM
	clientes
WHERE
	CodigoCliente NOT IN (
		SELECT
			CodigoCliente
		FROM
			pedidos
    );
*/