-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: dgi_catalog_db
-- Generation Time: Jan 13, 2020 at 12:00 PM
-- Server version: 10.4.11-MariaDB-1:10.4.11+maria~bionic
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `catalogo`
--

-- --------------------------------------------------------

--
-- Table structure for table `Address`
--

CREATE TABLE `Address` (
  `addressId` int(11) NOT NULL,
  `userId` varchar(254) NOT NULL,
  `addressType` char(1) NOT NULL,
  `CNPJ_CPF` varchar(15) NOT NULL,
  `compCNPJ` varchar(8) DEFAULT NULL,
  `digitCNPJ` char(2) DEFAULT NULL,
  `cep` varchar(8) NOT NULL,
  `street` varchar(64) DEFAULT NULL,
  `number` varchar(9) DEFAULT NULL,
  `complement` varchar(60) DEFAULT NULL,
  `district` varchar(32) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `delivery` int(11) DEFAULT NULL,
  `payment` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Company`
--

CREATE TABLE `Company` (
  `CNPJ` varchar(15) NOT NULL,
  `name` varchar(60) NOT NULL,
  `IE` varchar(25) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `payment` varchar(20) NOT NULL,
  `status` char(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Dataset`
--

CREATE TABLE `Dataset` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Description` varchar(512) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Download`
--

CREATE TABLE `Download` (
  `id` int(11) NOT NULL,
  `userId` varchar(200) DEFAULT NULL,
  `sceneId` varchar(200) DEFAULT NULL,
  `Dataset` varchar(64) DEFAULT NULL,
  `path` varchar(500) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `region` varchar(150) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `country` varchar(150) DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `Id` int(11) NOT NULL,
  `Dataset` varchar(50) NOT NULL,
  `Type` varchar(20) NOT NULL,
  `ProcessingDate` datetime DEFAULT NULL,
  `GeometricProcessing` varchar(20) DEFAULT NULL,
  `RadiometricProcessing` varchar(20) DEFAULT NULL,
  `SceneId` varchar(64) DEFAULT NULL,
  `Band` varchar(20) DEFAULT NULL,
  `Resolution` float NOT NULL,
  `Filename` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Qlook`
--

CREATE TABLE `Qlook` (
  `SceneId` varchar(64) NOT NULL DEFAULT '',
  `QLfilename` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Scene`
--

CREATE TABLE `Scene` (
  `SceneId` varchar(64) NOT NULL DEFAULT '',
  `Satellite` varchar(50) DEFAULT NULL,
  `Sensor` varchar(6) NOT NULL,
  `Path` varchar(11) DEFAULT NULL,
  `Row` varchar(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `CenterLatitude` float DEFAULT NULL,
  `CenterLongitude` float DEFAULT NULL,
  `TL_Latitude` float DEFAULT NULL,
  `TL_Longitude` float DEFAULT NULL,
  `BR_Latitude` float DEFAULT NULL,
  `BR_Longitude` float DEFAULT NULL,
  `TR_Latitude` float DEFAULT NULL,
  `TR_Longitude` float DEFAULT NULL,
  `BL_Latitude` float DEFAULT NULL,
  `BL_Longitude` float DEFAULT NULL,
  `CenterTime` double DEFAULT NULL,
  `StartTime` double DEFAULT NULL,
  `StopTime` double DEFAULT NULL,
  `CloudCoverQ1` int(11) DEFAULT NULL,
  `CloudCoverQ2` int(11) DEFAULT NULL,
  `CloudCoverQ3` int(11) DEFAULT NULL,
  `CloudCoverQ4` int(11) DEFAULT NULL,
  `CloudCoverMethod` char(1) DEFAULT NULL,
  `IngestDate` datetime DEFAULT NULL,
  `Deleted` smallint(6) NOT NULL,
  `Dataset` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SceneDataset`
--

CREATE TABLE `SceneDataset` (
  `SceneId` varchar(64) NOT NULL,
  `Dataset` varchar(64) NOT NULL,
  `C_Longitude` float NOT NULL,
  `C_Latitude` float NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `userId` varchar(254) NOT NULL,
  `addressId` int(11) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `fullname` varchar(64) NOT NULL,
  `CNPJ_CPF` varchar(15) NOT NULL,
  `compCNPJ` varchar(8) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `areaCode` varchar(4) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `company` varchar(64) DEFAULT NULL,
  `companyType` varchar(32) DEFAULT NULL,
  `activity` varchar(32) DEFAULT NULL,
  `userType` char(1) NOT NULL,
  `userStatus` char(1) NOT NULL,
  `registerDate` date NOT NULL,
  `unblockDate` datetime DEFAULT NULL,
  `marlin` int(11) NOT NULL,
  `language` varchar(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Address`
--
ALTER TABLE `Address`
  ADD PRIMARY KEY (`addressId`),
  ADD KEY `Address_idx1` (`CNPJ_CPF`);

--
-- Indexes for table `Company`
--
ALTER TABLE `Company`
  ADD PRIMARY KEY (`CNPJ`),
  ADD KEY `Company_idx1` (`name`),
  ADD KEY `Company_idx2` (`status`);

--
-- Indexes for table `Dataset`
--
ALTER TABLE `Dataset`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `Download`
--
ALTER TABLE `Download`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Product_idx4` (`GeometricProcessing`),
  ADD KEY `Product_idx3` (`Type`),
  ADD KEY `Product_idx1` (`SceneId`),
  ADD KEY `Product_idx6` (`Band`),
  ADD KEY `Product_idx5` (`RadiometricProcessing`),
  ADD KEY `Product_idx2` (`Dataset`),
  ADD KEY `Product_idx7` (`ProcessingDate`);

--
-- Indexes for table `Qlook`
--
ALTER TABLE `Qlook`
  ADD PRIMARY KEY (`SceneId`),
  ADD UNIQUE KEY `Filename` (`QLfilename`),
  ADD KEY `Product_idx1` (`SceneId`);

--
-- Indexes for table `Scene`
--
ALTER TABLE `Scene`
  ADD PRIMARY KEY (`SceneId`),
  ADD KEY `Scene_idx4` (`Row`),
  ADD KEY `Scene_idx2` (`Date`),
  ADD KEY `Scene_idx3` (`Path`),
  ADD KEY `Scene_idx1` (`Satellite`,`Sensor`),
  ADD KEY `Scene_idx5` (`Sensor`),
  ADD KEY `Scene_idx6` (`CloudCoverQ1`,`CloudCoverQ2`,`CloudCoverQ3`,`CloudCoverQ4`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`userId`),
  ADD KEY `User_idx1` (`addressId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Address`
--
ALTER TABLE `Address`
  MODIFY `addressId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Dataset`
--
ALTER TABLE `Dataset`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Download`
--
ALTER TABLE `Download`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
