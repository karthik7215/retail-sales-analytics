"""
Online Retail Sales Data Cleaning
Dataset: UCI Online Retail Dataset (UK e-commerce, Dec 2010 - Dec 2011)
Goal: Produce an analysis-ready dataset for SQL/Power BI, with documented
cleaning decisions (the part recruiters actually ask about in interviews).
"""

import pandas as pd

# --- 1. Load ---
df = pd.read_csv("online_retail_raw.csv", encoding="latin1")
print(f"Raw rows: {len(df):,}")

# --- 2. Remove exact duplicate rows ---
# 5,268 rows are byte-for-byte duplicates (likely double-scanned or re-exported).
# Safe to drop outright, no information lost.
df = df.drop_duplicates()
print(f"After removing duplicates: {len(df):,}")

# --- 3. Fix data types ---
df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"], format="%m/%d/%Y %H:%M")

# --- 4. Separate cancellations from genuine data errors ---
# Invoice numbers starting with 'C' are real cancellations, this is a
# legitimate business event (a customer returned an order), not bad data.
# We keep these in their own table for return-rate analysis instead of
# deleting them, since "what % of revenue is refunded" is a real KPI.
df["IsCancellation"] = df["InvoiceNo"].astype(str).str.startswith("C")
cancellations = df[df["IsCancellation"]].copy()
sales = df[~df["IsCancellation"]].copy()
print(f"Cancellations separated out: {len(cancellations):,}")

# --- 5. Drop rows that are negative quantity but NOT a cancellation ---
# These are unexplained negative values, likely stock adjustments or
# data entry errors, not real sales or returns. Dropping ~1,300 rows here.
bad_qty = (sales["Quantity"] < 0)
print(f"Unexplained negative-quantity rows dropped: {bad_qty.sum():,}")
sales = sales[~bad_qty]

# --- 6. Drop zero/negative unit price rows ---
# These are mostly "adjustment", "sample", or "manual" entries with no
# real price, not useful for revenue analysis.
bad_price = (sales["UnitPrice"] <= 0)
print(f"Zero/negative price rows dropped: {bad_price.sum():,}")
sales = sales[~bad_price]

# --- 7. Handle missing CustomerID ---
# 25% of rows have no CustomerID. Dropping them would erase a quarter of
# revenue, so instead we keep them and label them as "Guest" checkouts.
# This is flagged clearly so anyone using the dataset knows these can't
# be used for customer-level analysis (e.g. segmentation, repeat-purchase
# rate), only for aggregate revenue/product analysis.
sales["CustomerID"] = sales["CustomerID"].fillna(0).astype(int)
sales["CustomerType"] = sales["CustomerID"].apply(lambda x: "Guest" if x == 0 else "Registered")

# --- 8. Handle missing product descriptions ---
# Small number of rows (~1,450), and the StockCode is still present, so we
# label them rather than drop, the row still has valid sales value.
sales["Description"] = sales["Description"].fillna("UNKNOWN ITEM")

# --- 9. Add computed business metric ---
sales["TotalPrice"] = sales["Quantity"] * sales["UnitPrice"]

# --- 10. Save outputs ---
sales.to_csv("online_retail_cleaned.csv", index=False)
cancellations.to_csv("online_retail_cancellations.csv", index=False)

print()
print(f"Final clean sales rows: {len(sales):,}")
print(f"Total revenue represented: £{sales['TotalPrice'].sum():,.0f}")
print(f"Guest checkout revenue: £{sales[sales['CustomerType']=='Guest']['TotalPrice'].sum():,.0f}")
