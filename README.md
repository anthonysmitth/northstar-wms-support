## Northstar Logistics - Warehouse & Delivery Performance Analysis 

This project uses SQL to investigate warehouse and logistics data and identify potential issues affecting inventory accuracy, order fulfilment and delivery performance. 

Using a fictional logistics dataset, I explored how stock levels changed over time, investigated order cancellations and compared delivery performance across different warehouses and carriers. 

The aim was to understand how SQL can be used to investigate real-world business problems and produce findings that could help support operational decisions. 

## Methods Used 
- Data analysis 
- Data cleaning and validation
- Exploratory data analysis 
- Aggregation and trend analysis 
- Warehouse and carrier performance analysis 

## Technologies
- SQL
- SQLite 
- DB Browser for SQLite

## Project Description 

This project used a fictional logistics dataset containing information about inventory, orders, shipments, customers, warehouses and carriers. 

My analysis focused on several business questions:

1. Inventory: Are stock balances accurate, and are there unexplained changes in stock levels?

2. Order cancellations: How frequently are orders cancelled, and are there patterns across warehouses, customers or order channels?

3. Warehouse performance: Which warehouses have the highest rates of late deliveries?

4. Carrier performance: How do delivery times and on-time delivery rates compare across carriers?

5. Operational issues: What patterns or potential problems could be worth investigating further?

## Key Findings

1. Inventory Validation

- Analysed 16,290 inventory records.

- All records passed the stock balance calculation check, with no calculation mismatches.

- Identified 13 differences between opening stock and the previous day's closing stock, which could indicate missing or unrecorded stock movements.

2. Order Cancellations

- Analysed 1,434 orders, with 52 cancellations (3.63%).

- Birmingham had the highest cancellation rate across the three warehouses at 4.86%.

- February had the highest monthly cancellation rate at 5.38%.

3. Warehouse Delivery Performance

- Leicester had the highest late-delivery rate at 28.26%.

- Corby had a late-delivery rate of 20.88%.

- Birmingham had the lowest late-delivery rate at 19.78%.

4. Carrier Performance

- RapidRoute achieved the highest on-time delivery rate at 85.42%, followed by SwiftShip at 83.84%.

- National Freight had the lowest on-time delivery rate at 61.46%.

5. Further Investigation

- Identified differences in opening and closing stock balances that could indicate unrecorded movements or adjustments.

- Identified differences in delivery performance between warehouses and carriers that could benefit from further operational investigation.

## Recommendations

Based on the analysis, the following areas could be investigated further:

- Inventory management: Investigate differences between daily opening and previous closing stock balances to identify potentially missing stock movements or adjustments.

- Order cancellations: Review cancellation patterns across warehouses, customers and order channels, particularly the higher cancellation rates identified in Birmingham and during February.

- Warehouse performance: Investigate why Leicester had a higher late-delivery rate than the other warehouses.

- Carrier performance: Review delivery performance across carriers, particularly National Freight, which had the lowest on-time delivery rate.

- Ongoing monitoring: Introduce regular reporting to monitor inventory accuracy, cancellations and delivery performance over time.

## Project Structure

```
northstar-wms-support/
│
├── README.md
├── sql/
│   ├── 01_inventory_validation.sql
│   ├── 02_data_quality.sql
│   ├── 03_stock_movement_analysis.sql
│   ├── 04_order_cancellations.sql
│   ├── 05_warehouse_performance.sql
│   ├── 06_carrier_performance.sql
│   └── 07_customer_analysis.sql
├── data/
│   └── Original CSV dataset files
└── findings/
    └── Project analysis report
```

## Limitations

The dataset is fictional and contains a limited period of operational data. My analysis identifies patterns and potential issues but does not establish the underlying causes of those issues.

The findings are based on the information available in the dataset. Additional information about warehouse processes, stock movements, order handling and delivery operations would be needed to understand the reasons behind the patterns identified.

The project therefore highlights areas where a logistics business could carry out further investigation and potentially improve its operations.



