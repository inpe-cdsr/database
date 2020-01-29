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
