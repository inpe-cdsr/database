----------------------------------------------------------------------------------------------------
-- procedures
----------------------------------------------------------------------------------------------------

--------------------------------------------------
-- procedure to update the download materialized view
--------------------------------------------------
CREATE OR REPLACE PROCEDURE update_download_view_number_of_assets()
LANGUAGE SQL AS $$
	-- update the materalized view concurrently
	REFRESH MATERIALIZED VIEW CONCURRENTLY download_view_number_of_assets;
	-- add logging after executing the procedure
	INSERT INTO download_logging (message)
		VALUES ('Procedure `update_download_view_number_of_assets` has been executed successfully!');
$$;

-- CALL update_download_view_number_of_assets();


------------------------------
-- run above procedure inside a cron job
------------------------------
-- execute procedure every 15 minutes using pg_cron
-- run it inside gis database, create the job manually
-- source: https://github.com/citusdata/pg_cron/issues/89#issuecomment-701562076
INSERT INTO cron.job (schedule, command, nodename, nodeport, database, username)
VALUES ('*/15 * * * *', 'CALL update_download_view_number_of_assets()', 'localhost', 5432, 'cdsr_register', 'postgres');
