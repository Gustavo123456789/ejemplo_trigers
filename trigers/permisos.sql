CREATE USER 'valencia'@'localhost' 
         IDENTIFIED BY 'jhosselin';
         
CREATE USER 'geymar'@'localhost'
	IDENTIFIED BY 'wilson';
	
CREATE USER 'fuertes'@'localhost'
	IDENTIFIED BY 'prometido';

-- permisos Super usuario para valencia
GRANT ALL PRIVILEGES ON * . * 
         TO 'valencia'@'localhost';
         
-- permisos de usuario para beymar
GRANT ALL PRIVILEGES ON infochat.* TO 'geymar'@'localhost';         

-- permisos para fuertes

GRANT ALL PRIVILEGES ON infochat.usuario TO 'fuertes'@'localhost';          

FLUSH PRIVILEGES;

-- remover permisos

 REVOKE ALL ON infochat.usuario FROM 'fuertes'@'localhost';


GRANT SELECT,INSERT  ON infochat.* TO 'fuertes'@'localhost';          



CREATE OR REPLACE VIEW Mejores_clientes AS
SELECT c.id
        ,c.nombre
	, SUM(v.precio) AS monto
FROM ventas v
INNER JOIN cliente c ON v.id_cliente=c.id
HAVING monto > 1000
GROUP BY v.id_cliente;


SELECT * FROM Mejores_clientes;
INSERT INTO Mejores_clientes (id,nombre,monto)
 VALUES(4,'garcia',2000);


