-- --------------------------------------------------------
-- Host:                         185.80.130.117
-- Server version:               8.0.27 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for smd_cal
CREATE DATABASE IF NOT EXISTS `smdcal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `smdcal`;

-- Dumping structure for table smd_cal.bureliai
CREATE TABLE IF NOT EXISTS `bureliai` (
  `id` int NOT NULL AUTO_INCREMENT,
  `burelis` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `burelis` (`burelis`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table smd_cal.bureliai: ~23 rows (approximately)
DELETE FROM `bureliai`;
/*!40000 ALTER TABLE `bureliai` DISABLE KEYS */;
INSERT INTO `bureliai` (`id`, `burelis`) VALUES
	(10, 'Abdominalinės chirurgijos būrelis'),
	(16, 'Akių ligų būrelis'),
	(17, 'Anesteziologijos būrelis'),
	(3, 'Ausų, nosies ir gerklės ligų būrelis'),
	(23, 'Chirurgijos pagrindų mokykla'),
	(13, 'Endokrinologijos būrelis'),
	(18, 'Hematologijos, onkologijos ir transfuziologijos būrelis'),
	(6, 'Imunologijos ir alergologijos būrelis'),
	(5, 'Kardiologijos būrelis'),
	(7, 'Kineziterapijos būrelis'),
	(1, 'Klinikinės farmakologijos būrelis'),
	(9, 'Kraujagyslių chirurgijos būrelis'),
	(8, 'Maisto mokslo būrelis'),
	(11, 'Odos ir venerinių ligų būrelis'),
	(12, 'Ortopedijos – traumatologijos būrelis'),
	(4, 'Plastinės ir rekonstrukcinės chirurgijos būrelis'),
	(15, 'Psichiatrijos būrelis'),
	(2, 'Reabilitacijos būrelis'),
	(19, 'Širdies - krūtinės chirurgijos būrelis'),
	(14, 'Sveikatos psichologijos būrelis'),
	(20, 'Urologijos būrelis'),
	(21, 'Veido ir žandikaulių chirurgijos būrelis'),
	(22, 'Veterinarinės medicinos būrelis');
/*!40000 ALTER TABLE `bureliai` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;