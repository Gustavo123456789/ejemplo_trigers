CREATE USER super_usuario
	IDENTIFIED BY 'mysql';
	
CREATE USER usuario_sad_db
	IDENTIFIED BY 'mysql';
	

CREATE USER usuario_sad_prod
	IDENTIFIED BY 'mysql';
	
GRANT ALL PRIVILEGES ON *.*  TO 'super_usuario'@'localhost';

FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON sad_db.* TO 'usuario_sad_db'@'localhost';


GRANT SELECT ON sad_db.productos TO 'usuario_sad_prod'@'localhost';
GRANT UPDATE,INSERT ON sad_db.productos 
         TO 'usuario_sad_prod'@'localhost';

FLUSH PRIVILEGES;




REVOKE UPDATE ON sad_db.productos FROM 'usuario_sad_prod'@'localhost';



FLUSH PRIVILEGES;




