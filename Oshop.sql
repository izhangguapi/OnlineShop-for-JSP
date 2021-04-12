DROP DATABASE IF EXISTS eshop;
CREATE DATABASE eshop DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use eshop;

-- ------------------------------
-- 创建commoditiestype（商品类型）表
-- ------------------------------
DROP TABLE IF EXISTS `commoditiestype`;
CREATE TABLE `commoditiestype` (
  `typeid` INT(4) NOT NULL AUTO_INCREMENT,
  `typename` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO commoditiestype VALUES ('1','衣服');
INSERT INTO commoditiestype VALUES ('2','旅游');
INSERT INTO commoditiestype VALUES ('3','其他');
-- ------------------------------
-- 创建commodities（商品）表
-- ------------------------------
DROP TABLE IF EXISTS `commodities`;
CREATE TABLE `commodities` (
  `commodityid` INT(4) NOT NULL AUTO_INCREMENT,
  `typeid` INT(4) NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  `price` DOUBLE(9,2) NOT NULL,
  `picture` VARCHAR(100) DEFAULT NULL,
	`state` BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (`commodityid`),
  FOREIGN KEY (`typeid`) REFERENCES `commoditiestype` (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO commodities VALUES ('1001','1','男士上服','19.90',"img/commodities/4.png",TRUE);
INSERT INTO commodities VALUES ('1002','3','李贝鞋子','215.00',"img/commodities/9.png",TRUE);
INSERT INTO commodities VALUES ('1003','2','旅游帽子','25.80',"img/commodities/11.png",TRUE);
INSERT INTO commodities VALUES ('1004','3','酷炫眼镜','105.00',"img/commodities/12.png",TRUE);
INSERT INTO commodities VALUES ('1005','3','酷炫台灯','50.00',"img/commodities/1.png",TRUE);
INSERT INTO commodities VALUES ('1006','3','长的沙发','198.00',"img/commodities/2.png",FALSE);
INSERT INTO commodities VALUES ('1007','3','高的凳子','86.00',"img/commodities/3.png",TRUE);
INSERT INTO commodities VALUES ('1008','3','短的沙发','98.00',"img/commodities/5.png",TRUE);
INSERT INTO commodities VALUES ('1009','3','吊着的灯','35.00',"img/commodities/6.png",FALSE);
INSERT INTO commodities VALUES ('1010','3','普通椅子','49.90',"img/commodities/7.png",TRUE);
INSERT INTO commodities VALUES ('1011','3','很矮椅子','76.00',"img/commodities/8.png",TRUE);
INSERT INTO commodities VALUES ('1012','3','无手沙发','149.00',"img/commodities/10.png",TRUE);
INSERT INTO commodities VALUES ('1013','3','炫酷的钟','36.00',"img/commodities/13.png",TRUE);
INSERT INTO commodities VALUES ('1014','3','四轮滑板','205.00',"img/commodities/14.png",FALSE);
INSERT INTO commodities VALUES ('1015','3','公文包','89.00',"img/commodities/15.png",TRUE);
INSERT INTO commodities VALUES ('1016','1','蓝色衣服','29.00',"img/commodities/16.png",TRUE);
-- ------------------------------
-- 创建users（用户）表
-- ------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userid` INT(4) NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(16) NOT NULL,
  `nickname` VARCHAR(16) DEFAULT NULL,
  `name` VARCHAR(5) DEFAULT NULL,
  `telephone` VARCHAR(11) NOT NULL,
  `mail` VARCHAR(50) DEFAULT NULL,
  `address` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO users VALUES ('1000','123','管理员','张三','13526378907','13526378907@qq.com','湖北省武汉市江夏区');
INSERT INTO users VALUES ('1001','123','小旋风','李四','18789079870','18789079870@qq.com','湖北省武汉市洪山区');
INSERT INTO users VALUES ('1002','123','大牛牛','王五','18954875124','18954875124@qq.com','湖北省武汉市青山区');
-- ------------------------------
-- 创建orders（订单）表
-- ------------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderid` VARCHAR(18) NOT NULL,
  `time` DATETIME NOT NULL,
  `userid` INT(4) NOT NULL,
  `price` DOUBLE(9,2) NOT NULL,
	`state` BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`orderid`),
  FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO orders VALUES ('100020200512155435','2020-05-12 15:54:35','1000','279.9',TRUE);
INSERT INTO orders VALUES ('100120201101211414','2020-11-01 21:14:14','1001','615',FALSE);
INSERT INTO orders VALUES ('100220201003022445','2020-10-03 02:24:45','1001','717.8',TRUE);
INSERT INTO orders VALUES ('100320200122154441','2020-01-22 15:44:41','1001','274',FALSE);
INSERT INTO orders VALUES ('100420200830104358','2020-08-30 10:43:58','1002','249.8',TRUE);
INSERT INTO orders VALUES ('100520200910193414','2020-09-10 19:34:14','1002','535.9',TRUE);

-- ------------------------------
-- 创建orders（订单商品）表
-- ------------------------------
DROP TABLE IF EXISTS `orderProduct`;
CREATE TABLE `orderProduct` (
  `orderid` VARCHAR(18) NOT NULL,
  `commodityid` INT(4) NOT NULL,
	`number` INT(4) NOT NULL,
  FOREIGN KEY (`orderid`) REFERENCES `orders` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO orderProduct VALUES ('100020200512155435','1001','1');
INSERT INTO orderProduct VALUES ('100020200512155435','1004','2');
INSERT INTO orderProduct VALUES ('100020200512155435','1005','1');
INSERT INTO orderProduct VALUES ('100120201101211414','1014','3');
INSERT INTO orderProduct VALUES ('100220201003022445','1008','2');
INSERT INTO orderProduct VALUES ('100220201003022445','1004','2');
INSERT INTO orderProduct VALUES ('100220201003022445','1003','1');
INSERT INTO orderProduct VALUES ('100220201003022445','1011','3');
INSERT INTO orderProduct VALUES ('100220201003022445','1016','2');
INSERT INTO orderProduct VALUES ('100320200122154441','1006','1');
INSERT INTO orderProduct VALUES ('100320200122154441','1011','1');
INSERT INTO orderProduct VALUES ('100420200830104358','1010','2');
INSERT INTO orderProduct VALUES ('100420200830104358','1005','3');
INSERT INTO orderProduct VALUES ('100520200910193414','1007','1');
INSERT INTO orderProduct VALUES ('100520200910193414','1002','2');
INSERT INTO orderProduct VALUES ('100520200910193414','1001','1');
-- ------------------------------
-- 创建cart（购物车）表
-- ------------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
	`userid` INT(4) NOT NULL,
	`commodityid` INT(4) NOT NULL,
	`number` INT(10) NOT NULL,
  FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
	FOREIGN KEY (`commodityid`) REFERENCES `commodities` (`commodityid`)
) ENGINE=InnoDB AUTO_INCREMENT=1;

INSERT INTO cart VALUES ('1000','1001','1');
INSERT INTO cart VALUES ('1000','1002','2');
INSERT INTO cart VALUES ('1000','1003','1');
INSERT INTO cart VALUES ('1000','1004','2');
INSERT INTO cart VALUES ('1000','1005','6');
INSERT INTO cart VALUES ('1001','1006','1');
INSERT INTO cart VALUES ('1001','1007','1');
INSERT INTO cart VALUES ('1001','1008','2');
INSERT INTO cart VALUES ('1001','1009','1');
INSERT INTO cart VALUES ('1001','1010','3');
INSERT INTO cart VALUES ('1001','1011','1');
INSERT INTO cart VALUES ('1002','1012','1');
INSERT INTO cart VALUES ('1002','1013','4');
INSERT INTO cart VALUES ('1002','1014','1');
INSERT INTO cart VALUES ('1002','1015','1');
INSERT INTO cart VALUES ('1002','1016','1');