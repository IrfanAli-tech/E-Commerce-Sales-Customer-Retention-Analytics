# Power BI Dashboard

## Data Model
Use a star-schema style model:

- Fact_Sales -> sales_transactions_cleaned
- Dim_Customer -> customers_cleaned
- Dim_Product -> products_cleaned
- Optional Dim_Date -> calendar table

Relationships:
Fact_Sales[Customer_ID] -> Dim_Customer[Customer_ID]
Fact_Sales[Product_ID] -> Dim_Product[Product_ID]

## Core DAX

Total Revenue =
SUM(Fact_Sales[Sales_Amount])

Total Orders =
DISTINCTCOUNT(Fact_Sales[Transaction_ID])

Total Customers =
DISTINCTCOUNT(Fact_Sales[Customer_ID])

Total Units =
SUM(Fact_Sales[Quantity])

Average Order Value =
DIVIDE([Total Revenue], [Total Orders])

Repeat Customers =
COUNTROWS(
    FILTER(
        VALUES(Fact_Sales[Customer_ID]),
        CALCULATE(DISTINCTCOUNT(Fact_Sales[Transaction_ID])) > 1
    )
)

One-Time Customers =
COUNTROWS(
    FILTER(
        VALUES(Fact_Sales[Customer_ID]),
        CALCULATE(DISTINCTCOUNT(Fact_Sales[Transaction_ID])) = 1
    )
)

Repeat Customer Rate =
DIVIDE([Repeat Customers], [Total Customers])

## Dashboard Pages

### 1. Executive Overview
Cards: Revenue, Orders, Customers, AOV
Charts: Monthly Revenue, Revenue by Country, Top Products

### 2. Customer Retention
Repeat vs One-Time, Customer Revenue Ranking, Orders per Customer, Recency distribution

### 3. Product & Category
Revenue by Category, Profit by Category, Top 10 Products, Units Sold

### 4. Operations
Shipping Status, Payment Method, Discount Distribution, Cancelled/Returned orders
