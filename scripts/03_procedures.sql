--
-- Database: `catalogo`
--
USE `catalogo`;


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
        CALL logging_info('stac_collection table has been updated successfuly!');

        -- 'Updates stac_item table'
        DROP TABLE IF EXISTS stac_item;
        CREATE TABLE IF NOT EXISTS stac_item (SELECT * FROM _stac_item);
        CALL logging_info('stac_item table has been updated successfuly!');


        -- ALTER TABLE stac_item
        -- ADD CONSTRAINT stac_item_constraint_pk_id PRIMARY KEY (id, collection);

        -- -- CREATE UNIQUE INDEX index_stac_item_id
        -- -- ON stac_item (id);

        -- CREATE INDEX stac_item_index_collection
        -- ON stac_item (collection);

        -- CREATE INDEX stac_item_index_date
        -- ON stac_item (date);
END |
DELIMITER ;
