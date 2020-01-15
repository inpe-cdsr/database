-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: dgi_catalog_db
-- Generation Time: Jan 15, 2020 at 03:05 PM
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
-- Database: `cadastro`
--
CREATE DATABASE IF NOT EXISTS `cadastro` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `cadastro`;

-- --------------------------------------------------------

--
-- Table structure for table `Access`
--

CREATE TABLE `Access` (
  `accessId` int(11) NOT NULL,
  `userId` varchar(254) NOT NULL,
  `timestamp` datetime NOT NULL,
  `ip` varchar(20) NOT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Action`
--

CREATE TABLE `Action` (
  `uuid` varchar(32) NOT NULL,
  `userId` varchar(254) NOT NULL,
  `action` varchar(99) NOT NULL,
  `params` varchar(999) NOT NULL,
  `datetime` datetime NOT NULL,
  `expiration` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
-- Table structure for table `Download`
--

CREATE TABLE `Download` (
  `id` int(11) NOT NULL,
  `userId` varchar(200) DEFAULT NULL,
  `sceneId` varchar(200) DEFAULT NULL,
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
-- Table structure for table `ipToCountry`
--

CREATE TABLE `ipToCountry` (
  `IP_FROM` double NOT NULL,
  `IP_TO` double NOT NULL,
  `COUNTRY_CODE2` char(2) NOT NULL,
  `COUNTRY_CODE3` char(3) NOT NULL,
  `COUNTRY_NAME` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `migrate_version`
--

CREATE TABLE `migrate_version` (
  `repository_id` varchar(250) NOT NULL,
  `repository_path` text DEFAULT NULL,
  `version` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
-- Indexes for table `Access`
--
ALTER TABLE `Access`
  ADD PRIMARY KEY (`accessId`),
  ADD KEY `Access_idx1` (`userId`,`timestamp`);

--
-- Indexes for table `Action`
--
ALTER TABLE `Action`
  ADD PRIMARY KEY (`uuid`);

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
-- Indexes for table `Download`
--
ALTER TABLE `Download`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ipToCountry`
--
ALTER TABLE `ipToCountry`
  ADD PRIMARY KEY (`IP_FROM`);

--
-- Indexes for table `migrate_version`
--
ALTER TABLE `migrate_version`
  ADD PRIMARY KEY (`repository_id`);

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
-- AUTO_INCREMENT for table `Access`
--
ALTER TABLE `Access`
  MODIFY `accessId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Address`
--
ALTER TABLE `Address`
  MODIFY `addressId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Download`
--
ALTER TABLE `Download`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
