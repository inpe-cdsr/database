----------------------------------------------------------------------------------------------------
-- materialized views
----------------------------------------------------------------------------------------------------

--------------------------------------------------
-- number of downloaded assets by users
--------------------------------------------------
DROP MATERIALIZED VIEW IF EXISTS download_view_number_of_assets CASCADE;
CREATE MATERIALIZED VIEW download_view_number_of_assets AS
	SELECT COUNT(item_id) number_of_assets, item_id, collection, username, user_email,
			user_name, DATE(created_at) date, ip, longitude, latitude
	FROM download
	GROUP BY item_id, collection, ip, longitude, latitude, date, username, user_email, user_name
	ORDER BY number_of_assets DESC
WITH NO DATA;

-- an index is necessary to refresh the materialized view concurrently
CREATE UNIQUE INDEX idx_download_view_number_of_assets
	ON download_view_number_of_assets (item_id, username, date, ip);

-- update the materialized view
-- first time
REFRESH MATERIALIZED VIEW download_view_number_of_assets;
-- other times
REFRESH MATERIALIZED VIEW CONCURRENTLY download_view_number_of_assets;

-- SELECT * FROM download_view_number_of_assets;


----------------------------------------------------------------------------------------------------
-- views
----------------------------------------------------------------------------------------------------

--------------------------------------------------
-- number of downloaded items by users
--------------------------------------------------
CREATE OR REPLACE VIEW download_view_number_of_items AS
SELECT COUNT(item_id) number_of_items, username, user_email, user_name,
		date, ip, longitude, latitude
FROM download_view_number_of_assets
GROUP BY date, ip, longitude, latitude, username, user_email, user_name
ORDER BY number_of_items DESC;

-- SELECT * FROM download_view_number_of_items;


----------------------------------------------------------------------------------------------------
-- common selects
----------------------------------------------------------------------------------------------------

--------------------------------------------------
-- total number of downloaded items using both views
--------------------------------------------------
-- faster
SELECT COUNT(item_id) total_number_of_items
FROM download_view_number_of_assets;
-- slower
SELECT SUM(number_of_items) total_number_of_items
FROM download_view_number_of_items;

--------------------------------------------------
-- total number of downloaded assets
--------------------------------------------------
SELECT SUM(number_of_assets) total_number_of_assets
FROM download_view_number_of_assets;

--------------------------------------------------
-- number of downloaded items by satellte/sensor
--------------------------------------------------
SELECT COUNT(item_id) number_of_items,
		CONCAT(
			SPLIT_PART(collection, '_', 1),
			'_',
			SPLIT_PART(collection, '_', 2)
		) satellite_sensor
FROM download_view_number_of_assets
GROUP BY satellite_sensor
ORDER BY number_of_items DESC, satellite_sensor;
