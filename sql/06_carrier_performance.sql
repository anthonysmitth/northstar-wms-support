-- Late-delivery percentage for each number of delivery attempts for national freight at leicester warehourse 

SELECT  warehouse_name, carrier_name, COUNT(*) AS total_orders , SUM(delivery_attempts) AS total_delivery_attempts,
SUM(delivery_attempts) * 1.0/ COUNT(*) AS avg_attempts_per_shipment,
AVG(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1.0 ELSE 0 END) * 100 AS Late_Percentage 
FROM shipments AS s
JOIN orders AS o
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id =  w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
WHERE warehouse_Name  =  'Leicester Fulfilment Hub' AND carrier_name = 'National Freight'
GROUP BY delivery_attempts

-- Late-delivery percentage for each number of delivery attempts for all carriers at leicester warehourse 
SELECT  warehouse_name, carrier_name, COUNT(*) AS total_orders , SUM(delivery_attempts) AS total_delivery_attempts,
SUM(delivery_attempts) * 1.0/ COUNT(*) AS avg_attempts_per_shipment,
AVG(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1.0 ELSE 0 END) * 100 AS Late_Percentage 
FROM shipments AS s
JOIN orders AS o
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id =  w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
WHERE warehouse_name  =  'Leicester Fulfilment Hub' 
GROUP BY delivery_attempts, carrier_name

-- Late-delivery percentage for each number of delivery attempts for all carriers at all warehouses
SELECT  warehouse_name, carrier_name, COUNT(*) AS total_orders , SUM(delivery_attempts) AS total_delivery_attempts,
SUM(delivery_attempts) * 1.0/ COUNT(*) AS avg_attempts_per_shipment,
AVG(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1.0 ELSE 0 END) * 100 AS Late_Percentage 
FROM shipments AS s
JOIN orders AS o
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id =  w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
GROUP BY warehouse_name, delivery_attempts, carrier_name

-- Late-delivery percentage for one delivery attempt for all carriers at all warehouses
SELECT  warehouse_name, carrier_name, COUNT(*) AS total_orders , SUM(delivery_attempts) AS total_delivery_attempts,
AVG(CASE WHEN (actual_delivery_date  >  promised_delivery_date) THEN 1.0 ELSE 0 END) * 100 AS Late_Percentage 
FROM shipments AS s
JOIN orders AS o
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id =  w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
WHERE delivery_attempts = 1
GROUP BY warehouse_name, delivery_attempts, carrier_name

--  what percentage of the total orders is from certain carriers 
SELECT  warehouse_name, carrier_name, COUNT(*) AS total_orders , SUM(COUNT(*)) OVER(PARTITION BY warehouse_name) AS total_warehouse_shipments,
COUNT(*)*100.0 / SUM(COUNT(*)) OVER(PARTITION BY warehouse_name)  AS order_total_per_carrier
FROM shipments AS s
JOIN orders AS o
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id =  w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
GROUP BY warehouse_name, carrier_name


-- add late delviery percentage 
SELECT  warehouse_name, carrier_name, COUNT(*) AS total_orders , SUM(COUNT(*)) OVER(PARTITION BY warehouse_name) AS total_warehouse_shipments,
COUNT(*)*100.0 / SUM(COUNT(*)) OVER(PARTITION BY warehouse_name)  AS order_total_per_carrier,
AVG(CASE WHEN actual_delivery_date > promised_delivery_date THEN 1.0 ELSE 0 END) * 100 AS late_delivery_percentage 
FROM shipments AS s
JOIN orders AS o
  ON s.order_id = o.order_id
 JOIN warehouses AS w
   ON o.warehouse_id =  w.warehouse_id
  JOIN carriers AS c
    ON s.carrier_id = c.carrier_id
GROUP BY warehouse_name, carrier_name