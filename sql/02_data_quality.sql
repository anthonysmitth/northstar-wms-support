-- Data Quality Checks
-- 

SELECT COUNT(*)
FROM inventory_daily
WHERE closing_stock IS NULL;

SELECT COUNT(*)
FROM inventory_daily
WHERE closing_stock = 0;

SELECT *
FROM inventory_daily
WHERE closing_stock IS NULL;

SELECT *
FROM inventory_daily
WHERE closing_stock = 0;

SELECT *
FROM inventory_daily
WHERE closing_stock < 0;

SELECT  COUNT(*)
FROM inventory_daily
GROUP BY snapshot_date,  warehouse_id, product_id;


-- counting duplicates with it returning no duplicates 
SELECT COUNT(*)
FROM inventory_daily
GROUP BY snapshot_date,  warehouse_id, product_id
HAVING COUNT (*)  >  1

-- check for missing values 
SELECT COUNT(*)
FROM inventory_daily
WHERE warehouse_id IS NULL;

SELECT COUNT(*)
FROM inventory_daily
WHERE product_id IS NULL;

SELECT COUNT(*)
FROM inventory_daily
WHERE snapshot_date IS NULL;

SELECT COUNT(*)
FROM inventory_daily
WHERE units_used  <  0;

SELECT COUNT(*)
FROM inventory_daily
WHERE units_received < 0;

SELECT COUNT(*)
FROM inventory_daily
WHERE units_used  IS NULL;

SELECT COUNT(*)
FROM inventory_daily
WHERE units_received IS NULL;

