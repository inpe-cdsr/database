--
-- Database: `catalogo`
--
USE `catalogo`;


-- --------------------------------------------------------

--
-- `_stac_collection` and `_stac_item` views
--

CREATE OR REPLACE VIEW `_stac_collection` AS
SELECT d.Name id,
        d.Description description,
        s.start_date,
        s.end_date,
        s.min_y,
        s.min_x,
        s.max_y,
        s.max_x
FROM Dataset d
        LEFT JOIN
        (SELECT Satellite satellite,
                Sensor sensor,
                MIN(Date) start_date,
                MAX(Date) end_date,
                MIN(BL_Longitude) min_y,
                MIN(BL_Latitude) min_x,
                MAX(TR_Longitude) max_y,
                MAX(TR_Latitude) max_x
        FROM Scene
        GROUP BY Satellite, Sensor) s
ON d.Name LIKE CONCAT(s.satellite, '%')
        AND d.Name LIKE CONCAT('%', s.sensor, '%')
ORDER BY d.Name;


CREATE OR REPLACE VIEW `_stac_item` AS
SELECT s.SceneId id,
        p.Dataset collection,
        s.Date date,
        s.CenterTime center_time,
        s.Path path,
        s.Row row,
        s.Satellite satellite,
        s.Sensor sensor,
        s.CloudCover cloud_cover,
        s.SyncLoss sync_loss,
        s.thumbnail thumbnail,
        CONCAT('[',
                GROUP_CONCAT(CONCAT('{"band": "', p.band, '", "href": "', p.filename,'"}')),
        ']') assets,
        TL_Longitude tl_longitude,
        TL_Latitude tl_latitude,
        BL_Longitude bl_longitude,
        BL_Latitude bl_latitude,
        BR_Longitude br_longitude,
        BR_Latitude br_latitude,
        TR_Longitude tr_longitude,
        TR_Latitude tr_latitude
FROM Scene s, Product p
WHERE s.Deleted = 0 AND (s.SceneId = p.SceneId)
GROUP BY s.SceneId, p.Dataset
ORDER BY p.Dataset, s.Date DESC, s.Path, s.Row;


-- --------------------------------------------------------

--
-- Events
--

delimiter |
CREATE EVENT IF NOT EXISTS e_updates_stac_tables
        ON SCHEDULE EVERY 1 DAY
                STARTS '2020-07-22 00:00:00'

COMMENT 'Updates the stac_collection and stac_item tables'
DO
BEGIN
        -- updates stac_collection table
        DROP TABLE IF EXISTS stac_collection;
        CREATE TABLE IF NOT EXISTS stac_collection (SELECT * FROM _stac_collection);

        -- updates stac_item table
        DROP TABLE IF EXISTS stac_item;
        CREATE TABLE IF NOT EXISTS stac_item (SELECT * FROM _stac_item);
END |
delimiter ;


-- --------------------------------------------------------

--
-- `scene_dataset` and `dash_amount_scenes_by_dataset_year_month_lon_lat` views
--

CREATE OR REPLACE VIEW `scene_dataset` AS
SELECT  SceneId scene_id,
        Dataset dataset,
        Date date,
        C_longitude longitude,
        C_latitude latitude
FROM `SceneDataset`
ORDER BY Date, Dataset;


CREATE OR REPLACE VIEW `dash_amount_scenes_by_dataset_year_month_lon_lat` AS
SELECT COUNT(SceneId) amount,
        Dataset dataset,
        DATE_FORMAT(Date, '%Y-%m') _year_month,
        C_longitude longitude,
        C_latitude latitude
FROM `SceneDataset`
GROUP BY dataset, _year_month, longitude, latitude
ORDER BY _year_month, dataset;
