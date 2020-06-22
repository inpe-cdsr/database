--
-- Database: `catalogo`
--
USE `catalogo`;


-- --------------------------------------------------------

--
-- CREATE TABLE statements
--

CREATE TABLE `Location` (
  `ip` VARCHAR(15) NOT NULL PRIMARY KEY,
  `longitude` FLOAT DEFAULT NULL,
  `latitude` FLOAT DEFAULT NULL,
  `city` VARCHAR(254) DEFAULT NULL,
  `district` VARCHAR(254) DEFAULT NULL,
  `region` VARCHAR(254) DEFAULT NULL,
  `region_code` VARCHAR(2) DEFAULT NULL,
  `country` VARCHAR(254) DEFAULT NULL,
  `country_code` VARCHAR(2) DEFAULT NULL,
  `continent` VARCHAR(254) DEFAULT NULL,
  `continent_code` VARCHAR(2) DEFAULT NULL,
  `zip_code` VARCHAR(254) DEFAULT NULL,
  `time_zone` VARCHAR(254) DEFAULT NULL,
  `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- rename `Download`.`ip` to `Download`.`ip_old`

ALTER TABLE `Download`
ADD COLUMN `ip` VARCHAR(15) AFTER ip_old;

-- WAIT SOME MINUTES and restart the catalog-dash container and create a backup

-- delete almost all rows from `Download`

-- WAIT SOME MINUTES and restart the catalog-dash container and create a backup

-- remove `Download`.`ip_old`

-- WAIT SOME MINUTES and restart the catalog-dash container and create a backup

ALTER TABLE `Download`
ADD FOREIGN KEY (`ip`) REFERENCES `Location`(`ip`)
ON UPDATE CASCADE ON DELETE CASCADE;

-- WAIT SOME MINUTES and restart the catalog-dash container and create a backup






-- add constraint NOT NULL to `Download`.`ip`
