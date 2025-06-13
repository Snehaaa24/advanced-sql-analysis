--Segment products into	cost ranges and count how many products fall into each segment

WITH product_segments AS(
SELECT
product_key,
product_name,
cost,
CASE WHEN cost < 100 THEN 'BELOW 100'
	 WHEN cost BETWEEN 100 AND 500 THEN 'B/W 100 & 500'
	 WHEN cost BETWEEN 500 AND 1000 THEN 'B/W 500 & 1000'
	 ELSE 'ABOVE 1K'
END cost_range
FROM gold.dim_products)

SELECT
cost_range,
COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC