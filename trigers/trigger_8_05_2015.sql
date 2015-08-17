
-- objetos de la base de datos
-- ejecutan cuando se trata de modificar alguna tabla
-- los trigger se crean tabla por tabla 
-- eventos
	-- insert
	-- update
	-- delete
-- momento de ejecuacion
	-- antes de ejecutar la instruccion del usuario 	
	-- despues para mantener la integridad de datos

-- auditoria 
	-- control de transacciones
	
DROP TABLE cliente;
CREATE TABLE cliente(
	id INT PRIMARY KEY AUTO_INCREMENT
	,nombre VARCHAR(25)
	,id_ultimo_pedido INT
);
DROP TABLE ventas;
CREATE TABLE ventas(
	id INT PRIMARY KEY AUTO_INCREMENT
	,id_articulo INT
	,id_cliente INT
	,cantidad INT
	,precio DECIMAL
); 
INSERT INTO cliente(nombre) VALUES('Evo');
INSERT INTO cliente(nombre) VALUES('Alvaro');
INSERT INTO cliente(nombre) VALUES('Carlos');
-- before, after
-- new  NEW.id_articulo
-- old  old.id_articulo
CREATE TRIGGER nueva_ventas AFTER INSERT ON ventas
    FOR EACH ROW
    UPDATE cliente SET id_ultimo_pedido=NEW.id_articulo
    WHERE id=NEW.id_cliente
;   
 
INSERT INTO ventas
       (id_articulo,id_cliente,cantidad,precio)
       VALUES
       (100,3,1,150);

INSERT INTO ventas
       (id_articulo,id_cliente,cantidad,precio)
       VALUES
       (200,2,1,150);
       
INSERT INTO ventas
       (id_articulo,id_cliente,cantidad,precio)
       VALUES
       (300,1,1,150);
       
CREATE TABLE almacen(
	id INT PRIMARY KEY AUTO_INCREMENT
	,id_articulo INT
	,stock INT
);
INSERT INTO almacen 
	(id_articulo,stock)
	VALUES
	(100,10);

INSERT INTO almacen 
	(id_articulo,stock)
	VALUES
	(200,20);
INSERT INTO almacen 
	(id_articulo,stock)
	VALUES
	(300,30);

CREATE TRIGGER nueva_ventas2 BEFORE INSERT ON ventas
    FOR EACH ROW
    UPDATE almacen SET stock=stock - NEW.cantidad
    WHERE id_articulo=NEW.id_articulo
;   

INSERT INTO ventas
       (id_articulo,id_cliente,cantidad,precio)
       VALUES
       (100,1,1,750);

CREATE TABLE ventas_log(
	id INT PRIMARY KEY AUTO_INCREMENT
	,operacion VARCHAR(20)
	,usuario VARCHAR(30)
	,id_venta INT
	,new_id_articulo INT
	,old_id_articulo INT
	,new_id_cliente INT
	,old_id_cliente INT
	,new_cantidad INT
	,old_cantidad INT
	,new_precio DECIMAL
	,old_precio DECIMAL
	,fecha TIMESTAMP
);
DROP TRIGGER nueva_ventas;
CREATE TRIGGER nueva_ventas AFTER INSERT ON ventas
    FOR EACH ROW
    INSERT ventas_log
    (operacion,usuario,id_venta,new_id_articulo,new_id_cliente,new_cantidad,new_precio,fecha)
    VALUES
    ('insert',CURRENT_USER(),NEW.id,NEW.id_articulo,NEW.id_cliente,NEW.cantidad,New.Precio,NOW())  
;  
CREATE TRIGGER eliminar_ventas AFTER DELETE ON ventas
    FOR EACH ROW
    INSERT ventas_log
    (operacion,usuario,id_venta,old_id_articulo,old_id_cliente,old_cantidad,old_precio,fecha)
    VALUES
    ('delete',CURRENT_USER(),old.id,old.id_articulo,old.id_cliente,old.cantidad,old.Precio,NOW())  
;
DELETE FROM ventas WHERE id=4;  