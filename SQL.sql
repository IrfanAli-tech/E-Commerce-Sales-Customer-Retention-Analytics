CREATE DATABASE IF NOT EXISTS ecommerce_global_analytics;
USE ecommerce_global_analytics;

CREATE TABLE customers (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(150),
    Signup_Date DATE,
    Country VARCHAR(50),
    Segment VARCHAR(50)
);

CREATE TABLE products (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Product_Name VARCHAR(150),
    Category VARCHAR(100),
    Price DECIMAL(12,2),
    Cost DECIMAL(12,2)
);

CREATE TABLE sales_transactions (
    Transaction_ID VARCHAR(30) PRIMARY KEY,
    Customer_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Order_Date DATE,
    Quantity INT,
    Discount_Percent DECIMAL(6,2),
    Payment_Method VARCHAR(50),
    Shipping_Status VARCHAR(50),
    Sales_Amount DECIMAL(14,2),
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
);

-- Executive KPIs
SELECT
    ROUND(SUM(Sales_Amount),2) AS Revenue,
    COUNT(DISTINCT Transaction_ID) AS Orders,
    COUNT(DISTINCT Customer_ID) AS Customers,
    SUM(Quantity) AS Units,
    ROUND(SUM(Sales_Amount)/COUNT(DISTINCT Transaction_ID),2) AS AOV
FROM sales_transactions;

-- Monthly revenue trend
SELECT
    DATE_FORMAT(Order_Date,'%Y-%m') AS Month,
    ROUND(SUM(Sales_Amount),2) AS Revenue,
    COUNT(DISTINCT Transaction_ID) AS Orders
FROM sales_transactions
GROUP BY DATE_FORMAT(Order_Date,'%Y-%m')
ORDER BY Month;

-- Country performance
SELECT
    c.Country,
    ROUND(SUM(s.Sales_Amount),2) AS Revenue,
    COUNT(DISTINCT s.Transaction_ID) AS Orders,
    COUNT(DISTINCT s.Customer_ID) AS Customers
FROM sales_transactions s
JOIN customers c ON s.Customer_ID=c.Customer_ID
GROUP BY c.Country
ORDER BY Revenue DESC;

-- Product performance
SELECT
    p.Product_Name,
    p.Category,
    ROUND(SUM(s.Sales_Amount),2) AS Revenue,
    SUM(s.Quantity) AS Units,
    COUNT(DISTINCT s.Transaction_ID) AS Orders
FROM sales_transactions s
JOIN products p ON s.Product_ID=p.Product_ID
GROUP BY p.Product_ID, p.Product_Name, p.Category
ORDER BY Revenue DESC
LIMIT 10;

-- Repeat vs one-time customers
WITH customer_orders AS (
    SELECT Customer_ID, COUNT(DISTINCT Transaction_ID) AS Orders
    FROM sales_transactions
    GROUP BY Customer_ID
)
SELECT
    CASE WHEN Orders > 1 THEN 'Repeat' ELSE 'One-Time' END AS Customer_Type,
    COUNT(*) AS Customers
FROM customer_orders
GROUP BY Customer_Type;

-- Customer revenue ranking
SELECT
    Customer_ID,
    ROUND(SUM(Sales_Amount),2) AS Revenue,
    COUNT(DISTINCT Transaction_ID) AS Orders,
    DENSE_RANK() OVER (ORDER BY SUM(Sales_Amount) DESC) AS Revenue_Rank
FROM sales_transactions
GROUP BY Customer_ID
ORDER BY Revenue_Rank;

-- Category profitability
SELECT
    p.Category,
    ROUND(SUM(s.Sales_Amount),2) AS Revenue,
    ROUND(SUM(s.Quantity * p.Cost),2) AS Cost,
    ROUND(SUM(s.Sales_Amount - s.Quantity * p.Cost),2) AS Profit
FROM sales_transactions s
JOIN products p ON s.Product_ID=p.Product_ID
GROUP BY p.Category
ORDER BY Profit DESC;
