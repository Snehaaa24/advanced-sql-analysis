--Analyzing Sales over time

SELECT 
DATETRUNC(YEAR,order_date) as order_year,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as new_customers,
SUM(quantity) as total_quantity	
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)	
ORDER BY DATETRUNC(YEAR,order_date)


SELECT 
FORMAT(order_date,'yyyy-MM') as order_date,
SUM(sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as new_customers,
SUM(quantity) as total_quantity	
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date,'yyyy-MM')	
ORDER BY FORMAT(order_date,'yyyy-MM')