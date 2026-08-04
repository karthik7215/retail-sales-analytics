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

- **Source:** UCI Online Retail Dataset (publicly available)
- **Period:** December 2010 – December 2011
- **Size:** 541,909 rows × 8 columns
- **Content:** Invoices, products, quantities, prices, customers, countries

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
| **Power BI / Tableau** | Interactive dashboard |

---

## 📁 Project Structure

```
sales-analytics-project/
│
├── data/
│   ├── online_retail_raw.csv               ← original messy dataset
│   ├── online_retail_cleaned.csv           ← cleaned sales data (524,878 rows)
│   └── online_retail_cancellations.csv     ← separated cancellations (9,251 rows)
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
└── README.md
```

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
- Revenue by country (map visual)
- Top 10 products by revenue (bar chart)
- Guest vs Registered customer split (donut chart)
- Revenue by day of week (column chart)
- Filters: Date range, Country, Customer type

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

# 2. Install dependencies
pip install pandas

# 3. Run the cleaning script
python python/clean_data.py

# 4. Open queries.sql in any SQL client (SQLite, DBeaver, etc.)

# 5. Open powerbi/dashboard.pbix in Power BI Desktop
```

---

## 👤 Author

**Goje Karthik**
[LinkedIn](https://linkedin.com/in/karthik-goje-86778828a) · [GitHub](https://github.com/karthik7215)
