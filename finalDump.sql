-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hoteldb
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenities` (
  `aid` int NOT NULL AUTO_INCREMENT,
  `amenity` varchar(45) NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,'parking'),(2,'restaurant'),(3,'bar'),(4,'wifi'),(5,'pool'),(6,'gym'),(7,'spa');
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `bid` int NOT NULL AUTO_INCREMENT,
  `guest_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `no_guests` int NOT NULL,
  `room_type` varchar(128) NOT NULL,
  `booking_date` date NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  PRIMARY KEY (`bid`),
  KEY `hotel_id_idx` (`hotel_id`),
  KEY `guest_id_idx` (`guest_id`),
  CONSTRAINT `booking_gid` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`gid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `bookingk_hid` FOREIGN KEY (`hotel_id`) REFERENCES `marriott_hotel_chain` (`hid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (2,1,1,1,'Deluxe Garden View','2022-10-24','2022-12-09','2022-12-12'),(9,3,2,1,'Deluxe Garden View','2022-10-24','2023-02-13','2023-02-20'),(10,4,1,2,'Deluxe','2022-12-09','2022-12-09','2022-12-20');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guests` (
  `gid` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `country_of_residence` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state_or_province` varchar(45) DEFAULT NULL,
  `postal_code` varchar(15) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(128) NOT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guests`
--

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` VALUES (1,'Mili','Parikh','1999-09-09','Female','USA','87 Sheridan st','Boston','MA','2108','8573829184','parikhmili09@gmail.com'),(2,'Shaili','Parikh','1999-01-02','Female','India','3 Mark','Mumbai','Mah','390020','123456789','shaili@gmail.com'),(3,'Alex','Henry','1996-12-12','Female','USA','20 Apple St','Boston','Mass','02367','5084561211','email@yahoo.com'),(4,'Harsh','Modi','1999-10-31','Male','USA','3Mark','Boston','MA','02130','384930469','harsh@gmail.com'),(5,'Amy','Hale','1999-09-12','Female','USA','3Byner','Truro','MA','02381','97234873874','amy@sms.com'),(6,'Mili','PArikh','1999-09-09','Female','USA','3MArk','Boston','MA','02130','82374973947','mili@s.com'),(7,'Mili','Parikh','1999-09-09','Female','USA','3Mark','Boston','MA','02130','9347973974','sample@gmail.com');
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_amenities`
--

DROP TABLE IF EXISTS `hotel_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_amenities` (
  `hotel_id` int NOT NULL,
  `amenity_id` int NOT NULL,
  PRIMARY KEY (`hotel_id`,`amenity_id`),
  KEY `amenity_id_idx` (`amenity_id`),
  KEY `amenity_hid` (`hotel_id`),
  CONSTRAINT `amenity_aid` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`aid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `amenity_hid` FOREIGN KEY (`hotel_id`) REFERENCES `marriott_hotel_chain` (`hid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_amenities`
--

LOCK TABLES `hotel_amenities` WRITE;
/*!40000 ALTER TABLE `hotel_amenities` DISABLE KEYS */;
INSERT INTO `hotel_amenities` VALUES (1,1),(2,1),(4,1),(5,1),(1,2),(1,3),(1,4),(2,4),(3,4),(1,5),(3,5),(4,5),(3,6),(4,6),(4,7);
/*!40000 ALTER TABLE `hotel_amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_managers`
--

DROP TABLE IF EXISTS `hotel_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_managers` (
  `hotel_id` int NOT NULL,
  `manager_uniqueid` int NOT NULL,
  PRIMARY KEY (`hotel_id`,`manager_uniqueid`),
  KEY `hotel_id_idx` (`hotel_id`),
  KEY `manager_uniqueid_idx` (`manager_uniqueid`),
  CONSTRAINT `hotelmanagers_hid` FOREIGN KEY (`hotel_id`) REFERENCES `marriott_hotel_chain` (`hid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hotelmanagers_uniqueid` FOREIGN KEY (`manager_uniqueid`) REFERENCES `staff` (`unique_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_managers`
--

LOCK TABLES `hotel_managers` WRITE;
/*!40000 ALTER TABLE `hotel_managers` DISABLE KEYS */;
INSERT INTO `hotel_managers` VALUES (1,3),(2,5),(3,7),(4,8),(5,6);
/*!40000 ALTER TABLE `hotel_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_rooms`
--

DROP TABLE IF EXISTS `hotel_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_rooms` (
  `hotel_id` int NOT NULL,
  `room_id` int NOT NULL,
  PRIMARY KEY (`hotel_id`,`room_id`),
  KEY `hotelrooms_roomid_idx` (`room_id`),
  CONSTRAINT `hotelrooms_hid` FOREIGN KEY (`hotel_id`) REFERENCES `marriott_hotel_chain` (`hid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hotelrooms_roomid` FOREIGN KEY (`room_id`) REFERENCES `room_types` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_rooms`
--

LOCK TABLES `hotel_rooms` WRITE;
/*!40000 ALTER TABLE `hotel_rooms` DISABLE KEYS */;
INSERT INTO `hotel_rooms` VALUES (1,1),(2,1),(1,2),(1,3),(2,3),(5,3),(2,4),(3,4),(5,4),(3,5),(5,5),(3,6),(4,6),(5,6),(4,7),(5,7);
/*!40000 ALTER TABLE `hotel_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marriott_hotel_chain`
--

DROP TABLE IF EXISTS `marriott_hotel_chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marriott_hotel_chain` (
  `hid` int NOT NULL AUTO_INCREMENT,
  `city` varchar(45) NOT NULL,
  `state` char(2) NOT NULL,
  `zip_code` char(5) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `website` varchar(512) DEFAULT NULL,
  `no_rooms` int DEFAULT NULL,
  PRIMARY KEY (`hid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marriott_hotel_chain`
--

LOCK TABLES `marriott_hotel_chain` WRITE;
/*!40000 ALTER TABLE `marriott_hotel_chain` DISABLE KEYS */;
INSERT INTO `marriott_hotel_chain` VALUES (1,'Boston','MA','12130','5678329173','https://www.marriott.com/default.mi',200),(2,'Worcester ','MA','12936','3947285332','https://www.marriott.com/default.mi',120),(3,'Natick','MA','13826','9382749991','https://www.marriott.com/default.mi',39),(4,'Lowell','MA','19285','2847392856','https://www.marriott.com/default.mi',55),(5,'New York','NY','20589','2748349292','https://www.marriott.com/default.mi',340);
/*!40000 ALTER TABLE `marriott_hotel_chain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_reservations`
--

DROP TABLE IF EXISTS `restaurant_reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant_reservations` (
  `reservation_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `guest_name` varchar(45) NOT NULL,
  `reservation_date` date NOT NULL,
  `reservation_time` time NOT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `hotel_id_idx` (`hotel_id`),
  CONSTRAINT `reservation_hid` FOREIGN KEY (`hotel_id`) REFERENCES `marriott_hotel_chain` (`hid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_reservations`
--

LOCK TABLES `restaurant_reservations` WRITE;
/*!40000 ALTER TABLE `restaurant_reservations` DISABLE KEYS */;
INSERT INTO `restaurant_reservations` VALUES (1,2,'Zeneb','2022-10-28','11:00:00');
/*!40000 ALTER TABLE `restaurant_reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `rating` enum('1','2','3','4','5') NOT NULL,
  `description` mediumtext,
  `publication_date` date NOT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'5','Amazing Experience!','2022-10-24');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_types`
--

DROP TABLE IF EXISTS `room_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_types` (
  `type_id` int NOT NULL,
  `room_type` varchar(45) NOT NULL,
  `no_beds` int NOT NULL,
  `bed_types` varchar(45) NOT NULL,
  `max_capacity` int NOT NULL,
  `description` varchar(255) NOT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_types`
--

LOCK TABLES `room_types` WRITE;
/*!40000 ALTER TABLE `room_types` DISABLE KEYS */;
INSERT INTO `room_types` VALUES (1,'Deluxe Garden View',2,'queen',4,'A refreshing mix of professional and casual, the Skyline Suite inspires with brilliant views of the Boston Commons Garden from the comforts of your guest suite.',580.00),(2,'Partial Harbor View',1,'queen',3,'A refreshing mix of professional and casual, the Skyline Suite inspires with brilliant views of the Boston skyline from the comforts of your guest suite.',431.00),(3,'Traditional Deluxe',2,'queen',4,'Enjoy luxurious bedding and spacious accommodations in our suites.',536.00),(4,'Premium View',1,'queen',3,'Enjoy luxurious bedding and spacious accommodations and scenic views in our suites.',310.00),(5,'Executive Parlor',1,'king',3,'The expansive Parlor is perfect for business or leisure travelers who want a little extra room. This suite includes a 200-sq. ft. parlor with a pull-out sofa for extra guests, a separate bedroom and a wet bar.',696.00),(6,'Bedroom Suite',1,'king',3,'One-Bedroom Corner Suite',711.00),(7,'Single Suite',1,'twin',1,'If you\'re traveling solo, this one person room is for you.',270.00);
/*!40000 ALTER TABLE `room_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `unique_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `date_of_birth` date NOT NULL,
  `home_address` varchar(255) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` char(2) NOT NULL,
  `zip_code` char(5) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `date_of_hire` date NOT NULL,
  `employment_type` varchar(45) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `role` varchar(45) NOT NULL,
  `hotel_id` int DEFAULT NULL,
  PRIMARY KEY (`unique_id`),
  KEY `hotel_id_idx` (`hotel_id`),
  CONSTRAINT `staff_hid` FOREIGN KEY (`hotel_id`) REFERENCES `marriott_hotel_chain` (`hid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Jessica','Amir','1994-02-02','13 Apple St','Boston','MA','2301','5678329173','jessica_mh@gmail.com','2018-09-01','Full-time',43000.00,'Receptionist',1),(2,'Haley','Moe','1996-12-07','25 Cherry Lane','Cambridge','MA','2301','9382749991','haley_mh@gmail.com','2018-09-01','Full-time',43000.00,'Receptionist',4),(3,'Joshua','Hall','1999-03-28','7 Aspen Way','Boston','MA','2301','9282744491','joshua_mh@gmail.com','2021-01-15','Full-time',80200.00,'Manager',1),(4,'Robert','Green','1992-07-14','8 Main St','Boston','MA','2301','4678622153','robert_mh@gmail.com','2021-03-09','Part-time',28000.00,'Receptionist',3),(5,'James','Carter','1989-08-12','13 Central St','Worcester','MA','1419','8678559275','james_mh@gmail.com','2021-04-19','Part-time',72000.00,'Manager',2),(6,'Joseph','Scott','1990-04-28','107 E. Main St','Manhattan','NY','2356','6673324177','joseph_mh@gmail.com','2020-09-19','Full-time',56000.00,'Manager',5),(7,'David','Walker','1993-05-27','10 Water St','Quincy','MA','1085','5674622115','david_mh@gmail.com','2021-10-15','Full-time',75000.00,'Manager',3),(8,'Mary','Hepzibah','1992-01-01','256 Constitution Ct','Framingham','MA','1748','8578459385','mary_mh@gmail.com','2021-10-15','Part-time',82000.00,'Manager',4);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hoteldb'
--

--
-- Dumping routines for database 'hoteldb'
--
/*!50003 DROP FUNCTION IF EXISTS `getBookingId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getBookingId`(guestId INT) RETURNS int
    DETERMINISTIC
BEGIN

DECLARE bookingId INT;

SELECT bid INTO bookingId
FROM bookings 
WHERE guest_id = guestId;

RETURN bookingId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `max_guestId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `max_guestId`() RETURNS int
    DETERMINISTIC
BEGIN
	declare max_guestId INT;
    
    WITH cte AS (SELECT gid FROM hoteldb.guests)
    SELECT MAX(gid) INTO max_guestId
    FROM cte; 

RETURN max_guestId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `allHotels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `allHotels`()
BEGIN

SELECT hid, city, state, zip_code FROM marriott_hotel_chain AS h; 
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cancelBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelBooking`(IN bookingnumber INT)
BEGIN

DELETE FROM bookings WHERE bid=bookingnumber;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createBooking`(IN fname VARCHAR(45), IN lname VARCHAR(45), IN dob DATE,
	IN p_gender VARCHAR(15), IN country VARCHAR(45), IN p_address VARCHAR(45), IN p_city VARCHAR(45),
    IN sop VARCHAR(45), IN pcode VARCHAR(15), IN phonenumber VARCHAR(15), IN p_email VARCHAR(128),
	IN hotel INT, IN noguests INT, IN roomtype VARCHAR(45),
    IN p_currdate DATE, IN checkin_date DATE, IN checkout_date DATE)
BEGIN

DECLARE memberid INT;

IF NOT EXISTS(SELECT * FROM guests WHERE email=p_email ) THEN
	INSERT INTO guests(first_name, last_name, date_of_birth, gender, country_of_residence, address,
		city, state_or_province, postal_code, phone, email)
		VALUES(fname, lname, dob, p_gender, country, p_address, p_city, sop, pcode, phonenumber, p_email);
    SELECT LAST_INSERT_ID() INTO memberid;     
ELSE
	SELECT gid INTO memberid FROM guests WHERE email=p_email;
END IF;	

INSERT INTO bookings(guest_id, hotel_id, no_guests, room_type, booking_date, check_in, check_out)
	VALUES(memberid, hotel, noguests, roomtype, p_currdate, checkin_date, checkout_date);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `findHotelAmenities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `findHotelAmenities`(IN hotelid INT)
BEGIN

SELECT a.amenity FROM amenities AS a
	JOIN hotel_amenities AS ha ON a.aid=ha.amenity_id
		WHERE hotel_id=hotelid;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `findHotelManagers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `findHotelManagers`()
BEGIN

SELECT s.unique_id, s.first_name AS manager_first_name, s.last_name AS manager_last_name,
		s.date_of_hire, s.employment_type, s.salary, s.role,
		h.hid, h.city AS hotel_location, h.state FROM marriott_hotel_chain AS h
				 LEFT JOIN hotel_managers AS m ON h.hid=m.hotel_id
					LEFT JOIN staff AS s ON s.unique_id=m.manager_uniqueid;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `findHotelManagersContactInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `findHotelManagersContactInfo`(IN hotelid INT)
BEGIN

SELECT s.first_name AS manager_first_name, s.last_name AS manager_last_name,
		s.phone AS phone, s.email AS email FROM marriott_hotel_chain AS h
				 LEFT JOIN hotel_managers AS m ON h.hid=m.hotel_id
					LEFT JOIN staff AS s ON s.unique_id=m.manager_uniqueid
                    WHERE h.hid = hotelid;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `modifyBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modifyBooking`(IN bookingnumber INT, IN new_checkin DATE, IN new_checkout DATE)
BEGIN

UPDATE bookings SET check_in=new_checkin, check_out=new_checkout
		WHERE bid=bookingnumber;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `roomTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `roomTypes`()
BEGIN

SELECT * FROM hotel_rooms AS hr
		JOIN room_types AS t ON t.type_id=hr.room_id
				ORDER BY hotel_id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-09 19:58:41
