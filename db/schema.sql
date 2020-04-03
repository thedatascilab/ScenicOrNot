-- MySQL dump 10.11
--
-- Host: localhost    Database: scenic
-- ------------------------------------------------------
-- Server version	5.0.51a-24+lenny5-log

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
-- Table structure for table `place`
--

-- DROP TABLE IF EXISTS `place`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `place` (
  `id` int(11) NOT NULL auto_increment,
  `image_uri` varchar(1024) default NULL,
  `geograph_uri` varchar(1024) default NULL,
  `type` enum('representative','supplemental') NOT NULL default 'representative',
  `title` text NOT NULL,
  `description` text NOT NULL,
  `subject` varchar(255) NOT NULL,
  `creator` varchar(128) NOT NULL,
  `creator_uri` varchar(1024) default NULL,
  `date_submitted` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `lat` float NOT NULL,
  `lon` float NOT NULL,
  `gridsquare` varchar(8) NOT NULL,
  `license_uri` varchar(1024) default NULL,
  `format` varchar(32) NOT NULL,
  `votes` int(11) NOT NULL,
  `rand` float default NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `aspect` float NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `votes` (`votes`),
  KEY `gridsquare` (`gridsquare`),
  KEY `rand` (`rand`),
  KEY `geograph_uri` (`geograph_uri`(333)),
  KEY `votes_rand_idx` (`votes`,`rand`)
) ENGINE=MyISAM AUTO_INCREMENT=217675 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `token`
--

-- DROP TABLE IF EXISTS `token`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `token` (
  `token` int(11) NOT NULL default '0',
  PRIMARY KEY  (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vote`
--

-- DROP TABLE IF EXISTS `vote`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `vote` (
  `id` int(11) NOT NULL auto_increment,
  `place` int(11) NOT NULL,
  `uuid` varchar(64) NOT NULL,
  `rating` int(11) default NULL,
  `token` int(11) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `date_submitted` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `place` (`place`),
  KEY `token` (`token`),
  KEY `uuid_idx` (`uuid`)
) ENGINE=MyISAM AUTO_INCREMENT=1392496 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-03-14 18:18:40
