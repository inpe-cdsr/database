-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: inpe_cdsr_db
-- Generation Time: Jul 31, 2020 at 07:44 PM
-- Server version: 10.5.3-MariaDB-1:10.5.3+maria~focal
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
-- Database: `catalog`
--
CREATE DATABASE IF NOT EXISTS `catalog` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `catalog`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Asset`
--

CREATE TABLE `Asset` (
  `Dataset` varchar(50) NOT NULL,
  `SceneId` varchar(64) NOT NULL,
  `Assets` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `dash_amount_scenes_by_dataset_year_month_lon_lat`
-- (See below for the actual view)
--
CREATE TABLE `dash_amount_scenes_by_dataset_year_month_lon_lat` (
`amount` bigint(21)
,`dataset` varchar(64)
,`_year_month` varchar(7)
,`longitude` float
,`latitude` float
);

-- --------------------------------------------------------

--
-- Table structure for table `Dataset`
--

CREATE TABLE `Dataset` (
  `Name` varchar(50) NOT NULL,
  `Description` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Download`
--

CREATE TABLE `Download` (
  `id` int(11) NOT NULL,
  `userId` varchar(200) DEFAULT NULL,
  `sceneId` varchar(200) DEFAULT NULL,
  `path` varchar(500) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Location`
--

CREATE TABLE `Location` (
  `ip` varchar(15) NOT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `city` varchar(254) DEFAULT NULL,
  `district` varchar(254) DEFAULT NULL,
  `region` varchar(254) DEFAULT NULL,
  `region_code` varchar(2) DEFAULT NULL,
  `country` varchar(254) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `continent` varchar(254) DEFAULT NULL,
  `continent_code` varchar(2) DEFAULT NULL,
  `zip_code` varchar(254) DEFAULT NULL,
  `time_zone` varchar(254) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `Dataset` varchar(50) NOT NULL,
  `ProcessingDate` datetime DEFAULT NULL,
  `SceneId` varchar(64) NOT NULL,
  `Band` varchar(20) NOT NULL,
  `Resolution` float NOT NULL,
  `Filename` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Scene`
--

CREATE TABLE `Scene` (
  `SceneId` varchar(64) NOT NULL DEFAULT '',
  `Satellite` varchar(50) NOT NULL,
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
  `CenterTime` datetime DEFAULT NULL,
  `StartTime` datetime DEFAULT NULL,
  `StopTime` datetime DEFAULT NULL,
  `CloudCover` float DEFAULT NULL,
  `CloudCoverMethod` char(4) DEFAULT NULL,
  `SyncLoss` float DEFAULT NULL,
  `IngestDate` datetime DEFAULT NULL,
  `Deleted` smallint(6) NOT NULL,
  `ControladoCQ` char(1) DEFAULT 'N',
  `OperatorId` varchar(20) DEFAULT NULL,
  `ControladoEm` datetime DEFAULT NULL,
  `thumbnail` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
-- Stand-in structure for view `scene_dataset`
-- (See below for the actual view)
--
CREATE TABLE `scene_dataset` (
`scene_id` varchar(64)
,`dataset` varchar(64)
,`date` date
,`longitude` float
,`latitude` float
);

-- --------------------------------------------------------

--
-- Table structure for table `stac_collection`
--

CREATE TABLE `stac_collection` (
  `id` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `min_y` float DEFAULT NULL,
  `min_x` float DEFAULT NULL,
  `max_y` float DEFAULT NULL,
  `max_x` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stac_item`
--

CREATE TABLE `stac_item` (
  `id` varchar(64) NOT NULL,
  `collection` varchar(50) NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `path` varchar(11) DEFAULT NULL,
  `row` varchar(11) DEFAULT NULL,
  `satellite` varchar(50) NOT NULL,
  `sensor` varchar(6) NOT NULL,
  `cloud_cover` float DEFAULT NULL,
  `sync_loss` float DEFAULT NULL,
  `thumbnail` varchar(256) NOT NULL,
  `assets` mediumtext DEFAULT NULL,
  `tl_longitude` float DEFAULT NULL,
  `tl_latitude` float DEFAULT NULL,
  `bl_longitude` float DEFAULT NULL,
  `bl_latitude` float DEFAULT NULL,
  `br_longitude` float DEFAULT NULL,
  `br_latitude` float DEFAULT NULL,
  `tr_longitude` float DEFAULT NULL,
  `tr_latitude` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `userId` varchar(254) NOT NULL,
  `addressId` int(11) NOT NULL,
  `password` varchar(32) NOT NULL,
  `fullname` varchar(64) NOT NULL,
  `CNPJ_CPF` varchar(15) DEFAULT NULL,
  `compCNPJ` varchar(8) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `areaCode` varchar(4) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `company` varchar(64) DEFAULT NULL,
  `companyType` varchar(32) DEFAULT NULL,
  `activity` varchar(32) DEFAULT NULL,
  `userType` char(1) DEFAULT NULL,
  `userStatus` char(1) DEFAULT NULL,
  `registerDate` date DEFAULT NULL,
  `unblockDate` datetime DEFAULT NULL,
  `siape` varchar(32) DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `_stac_collection`
-- (See below for the actual view)
--
CREATE TABLE `_stac_collection` (
`id` varchar(50)
,`description` varchar(512)
,`start_date` date
,`end_date` date
,`min_y` float
,`min_x` float
,`max_y` float
,`max_x` float
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `_stac_item`
-- (See below for the actual view)
--
CREATE TABLE `_stac_item` (
`id` varchar(64)
,`collection` varchar(50)
,`datetime` datetime
,`path` varchar(11)
,`row` varchar(11)
,`satellite` varchar(50)
,`sensor` varchar(6)
,`cloud_cover` float
,`sync_loss` float
,`thumbnail` varchar(256)
,`assets` mediumtext
,`tl_longitude` float
,`tl_latitude` float
,`bl_longitude` float
,`bl_latitude` float
,`br_longitude` float
,`br_latitude` float
,`tr_longitude` float
,`tr_latitude` float
);

-- --------------------------------------------------------

--
-- Structure for view `dash_amount_scenes_by_dataset_year_month_lon_lat`
--
DROP TABLE IF EXISTS `dash_amount_scenes_by_dataset_year_month_lon_lat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `dash_amount_scenes_by_dataset_year_month_lon_lat`  AS  select count(`SceneDataset`.`SceneId`) AS `amount`,`SceneDataset`.`Dataset` AS `dataset`,date_format(`SceneDataset`.`Date`,'%Y-%m') AS `_year_month`,`SceneDataset`.`C_Longitude` AS `longitude`,`SceneDataset`.`C_Latitude` AS `latitude` from `SceneDataset` group by `SceneDataset`.`Dataset`,date_format(`SceneDataset`.`Date`,'%Y-%m'),`SceneDataset`.`C_Longitude`,`SceneDataset`.`C_Latitude` order by date_format(`SceneDataset`.`Date`,'%Y-%m'),`SceneDataset`.`Dataset` ;

-- --------------------------------------------------------

--
-- Structure for view `scene_dataset`
--
DROP TABLE IF EXISTS `scene_dataset`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `scene_dataset`  AS  select `SceneDataset`.`SceneId` AS `scene_id`,`SceneDataset`.`Dataset` AS `dataset`,`SceneDataset`.`Date` AS `date`,`SceneDataset`.`C_Longitude` AS `longitude`,`SceneDataset`.`C_Latitude` AS `latitude` from `SceneDataset` order by `SceneDataset`.`Date`,`SceneDataset`.`Dataset` ;

-- --------------------------------------------------------

--
-- Structure for view `_stac_collection`
--
DROP TABLE IF EXISTS `_stac_collection`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `_stac_collection`  AS  select `d`.`Name` AS `id`,`d`.`Description` AS `description`,min(`s`.`Date`) AS `start_date`,max(`s`.`Date`) AS `end_date`,min(`s`.`BL_Longitude`) AS `min_y`,min(`s`.`BL_Latitude`) AS `min_x`,max(`s`.`TR_Longitude`) AS `max_y`,max(`s`.`TR_Latitude`) AS `max_x` from ((`Scene` `s` join `Asset` `a`) join `Dataset` `d`) where `s`.`SceneId` = `a`.`SceneId` and `d`.`Name` = `a`.`Dataset` group by `d`.`Name` order by `d`.`Name` ;

-- --------------------------------------------------------

--
-- Structure for view `_stac_item`
--
DROP TABLE IF EXISTS `_stac_item`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `_stac_item`  AS  select `s`.`SceneId` AS `id`,`a`.`Dataset` AS `collection`,`s`.`CenterTime` AS `datetime`,`s`.`Path` AS `path`,`s`.`Row` AS `row`,`s`.`Satellite` AS `satellite`,`s`.`Sensor` AS `sensor`,`s`.`CloudCover` AS `cloud_cover`,`s`.`SyncLoss` AS `sync_loss`,`s`.`thumbnail` AS `thumbnail`,`a`.`Assets` AS `assets`,`s`.`TL_Longitude` AS `tl_longitude`,`s`.`TL_Latitude` AS `tl_latitude`,`s`.`BL_Longitude` AS `bl_longitude`,`s`.`BL_Latitude` AS `bl_latitude`,`s`.`BR_Longitude` AS `br_longitude`,`s`.`BR_Latitude` AS `br_latitude`,`s`.`TR_Longitude` AS `tr_longitude`,`s`.`TR_Latitude` AS `tr_latitude` from (`Scene` `s` join `Asset` `a`) where `s`.`Deleted` = 0 and `s`.`SceneId` = `a`.`SceneId` order by `a`.`Dataset`,`s`.`CenterTime` desc,`s`.`Path`,`s`.`Row` ;

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
-- Indexes for table `Asset`
--
ALTER TABLE `Asset`
  ADD PRIMARY KEY (`Dataset`,`SceneId`);

--
-- Indexes for table `Dataset`
--
ALTER TABLE `Dataset`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `Download`
--
ALTER TABLE `Download`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Location`
--
ALTER TABLE `Location`
  ADD PRIMARY KEY (`ip`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`Dataset`,`SceneId`,`Band`);
ALTER TABLE `Product` ADD FULLTEXT KEY `DatasetSceneId` (`Dataset`,`SceneId`);
ALTER TABLE `Product` ADD FULLTEXT KEY `Dataset` (`Dataset`);

--
-- Indexes for table `Scene`
--
ALTER TABLE `Scene`
  ADD PRIMARY KEY (`SceneId`);

--
-- Indexes for table `SceneDataset`
--
ALTER TABLE `SceneDataset`
  ADD UNIQUE KEY `scenedataset` (`SceneId`,`Dataset`);

--
-- Indexes for table `stac_collection`
--
ALTER TABLE `stac_collection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stac_item`
--
ALTER TABLE `stac_item`
  ADD KEY `stac_item_index_collection` (`collection`);

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
-- AUTO_INCREMENT for table `Download`
--
ALTER TABLE `Download`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Asset`
--
ALTER TABLE `Asset`
  ADD CONSTRAINT `constraint_fk_dataset` FOREIGN KEY (`Dataset`) REFERENCES `Dataset` (`Name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
