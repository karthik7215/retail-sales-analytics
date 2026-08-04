# 🛒 Retail Sales Analytics — End-to-End Data Project

An end-to-end data analytics project on 541,909 real UK e-commerce transactions.
This project covers the full analytics pipeline: raw messy data → Python cleaning → SQL analysis → Power BI dashboard.

---

## 📌 Project Objective

To analyse retail sales performance across products, regions, and time periods —
and surface actionable business insights from a real-world dataset that required
significant cleaning before it could be trusted.

---

## 🗂️ Dataset

- **Source:** [UCI Online Retail Dataset](https://archive.ics.uci.edu/dataset/352/online+retail) — publicly available
- **Period:** December 2010 – December 2011
- **Size:** 541,909 rows × 8 columns
- **Content:** Invoices, products, quantities, prices, customers, countries

> **Note:** The raw and cleaned CSV files are not included in this repository as they exceed GitHub's 25MB file limit.
> Download the original dataset directly from the [UCI Machine Learning Repository](https://archive.ics.uci.edu/dataset/352/online+retail),
> then run `python/clean_data.py` to reproduce the cleaned version (524,878 rows) locally.

### Raw Data Issues Found

| Problem | Count | Decision |
|---|---|---|
| Duplicate rows | 5,268 | Dropped — exact byte-for-byte copies |
| Missing CustomerID | 135,080 | Labelled as "Guest" — still useful for revenue analysis |
| Missing Descriptions | 1,454 | Filled as "UNKNOWN ITEM" — StockCode still valid |
| Cancelled invoices (prefix 'C') | 9,251 | Separated into own table — real business events |
| Unexplained negative quantities | 1,336 | Dropped — likely stock adjustments, not real sales |
| Zero / negative unit prices | 1,176 | Dropped — manual entries with no revenue value |

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| **Python (pandas)** | Data cleaning and transformation |
| **SQL (SQLite)** | KPI queries and business metric extraction |
| **Excel** | Pivot table cross-validation of key metrics |
| **Power BI** | Interactive dashboard |

---

## 📁 Project Structure

```
sales-analytics-project/
│
├── python/
│   └── clean_data.py                       ← cleaning script with documented decisions
│
├── sql/
│   └── queries.sql                         ← 6 business KPI queries
│
├── powerbi/
│   └── dashboard.pbix                      ← interactive Power BI dashboard
│
├── .gitignore                              ← excludes large CSV files
└── README.md
```

> **data/ folder is excluded via .gitignore** — CSV files exceed GitHub's 25MB limit.
> Download the dataset from UCI and run `clean_data.py` to reproduce them locally.

---

## 🔍 Key SQL Insights

- 📈 **Peak month:** November 2011 — highest revenue of the year
- 🏆 **Top product:** DOTCOM POSTAGE — £206,248 in revenue
- 🌍 **Top market:** United Kingdom — 84.6% of total revenue
- 👤 **Guest checkouts:** £1.75M in revenue (16% of total) — not to be ignored
- 📅 **Best day:** Thursday — consistently highest order volume

---

## 📊 Dashboard KPIs (Power BI)

- Monthly revenue trend (line chart)
- Revenue by country (bar chart)
- Top 10 products by revenue (bar chart)
- Guest vs Registered customer split (donut chart)
- Revenue by day of week (column chart)
- Filters: Date range, Country, Customer type, Product description

---

## 💡 Business Recommendations

1. **Focus retention efforts on the UK market** — it drives 85% of revenue but also represents the biggest churn risk.
2. **Investigate guest checkouts** — £1.75M in revenue from unidentified customers is an opportunity for loyalty/email capture.
3. **Stock up before November** — clear seasonal spike every year suggests inventory should be optimised by October.

---

## 🚀 How to Run

```bash
# 1. Clone this repository
git clone https://github.com/YOUR_USERNAME/sales-analytics-project.git

# 2. Download the dataset from UCI
# https://archive.ics.uci.edu/dataset/352/online+retail
# Save the file as: data/online_retail_raw.csv

# 3. Install dependencies
pip install pandas

# 4. Run the cleaning script — produces cleaned CSV and cancellations CSV
python python/clean_data.py

# 5. Open queries.sql in any SQL client (SQLite, DBeaver, DB Browser, etc.)

# 6. Open powerbi/dashboard.pbix in Power BI Desktop
```

---

## 📄 .gitignore

The following large files are excluded from this repository:

```
data/online_retail_raw.csv
data/online_retail_cleaned.csv
data/online_retail_cancellations.csv
```

---

## 👤 Author

**Goje Karthik**
[LinkedIn](https://linkedin.com/in/karthik-goje-86778828a) · [GitHub](https://github.com/karthik7215)
