CREATE TABLE almacen(
	id INT
	,id_almacen INT
	,id_articulo INT
	,stock INT
);
INSERT INTO almacen VALUES(1,1,100,10);
INSERT INTO almacen VALUES(2,1,200,20);
INSERT INTO almacen VALUES(3,1,300,100);

DROP TRIGGER Actualizar_Stock;
DELIMITER //
CREATE TRIGGER Actualizar_Stock AFTER INSERT ON ventas
    FOR EACH ROW
    BEGIN
        UPDATE almacen SET stock=stock - NEW.cantidad  WHERE id_articulo=NEW.id_articulo;
        UPDATE cliente SET id_ultimo_pedido = NEW.id WHERE id = NEW.id_cliente;
    END
//
DELIMITER ;

-- http://manuales.guebs.com/mysql-5.0/error-handling.html

DROP TRIGGER insertar_ventas;

DELIMITER //
CREATE TRIGGER insertar_ventas BEFORE INSERT ON ventas
    FOR EACH ROW
    BEGIN
        IF new.cantidad <= 0 THEN 
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puedo actualizar el registro reconciliado in ventas';
        END IF;
    END;
//
DELIMITER ;


INSERT INTO ventas VALUES(4,100,3,0,10);



DELIMITER //
CREATE TRIGGER actualizarventas BEFORE UPDATE ON ventas
    FOR EACH ROW
    BEGIN
        IF ( SELECT reconciliado FROM ventas WHERE id = NEW.id ) > 0 THEN
		ROLLBACK;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puedo actualizar el registro reconciliado in ventas';
        END IF;
    END;
//
DELIMITER ;


DROP PROCEDURE IF EXISTS lista_albums;

DELIMITER //
CREATE PROCEDURE lista_albums ()
BEGIN
    SELECT * FROM album;
END
//

DELIMITER ;
CALL lista_albums();