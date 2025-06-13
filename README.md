# Advanced SQL Analysis Project

A hands-on SQL project focused on extracting business insights from structured sales, customer, and product data using Microsoft SQL Server and SSMS.

## Project Structure
<pre>
sql-data-analytics-project/
├── datasets/
│   └── csv-files/
│       ├── gold.fact_sales.xlsx
│       ├── gold.dim_customers.xlsx
│       └── gold.dim_products.xlsx
├── scripts/
│   ├── SQLQuery-change-over-time.sql
│   ├── SQLQuery-cumulative-analysis.sql
│   ├── SQLQuery-performance-analysis.sql
│   ├── SQLQuery-PART-TO-WHOLE.sql
│   ├── SQLQuery-data_segmentation.sql
│   ├── SQLQuery-TASK.sql
│   └── SQLQuery-FINALREPORT.sql
├── README.md
</pre>
</details>

------------------------------------------------------------------------

## 🧾 Dataset Overview

- **Schema used**: `gold`
- **Tables involved**:
  - `gold.fact_sales`: Transaction-level sales data
  - `gold.dim_customers`: Customer demographics and metadata
  - `gold.dim_products`: Product catalog with cost, category, etc.

-------------------------------------------------------------------------

## 🔍 SQL Tasks & Insights

### 1. 📆 Sales Over Time
Analyzed trends in sales revenue, new customer acquisition, and quantity sold over months and years using `DATETRUNC`, `FORMAT`, and aggregations.

### 2. 📊 Cumulative Sales & Moving Average
Calculated running total sales and moving average prices over time using `WINDOW FUNCTIONS` such as `SUM() OVER`, `AVG() OVER`.

### 3. 🚀 Product Performance
Compared each product’s yearly performance with:
- Their **average historical sales**
- Their **previous year’s sales**

Categorized results into `INCREASE`, `DECREASE`, or `NO CHANGE`.

### 4. 📦 Category Contribution (Part-to-whole)
Identified which product categories contribute the most to total revenue and calculated their percentage share.

### 5. 💸 Product Segmentation
Grouped products into price segments (`<100`, `100-500`, `500-1000`, `>1000`) to understand cost distribution across the catalog.

### 6. 🧍‍♀️ Final Customer Report (`FINALREPORT.sql`)
Created a detailed customer view `gold.report_customerz` to derive:
- Customer segmentation: `VIP`, `REGULAR`, `NEW`
- KPIs: total sales, quantity, lifespan, recency, avg. monthly spend, etc.
- Age group classification

### 7. ✅ Task Summary
Counted number of customers by KYC segment using the customer report view.

-----------------------------------------------------------------------------

## ⚙️ Tools Used

- **DBMS**: Microsoft SQL Server 2022  
- **IDE**: SQL Server Management Studio (SSMS)  
- **Language**: T-SQL (Transact-SQL)  
- **Data Format**: Excel `.xlsx`  

----------------------------------------------------------------------------

## 🧠 Learning Outcomes

- SQL querying and view creation
- Joins, window functions, aggregations
- Business analysis with segmentation and KPI computation
- Building cumulative logic and historical comparisons

----------------------------------------------------------------------------

## 🙋‍♀️ About Me

**Sneha Nair**  
B.E. AI & Data Science | SIES GST, Nerul  
[LinkedIn](www.linkedin.com/in/snehasantoshnair)

----------------------------------------------------------------------------

## 🚫 License

This project is for academic and demonstration purposes only.


