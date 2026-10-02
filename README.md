# 📊 E-Commerce Sales & Customer Retention Analytics

## 📌 Project Overview

This project presents an end-to-end **E-Commerce Data Analytics solution** focused on analyzing sales performance, customer retention, product performance, revenue trends, and operational activities.

The project transforms raw and unstructured e-commerce transaction data into meaningful analytical outputs using **MySQL, Python, and Power BI**.

The complete workflow follows:

**Raw Data → Data Cleaning → SQL Analysis → Python EDA → Power BI Dashboard → Business Insights**

---

## 🎯 Business Objectives

The analysis focuses on understanding key business areas, including:

- Revenue and overall sales performance
- Monthly and geographical sales trends
- Customer retention and repeat-purchase behavior
- Product and category performance
- Discount and pricing impact
- Payment and shipping operations
- Customer and product rankings

---

## 🗂️ Dataset

The project contains multiple datasets covering customers, products, and sales transactions.

| Dataset | Records |
|---|---:|
| Customers | 500 |
| Products | 100 |
| Cleaned Sales Transactions | 5,000 |
| Original Sales Transactions | 5,006 |

The datasets contain **20 unique columns** across the three source tables.

---

## 🧹 Data Cleaning & Preparation

The raw data was cleaned and prepared to improve data quality and ensure reliable analysis.

Key data-cleaning activities include:

- Missing-value handling
- Duplicate transaction and customer-record handling
- Date standardization
- Country, customer segment, payment and shipping normalization
- Numeric type conversion
- Negative quantity and price validation
- Discount anomaly handling
- Revenue recalculation using price × quantity × discount
- Referential integrity checks

---

## 📊 Analytical Areas

### 💰 Sales Analytics
- Revenue and sales performance
- Monthly sales trends
- Country-wise performance
- KPI analysis

### 👥 Customer Analytics
- Customer ranking
- Repeat-customer analysis
- Customer retention
- Retention segmentation

### 📦 Product & Category Analytics
- Product performance and ranking
- Category profitability
- Discount analysis

### 🚚 Operations Analytics
- Payment method analysis
- Shipping activities
- Operational performance

---

## 🔍 Analysis Performed

### SQL Analysis

MySQL was used for structured data analysis and business-level querying, including:

- KPI aggregation
- Monthly trend analysis
- Country performance analysis
- Product ranking
- Customer ranking
- Repeat-customer analysis
- Category profitability analysis

### Python Analysis

Python was used for:

- Data validation
- Exploratory Data Analysis (EDA)
- KPI analysis
- Customer retention segmentation
- Trend visualization

### Power BI Dashboard

The final analysis was presented through an interactive Power BI dashboard consisting of:

- **Executive Overview**
- **Customer Retention**
- **Product & Category Analysis**
- **Operations Analysis**

---

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **MySQL** | Data querying and analysis |
| **Python** | Data validation, EDA and visualization |
| **Pandas** | Data manipulation and analysis |
| **NumPy** | Numerical operations |
| **Matplotlib** | Data visualization |
| **Power BI** | Interactive dashboards and reporting |
| **CSV / Excel** | Data storage and preparation |

---

## 🔄 Project Workflow

```text
Raw E-Commerce Data
        ↓
Data Cleaning & Validation
        ↓
SQL Analysis
        ↓
Python Exploratory Data Analysis
        ↓
Power BI Dashboard
        ↓
Business Insights
