# Employee Data Cleaning & Exploratory Data Analysis (EDA) in MySQL

An end-to-end Data Analysis project demonstrating raw data preprocessing, data cleaning, ETL pipeline implementation, and Exploratory Data Analysis (EDA) using MySQL Workbench.

## 📌 Project Overview
Real-world datasets are often messy, containing duplicate records, inconsistent date formats, and missing/null values. This project takes a raw employee dataset, builds a robust staging-table workflow to clean and transform the data, and performs advanced SQL queries to derive meaningful business insights.

## 🛠️ Tech Stack & Tools
* **Database Management System:** MySQL Workbench
* **Language:** SQL (Data Definition Language, Data Manipulation Language, Window Functions, Aggregations)
* **Version Control:** Git & GitHub

---

## 🔄 Project Workflow & Steps

### 1. Data Cleaning & ETL Pipeline
* **Staging Tables Setup:** Created intermediate staging tables (`emp_staging`, `emp_staging2`) to isolate and protect the original raw data (`emp`).
* **Duplicate Removal:** Engineered complex window functions (`ROW_NUMBER()` with `PARTITION BY` across all columns) to accurately identify and delete duplicate customer records.
* **Data Standardization:** Converted text-based date fields into standard `DATE` data types using `STR_TO_DATE` and safe null-handling techniques.
* **Missing Value Handling:** Replaced null and blank string anomalies across multiple attributes (`first_name`, `last_name`, `email`, `country`, `status`) with standard placeholder values (`'Not Provided'`).

### 2. Exploratory Data Analysis (EDA)
Wrote modular SQL queries to uncover business insights, including:
* Calculating total employee count, average age, and average salary.
* Grouping and ranking employee distribution by `country`.
* Filtering active employees based on salary thresholds.
* Extracting salary extremes (highest and lowest paid employees) using `UNION` and parentheses logic.
* Time-based analysis for year-specific signups (`2024`).

---

## 📂 Repository Structure
```text
├── data_cleaning_script.sql    # Complete SQL script for data cleaning & ETL
├── eda_script.sql              # SQL queries and insights for EDA
└── README.md                   # Project documentation
