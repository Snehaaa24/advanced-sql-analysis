--WHICH CATEGORIES CONTRIBUTE THE MOST TO OVERALL SALES?

WITH CATEGORY_SALES AS(
SELECT
category,
SUM(sales_amount) total_sales
FROM GOLD.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY category)

SELECT 
category,
total_sales,
SUM(total_sales) OVER () overall_sales,
CONCAT(ROUND((CAST(total_sales AS float)/SUM(total_sales) OVER ())*100,1),'%') AS percentage_of_total
FROM CATEGORY_SALES
ORDER BY total_sales DESC