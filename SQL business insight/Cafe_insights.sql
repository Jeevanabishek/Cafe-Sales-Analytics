-- CAFE SALES INSIGHTS - SQL ANALYSIS
-- Database: cafe_data | Table : cafe | Records : 9,946
-- Purpose: Extract business insights to support operational and strategic decision-making for cafe management

use cafe_data

--Query 1. Top 5 selling items by revenue and by units sold
--Business question: Which products are driving the most revenue?
--Business use: Prioritize high-revenue items in menu promotions and ensure consistent stock availability

SELECT Top 5 item,
       SUM(recalculated_total_amt) AS revenue,
       SUM(quantity) AS units_sold
FROM cafe
GROUP BY item
ORDER BY revenue DESC;

--Query 2. Total revenue and transaction count (overall and by month-wise)
--Business question: Are there seasonal peaks or slow months in 2025?
--Business use: Plan staffing levels and inventory procurement around high and low demand periods

SELECT 
  YEAR(transaction_date) AS year,
  MONTH(transaction_date) AS month,
  COUNT(*) AS transactions,
  SUM(recalculated_total_amt) AS revenue
FROM cafe
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY year, month;

--Query 3. Total revenue on each products based on Service type
--Business question: Which items sell best through In-store vs Takeaway?
--Business use: Tailor menu offerings and promotions per service channel to maximize revenue

SELECT service_type, item,
       COUNT(*) AS count,
       SUM(recalculated_total_amt) AS revenue
FROM cafe
GROUP BY service_type,item
ORDER BY service_type, revenue DESC;

--Query 4. Total revenue based on Service type
--Business question: Which service channel generates the most revenue?
--Business use: Decide where to invest - In-store experience improvements vs Takeaway/delivery infrastructure

SELECT service_type,
       COUNT(*) AS count,
       SUM(recalculated_total_amt) AS revenue
FROM cafe
GROUP BY service_type;

--Query 5. Transaction counts based on service type & payment method
--Business question: How do customers prefer to pay across service channels?
--Business use: Optimize POS terminal setup — ensure enough card machines for Takeaway, cash handling for In-store

SELECT service_type,
       payment_method,
       COUNT(*) AS transaction_count
FROM cafe
GROUP BY service_type, payment_method
ORDER BY service_type, payment_method, transaction_count DESC;

--Query 6. Average order value per item
--Business question: What is the typical spend when a customer orders each item?
--Business use: Use avg order value benchmarks to design combo deals and upselling strategies per product

SELECT item,
       AVG(recalculated_total_amt) AS avg_order_value,
       AVG(price_per_unit) AS avg_unit_price
FROM cafe
WHERE item IS NOT NULL AND recalculated_total_amt > 0
GROUP BY item
ORDER BY avg_order_value DESC;

--Query 7. Payment methods with significant volume only
--Business question: Which payment methods are genuinely popular vs rarely used?
--Business use: Removes noise from rare payment types in reporting & helps decide which payment infrastructure to maintain

SELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    SUM(recalculated_total_amt) AS total_revenue
FROM cafe
WHERE payment_method != 'Unknown'
GROUP BY payment_method
HAVING COUNT(*) > 500
ORDER BY transaction_count DESC;

