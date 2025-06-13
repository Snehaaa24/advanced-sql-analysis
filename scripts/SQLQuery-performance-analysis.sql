/* Analyse the yearly performance of products by comparing their sales to both the 
(i) average sales performance of the product and (ii) the previous year's sales */

WITH yearly_product_sales AS
(
SELECT 
YEAR(f.order_date) as order_year,
p.product_name,
SUM(f.sales_amount) as current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
on f.product_key=p.product_key
WHERE order_date IS NOT NULL
GROUP BY 
YEAR(f.order_date),
P.product_name
)

SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) AS average_sales,
--(i) (current sales-avg sales)
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS performance_diffavg,
CASE WHEN current_sales-AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'ABOVE AVG'
	 WHEN current_sales-AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'BELOW AVG'
	 ELSE 'AVG'
END avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) prev_sales,
--(ii) (current sales-prev year sales)
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) as performance_diffprev,
CASE WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'INCREASE'
	 WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'DECREASE'
	 ELSE 'NO CHANGE'
END	prev_year_change
FROM yearly_product_sales
ORDER BY
product_name,
order_year