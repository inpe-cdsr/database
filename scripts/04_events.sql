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
        ON SCHEDULE
                EVERY 1 DAY
                STARTS '2020-07-24 00:00:00'

COMMENT 'Updates the stac_collection and stac_item tables'
DO
BEGIN
        CALL update_stac_tables();
END |
DELIMITER ;


-- --------------------------------------------------
-- `e_remove_old_rows_from_security
-- --------------------------------------------------

DROP EVENT IF EXISTS e_remove_old_rows_from_security;

-- Runs 3 times a day (i.e. every 8 hours, in other words, every 480 minutes)
DELIMITER |
CREATE EVENT IF NOT EXISTS e_remove_old_rows_from_security
        ON SCHEDULE
                EVERY 480 MINUTE
                STARTS '2020-10-27 00:00:00'

COMMENT 'Remove old rows (i.e. more than 24 hours) from security table'
DO
BEGIN
        CALL remove_old_rows_from_security();
END |
DELIMITER ;


-- --------------------------------------------------
-- `e_update_dataset_records
-- --------------------------------------------------

DROP EVENT IF EXISTS e_update_dataset_records;

-- Runs 1 time a day
DELIMITER |
CREATE EVENT IF NOT EXISTS e_update_dataset_records
        ON SCHEDULE
                EVERY 1 DAY
                -- starts on the next day at 00:00:00
                STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY)

COMMENT 'Update Dataset table records every day.'
DO
BEGIN
        CALL update_dataset_records();
END |
DELIMITER ;
