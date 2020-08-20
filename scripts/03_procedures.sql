--
-- Database: `catalog`
--
USE `catalog`;


-- --------------------------------------------------------

--
-- Procedures
--

-- --------------------------------------------------
-- `logging_info` procedure
-- --------------------------------------------------

DROP PROCEDURE IF EXISTS logging_info;

DELIMITER |
CREATE PROCEDURE IF NOT EXISTS logging_info (_text TEXT)
BEGIN
        SELECT _text as '** INFO: ';
END |
DELIMITER ;


-- --------------------------------------------------
-- `update_stac_tables` procedure
-- --------------------------------------------------

DROP PROCEDURE IF EXISTS update_stac_tables;

DELIMITER |
CREATE PROCEDURE IF NOT EXISTS update_stac_tables ()
BEGIN
        -- 'Updates stac_collection table'
        DROP TABLE IF EXISTS stac_collection;
        CREATE TABLE IF NOT EXISTS stac_collection (SELECT * FROM _stac_collection);
        ALTER TABLE stac_collection ADD PRIMARY KEY (id);

        -- 'Updates stac_item table'
        DROP TABLE IF EXISTS stac_item;
        CREATE TABLE IF NOT EXISTS stac_item (SELECT * FROM _stac_item);
        -- ALTER TABLE stac_item ADD PRIMARY KEY (id, collection);
        CREATE INDEX stac_item_index_collection
                ON stac_item (collection);

        CALL logging_info('stac tables have been updated successfuly!');
END |
DELIMITER ;
