-- Inventory balance validation 
-- Does closing stock match the stock calulation?
-- opening stock + received units - used units?

SELECT *
FROM inventory_daily
LIMIT 20;

SELECT 
 COUNT(*) AS total_records, 
 SUM (CASE WHEN closing_stock = opening_stock +units_received - units_used
 THEN 1 ELSE 0 END) AS matching_records,
 SUM( CASE WHEN closing_stock <> opening_stock + units_received - units_used
 THEN 1 ELSE 0 END) AS mismatched_records
 FROM inventory_daily;
 
 SELECT opening_stock, units_received, units_used
 FROM inventory_daily
 WHERE  closing_stock <> opening_stock + units_received - units_used;
 
 SELECT COUNT(*)
FROM inventory_daily;