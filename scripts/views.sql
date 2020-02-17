--
-- Database: `catalogo`
--
USE `catalogo`;


-- --------------------------------------------------------

--
-- View structure for view `collection`
--

CREATE OR REPLACE VIEW `stac_collection` AS
SELECT d.Name id,
        d.Description description,
        MIN(s.Date) start_date,
        MAX(s.Date) end_date,
        MIN(BL_Latitude) min_y,
        MIN(BL_Latitude) min_x,
        MAX(TR_Latitude) max_x,
        MAX(TR_Longitude) max_y
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
        q.QLfilename thumbnail,
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
FROM Scene s, Product p, Dataset d, Qlook q
WHERE s.SceneId = p.SceneId AND p.Dataset = d.Name AND p.SceneId = q.SceneId
GROUP BY s.SceneId
ORDER BY s.Date DESC, s.SceneId ASC;
