-- parametros
-- IN parametros de entrada
-- OUT parametros de salida
-- INOUT parametros de entrada y salida
CREATE PROCEDURE mostrar_clientes()
SELECT id,nombre,id_ultimo_pedido
FROM cliente ORDER BY nombre;

CALL mostrar_clientes();

CREATE PROCEDURE datos_cliente(IN id_cliente INT)
SELECT id,nombre,id_ultimo_pedido 
FROM cliente WHERE id=id_cliente;

CALL datos_cliente(1);

CREATE PROCEDURE insertar_cliente(nombre VARCHAR(25),id_ultimo INT)
INSERT INTO cliente(nombre,id_ultimo_pedido)
 VALUES(nombre,id_ultimo);

CALL insertar_cliente('Patty','0');

CREATE PROCEDURE modificar_cliente(id_cliente INT,nombre VARCHAR(25),id_ultimo INT)
UPDATE cliente SET nombre=nombre, id_ultimo_pedido=id_ultimo
WHERE id=id_cliente;

CALL modificar_cliente(4,'Lucia',100);

DROP PROCEDURE eliminar_cliente;

CREATE PROCEDURE eliminar_cliente(id_cliente INT)
DELETE FROM cliente WHERE id=id_cliente;

ROLLBACK;

CALL eliminar_cliente(8);

CREATE PROCEDURE mostrar_usuarios()
SELECT id_usuario,nombre,ap_paterno,ap_materno,ci FROM usuarios ORDER BY nombre;

CREATE PROCEDURE usuario_get_by_id(id INT)
SELECT id_usuario
		,nombre
		,ap_paterno
		,ap_materno
		,ci
		,direccion
		,celular
		,email
		,id_rol
	FROM usuarios
	WHERE id_usuario=id;





DROP PROCEDURE insertar_usuario;


DELIMITER //
CREATE PROCEDURE insertar_usuario(nombre VARCHAR(25),ap_pat VARCHAR(25),ap_mat VARCHAR(25),ci INT, direccion VARCHAR(50),celular INT, email VARCHAR(25), id_rol INT)
BEGIN
IF NOT EXISTS (SELECT u.ci FROM usuarios u WHERE u.ci=ci) THEN
INSERT INTO usuarios(nombre,ap_paterno,ap_materno,ci,direccion,celular,email,id_rol) VALUES(nombre,ap_pat,ap_mat,ci,direccion,celular,email,id_rol);
ELSE
SELECT 'El Usuario ya esta registrado';
END IF;
END
//
DELIMITER ;

CALL insertar_usuario('laura','pariente','nose',666,'nose',369852,'laura@hotmail.com',1);








