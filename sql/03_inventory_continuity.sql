-- Finding the lowest stock levels 
-- Whata re the lowest closing-stock quantities recorded in the inventory table? 

SELECT product_id, warehouse_id, snapshot_date, closing_stock
FROM inventory_daily
ORDER BY closing_stock ASC
LIMIT 20;

-- What happened to SKU013 in warehouse WH01 across its recorded dates? 
SELECT snapshot_date, opening_stock, units_received, units_used, closing_stock
FROM inventory_daily
WHERE product_id = 'SKU013' AND warehouse_id = 'WH01'
ORDER BY snapshot_date ASC

SELECT snapshot_date, opening_stock , closing_stock, LAG(closing_stock) OVER (
ORDER BY snapshot_date) AS previous_closing_stock
FROM inventory_daily
WHERE product_id = 'SKU013'
AND warehouse_id = 'WH01' 
ORDER BY snapshot_date;


SELECT snapshot_date, opening_stock , closing_stock, LAG(closing_stock) OVER (
PARTITION BY  product_id AND warehouse_id ) AS previous_closing_stock
FROM inventory_daily
ORDER BY snapshot_date;

SELECT snapshot_date, opening_stock , closing_stock, LAG(closing_stock) OVER (
PARTITION BY  product_id , warehouse_id ORDER BY snapshot_date) AS previous_closing_stock
FROM inventory_daily
ORDER BY snapshot_date;

WITH Inventorywithlag AS (SELECT snapshot_date, opening_stock , closing_stock, product_id, warehouse_id, LAG(closing_stock) OVER (
PARTITION BY  product_id , warehouse_id ORDER BY snapshot_date) AS previous_closing_stock
FROM inventory_daily
ORDER BY snapshot_date)

SELECT * 
FROM Inventorywithlag
WHERE opening_stock <> previous_closing_stock;

-- calculating stock difference 

WITH Inventorywithlag AS (SELECT snapshot_date, opening_stock , closing_stock, product_id, warehouse_id,  LAG(closing_stock) OVER (
PARTITION BY  product_id , warehouse_id ORDER BY snapshot_date) AS previous_closing_stock
FROM inventory_daily
ORDER BY snapshot_date)

SELECT *, opening_stock - previous_closing_stock AS stock_difference
FROM Inventorywithlag
WHERE opening_stock <> previous_closing_stock;

-- checking previous snapshot dates 


WITH Inventorywithlag AS (SELECT snapshot_date, opening_stock , closing_stock, product_id, warehouse_id,  LAG(closing_stock) OVER (
PARTITION BY  product_id , warehouse_id ORDER BY snapshot_date) AS previous_closing_stock, LAG(snapshot_date) OVER ( PARTITION BY product_id, warehouse_id ORDER BY snapshot_date) AS previous_snapshot_date
FROM inventory_daily
ORDER BY snapshot_date)

SELECT *, opening_stock - previous_closing_stock AS stock_difference
FROM Inventorywithlag
WHERE opening_stock <> previous_closing_stock;

-- Check whether opening stock matches the previous
-- day's closing stock for each product and warehouse.
-- Investigate any differences.

SELECT
    snapshot_date,
    opening_stock,
    units_received,
    units_used,
    closing_stock
FROM inventory_daily
WHERE product_id = 'SKU013'
  AND warehouse_id = 'WH01'
  AND snapshot_date BETWEEN '2026-03-14' AND '2026-03-22'
ORDER BY snapshot_date;
