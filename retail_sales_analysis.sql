/*
========================================
RETAIL SALES ANALYSIS USING SQL
========================================

Objective:
Analyze retail sales transactions to identify
customer behavior, product performance,
and sales trends.

Dataset Size: 1,000+ Records

Tools Used:
- MySQL
- MySQL Workbench
*/

-- ====================================
-- DATA EXPLORATION
-- ====================================

-- Total Records
SELECT COUNT(*) AS total_records

FROM retail_sales_dataset;

-- Date Range
SELECT MIN(Date) AS start_date,
       MAX(Date) AS end_date
FROM retail_sales_dataset;

-- Product Categories
SELECT DISTINCT `Product Category`
FROM retail_sales_dataset;

-- ====================================
-- DATA CLEANING
-- ====================================

-- Check for Null Values

SELECT *
FROM retail_sales_dataset
WHERE `Transaction ID` IS NULL
   OR Date IS NULL
   OR `Customer ID` IS NULL
   OR Gender IS NULL
   OR Age IS NULL
   OR `Product Category` IS NULL
   OR Quantity IS NULL
   OR `Price per Unit` IS NULL
   OR `Total Amount` IS NULL;

-- Check for Duplicate Transactions

SELECT `Transaction ID`,
       COUNT(*) AS duplicate_count
FROM retail_sales_dataset
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1;

-- ====================================
-- SALES ANALYSIS
-- ====================================

-- Total Revenue

SELECT SUM(`Total Amount`) AS total_revenue
FROM retail_sales_dataset;

-- Average Order Value

SELECT AVG(`Total Amount`) AS avg_order_value
FROM retail_sales_dataset;

-- Total Quantity Sold

SELECT SUM(Quantity) AS total_items_sold
FROM retail_sales_dataset;

-- Revenue by Product Category

SELECT `Product Category`,SUM(`Total Amount`) AS revenue
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY revenue DESC;

-- Top 5 Best-Selling Products

SELECT `Product Category`,
       SUM(Quantity) AS total_quantity
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY total_quantity DESC
LIMIT 5;

-- Monthly Sales Trend

SELECT DATE_FORMAT(Date, '%Y-%m') AS month,
       SUM(`Total Amount`) AS monthly_revenue
FROM retail_sales_dataset
GROUP BY month
ORDER BY month;

-- ====================================
-- CUSTOMER ANALYSIS
-- ====================================

-- Total Unique Customers

SELECT COUNT(DISTINCT `Customer ID`) AS total_customers
FROM retail_sales_dataset;

-- Top Customers by Spending

SELECT `Customer ID`,
       SUM(`Total Amount`) AS total_spent
FROM retail_sales_dataset
GROUP BY `Customer ID`
ORDER BY total_spent DESC
LIMIT 10;

-- Customer Purchase Frequency

SELECT `Customer ID`,
       COUNT(*) AS total_orders
FROM retail_sales_dataset
GROUP BY `Customer ID`
ORDER BY total_orders DESC;

-- Spending by Gender

SELECT Gender,
       SUM(`Total Amount`) AS total_spent
FROM retail_sales_dataset
GROUP BY Gender;

-- Average Spend by Age Group

SELECT
  CASE
    WHEN Age < 20 THEN 'Teen'
    WHEN Age BETWEEN 20 AND 29 THEN '20s'
    WHEN Age BETWEEN 30 AND 39 THEN '30s'
    WHEN Age BETWEEN 40 AND 49 THEN '40s'
    ELSE '50+'
  END AS age_group,
  AVG(`Total Amount`) AS avg_spent
FROM retail_sales_dataset
GROUP BY age_group
ORDER BY age_group;

-- ====================================
-- PRODUCT PERFORMANCE 
-- ====================================

-- Most Profitable Categories

SELECT `Product Category`,
       SUM(`Total Amount`) AS revenue
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY revenue DESC;

-- High Quantity vs High Revenue Insight

SELECT `Product Category`,
       SUM(Quantity) AS total_qty,
       SUM(`Total Amount`) AS revenue
FROM retail_sales_dataset
GROUP BY `Product Category`
ORDER BY revenue DESC;
