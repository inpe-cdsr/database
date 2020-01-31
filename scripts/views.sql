--
-- Database: `catalogo`
--
USE `catalogo`;


-- --------------------------------------------------------

--
-- View structure for view `collection`
--

CREATE OR REPLACE VIEW `collection` AS
SELECT d.Name as id, d.Description as description,
        MIN(s.Date) as start_date, MAX(s.Date) as end_date,
        MIN(BL_Latitude) as min_y, MIN(BL_Latitude) as min_x,
        MAX(TR_Latitude) as max_x, MAX(TR_Longitude) as max_y
FROM Scene s, Product p, Dataset d
WHERE s.sceneId = p.sceneId AND d.name = p.Dataset
GROUP BY p.Dataset
ORDER BY p.Dataset;


CREATE OR REPLACE VIEW `item` AS
SELECT a.SceneId as id,
        b.Dataset as collection,
        Date as date, Path as path, Row as row, Satellite as satellite, Sensor as sensor, CloudCoverQ1 as cloud_cover,
        q.QLfilename as thumbnail,
        GROUP_CONCAT(CONCAT('{"band": "', b.band, '", "filename": "', b.filename,'"}')) as assets,
        TL_Longitude, TL_Latitude, BL_Longitude, BL_Latitude,
        BR_Longitude, BR_Latitude, TR_Longitude, TR_Latitude
FROM Scene a, Product b, Dataset c, Qlook q
WHERE a.SceneId = b.SceneId AND b.Dataset = c.Name AND b.SceneId = q.SceneId
GROUP BY a.SceneId
ORDER BY a.Date DESC, a.SceneId ASC;
