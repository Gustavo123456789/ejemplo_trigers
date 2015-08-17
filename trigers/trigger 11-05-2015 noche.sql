DELIMITER //
CREATE TRIGGER nueva_venta AFTER INSERT ON ventas
    FOR EACH ROW
    BEGIN
        UPDATE cliente SET id_ultimo_pedido=NEW.id_articulo WHERE id=NEW.id_cliente;
        UPDATE almacen SET stock = stock - NEW.cantidad WHERE id_articulo=NEW.id_articulo;      
    END
//
DELIMITER ;


INSERT INTO ventas
	(id_articulo,id_cliente,cantidad,precio)
	VALUES
	(300,3,25,100);
	
	
DELIMITER //
CREATE TRIGGER validar_venta BEFORE INSERT ON ventas
    FOR EACH ROW
    BEGIN
        
        IF (SELECT stock FROM almacen WHERE id_articulo=NEW.id_articulo) < NEW.cantidad THEN
             SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: NO TIENE LA CANTIDAD SOLICITADA EN ALMACEN';        
        END IF;      
    END
//
DELIMITER ;	
	
	
	
	
	
	
-- http://manuales.guebs.com/mysql-5.0/error-handling.html
	
DELIMITER //	
CREATE TRIGGER nuevo_cliente BEFORE INSERT ON cliente
    FOR EACH ROW
    BEGIN
        IF new.nombre='' THEN
             SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: EL NOMBRE NO PUEDE ESTAR VACIO';        
        END IF;
    END
//
DELIMITER ;

INSERT INTO cliente(nombre) VALUES('');




