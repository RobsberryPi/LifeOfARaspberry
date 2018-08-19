-- MySQL dump 10.16  Distrib 10.1.23-MariaDB, for debian-linux-gnueabihf (armv7l)
--
-- Host: localhost    Database: RaspberryFields
-- ------------------------------------------------------
-- Server version	10.1.23-MariaDB-9+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `PIData`
--

DROP TABLE IF EXISTS `PIData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PIData` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `CreateTimeUTC` datetime DEFAULT NULL,
  `CreateTime` datetime NOT NULL,
  `TimeZone` varchar(5) DEFAULT NULL,
  `SystemTemp` float(7,3) DEFAULT NULL,
  `SenseTemp` float(7,3) DEFAULT NULL,
  `SenseTempHumidity` float(7,3) DEFAULT NULL,
  `SenseTempPressure` float(7,3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `RoomTemp`
--

DROP TABLE IF EXISTS `RoomTemp`;
/*!50001 DROP VIEW IF EXISTS `RoomTemp`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `RoomTemp` (
  `id` tinyint NOT NULL,
  `CreateTimeUTC` tinyint NOT NULL,
  `SystemTemp` tinyint NOT NULL,
  `SenseTemp` tinyint NOT NULL,
  `CalculatedTemp` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `TodaysForecast`
--

DROP TABLE IF EXISTS `TodaysForecast`;
/*!50001 DROP VIEW IF EXISTS `TodaysForecast`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `TodaysForecast` (
  `ForecastTime` tinyint NOT NULL,
  `WeatherType` tinyint NOT NULL,
  `ForecastValue` tinyint NOT NULL,
  `Units` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `UVIndexRef`
--

DROP TABLE IF EXISTS `UVIndexRef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UVIndexRef` (
  `Code` varchar(3) NOT NULL,
  `Description` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `VisibilityRef`
--

DROP TABLE IF EXISTS `VisibilityRef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VisibilityRef` (
  `Code` varchar(3) NOT NULL,
  `Description` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WeatherDataTypeRef`
--

DROP TABLE IF EXISTS `WeatherDataTypeRef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WeatherDataTypeRef` (
  `ReferenceId` int(20) NOT NULL AUTO_INCREMENT,
  `WeatherType` varchar(50) DEFAULT NULL,
  `Units` varchar(10) DEFAULT NULL,
  `Abreviation` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ReferenceId`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WeatherForecast`
--

DROP TABLE IF EXISTS `WeatherForecast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WeatherForecast` (
  `ForecastKey` int(100) NOT NULL AUTO_INCREMENT,
  `ForecastTime` datetime DEFAULT NULL,
  `ForecastCode` varchar(5) DEFAULT NULL,
  `ForecastValue` varchar(10) DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ForecastKey`)
) ENGINE=InnoDB AUTO_INCREMENT=1951 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WeatherTypeRef`
--

DROP TABLE IF EXISTS `WeatherTypeRef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WeatherTypeRef` (
  `Code` varchar(3) NOT NULL,
  `Description` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `RoomTemp`
--

/*!50001 DROP TABLE IF EXISTS `RoomTemp`*/;
/*!50001 DROP VIEW IF EXISTS `RoomTemp`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`pi`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `RoomTemp` AS select `PIData`.`id` AS `id`,`PIData`.`CreateTimeUTC` AS `CreateTimeUTC`,`PIData`.`SystemTemp` AS `SystemTemp`,`PIData`.`SenseTemp` AS `SenseTemp`,round((`PIData`.`SenseTemp` - ((`PIData`.`SystemTemp` - `PIData`.`SenseTemp`) / 2.329)),3) AS `CalculatedTemp` from `PIData` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TodaysForecast`
--

/*!50001 DROP TABLE IF EXISTS `TodaysForecast`*/;
/*!50001 DROP VIEW IF EXISTS `TodaysForecast`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`pi`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TodaysForecast` AS select `W`.`ForecastTime` AS `ForecastTime`,`WRef`.`WeatherType` AS `WeatherType`,(case `W`.`ForecastCode` when 'W' then `WTypeRef`.`Description` when 'V' then `VisRef`.`Description` when 'U' then concat(`W`.`ForecastValue`,' - ',`UVRef`.`Description`) else `W`.`ForecastValue` end) AS `ForecastValue`,`WRef`.`Units` AS `Units` from ((((`WeatherForecast` `W` left join `WeatherDataTypeRef` `WRef` on((`WRef`.`Abreviation` = `W`.`ForecastCode`))) left join `WeatherTypeRef` `WTypeRef` on(((`WTypeRef`.`Code` = `W`.`ForecastValue`) and (`W`.`ForecastCode` = 'W')))) left join `VisibilityRef` `VisRef` on(((`VisRef`.`Code` = `W`.`ForecastValue`) and (`W`.`ForecastCode` = 'V')))) left join `UVIndexRef` `UVRef` on(((`UVRef`.`Code` = `W`.`ForecastValue`) and (`W`.`ForecastCode` = 'U')))) where (`W`.`ForecastTime` between (sysdate() + interval -(3) hour) and ((cast(sysdate() as date) + interval 1 day) + interval -(1) second)) order by `W`.`ForecastTime`,`WRef`.`WeatherType` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-19 10:20:10
