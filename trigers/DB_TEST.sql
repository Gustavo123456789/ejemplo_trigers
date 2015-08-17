/*
SQLyog Community v11.25 (64 bit)
MySQL - 5.5.27 : Database - test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`test` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `test`;

/*Table structure for table `almacen` */

DROP TABLE IF EXISTS `almacen`;

CREATE TABLE `almacen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_articulo` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `almacen` */

insert  into `almacen`(`id`,`id_articulo`,`stock`) values (1,100,4),(2,200,20),(3,300,15);

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) DEFAULT NULL,
  `id_ultimo_pedido` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `cliente` */

insert  into `cliente`(`id`,`nombre`,`id_ultimo_pedido`) values (1,'Evo',300),(2,'Alvaro',200),(3,'Carlos',300);

/*Table structure for table `ventas` */

DROP TABLE IF EXISTS `ventas`;

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_articulo` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `ventas` */

insert  into `ventas`(`id`,`id_articulo`,`id_cliente`,`cantidad`,`precio`) values (1,100,3,1,'150'),(2,200,2,1,'150'),(3,300,1,1,'150'),(5,100,1,1,'750'),(6,300,1,10,'125'),(7,300,3,5,'100'),(8,300,3,25,'100');

/*Table structure for table `ventas_log` */

DROP TABLE IF EXISTS `ventas_log`;

CREATE TABLE `ventas_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operacion` varchar(20) DEFAULT NULL,
  `usuario` varchar(30) DEFAULT NULL,
  `id_venta` int(11) DEFAULT NULL,
  `new_id_articulo` int(11) DEFAULT NULL,
  `old_id_articulo` int(11) DEFAULT NULL,
  `new_id_cliente` int(11) DEFAULT NULL,
  `old_id_cliente` int(11) DEFAULT NULL,
  `new_cantidad` int(11) DEFAULT NULL,
  `old_cantidad` int(11) DEFAULT NULL,
  `new_precio` decimal(10,0) DEFAULT NULL,
  `old_precio` decimal(10,0) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `ventas_log` */

insert  into `ventas_log`(`id`,`operacion`,`usuario`,`id_venta`,`new_id_articulo`,`old_id_articulo`,`new_id_cliente`,`old_id_cliente`,`new_cantidad`,`old_cantidad`,`new_precio`,`old_precio`,`fecha`) values (1,'insert','root@localhost',5,100,NULL,1,NULL,1,NULL,'750',NULL,'2015-05-08 21:21:34'),(2,'insert','root@localhost',4,NULL,100,NULL,1,NULL,5,NULL,'750','2015-05-08 21:26:30');

/* Trigger structure for table `cliente` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `nuevo_cliente` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `nuevo_cliente` BEFORE INSERT ON `cliente` FOR EACH ROW begin
        if new.nombre='' then
             SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: EL NOMBRE NO PUEDE ESTAR VACIO';        
        end if;
    END */$$


DELIMITER ;

/* Trigger structure for table `ventas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `validar_venta` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `validar_venta` BEFORE INSERT ON `ventas` FOR EACH ROW BEGIN
        
        IF (select stock from almacen where id_articulo=NEW.id_articulo) < NEW.cantidad THEN
             SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: NO TIENE LA CANTIDAD SOLICITADA EN ALMACEN';        
        END IF;      
    END */$$


DELIMITER ;

/* Trigger structure for table `ventas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `nueva_venta` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `nueva_venta` AFTER INSERT ON `ventas` FOR EACH ROW begin
        update cliente set id_ultimo_pedido=NEW.id_articulo where id=NEW.id_cliente;
        update almacen set stock = stock - NEW.cantidad where id_articulo=NEW.id_articulo;      
    end */$$


DELIMITER ;

/*Table structure for table `mejores_clientes` */

DROP TABLE IF EXISTS `mejores_clientes`;

/*!50001 DROP VIEW IF EXISTS `mejores_clientes` */;
/*!50001 DROP TABLE IF EXISTS `mejores_clientes` */;

/*!50001 CREATE TABLE  `mejores_clientes`(
 `id` int(11) ,
 `nombre` varchar(25) ,
 `monto` decimal(32,0) 
)*/;

/*View structure for view mejores_clientes */

/*!50001 DROP TABLE IF EXISTS `mejores_clientes` */;
/*!50001 DROP VIEW IF EXISTS `mejores_clientes` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mejores_clientes` AS select `c`.`id` AS `id`,`c`.`nombre` AS `nombre`,sum(`v`.`precio`) AS `monto` from (`ventas` `v` join `cliente` `c` on((`v`.`id_cliente` = `c`.`id`))) where (2 > 1000) group by `v`.`id_cliente` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
