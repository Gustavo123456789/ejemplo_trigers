CREATE TABLE cliente( id SERIAL, nombre VARCHAR(255), id_ultimo_pedido BIGINT );
CREATE TABLE ventas ( id SERIAL, id_articulo BIGINT, id_cliente BIGINT, cantidad INT, precio DECIMAL(9,2) );

INSERT INTO cliente(nombre) VALUES ('Bob');
INSERT INTO cliente(nombre) VALUES ('Sally');
INSERT INTO cliente(nombre) VALUES ('Fred');

SELECT * FROM cliente;

CREATE TRIGGER nuevasventas AFTER INSERT ON ventas
    FOR EACH ROW
    UPDATE cliente SET id_ultimo_pedido = NEW.id WHERE id = NEW.id_cliente
;

INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio) VALUES (1, 3, 5, 19.95);
INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio) VALUES (2, 2, 3, 14.95);
INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio) VALUES (3, 1, 1, 29.95);
SELECT * FROM ventas;
SELECT * FROM cliente


DROP TABLE IF EXISTS ventas;

CREATE TABLE ventas ( id SERIAL, id_articulo BIGINT, id_cliente BIGINT, cantidad INT, precio DECIMAL(9,2), reconciliado INT );
INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio, reconciliado) VALUES (1, 3, 5, 19.95, 0);
INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio, reconciliado) VALUES (2, 2, 3, 14.95, 1);
INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio, reconciliado) VALUES (3, 1, 1, 29.95, 0);
SELECT * FROM ventas;

DELIMITER //
CREATE TRIGGER actualizarventas BEFORE UPDATE ON ventas
    FOR EACH ROW
    BEGIN
        IF ( SELECT reconciliado FROM ventas WHERE id = NEW.id ) > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puedo actualizar el registro reconciliado in ventas';
        END IF;
    END;
//
DELIMITER ;

START TRANSACTION;
UPDATE ventas SET cantidad = cantidad + 9 WHERE id = 2;
COMMIT;

SELECT * FROM ventas;


DROP TABLE IF EXISTS ventas;

CREATE TABLE ventas ( id SERIAL, id_articulo BIGINT, id_cliente BIGINT, cantidad INT, precio DECIMAL(9,2) );
CREATE TABLE registro ( id SERIAL, marca TIMESTAMP, evento VARCHAR(255), nombreusuario VARCHAR(255),
    nombretabla VARCHAR(255), id_tabla BIGINT);
    
DELIMITER //
CREATE TRIGGER marcaVenta AFTER INSERT ON ventas
    FOR EACH ROW
    BEGIN
        UPDATE cliente SET id_ultimo_pedido = NEW.id
            WHERE cliente.id = NEW.id_cliente;
        INSERT INTO registro (evento, nombreusuario, nombretabla, id_tabla)
            VALUES ('INSERT', 'TRIGGER', 'ventas', NEW.id);
    END
//
DELIMITER ;

INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio) VALUES (1, 3, 5, 19.95);
INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio) VALUES (2, 2, 3, 14.95);
INSERT INTO ventas (id_articulo, id_cliente, cantidad, precio) VALUES (3, 1, 1, 29.95);

SELECT * FROM ventas;
SELECT * FROM cliente;
SELECT * FROM registro;

DROP TRIGGER IF EXISTS nuevasventas;
DROP TRIGGER IF EXISTS actualizarventas;
DROP TRIGGER IF EXISTS marcaventas;

DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS registro;