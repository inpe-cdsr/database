----------------------------------------------------------------------------------------------------
-- create language
----------------------------------------------------------------------------------------------------

CREATE LANGUAGE plpython3u;

----------------------------------------------------------------------------------------------------
-- scripts to fix records
----------------------------------------------------------------------------------------------------

--------------------------------------------------
-- remove unnecessary final substring to each record
--------------------------------------------------

DROP FUNCTION IF EXISTS remove_unnecessary_final_substring (TEXT);
CREATE OR REPLACE FUNCTION remove_unnecessary_final_substring (s TEXT)
RETURNS TEXT AS $$
	# treat `s` as readonly
	global s
	string = s

	# plpy.info(f'original string: {string}')

	# remove white spaces
	string = string.replace(' ', '')

	unwanted_strings = [
		'_L2_DN', '_L2B_DN', '_L3_DN', '_L4_DN',
		'_L2_SR', '_L2B_SR', '_L3_SR', '_L4_SR'
	]

	for unwanted_string in unwanted_strings:
		# remove unwanted string, if it exists
		if unwanted_string in string:
			string = string.replace(unwanted_string, '')
			break

	# plpy.info(f'final string: {string}')

	return string
$$ LANGUAGE plpython3u;

-- update records
UPDATE download SET item_id = remove_unnecessary_final_substring(item_id);


--------------------------------------------------
-- remove unnecessary records
--------------------------------------------------

DELETE FROM download
	WHERE (collection != 'CBERS4A_WPM_L4_DN'
		   AND collection != 'CBERS4A_WPM_L2_DN'
		   AND collection != 'CBERS4A_MUX_L2_DN'
		   AND collection != 'CBERS4A_MUX_L4_DN'
		   AND collection != 'CBERS4A_WFI_L2_DN'
			AND collection != 'CBERS4A_WFI_L4_DN')
		AND (item_id LIKE 'CBERS4A_WF\_%'
		OR item_id LIKE 'CBERS4A_W\_%'
		OR item_id LIKE 'CBERS4A_WFI1\_%'
		OR item_id LIKE 'CBERS4A_MU\_%'
		OR item_id LIKE 'CBERS4A_WPM20\_%'
		OR item_id LIKE 'CBERS4A_MUX1\_%'
		OR item_id LIKE 'CBERS4A_\_%'
		OR item_id LIKE 'CBERS4A_WP\_%'
		OR item_id LIKE 'CBERS4A_WFI2\_%'
		OR item_id LIKE 'CBERS4A_MUX2\_%'
		OR item_id LIKE 'CBERS4A_WPM1\_%'
		OR item_id LIKE 'CBERS4A_WPM2\_%');


--------------------------------------------------
-- fix underscores to each record
--------------------------------------------------

CREATE OR REPLACE FUNCTION fix_underscore (s TEXT)
RETURNS TEXT AS $$
	# treat `s` as readonly
	global s
	string = s

	splitted = string.split('_')

	last = splitted[1][-1]
	splitted[1] = splitted[1][:-1]
	splitted[2] = last + splitted[2]

	last = splitted[2][-1]
	splitted[2] = splitted[2][:-1]
	splitted[3] = last + splitted[3]

	return '_'.join(splitted)
$$ LANGUAGE plpython3u;


UPDATE download
SET item_id=subquery.fixed_item_id
FROM (
	SELECT id, fix_underscore(item_id) fixed_item_id
	FROM download
	WHERE (item_id LIKE 'CBERS4A_WF\_%'
		OR item_id LIKE 'CBERS4A_W\_%'
		OR item_id LIKE 'CBERS4A_WFI1\_%'
		OR item_id LIKE 'CBERS4A_MU\_%'
		OR item_id LIKE 'CBERS4A_WPM20\_%'
		OR item_id LIKE 'CBERS4A_MUX1\_%'
		OR item_id LIKE 'CBERS4A_\_%'
		OR item_id LIKE 'CBERS4A_WP\_%'
		OR item_id LIKE 'CBERS4A_WFI2\_%'
		OR item_id LIKE 'CBERS4A_MUX2\_%'
		OR item_id LIKE 'CBERS4A_WPM1\_%'
		OR item_id LIKE 'CBERS4A_WPM2\_%')
	) AS subquery
WHERE download.id = subquery.id;
