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

-- ALTER TABLE `Download`
-- ADD COLUMN `ip` VARCHAR(15) AFTER path;

-- ALTER TABLE `Download`
-- ADD FOREIGN KEY (`ip`) REFERENCES `Location`(`ip`)
-- ON UPDATE CASCADE ON DELETE CASCADE;



-- --------------------------------------------------------

--
-- Script to create Asset table by Product table
--

DROP TABLE IF EXISTS Asset;
CREATE TABLE IF NOT EXISTS Asset (
        SELECT p.Dataset Dataset,
        p.SceneId SceneId,
        CONCAT('[',
                GROUP_CONCAT(CONCAT('{"band": "', p.band, '", "href": "', p.filename,'"}')),
        ']') Assets
        FROM Product p
        GROUP BY p.SceneId, p.Dataset
        ORDER BY p.Dataset, p.SceneId
);
ALTER TABLE Asset ADD PRIMARY KEY (Dataset, SceneId);
ALTER TABLE Asset ADD CONSTRAINT constraint_fk_dataset
        FOREIGN KEY (Dataset) REFERENCES Dataset (name);