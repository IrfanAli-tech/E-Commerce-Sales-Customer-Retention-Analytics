import pandas as pd
import matplotlib.pyplot as plt

DATA = "../data/cleaned/sales_transactions_cleaned.csv"
df = pd.read_csv(DATA, parse_dates=["Order_Date"])

df["Month"] = df["Order_Date"].dt.to_period("M").astype(str)

total_revenue = df["Sales_Amount"].sum()
total_orders = df["Transaction_ID"].nunique()
unique_customers = df["Customer_ID"].nunique()
total_quantity = df["Quantity"].sum()
aov = total_revenue / total_orders

print("=== Executive KPIs ===")
print(f"Revenue: ${total_revenue:,.2f}")
print(f"Orders: {total_orders:,}")
print(f"Customers: {unique_customers:,}")
print(f"Quantity: {total_quantity:,}")
print(f"AOV: ${aov:,.2f}")

customer = df.groupby("Customer_ID").agg(
    Orders=("Transaction_ID","nunique"),
    Revenue=("Sales_Amount","sum"),
    Last_Order=("Order_Date","max")
).reset_index()
customer["Customer_Type"] = customer["Orders"].apply(
    lambda x: "Repeat" if x > 1 else "One-Time"
)
print("\n=== Customer Retention ===")
print(customer["Customer_Type"].value_counts())

monthly = df.groupby("Month").agg(
    Revenue=("Sales_Amount","sum"),
    Orders=("Transaction_ID","nunique")
).reset_index()

product = df.groupby("Product_ID").agg(
    Revenue=("Sales_Amount","sum"),
    Quantity=("Quantity","sum"),
    Orders=("Transaction_ID","nunique")
).sort_values("Revenue", ascending=False)

print("\n=== Top 10 Products ===")
print(product.head(10))

monthly.to_csv("../outputs/monthly_kpis_python.csv", index=False)
customer.to_csv("../outputs/customer_retention_python.csv", index=False)
product.to_csv("../outputs/product_performance_python.csv")

plt.figure(figsize=(11,5))
plt.plot(monthly["Month"], monthly["Revenue"], marker="o")
plt.xticks(rotation=45)
plt.title("Monthly Revenue Trend")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.tight_layout()
plt.savefig("../outputs/monthly_revenue_trend.png", dpi=150)
plt.close()
