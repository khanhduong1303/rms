-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: rms_development
-- ------------------------------------------------------
-- Server version	5.5.37-0ubuntu0.13.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `condos`
--

DROP TABLE IF EXISTS `condos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `property_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `developer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tenure` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `top_year` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `num_of_units` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condos`
--

LOCK TABLES `condos` WRITE;
/*!40000 ALTER TABLE `condos` DISABLE KEYS */;
INSERT INTO `condos` VALUES (1,'Phu My Hung',NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-01 10:18:46','2014-07-01 10:18:46'),(2,'Phu My Hung II',NULL,NULL,NULL,NULL,NULL,NULL,'2014-07-01 10:19:44','2014-07-03 12:02:19');
/*!40000 ALTER TABLE `condos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20140701015334'),('20140701015631'),('20140701100206'),('20140701101435'),('20140702010313');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enquiry` text COLLATE utf8_unicode_ci,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `condo_id` int(11) DEFAULT NULL,
  `avatar_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar_file_size` int(11) DEFAULT NULL,
  `avatar_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@rms.net','$2a$10$SgZT9ygnnUfJvCXGJfI7Me4yWcPsVoljVPOCi9LJIRyhi3mF6B2IG',NULL,NULL,NULL,10,'2014-07-03 11:55:06','2014-07-03 11:43:12','127.0.0.1','127.0.0.1','2014-07-01 02:38:09','2014-07-03 12:00:50','admin','admin','0939456789','Innoria inc','12345','simple test','Viet Nam','Can Tho',NULL,'avatar-thu-nghiem-bien-hinh.jpg','image/jpeg',110347,'2014-07-03 09:49:27'),(2,'shin@rms.net','$2a$10$bNwBhd.jJ.dC/gCzS5D9W.OQIzchpytf3nlLyJj6ML00bJJYpBiym',NULL,NULL,NULL,18,'2014-07-03 11:53:06','2014-07-03 08:02:35','127.0.0.1','127.0.0.1','2014-07-01 03:30:57','2014-07-03 11:54:39','shin','Mai Phan Nhat Binh','01239441421','Ctu','12345','This is simple test','Viet Nam','Can Tho',NULL,'Shin-cau-be-but-chi-tap-2.jpg','image/jpeg',53306,'2014-07-02 01:31:54'),(4,'hung@rms.net','$2a$10$XoXeb3C4cfbIHuN8MU4o7O6BzsxOG8s3EJZeXo36PUHR5CPxxRBw.',NULL,NULL,NULL,1,'2014-07-01 10:49:20','2014-07-01 10:49:20','127.0.0.1','127.0.0.1','2014-07-01 10:49:20','2014-07-01 10:49:20','hungnt',NULL,'012345678',NULL,'12345','this is simple test',NULL,NULL,1,NULL,NULL,NULL,NULL),(6,'tuyet@rms.net','$2a$10$iPGliylcqmEhThdHhNd/z.qquSXtsOVenjjWFJjNDKSD4zL.gMUlW',NULL,NULL,NULL,1,'2014-07-02 03:31:06','2014-07-02 03:31:06','127.0.0.1','127.0.0.1','2014-07-02 03:31:06','2014-07-02 03:31:06','tuyet',NULL,'0123456789',NULL,'12345','this is simple test',NULL,NULL,2,NULL,NULL,NULL,NULL),(12,'khanh@rms.net','$2a$10$9tN/hE8uPJS5vF73Akme9eQIqSatG9M0azYSX7H0rzIba7ZRs6K5q',NULL,NULL,NULL,2,'2014-07-03 01:34:27','2014-07-02 11:05:36','127.0.0.1','127.0.0.1','2014-07-02 11:05:36','2014-07-03 01:34:27','khanh',NULL,'012345678',NULL,'12345','this is simple test',NULL,NULL,1,NULL,NULL,NULL,NULL),(13,'thaihung@gmail.com','$2a$10$pzSoyeHRwyXiopLFAQH4jOVfec8GvA72bsCgRZFXxQnWAKcL8pWhC',NULL,NULL,NULL,5,'2014-07-03 14:12:55','2014-07-03 14:01:11','127.0.0.1','127.0.0.1','2014-07-03 11:45:14','2014-07-03 14:44:09','nthung','Hung Nguyen','012345678','Innoria','hdjksa','jdsh','Vietnam','Vietnam',1,'cool_blue_water.jpg','image/jpeg',252537,'2014-07-03 14:44:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-04  8:19:50
