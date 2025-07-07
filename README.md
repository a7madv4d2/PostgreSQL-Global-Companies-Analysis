# PostgreSQL-Global-Companies-Analysis

This SQL portfolio project analyzes the **world's 2000 largest global companies**, as published by **Forbes** and sourced from Kaggle: [Kaggle Dataset](https://www.kaggle.com/datasets/mohammadgharaei77/largest-2000-global-companies?resource=download). The dataset was cleaned, encoded in **UTF-8**, and restructured for compatibility with **PostgreSQL**, including proper typing for numeric and date fields.

---

## Overview

The project answers 21 business-focused SQL questions using PostgreSQL. It demonstrates proficiency in:

* **CTEs (Common Table Expressions)**
* **Subqueries and nested logic**
* **Window Functions** (`RANK()`, `ROW_NUMBER()`, `LAG()`, `SUM(...) OVER`)
* **Self-joins and conditional joins**
* **Views** for reusability and dashboard reporting

All queries were executed in **pgAdmin 4** and structured for clarity and performance.

---

## Dataset Schema (PostgreSQL Table)

```sql
CREATE TABLE largest_companies (
    rank INTEGER,
    name TEXT,
    sales NUMERIC,         -- in billions
    profit NUMERIC,        -- in billions
    assets NUMERIC,        -- in billions
    market_value NUMERIC,  -- in billions
    industry TEXT,
    founded INTEGER,
    headquarters TEXT,
    country TEXT,
    ceo TEXT,
    employees NUMERIC
);
```

---

##  Sample Business Questions & Insights

### 1. **Top 10 Most Profitable Companies**

* **Saudi Aramco**, **Apple**, and **Microsoft** lead the list, each with over \$85B in profit.

### 2. **Average Number of Employees per Country**

* Global average: **48,583 employees** per company.

### 3. **US Companies Founded Before 1950**

* Includes **Wells Fargo (1852)**, **Chevron (1879)**, **Johnson & Johnson (1886)**, among others.

### 5. **Companies with 'Bank' in Their Name**

* Top entries include **Bank of America**, **China Construction Bank**, **TD Bank Group**.

### 6. **Industry with Highest Total Assets**

* **Banking and Financial Services** dominates with over **\$77,412B** in total assets.

### 7. **Number of Companies per Country**

* **USA: 621**, **China: 282**, **Japan: 181**, **India: 70**.

### 8. **Average Market Value by Industry (min 3 companies)**

* Top: **Semiconductors (\$202B)**, **IT Software & Services (\$143B)**, **Packaged Goods (\$142B)**.

### 9. **Total Profit by Country**

* **USA: \$1,767B**, **China: \$629B**, **Japan: \$280B**.

---

## Advanced SQL Techniques Used

### **Self Join**

* To identify **company pairs in the same country but different industries**.

### **Subqueries**

* Used to calculate **average sales and average assets by group**.

### **CTEs + Window Functions**

* `RANK()` to find top 3 companies by profit per country.
* `ROW_NUMBER()` to get the alphabetically first company per country.
* `LAG()` to compare profit to previous company by industry.
* `SUM(...) OVER` for **running total of market value** by country.

### **Views**

* `dashboard`: summarized company metrics for BI tools.
* `top_5`: top 5 companies by sales in each industry.

---

## Tools & Technologies

* **PostgreSQL** (v15+)
* **pgAdmin**
* **CSV pre-processing** (encoding fixes, column normalization)
* **Data visualization** (optional in Power BI or Tableau)

---

## Author

**Ahmed Elsayed Abdelmawla Elsayed**
 [a7madv4d2@gmail.com](mailto:a7madv4d2@gmail.com)
 [LinkedIn](https://www.linkedin.com/in/ahmed-elsayed-2a8208239/) | [GitHub](https://github.com/a7madv4d2)

---

## License

Apache 2.0.

