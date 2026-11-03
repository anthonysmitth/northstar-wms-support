SELECT carrier_name, COUNT(*) AS total_amount,
SUM(CASE WHEN actual_delivery_date > promised_delivery_date THEN 1 ELSE 0 END) AS total_late_shipments, 
AVG(CASE WHEN actual_delivery_date > promised_delivery_date THEN 1.0 ELSE 0 END) * 100 AS late_delivery_percentage 
FROM shipments AS s
JOIN orders AS o
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id =  w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
GROUP BY  carrier_name
 
 --Do customers with higher cancelation rate also have higher order volumes or order patterns 
SELECT customer_name, warehouse_name, COUNT(*),
SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Total ,
SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Cancell_Rate 
FROM customers AS c
JOIN orders AS o
  ON  c.customer_id = o.customer_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
 GROUP BY customer_name, warehouse_name
 ORDER BY Cancell_Rate DESC

-- Do customers with higher cancellation rate also have a particular order channel
-- customer + warehouse + order channel 
SELECT customer_name, warehouse_name,order_channel, COUNT(*),
SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Total ,
SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Cancell_Rate 
FROM customers AS c
JOIN orders AS o
  ON  c.customer_id = o.customer_id
 JOIN warehouses AS w
   ON o.warehouse_id = w.warehouse_id
 GROUP BY customer_name, warehouse_name, order_channel
 ORDER BY Cancell_Rate DESC