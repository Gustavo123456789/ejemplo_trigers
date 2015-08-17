CREATE DATABASE sad_db;

USE sad_db;

CREATE TABLE usuarios(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT
	,nombre VARCHAR(25) NOT NULL
	,ap_paterno VARCHAR(25) NOT NULL
	,ap_materno VARCHAR(25) 
	,ci INT UNIQUE
	,direccion VARCHAR(150)NOT NULL
	,celular INT NOT NULL UNIQUE
	,email VARCHAR(100) NOT NULL
	 
);
CREATE TABLE usuarios2(
	id_usuario INT
	,nombre VARCHAR(25) NOT NULL
	,ap_paterno VARCHAR(25) NOT NULL
	,ap_materno VARCHAR(25) 
	,ci INT 
	,direccion VARCHAR(150)NOT NULL
	,celular INT NOT NULL  
);
/* agregar un campo*/
ALTER TABLE usuarios2
	ADD email VARCHAR(50) NOT NULL;

ALTER TABLE usuarios2
	DROP email;
	
	
/* cambiar de nombre a la tabla*/
ALTER TABLE usuarios2
	RENAME usuarios22;

/* agregar primary key*/
ALTER TABLE usuarios2
	ADD CONSTRAINT pk_id_usuario PRIMARY KEY(id_usuario);
ALTER TABLE usuarios2
	ADD CONSTRAINT pk_id_usuario PRIMARY KEY(ci);
/* cambiar de nombre a un campo*/

ALTER TABLE usuarios2
	CHANGE movil movil2  INT(11) NOT NULL;
	
ALTER TABLE `usuarios2`
 CHANGE `celular` `movil` INT(11) NOT NULL;
/* agregar check a un campo*/

ALTER TABLE usuarios2
	ADD edad INT NOT NULL; 
 
ALTER TABLE usuarios2
ADD CONSTRAINT chk_edad CHECK (edad>0)
