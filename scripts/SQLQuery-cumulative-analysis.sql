-- CALCULATE TOTAL SALES PER MONTH AND RUNNING TOTAL SALES OVER TIME

SELECT 
order_date,
total_sales,
--WINDOW FUNCTION  ~adding each total_sales one by one (cumulative)
SUM(total_sales) OVER (ORDER BY order_date) AS Running_total ,
SUM(avg_sales) OVER (ORDER BY order_date) AS Moving_average_price 
--WINDOW FUNCTION
FROM
(SELECT
DATETRUNC(MONTH,order_date) as order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
) t