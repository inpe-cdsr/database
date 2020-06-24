--
-- Database: `catalogo`
--
USE `catalogo`;


-- --------------------------------------------------------

--
-- View structure for views `stac_collection` and `stac_item`
--

CREATE OR REPLACE VIEW `stac_collection` AS
SELECT d.Name id,
        d.Description description,
        MIN(s.Date) start_date,
        MAX(s.Date) end_date,
        MIN(BL_Longitude) min_y,
        MIN(BL_Latitude) min_x,
        MAX(TR_Longitude) max_y,
        MAX(TR_Latitude) max_x
FROM Scene s, Product p, Dataset d
WHERE s.sceneId = p.sceneId AND d.name = p.Dataset
GROUP BY p.Dataset
ORDER BY p.Dataset;


CREATE OR REPLACE VIEW `stac_item` AS
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
FROM Scene s, Product p, Dataset d
WHERE s.SceneId = p.SceneId AND p.Dataset = d.Name
GROUP BY s.SceneId, p.Dataset
ORDER BY p.Dataset, s.Date DESC, s.Path, s.Row;


-- --------------------------------------------------------

--
-- View structure for view `graph_amount_scenes_by_dataset_and_date`
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
