-- Which warehouse processes the highest number of orders, and how does its cancellation rate compare with the others? 

SELECT * 
FROM orders;

SELECT warehouse_id, COUNT(*) 
FROM orders 
GROUP BY warehouse_id;

-- calculating the total cancels and cancel rate 
SELECT warehouse_id, COUNT(*)  AS total_orders,
SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Total ,
SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Cancell_Rate 
FROM orders 
GROUP BY warehouse_id;

SELECT warehouse_id, COUNT(*)  AS total_shipments,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS Late_Total ,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
GROUP BY warehouse_id;

-- add name 
SELECT  warehouse_name, COUNT(*)  AS total_shipments,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS Late_Total ,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
GROUP BY warehouse_name;

-- Warehouse performance by month 
SELECT  strftime('%Y-%m', order_date) AS order_month ,warehouse_name, COUNT(*)  AS total_shipments,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS Late_Total ,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
GROUP BY order_month, warehouse_name
ORDER BY order_month DESC

-- Which carrier has highest alte delviery precentage when handling shipments for leicester 

SELECT  carrier_name, COUNT(*)  AS total_shipments,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS Late_Total ,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
WHERE warehouse_name =  'Leicester Fulfilment Hub'
GROUP BY carrier_name;


SELECT * 
FROM shipments

-- Late delivery attempts by carrier for Leicester Warehouse
SELECT  carrier_name, COUNT(*)  AS total_shipments,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS Late_Total ,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
WHERE warehouse_name =  'Leicester Fulfilment Hub'
GROUP BY carrier_name;

-- late delivery for all warehouses
SELECT  carrier_name, COUNT(*)  AS total_shipments,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS Late_Total ,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
GROUP BY carrier_name;

-- Comparing late delivery percentages by carrier at each warehouse
SELECT  warehouse_name, carrier_name, COUNT(*)  AS total_shipments,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS Late_Total ,
SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
GROUP BY carrier_name, warehouse_name;

SELECT  warehouse_name, carrier_name, COUNT(*)  AS total_shipments,
AVG( julianday(actual_delivery_date ) - julianday (ship_date) )AS average_delivery_rate ,
AVG(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Late_Percentage 
FROM shipments AS s 
JOIN orders AS o 
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
GROUP BY carrier_name, warehouse_name;

SELECT * FROM orders