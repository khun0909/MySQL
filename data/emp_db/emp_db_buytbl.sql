-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: emp_db
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `buytbl`
--

DROP TABLE IF EXISTS `buytbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buytbl` (
  `num` int NOT NULL AUTO_INCREMENT,
  `userid` char(8) NOT NULL,
  `productname` char(10) DEFAULT NULL,
  `groupname` char(10) DEFAULT NULL,
  `price` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`num`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buytbl`
--

LOCK TABLES `buytbl` WRITE;
/*!40000 ALTER TABLE `buytbl` DISABLE KEYS */;
INSERT INTO `buytbl` VALUES (1,'kty','운동화','잡화',30,2),(2,'kty','노트북','전자',1000,1),(3,'jsm','운동화','잡화',30,1),(4,'lhl','모니터','전자',200,1),(5,'bsj','모니터','전자',200,1),(6,'kty','청바지','잡화',100,1),(7,'lhl','책','서적',15,2),(8,'iyou','책','서적',15,7),(9,'iyou','컴퓨터','전자',500,1),(10,'bsj','노트북','전자',1000,1),(11,'bjh','메모리','전자',50,4),(12,'ailee','운동화','잡화',30,2),(13,'ghr','운동화','잡화',30,1);
/*!40000 ALTER TABLE `buytbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-29 10:47:22
