
# Indian E-Commerce Sales Analysis
![Uploading WhatsApp Image 2026-09-11 at 10.51.41 AM.jpeg…]()

## Overview
End-to-end data analysis project on 200,000+ Indian e-commerce 
transactions across 3 connected tables using Python, MySQL and Power BI.

## Tools Used
- Python (Pandas) - Data Cleaning
- MySQL - Data Analysis  
- Power BI - Interactive Dashboard

## Dataset
Kaggle - Indian E-Commerce Sales Dataset

## Project Workflow
Python → MySQL → Power BI

## Python - Data Cleaning
- Customers (40,000 rows) - date formats corrected
- Products (2,000 rows) - minimal cleaning needed
- Sales (200,000 rows) - nulls handled, dates corrected

## SQL - Key Findings
1. October 2025 had highest monthly revenue — festive season peak
2. Uttar Pradesh generates highest state revenue
3. UPI is most popular payment mode
4. Heavy discounts (50%) not driving sales for several products
5. Average delivery time is 4-5 days across India
6. Customers without coupons spend more per order than coupon users

## Power BI Dashboard

### Page 1 - Sales Overview

<img width="1311" height="735" alt="Screenshot 2026-09-09 090920" src="https://github.com/user-attachments/assets/cbd28300-82e0-4f4c-acac-6b58b7bcb037" />

Findings:- 
- Total orders: 250K across 3 years (2024-2026)
- Total revenue: ₹5.93 billion
- Average order value: ₹23.97K
- Total unique customers: 39.914K
- UP is highest revenue generating state
- Top 5 states: UP, Rajasthan, Haryana, Maharashtra, Punjab
- Revenue trend shows fluctuation with peaks around Oct 2025
### Page 2 - Customer Analysis

<img width="1306" height="736" alt="Screenshot 2026-09-09 090959" src="https://github.com/user-attachments/assets/b70b2b09-4332-4aa7-9cb2-77594c9ed6e7" />

Findings:-
- Platinum tire dominates with 68.37% of customers
- Age group 26-35 shops most frequently
- Average revenue is ₹23.72K
- Pooja Shah is highest spending customer
### Page 3 - Product and category

<img width="1319" height="745" alt="Screenshot 2026-09-09 091012" src="https://github.com/user-attachments/assets/56298bee-faa1-4deb-a6e3-d6f7f0febee5" />

Findings:-
- Electronics dominates revenue by far (₹4bn+)
- Home and Sports follow distantly
- Books and Beauty generate least revenue
- Yoga Mat is best selling product (multiple versions in top 10!)
- Average discount across all products is 27.47%
- Scatter plot shows no clear relationship between 
  discount % and units sold
- Total unique products: 2K
### Page 4 - Delivery and Operations

<img width="1311" height="732" alt="Screenshot 2026-09-09 091027" src="https://github.com/user-attachments/assets/ec62b81c-772a-4c3d-965b-f113914f2204" />

Findings:-
- 80.06% of orders successfully delivered (200.14K orders)
- Average delivery time is 4.50 days across India
- Gujarat and Haryana have slowest delivery times
- Delhi has fastest delivery among top states
- Shipping costs are consistent across all order statuses
- 5% cancelled and 5% returned orders
### Page 5 - Coupon and Payment Analysis

<img width="1308" height="738" alt="Screenshot 2026-09-09 091040" src="https://github.com/user-attachments/assets/8bb34f86-07eb-4fa0-b5be-f74185cfd835" />

Findings:-
- 79.93% orders placed without coupon (199.82K orders)
- Only 20.07% orders used coupons (50.19K orders)
- Average order value is ₹23.89K overall
- Average coupon discount given is ₹250
- UPI is most popular payment mode by far
- COD is second most popular
- Credit Card least used payment method
- Non-coupon users have higher average order value 
  than coupon users
