/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

CREATE VIEW gold.report_customerz AS
-------------------------------------------------------------------------------
--1) Base Query: Retrieves core columns from tables
-------------------------------------------------------------------------------
WITH Base_Query AS
(
SELECT
f.order_number,
f.order_date,
f.product_key,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ',c.last_name) AS customer_name,
DATEDIFF(year,c.birthdate, GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key=f.customer_key
WHERE order_date IS NOT NULL
)


-------------------------------------------------------------------------------
/*
--2) Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
*/
-------------------------------------------------------------------------------
, CUSTOMER_AGGREGATION AS(
SELECT 
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantities,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order,
	MIN(order_date) AS first_order,
	DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
FROM Base_Query
GROUP BY 
	customer_key,
	customer_number,
	customer_name,
	age
)
--------------------------------------------------------------------
--3) Segments customers into categories (VIP, Regular, New) and age groups.
--------------------------------------------------------------------
SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE
		 WHEN age < 20 THEN 'Under 20'
		 WHEN age between 20 and 29 THEN '20-29'
		 WHEN age between 30 and 39 THEN '30-39'
		 WHEN age between 40 and 49 THEN '40-49'
		 ELSE '50 and above'
	END AGE_GROUP,
	CASE WHEN total_sales>5000 AND lifespan>=12 THEN 'VIP' --1)
		 WHEN total_sales<=5000 AND lifespan>=12 THEN 'REGULAR' --2)
		 ELSE 'NEW' --3)
	END KYC,
	last_order,
	----Computing recency
	DATEDIFF(month,last_order,GETDATE()) AS recency,
	total_orders,
	total_sales,
	total_quantities,
	total_products,
	lifespan,
	----Computing Avg order value
	CASE WHEN total_orders=0 THEN 0
		 ELSE total_sales/total_orders 
	END AS avg_orderValue,
	----Computing Avg MONTHLY SPEND
	CASE WHEN lifespan=0 THEN total_sales
		 ELSE total_sales/lifespan 
	END AS avg_monthlySpend
	FROM CUSTOMER_AGGREGATION



