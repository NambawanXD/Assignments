-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 02, 2025 at 05:49 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seniorconnect`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `Admin_ID` int NOT NULL AUTO_INCREMENT,
  `IC_Number` varchar(20) NOT NULL,
  PRIMARY KEY (`Admin_ID`),
  KEY `IC_Number` (`IC_Number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

DROP TABLE IF EXISTS `contact_us`;
CREATE TABLE IF NOT EXISTS `contact_us` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(255) NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  `Feedback` text NOT NULL,
  `IC_Number` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contact_us`
--

INSERT INTO `contact_us` (`id`, `Email`, `Phone_Number`, `Feedback`, `IC_Number`, `created_at`) VALUES
(1, 'hemanth0303@gmail.com', '0175245372', 'waddadawd', '041342571562', '2025-02-02 17:42:10'),
(2, 'anusha@mail.com', '142424242', 'wdwdawdaw', '070503171657', '2025-02-02 17:46:02');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `Feedback_ID` int NOT NULL AUTO_INCREMENT,
  `IC_Number` varchar(20) NOT NULL,
  `Comments` text NOT NULL,
  `Rating` int DEFAULT NULL,
  `Created_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Feedback_ID`),
  KEY `IC_Number` (`IC_Number`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `senior`
--

DROP TABLE IF EXISTS `senior`;
CREATE TABLE IF NOT EXISTS `senior` (
  `Senior_ID` int NOT NULL AUTO_INCREMENT,
  `IC_Number` varchar(20) NOT NULL,
  `User_ID` int NOT NULL,
  PRIMARY KEY (`Senior_ID`),
  UNIQUE KEY `IC_Number` (`IC_Number`),
  KEY `User_ID` (`User_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `senior`
--

INSERT INTO `senior` (`Senior_ID`, `IC_Number`, `User_ID`) VALUES
(1, '041342571562', 0);

-- --------------------------------------------------------

--
-- Table structure for table `senior_req`
--

DROP TABLE IF EXISTS `senior_req`;
CREATE TABLE IF NOT EXISTS `senior_req` (
  `Request_ID` int NOT NULL AUTO_INCREMENT,
  `Assistance` varchar(255) NOT NULL,
  `Location` varchar(255) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Priority` enum('Low','Medium','High') NOT NULL,
  `Senior_ID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Status` enum('Pending','In Progress','Completed') DEFAULT 'Pending',
  PRIMARY KEY (`Request_ID`),
  KEY `Senior_ID` (`Senior_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Request_ID` int NOT NULL,
  `Status` enum('Pending','In Progress','Completed') NOT NULL DEFAULT 'Pending',
  `Updated_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Assistance` varchar(255) NOT NULL,
  `Location` varchar(255) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Volunteer_Name` varchar(100) NOT NULL,
  `Senior_Name` varchar(100) NOT NULL,
  `Volunteer_ID` int NOT NULL,
  `Senior_ID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Request_ID` (`Request_ID`),
  KEY `Volunteer_ID` (`Volunteer_ID`),
  KEY `Senior_ID` (`Senior_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`ID`, `Request_ID`, `Status`, `Updated_At`, `Assistance`, `Location`, `Date`, `Time`, `Volunteer_Name`, `Senior_Name`, `Volunteer_ID`, `Senior_ID`) VALUES
(1, 0, 'Completed', '2025-02-02 17:47:38', 'Anusha is disturbing me ', 'Pls send help', '2025-02-03', '01:38:00', 'Anusha Devy', 'Hemamth awdwad', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IC_Number` varchar(20) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  `Phone_Number` varchar(20) NOT NULL,
  `Role` enum('Senior','Volunteer','Admin') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IC_Number` (`IC_Number`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID`, `IC_Number`, `Email`, `First_Name`, `Last_Name`, `Password`, `Address`, `Phone_Number`, `Role`) VALUES
(1, '041342571562', 'hemanth0303@gmail.com', 'Hemamth', 'awdwad', 'abc123', 'wedwd', '+01023782213', 'Senior'),
(2, '070503171657', 'Anusha@mail.com', 'Anusha', 'Devy', 'abc123', 'Send help', '0186727627', 'Volunteer');

-- --------------------------------------------------------

--
-- Table structure for table `volunteer`
--

DROP TABLE IF EXISTS `volunteer`;
CREATE TABLE IF NOT EXISTS `volunteer` (
  `Volunteer_ID` int NOT NULL AUTO_INCREMENT,
  `IC_Number` varchar(20) NOT NULL,
  `User_ID` int NOT NULL,
  PRIMARY KEY (`Volunteer_ID`),
  UNIQUE KEY `IC_Number` (`IC_Number`),
  KEY `User_ID` (`User_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `volunteer`
--

INSERT INTO `volunteer` (`Volunteer_ID`, `IC_Number`, `User_ID`) VALUES
(1, '070503171657', 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
