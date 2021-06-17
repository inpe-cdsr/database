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
DELIMITER;


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
DELIMITER;


-- --------------------------------------------------
-- `remove_old_rows_from_security` procedure
-- --------------------------------------------------

DROP PROCEDURE IF EXISTS remove_old_rows_from_security;

DELIMITER |
CREATE PROCEDURE IF NOT EXISTS remove_old_rows_from_security ()
BEGIN
        -- 86400 seconds is one day (24 hours)
        -- remove all rows that are one day old
        DELETE FROM security
        WHERE TIME_TO_SEC(TIMEDIFF(CURRENT_TIMESTAMP, timestamp)) >= 86400;
END |
DELIMITER ;


-- --------------------------------------------------
-- `remove_trash_from_download` procedure
-- development use, not production use
-- --------------------------------------------------

DROP PROCEDURE IF EXISTS remove_trash_from_download;

DELIMITER |
CREATE PROCEDURE IF NOT EXISTS remove_trash_from_download ()
BEGIN
        -- remove bad values from Download table
        DELETE FROM Download
        WHERE sceneId IS NULL OR CHAR_LENGTH(sceneId) <= 8;
END |
DELIMITER ;


--------------------------------------------------
-- update Dataset table records
--------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS `update_collection_fields` $$
CREATE PROCEDURE update_collection_fields(collection_name TEXT)
BEGIN
    -- this script looks for the min/max values of a collection
    -- and update its record with them

    UPDATE Dataset d
        INNER JOIN (
            SELECT collection,
                MIN(datetime) start_date,
                MAX(datetime) end_date,
                MIN(bl_longitude) min_x,
                MIN(bl_latitude) min_y,
                MAX(tr_longitude) max_x,
                MAX(tr_latitude) max_y
            FROM stac_item
            WHERE collection = collection_name
            GROUP BY collection
        ) si ON d.Name = si.collection
        SET d.start_date = si.start_date,
            d.end_date = si.end_date,
            d.min_y = si.min_y,
            d.min_x = si.min_x,
            d.max_y = si.max_y,
            d.max_x = si.max_x
        WHERE Name = collection_name;
END $$
DELIMITER ;

-- example
-- CALL update_collection_fields('CBERS4A_MUX_L2_DN');
-- CALL update_collection_fields('CBERS4A_MUX_L4_DN');
-- CALL update_collection_fields('CBERS4A_WFI_L2_DN');
-- CALL update_collection_fields('CBERS4A_WFI_L4_DN');
-- CALL update_collection_fields('CBERS4A_WPM_L2B_DN');
-- CALL update_collection_fields('CBERS4A_WPM_L2_DN');
-- CALL update_collection_fields('CBERS4A_WPM_L4_DN');


DELIMITER $$
DROP PROCEDURE IF EXISTS `update_dataset_records` $$
CREATE PROCEDURE update_dataset_records()
BEGIN
    -- this procedure updates each row of Dataset table
    -- based on the available items

    DECLARE size_dataset INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE collection_name VARCHAR(20);

    SELECT COUNT(*) FROM Dataset INTO size_dataset;

    -- iterate over Dataset rows and call procedure to each collection
    SET i=0;
    WHILE i<size_dataset DO
        -- get collection name on the position 'i'
        SELECT Name FROM Dataset ORDER BY Name LIMIT i,1 INTO collection_name;
        -- call procedure passing the collection name
        CALL update_collection_fields(collection_name);
        SET i=i+1;
    END WHILE;
END $$
DELIMITER ;

-- example
-- CALL update_dataset_records();
