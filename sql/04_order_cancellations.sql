-- Unfulfilled orders
-- Which customer orders have not been fullfilled and how many need to be investigated?

SELECT * 
FROM orders 
LIMIT 10;

-- checking data to see what order status it shows - i find it only has shipped and cancelled 
SELECT DISTINCT order_status
FROM orders;

SELECT  COUNT(*) 
FROM orders
ORDER BY  order_status;

SELECT   order_status, COUNT(*) AS total_count
FROM orders
ORDER BY  order_status;

SELECT   order_status, COUNT(*) AS total_count
FROM orders
GROUP BY order_status;

-- Finding what customers and warehouses are associated with cancelled orders 

SELECT * 
FROM orders
WHERE order_status  = 'Cancelled';

-- Cancelation amount by warehouse 
SELECT order_status, warehouse_id , COUNT(*) AS total_count 
FROM orders 
WHERE order_status = 'Cancelled'
GROUP BY warehouse_id;

-- Cancelation amount by customer 
SELECT order_status, customer_id , COUNT(*) AS total_count 
FROM orders 
WHERE order_status = 'Cancelled'
GROUP BY customer_id;

SELECT  warehouse_id, customer_id , COUNT(*) AS total_cancelled 
FROM orders 
WHERE order_status = 'Cancelled'
GROUP BY customer_id, warehouse_id;

-- Compare cancellation rates across warehouses
-- to identify locations that may need further investigation.

SELECT warehouse_id , 
COUNT(*) AS total_order_amount, 
SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS num_cancelled,
(SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)  * 100.0/ COUNT(*)) AS Cancellation_rate
FROM orders
GROUP BY warehouse_id;

-- Are cancellations more common in certain months?
SELECT strftime('%Y-%m', order_date) AS order_month ,  COUNT(*) AS total_cancelled
FROM orders
WHERE order_status = 'Cancelled'
GROUP BY order_month
ORDER BY order_month DESC


 SELECT strftime('%Y-%m', order_date) AS order_month ,  COUNT(*) AS total_cancelled, COUNT(order_id) AS total_orders,
 SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS num_cancelled,
(SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)  * 100.0/ COUNT(*)) AS Cancellation_rate
FROM orders
GROUP BY order_month
ORDER BY order_month DESC


-- cancellation rate per month compared with total orders 

 SELECT strftime('%Y-%m', order_date) AS order_month , COUNT(*) AS total_orders,
 SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS num_cancelled,
(SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)  * 100.0/ COUNT(*)) AS Cancellation_rate
FROM orders
GROUP BY order_month
ORDER BY order_month DESC


 SELECT strftime('%Y-%m', order_date) AS order_month ,order_channel,  COUNT(*) AS total_orders,
  SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS num_cancelled,
(SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)  * 100.0/ COUNT(*)) AS Cancellation_rate
 FROM orders
WHERE strftime('%Y-%m', order_date) = '2026-02'
GROUP BY order_channel
ORDER BY order_channel;

-- Checking every month cancellationr ate for the channel source EDI 
 SELECT strftime('%Y-%m', order_date) AS order_month ,order_channel,  COUNT(*) AS total_orders,
  SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS num_cancelled,
(SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)  * 100.0/ COUNT(*)) AS Cancellation_rate
 FROM orders
WHERE order_channel = 'EDI'
GROUP BY order_month
ORDER BY order_month DESC;


SELECT *
FROM shipments
LIMIT 10;

SELECT o.order_id, o.order_status, s.shipment_id, s.ship_date, s.actual_delivery_date, s.delivery_attempts, s.damaged_flag
FROM orders AS o 
LEFT JOIN shipments AS s
  ON  o.order_id = s.order_id
 WHERE o.order_status = 'Cancelled';
 
 SELECT COUNT(*)  AS cancelled_orders, 
 COUNT(s.shipment_id) AS cancelled_orders_with_shipments
 FROM orders as o
 LEFT JOIN shipments as s
   ON o.order_id = s.order_id 
 WHERE o.order_status = 'Cancelled';
 
 SELECT s.delivery_attemps, COUNT(*) AS total_shipments, SUM(s.damaged_flag) 	AS damaged_shipments
 FROM orders AS o
 JOIN shipments as s
   ON o.order_id = s.order_id
   WHERE .order_status = 'Shipped'
   GROUP BY s.delivery_attempts
   ORDER BY s.delivery_attemps;
   
   SELECT
    s.delivery_attempts,
    COUNT(*) AS total_shipments,
    SUM(s.damaged_flag) AS damaged_shipments
FROM orders AS o
JOIN shipments AS s
    ON o.order_id = s.order_id
WHERE o.order_status = 'Shipped'
GROUP BY s.delivery_attempts
ORDER BY s.delivery_attempts;
 
 SELECT carrier_id, COUNT(*) AS total_shipments, AVG(julianday(actual_delivery_date) - julianday(ship_date)) AS average_delivery_days
 FROM shipmentsGROUP BY carrier_idORDER BY average_delivery_days DESC;
 
SELECT
    carrier_id,
    COUNT(*) AS total_shipments,
    AVG(
        julianday(actual_delivery_date) - julianday(ship_date)
    ) AS average_delivery_days
FROM shipments
GROUP BY carrier_id
ORDER BY average_delivery_days DESC;

-- which carrier has most shipments comapred to total shipments 
SELECT  carrier_id, SUM(delivery_attempts) AS total_deliv_attempts, COUNT(*) AS total_shipments,
SUM(delivery_attempts )*1.0 / COUNT(*) AS  avg_attempts_per_shipment
FROM shipments
GROUP BY carrier_id
ORDER BY avg_attempts_per_shipment DESC;

-- average delviery time 
SELECT delivery_attempts, COUNT(*) AS overall_attempts,AVG(julianday (actual_delivery_date)-julianday(ship_date) )AS average_delivery_time
FROM shipments
GROUP BY delivery_attempts

-- 

SELECT *
FROM carriers;

SELECT carrier_name, service_level, delivery_attempts, ship_date, actual_delivery_date
FROM shipments AS s
JOIN carriers AS c
  ON s.carrier_id = c.carrier_id

  -- average delviery time for each carrier 
 SELECT  carrier_name, service_level, COUNT(*) AS total_shipments, AVG(julianday(actual_delivery_date)-julianday(ship_date)) AS average_delivery_time
FROM shipments AS s
JOIN carriers AS c
  ON s.carrier_id = c.carrier_id
 GROUP BY carrier_name, service_level;
 
 -- percentage of shipments delivered within one day for each carrier 
 
 SELECT  carrier_name, service_level, COUNT(*) AS total_shipments, AVG(julianday(actual_delivery_date)-julianday(ship_date)) AS average_delivery_time,
 SUM(CASE WHEN (julianday(actual_delivery_date)-julianday(ship_date) <=1 THEN 1 ELSE 0 END) AS percent
FROM shipments AS s
JOIN carriers AS c
  ON s.carrier_id = c.carrier_id
 GROUP BY carrier_name, service_level;
  
 SELECT  carrier_name, service_level, COUNT(*) AS total_shipments,
 SUM(CASE WHEN (julianday(actual_delivery_date)-julianday(ship_date) <=1) THEN 1 ELSE 0 END) AS delivered_within_one_day 
FROM shipments AS s
JOIN carriers AS c
  ON s.carrier_id = c.carrier_id
 GROUP BY carrier_name, service_level;
  
  SELECT  carrier_name, service_level, COUNT(*) AS total_shipments,
 SUM(CASE WHEN (julianday(actual_delivery_date)-julianday(ship_date) <=1) THEN 1 ELSE 0 END) AS delivered_within_one_day ,
 SUM(CASE WHEN (julianday(actual_delivery_date)-julianday(ship_date) <=1) THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS delivery_percentage 
FROM shipments AS s
JOIN carriers AS c
  ON s.carrier_id = c.carrier_id
 GROUP BY carrier_name, service_level;
 
 SELECT  carrier_name, COUNT(*) AS total_shipments, 
  SUM(CASE WHEN (actual_delivery_date  <= promised_delivery_date) THEN 1 ELSE 0 END) AS on_time ,
  SUM(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1 ELSE 0 END) AS late ,
  SUM(CASE WHEN (actual_delivery_date  <= promised_delivery_date) THEN 1 ELSE 0 END) *100.0 / COUNT(*) AS on_time_rate
 FROM shipments AS s
 JOIN orders AS o
   ON s.order_id = o.order_id
  JOIN carriers AS c
   ON s.carrier_id = c.carrier_id
  GROUP BY carrier_name
 


 SELECT  carrier_name, COUNT(*) AS total_shipments, 
  AVG(CASE WHEN actual_delivery_date <= promised_delivery_date THEN julianday(actual_delivery_date) - julianday(ship_date) END) AS avg_on_time_days,
  AVG(CASE WHEN actual_delivery_date > promised_delivery_date THEN julianday(actual_delivery_date) - julianday(ship_date) END) AS avg_late_days
 FROM shipments AS s
 JOIN orders AS o
   ON s.order_id = o.order_id
     JOIN carriers AS c
   ON s.carrier_id = c.carrier_id
  GROUP BY carrier_name
  
  