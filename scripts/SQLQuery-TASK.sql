/*
Group customers into three segments based on their spending behavior:
1)VIP- Customers with atleast 12 months of history and spending more than 5000
2)Regular- Customers with atleast 12 months of history and spending 5000 or less
3)New- Customers with less than 12 months of a lifespan
And find the total number of customers from each group
*/

WITH customer_spending AS
(
SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key=c.customer_key
GROUP BY c.customer_key
)

SELECT 
KYC,
COUNT(customer_key) as total_cust
FROM(
	SELECT
	customer_key,
	CASE WHEN total_spending>5000 AND lifespan>=12 THEN 'VIP' --1)
		 WHEN total_spending<=5000 AND lifespan>=12 THEN 'REGULAR' --2)
		 ELSE 'NEW' --3)
	END KYC
	FROM customer_spending)t
GROUP BY KYC
ORDER BY total_cust DESC
