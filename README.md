I worked on cleaning the same dataset using both SQL and Pandas to understand how each tool handles real-world data issues.
#  Data Cleaning Project (SQL + Pandas)

## 📌 Overview
This project demonstrates a complete data cleaning workflow using **SQL** and **Python (Pandas)**.  
The dataset contains inconsistencies such as missing values, duplicates, invalid entries, and formatting issues.

The goal of this project is to transform raw, messy data into a **clean, structured, and analysis-ready dataset**.

---

## Tools & Technologies
- **SQL (PostgreSQL)**
- **Python (Pandas, NumPy)**
- Jupyter Notebook

---

## Dataset Features
- `customer_id`
- `name`
- `age`
- `email`
- `city`
- `signup_date`
- `salary`

---

## Data Cleaning Steps

### 1️⃣ Data Inspection
- Checked total rows and previewed dataset
- Verified table structure using `information_schema`
- Used `.info()`, `.describe()` in Pandas

---

### 2️⃣ Handling Missing Values
- Identified missing values using:
  - SQL: `COUNT(*) - COUNT(column)`
  - Pandas: `isnull().sum()`
- Strategy:
  - `age` → imputed using **median / mean (rounded)**
  - `salary` → imputed using **mean**
  - `signup_date` → kept as NULL (important time-based column)
  - `email` → kept NULL (to avoid fake identifiers)

---

### 3️⃣ Handling Invalid Values
- Removed invalid age values:
  - `< 0` or `> 100` → set to NULL
- Ensured logical data consistency

---

### 4️⃣ Duplicate Removal
- Identified duplicates using `ROW_NUMBER()`
- Removed duplicates based on `customer_id`
- Learned to avoid deleting entire groups by mistake

---

### 5️⃣ Email Cleaning & Validation
- Trimmed spaces and converted to lowercase
- Fixed missing `@` in emails (e.g., `gmail.com → @gmail.com`)
- Validated using:
  ```sql
  email LIKE '%@%.%'
  
---

### 6️⃣ Text Standardization
Removed extra spaces using TRIM
Standardized case:
LOWER() for email
INITCAP() for name and city

---

### 7️⃣ Data Type Conversion

Converted columns to appropriate types:

customer_id → INTEGER
age → INTEGER
salary → NUMERIC
signup_date → DATE

---

### 8️⃣ Outlier Handling
Applied business rule:
Age outside valid range set to NULL
(Optional) Discussed statistical method (IQR)

---

### 9️⃣ Final Validation
Checked:
Remaining NULL values
Duplicates
Data types
Ensured dataset is analysis-ready
