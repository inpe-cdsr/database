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
        MIN(s.Date) start_date,
        MAX(s.Date) end_date,
        MIN(BL_Longitude) min_y,
        MIN(BL_Latitude) min_x,
        MAX(TR_Longitude) max_y,
        MAX(TR_Latitude) max_x
FROM Scene s, Asset a, Dataset d
WHERE s.SceneId = a.SceneId AND d.Name = a.Dataset
GROUP BY d.Name
ORDER BY d.Name;


CREATE OR REPLACE VIEW `_stac_item` AS
SELECT s.SceneId id,
        a.Dataset collection,
        s.Date date,
        s.CenterTime center_time,
        s.Path path,
        s.Row row,
        s.Satellite satellite,
        s.Sensor sensor,
        s.CloudCover cloud_cover,
        s.SyncLoss sync_loss,
        s.thumbnail thumbnail,
        a.Assets assets,
        TL_Longitude tl_longitude,
        TL_Latitude tl_latitude,
        BL_Longitude bl_longitude,
        BL_Latitude bl_latitude,
        BR_Longitude br_longitude,
        BR_Latitude br_latitude,
        TR_Longitude tr_longitude,
        TR_Latitude tr_latitude
FROM Scene s, Asset a
WHERE s.Deleted = 0 AND (s.SceneId = a.SceneId)
ORDER BY a.Dataset, s.Date DESC, s.Path, s.Row;


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