
CREATE OR REPLACE VIEW bdc.stac_item AS
SELECT CONCAT(c.name, '-', c.version) collection,
        i.*
FROM bdc.items i, bdc.collections c
WHERE i.collection_id = c.id
ORDER BY c.name, i.start_date DESC;
