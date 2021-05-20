
--------------------------------------------------
-- Fix table sequences
--------------------------------------------------

-- address table
SELECT setval('address_id_seq', COALESCE((SELECT MAX(id)+1 FROM address), 1), false);

-- download table
SELECT setval('download_id_seq', COALESCE((SELECT MAX(id)+1 FROM download), 1), false);

