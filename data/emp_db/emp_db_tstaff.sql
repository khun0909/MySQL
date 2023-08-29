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
-- Table structure for table `tstaff`
--

DROP TABLE IF EXISTS `tstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tstaff` (
  `name` char(15) NOT NULL,
  `depart` char(10) NOT NULL,
  `gender` char(3) NOT NULL,
  `joindate` date NOT NULL,
  `grade` char(10) NOT NULL,
  `salary` int NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tstaff`
--

LOCK TABLES `tstaff` WRITE;
/*!40000 ALTER TABLE `tstaff` DISABLE KEYS */;
INSERT INTO `tstaff` VALUES ('강감찬','영업부','남','2018-10-09','사원',320,56.00),('김유신','총무부','남','2000-02-03','이사',420,88.80),('논개','인사과','여','2010-09-16','대리',340,46.20),('대조영','총무부','남','2020-07-07','차장',290,49.90),('선덕여왕','인사과','여','2017-08-03','사원',315,45.10),('성삼문','영업부','남','2014-06-08','대리',285,87.75),('신사임당','영업부','여','2013-06-19','부장',400,92.00),('안중근','인사과','남','2012-05-05','대리',256,76.50),('안창호','영업부','남','2015-08-15','사원',370,74.20),('유관순','영업부','여','2009-03-01','과장',380,NULL),('윤봉길','영업부','남','2015-08-15','과장',350,71.25),('을지문덕','영업부','남','2019-06-29','사원',330,NULL),('이사부','총무부','남','2000-02-03','대리',375,50.00),('이율곡','총무부','남','2016-03-08','과장',385,65.40),('장보고','인사과','남','2005-04-01','부장',440,58.30),('정몽주','총무부','남','2010-09-16','대리',370,89.50),('정약용','총무부','남','2020-03-14','과장',380,69.80),('허난설헌','인사과','여','2020-01-05','사원',285,44.50),('홍길동','인사과','남','2019-08-08','차장',380,77.70),('황진이','인사과','여','2012-05-05','사원',275,52.50);
/*!40000 ALTER TABLE `tstaff` ENABLE KEYS */;
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
