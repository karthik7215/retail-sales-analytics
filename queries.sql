-- ============================================================
-- Sales Analytics Project - SQL Queries
-- Dataset: UCI Online Retail (UK E-Commerce, Dec 2010 - Dec 2011)
-- Database: SQLite (can also run on MySQL / PostgreSQL)
-- ============================================================

-- ============================================================
-- STEP 1: CREATE TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS sales (
    InvoiceNo     TEXT,
    StockCode     TEXT,
    Description   TEXT,
    Quantity      INTEGER,
    InvoiceDate   TEXT,
    UnitPrice     REAL,
    CustomerID    INTEGER,
    Country       TEXT,
    IsCancellation BOOLEAN,
    CustomerType  TEXT,
    TotalPrice    REAL
);

-- ============================================================
-- QUERY 1: Monthly Revenue Trend
-- Business question: Is the business growing month over month?
-- ============================================================

SELECT
    strftime('%Y-%m', InvoiceDate)  AS Month,
    ROUND(SUM(TotalPrice), 2)       AS Revenue,
    COUNT(DISTINCT InvoiceNo)       AS TotalOrders,
    ROUND(AVG(TotalPrice), 2)       AS AvgOrderValue
FROM sales
GROUP BY Month
ORDER BY Month;

-- ============================================================
-- QUERY 2: Top 10 Products by Revenue
-- Business question: Which products are driving the most income?
-- ============================================================

SELECT
    Description,
    SUM(Quantity)                   AS UnitsSold,
    ROUND(SUM(TotalPrice), 2)       AS Revenue,
    ROUND(AVG(UnitPrice), 2)        AS AvgUnitPrice
FROM sales
WHERE Description != 'UNKNOWN ITEM'
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 10;

-- ============================================================
-- QUERY 3: Revenue by Country
-- Business question: Which markets contribute the most?
-- ============================================================

SELECT
    Country,
    COUNT(DISTINCT CustomerID)      AS UniqueCustomers,
    COUNT(DISTINCT InvoiceNo)       AS TotalOrders,
    ROUND(SUM(TotalPrice), 2)       AS Revenue,
    ROUND(SUM(TotalPrice) * 100.0 /
        (SELECT SUM(TotalPrice) FROM sales), 2) AS RevenueSharePct
FROM sales
GROUP BY Country
ORDER BY Revenue DESC;

-- ============================================================
-- QUERY 4: Guest vs Registered Customer Revenue Split
-- Business question: How much revenue comes from non-logged-in users?
-- ============================================================

SELECT
    CustomerType,
    COUNT(DISTINCT InvoiceNo)       AS TotalOrders,
    ROUND(SUM(TotalPrice), 2)       AS Revenue,
    ROUND(AVG(TotalPrice), 2)       AS AvgOrderValue
FROM sales
GROUP BY CustomerType;

-- ============================================================
-- QUERY 5: Best Performing Day of Week
-- Business question: Which days drive the most sales?
-- ============================================================

SELECT
    CASE CAST(strftime('%w', InvoiceDate) AS INTEGER)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END                             AS DayOfWeek,
    COUNT(DISTINCT InvoiceNo)       AS Orders,
    ROUND(SUM(TotalPrice), 2)       AS Revenue
FROM sales
GROUP BY DayOfWeek
ORDER BY Revenue DESC;

-- ============================================================
-- QUERY 6: High Value Customers (Top 10)
-- Business question: Who are our most valuable customers?
-- ============================================================

SELECT
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo)       AS TotalOrders,
    ROUND(SUM(TotalPrice), 2)       AS TotalSpent,
    ROUND(AVG(TotalPrice), 2)       AS AvgOrderValue
FROM sales
WHERE CustomerType = 'Registered'
GROUP BY CustomerID
ORDER BY TotalSpent DESC
LIMIT 10;
