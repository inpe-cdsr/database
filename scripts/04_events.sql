--
-- Database: `catalog`
--
USE `catalog`;


-- --------------------------------------------------------

--
-- Events
--

-- --------------------------------------------------
-- `e_update_stac_tables` event
-- --------------------------------------------------

DROP EVENT IF EXISTS e_update_stac_tables;

DELIMITER |
CREATE EVENT IF NOT EXISTS e_update_stac_tables
        ON SCHEDULE EVERY 1 DAY
                STARTS '2020-07-24 00:00:00'

COMMENT 'Updates the stac_collection and stac_item tables'
DO
BEGIN
        CALL update_stac_tables();
END |
DELIMITER ;
