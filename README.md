# Cafe-Sales-Analytics

## 📌 Project Overview

This project simulates a real-world data analytics engagement for a cafe business operating across multiple service channels — In-store and Takeaway. The raw transactional data collected through the cafe's Point-of-Sale (POS) system was riddled with quality issues including missing values, corrupted entries, mismatched revenue figures, and inconsistent date formats - making it unreliable for any business decision-making.

The goal of this project was to design and implement a complete, production-ready ETL (Extract, Transform, Load) pipeline using Python and MS SQL Server, followed by a comprehensive Business Intelligence Dashboard in Power BI that enables stakeholders to make data-driven decisions on product performance, customer behaviour, revenue trends, and operational efficiency.

## ❗ Problem Statement

A cafe collects transaction data in 2025 via its POS system. Over time, the accumulated raw data developed severe quality issues across multiple columns - ERROR strings in revenue fields, UNKNOWN labels in categorical fields, NULL values in critical columns, and total amounts that did not match price × quantity calculations. With over 10,000 transactions spanning the full year 2025, the raw data was completely unsuitable for financial reporting, inventory planning, or customer behaviour analysis. The business could not answer even basic operational questions without first resolving these data integrity problems.

## 🎯 Objective

To build an end-to-end data analytics pipeline that:

- Extracts raw cafe transaction data from a CSV source (Kaggle)
- Transforms it using Python (Pandas) by handling all data quality issues systematically
- Loads the clean, structured dataset into MS SQL Server for persistent storage
- Enables SQL-based business analysis to answer critical operational questions
- Visualizes key business insights through an interactive Power BI dashboard

## 🔄 Pipeline Architecture  

```text
Kaggle (Raw CSV)
        |
        ▼
Jupyter Notebook (Python + Pandas)
├── Data Extraction
├── Exploratory Data Analysis
├── Data Cleaning & Transformation
        |
        ▼
MS SQL Server
├── cafe_data database → cafe table
├── SQL Analysis (Cafe_insights.sql)
     └── 7 business insight queries
        |
        ▼
Power BI
└── Cafe Business Intelligence Dashboard - 2025
```

## 🛠 Tech Stack

- **Data Source:** Kaggle  
- **Development Environment:** Jupyter Notebook  
- **Data Processing:** Python, Pandas, NumPy, Excel  
- **Database & Connectivity:** MS SQL Server 2022, SQLAlchemy  
- **Visualization:** Microsoft Power BI  

## 📂 Dataset Overview

**Source:** Kaggle - dirty_cafe_sales_dataset.csv

**Raw dataset:** 10,000 rows × 8 columns

| Column | Description | Issues Found |
|---|---|---|
| Transaction ID | Unique transaction identifier | None |
| Item | Product name | 333 nulls, UNKNOWN/ERROR values |
| Price Per Unit | Unit selling price | 179 nulls |
| Quantity | Units purchased | 138 nulls |
| Total Spent | Original recorded revenue | 173 nulls, ERROR strings, wrong values |
| Payment Method | Cash / Card / Digital Wallet | 2,579 nulls, UNKNOWN values |
| Order Type | In-store / Takeaway | 3,265 nulls, UNKNOWN values |
| Transaction Date | Date of transaction | 159 nulls, inconsistent formats |

## 🧹 Data Cleaning Summary

All transformations were performed in `End-to-End_ETL_Pipeline_Python_&_MS_SQL_Server.ipynb`.

| Issue | Action Taken |
|---|---|
| Column names with spaces & mixed case | Renamed to `snake_case` |
| `ERROR` / `UNKNOWN` strings in all columns | Replaced with `NaN` for uniform null handling |
| Null `item` and `price_per_unit` rows | Dropped - revenue cannot be recalculated without these |
| Null `payment_method` and `service_type` | Filled with `"Unknown"` to preserve transaction records |
| Incorrect and missing `total_amt` values | Recalculated as `price_per_unit × quantity` → stored as `recalculated_total_amt` |
| Inconsistent date formats (DD/MM/YYYY, UNKNOWN) | Standardized to `YYYY-MM-DD` |
| Null `quantity` and `total_amt` remaining | Filled with `0`; `recalculated_total_amt` is the trusted revenue column |
| Redundant `transaction_date_str` column | Dropped before loading to SQL Server |

**Final cleaned dataset:** cleaned_cafe_sales_dataset.xlsx with 9,946 rows × 9 columns

**Records dropped:** 54 rows (0.54% of total)

**New column added:** `recalculated_total_amt`

## 📊 SQL Business Insights

All queries are available in `Cafe_insights.sql`. Each query is written to answer a specific business question relevant to café operations and strategy.

**Query 1 - Top 5 items by revenue and units sold**
Identifies which products drive the most revenue and volume, used to prioritize menu promotions and stock planning.

**Query 2 - Monthly revenue trend**
Reveals seasonal peaks and slow periods across 2025, used for staffing and procurement planning.

**Query 3 - Revenue per product by service type**
Shows which items perform best through In-store versus Takeaway channels, enabling channel-specific menu strategy.

**Query 4 - Revenue by service type**
Identifies which service channel generates the most revenue overall, informing infrastructure investment decisions.

**Query 5 - Transaction count by service type and payment method**
Uncovers how customers prefer to pay across different channels, used for POS terminal optimization.

**Query 6 - Average order value per item**
Benchmarks typical customer spend per product, used to design combo deals and upselling strategies.

**Query 7 - Significant payment methods (HAVING clause)**
Filters out low-volume payment types to surface only genuinely popular methods, reducing reporting noise.

## 📈 Power BI Dashboard

**Dashboard Title:** Cafe Business Intelligence Dashboard - 2025

All dashboards are available in `Cafe Business Intelligence Dashboard.pbix`. The dashboard is structured across three analytical pages, each answering a distinct business question:

**Page 1 - Executive Summary**
High-level KPIs including Total Revenue, Total Transactions, Average Order Value, and Best Selling Item, supported by monthly revenue trend and service type / payment method breakdowns.

**Page 2 - Sales & Product Performance**
Deep dive into product-level performance including revenue and quantity by item, monthly sales matrix, and best-seller rankings.

**Page 3 - Customer & Operational Insights**
Cross-analysis of payment behaviour by service type, data quality indicators (Unknown % for payment and service type).

**Key Features:**
- Date, item, service type, and payment method slicers across all pages
- DAX measures for MoM growth, revenue share %, and dynamic titles
- Tooltips with additional context on hover

## 🔑 Key Business Findings

Based on the SQL analysis and Power BI dashboard:

- **Juice and Coffee** are the highest revenue-generating items, consistently topping both revenue and units sold across all service types.
- **Digital Wallet** is the most preferred payment method, accounting for the largest transaction share - indicating the business should maintain robust digital payment infrastructure.
- **Takeaway** is the dominant service channel by transaction volume, while **In-store** commands a higher average order value.
- Revenue data reveals **clear monthly seasonality** in 2025, with identifiable peak and slow months useful for operational planning.
- Approximately **32% of transactions** had unresolvable service type data, flagging a systemic data capture issue in the POS system worth addressing at the operational level.

## 💡 Real-World Value

This project is relevant for a cafe, restaurant, or retail business because it helps answer practical questions such as:
- What should be stocked more?
- Which payment mode should be supported better?
- Which items deserve promotion?
- Which service channel is more profitable?
- When should staff levels increase?

That makes the project useful not just as a portfolio item, but as a realistic business intelligence use case.

## 📂 Project Structure

```text
cafe-sales-analytics/
├── dirty_cafe_sales_dataset.csv                          # Raw data source from Kaggle
├── cleaned_cafe_sales_dataset.xlsx                       # Cleaned data output after ETL
├── End-to-End_ETL_Pipeline_Python_&_MS_SQL_Server.ipynb  # Full ETL notebook
├── Cafe_insights.sql                                     # SQL business insight queries
├── Cafe_Business_Intelligence_Dashboard.pbix             # Power BI dashboard file
└── README.md                                             # Project documentation
```

## 🧑‍💻 Skills Demonstrated

This project demonstrates the following skills directly relevant to a Data Analyst role:

- **Data wrangling** — handling nulls, corrupted strings, type mismatches, and inconsistent formats using Pandas.
- **ETL pipeline design** — end-to-end pipeline from raw CSV to structured relational database.
- **Database connectivity** — loading DataFrames to SQL Server using SQLAlchemy.
- **SQL analysis** — writing business-context queries using `GROUP BY`, `HAVING`, `AGGREGATE FUNCTIONS`, and `ORDER BY`.
- **Business intelligence** — building a multi-page Power BI dashboard with DAX measures, slicers.
- **Data storytelling** — translating raw transaction data into actionable business insights.

## 👤 Author

**Jeevan Abishek**  
Aspiring Data Analyst

<a href="https://www.linkedin.com/in/jeevan-abishek" target="_blank">LinkedIn Profile</a>

## 📜 License

This project is licensed under the MIT License. The dataset is sourced from Kaggle and used for educational and portfolio purposes only.
