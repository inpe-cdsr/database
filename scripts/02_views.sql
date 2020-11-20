--
-- Database: `catalog`
--
USE `catalog`;


-- --------------------------------------------------------

--
-- `_stac_collection` and `_stac_item` views
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
FROM Scene s, Asset a, Dataset d
WHERE s.SceneId = a.SceneId AND d.Name = a.Dataset
GROUP BY d.Name
ORDER BY d.Name;


CREATE OR REPLACE VIEW `stac_item` AS
SELECT s.SceneId id,
        a.Dataset collection,
        s.CenterTime datetime,
        DATE(s.CenterTime) date,
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
        TR_Latitude tr_latitude,
        s.Deleted deleted
FROM Scene s, Asset a
WHERE s.SceneId = a.SceneId
ORDER BY a.Dataset, s.CenterTime DESC, s.Path, s.Row;


-- --------------------------------------------------------

--
-- other views
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


-- --------------------------------------------------------
-- `dash_download` view
-- Join among Download, Location and User tables
-- --------------------------------------------------------
CREATE OR REPLACE VIEW `dash_download` AS
SELECT u.email, u.fullname name, dl.*
FROM (
    SELECT d.scene_id, d.user_id, d.date, d.path, l.*
    FROM (
        SELECT sceneId scene_id, userId user_id, DATE(date) date, path, ip
        FROM Download
    ) d
    LEFT JOIN
        Location l
    ON d.ip = l.ip
) dl
LEFT JOIN
    User u
ON u.userId = dl.user_id;


-- --------------------------------------------------------
-- `dash_download_nofbs` view
-- This view returns the number of files by scene (nofbs)
-- that a single user downloaded in one day
-- --------------------------------------------------------
CREATE OR REPLACE VIEW `dash_download_nofbs` AS
SELECT scene_id, count(scene_id) nofbs, user_id, name, email, date, longitude, latitude
FROM `dash_download`
GROUP BY scene_id, user_id, date
ORDER BY scene_id, nofbs DESC, date DESC;


-- --------------------------------------------------------
-- Statistics
-- --------------------------------------------------------

-- --------------------------------------------------------
-- This script returns the total of downloaded scenes (tds)
-- --------------------------------------------------------
SELECT COUNT(scene_id) tds
FROM `dash_download_nofbs
`

-- --------------------------------------------------------
-- This script returns the total of downloaded assets (files) (tda)
-- --------------------------------------------------------
SELECT SUM(nofbs) tda
FROM `dash_download_nofbs`


-- --------------------------------------------------------
-- This script returns the number of downloaded scenes (nods) by user
-- --------------------------------------------------------
SELECT count(scene_id) nods, user_id, name, email
FROM `dash_download_nofbs`
GROUP BY user_id
ORDER BY user_id, nods DESC
