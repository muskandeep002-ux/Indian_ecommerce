-- Indian E-Commerce Sales Analysis
-- Tools: MySQL
-- Author: Muskan Deep

create database ecommerce;
USE ecommerce;

-- Data cleaning
ALTER TABLE customers_cleaned
MODIFY COLUMN registration_date VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;
UPDATE customers_cleaned
SET registration_date = STR_TO_DATE(registration_date, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;
ALTER TABLE customers_cleaned
MODIFY COLUMN registration_date DATE;

ALTER TABLE customers_cleaned
MODIFY COLUMN date_of_birth VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;
UPDATE customers_cleaned
SET date_of_birth = STR_TO_DATE(date_of_birth, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;
ALTER TABLE customers_cleaned
MODIFY COLUMN date_of_birth DATE;

SET SQL_SAFE_UPDATES = 0;
ALTER TABLE sales_cleaned
MODIFY COLUMN order_date DATE;
ALTER TABLE sales_cleaned
MODIFY COLUMN delivery_date DATE;
ALTER TABLE sales_cleaned
MODIFY COLUMN order_time TIME;
SET SQL_SAFE_UPDATES = 1;

-- Setting up the foregin key and primary key
ALTER TABLE sales_cleaned
MODIFY COLUMN customer_id VARCHAR(50),
MODIFY COLUMN product_id VARCHAR(50);

ALTER TABLE customers_cleaned
MODIFY COLUMN customer_id VARCHAR(50);

ALTER TABLE products_cleaned
MODIFY COLUMN product_id VARCHAR(50);

ALTER TABLE customers_cleaned
ADD PRIMARY KEY (customer_id);

ALTER TABLE products_cleaned
ADD PRIMARY KEY (product_id);
ALTER TABLE sales_cleaned
ADD FOREIGN KEY (customer_id) REFERENCES customers_cleaned(customer_id),
ADD FOREIGN KEY (product_id) REFERENCES products_cleaned(product_id);

-- Analysis
-- sales performence
-- Q1 — Total revenue, total orders, average order value by month:
select * from sales_cleaned;
select month(order_date) as month, year(order_date) as year, 
round(sum(total_amount),2) as total_revenue,
round(avg(total_amount),2) as avg_order_value, 
count(order_id) as total_orders
from sales_cleaned
group by  year(order_date), month(order_date)
order by  year(order_date), month(order_date);

-- Q2— Which state generates highest revenue?
select * from sales_cleaned;
select state, round(sum(total_amount),2) as total_revenue
from sales_cleaned
group by state
order by total_revenue desc
limit 5;

-- Q3 Which payment mode is most popular and highest value?
select * from sales_cleaned;
select payment_mode, count(order_id) as total_orders,
round(sum(total_amount),2) as total_revenue,
round(avg(total_amount),2) as avg_order_value
from sales_cleaned
group by payment_mode
order by total_orders desc;

-- products analysis
-- Q4 Top 10 best selling products by quantity
SELECT 
    p.product_name,
    p.category,
    p.brand,
    SUM(s.quantity) AS total_quantity_sold,
    ROUND(SUM(s.total_amount), 2) AS total_revenue
FROM sales_cleaned s
JOIN products_cleaned p 
    ON s.product_id = p.product_id
GROUP BY p.product_name, p.category, p.brand
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- Q5 Which category generates most revenue?
with higest_revenue as(
select sum(s.total_amount) as total_revenue, p.category
from sales_cleaned s join products_cleaned p 
on s.product_id= p.product_id
group by p.category)
select category, total_revenue
from higest_revenue
order by total_revenue desc
limit 1;

-- Q6 Products with high discount but low sales — are discounts working
WITH discount_sales AS (
    SELECT 
        p.product_name,
        p.category,
        p.discount_percent,
        SUM(s.quantity) AS total_sold
    FROM products_cleaned p
    JOIN sales_cleaned s ON p.product_id = s.product_id
    GROUP BY p.product_name, p.category, p.discount_percent
)
SELECT * FROM discount_sales
WHERE discount_percent > 20 
AND total_sold < 500
ORDER BY discount_percent DESC
LIMIT 10;

-- Customer analysis
-- Q7 Top 10 customers by spending
SELECT 
    c.customer_name,
    ROUND(SUM(s.total_amount), 2) AS total_spent
FROM customers_cleaned c
JOIN sales_cleaned s ON c.customer_id = s.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 10;
 
--  Q8 Customer tier vs spending
select customer_tier, round(sum(total_spent),2) as total_spent
from customers_cleaned
group by customer_tier
order by total_spent desc;

-- Q9 Age group shopping frequency
SELECT 
    c.age_group,
    COUNT(s.order_id) AS frequency_of_shopping
FROM customers_cleaned c
JOIN sales_cleaned s ON c.customer_id = s.customer_id
GROUP BY c.age_group
ORDER BY frequency_of_shopping DESC;
 
-- Q10 delivery performance by state
WITH delivery_time AS (
    SELECT 
        state,
        DATEDIFF(delivery_date, order_date) AS days_to_deliver
    FROM sales_cleaned
)
SELECT 
    state,
    ROUND(AVG(days_to_deliver), 1) AS avg_delivery_days,
    RANK() OVER (ORDER BY AVG(days_to_deliver)) AS delivery_rank
FROM delivery_time
GROUP BY state
ORDER BY avg_delivery_days;

-- Q11 running total revenue by month
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(total_amount), 2) AS monthly_revenue,
    ROUND(SUM(SUM(total_amount)) OVER (
        PARTITION BY YEAR(order_date) 
        ORDER BY MONTH(order_date)
    ), 2) AS running_total
FROM sales_cleaned
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- Q12 Coupon impact analysis
SELECT 
    CASE 
        WHEN coupon_code != 'No Coupon' THEN 'With Coupon'
        ELSE 'Without Coupon'
    END AS coupon_usage,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(coupon_discount), 2) AS avg_discount_given
FROM sales_cleaned
GROUP BY coupon_usage
ORDER BY avg_order_value DESC;

