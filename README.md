# ❤️ Heart Attack Risk SQL Analysis

<p align="center">
  <img src="https://img.shields.io/badge/SQL-MySQL-blue?style=for-the-badge&logo=mysql&logoColor=white" />
  <img src="https://img.shields.io/badge/Project-Data%20Analytics-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Status-Completed-success?style=for-the-badge" />
</p>

## 📌 Project Overview

This project focuses on analyzing heart attack risk data using **MySQL**. The objective is to explore patient health indicators, identify patterns across different age groups, genders and states, and calculate high-risk patient percentages using SQL queries.

## 🎯 Project Objectives

- 🔍 Analyze patient distribution across different states and genders.
- 📊 Calculate average cholesterol, LDL and HDL levels.
- 👥 Identify high-risk patients across different age groups.
- 📈 Calculate state-wise and gender-wise high-risk percentages.
- 🏆 Rank patients based on cholesterol levels.
- 🔄 Explore patient records using SQL window functions.
- ⚙️ Create stored procedures for state-wise and gender-wise analysis.

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| 🐬 MySQL | Database management and SQL analysis |
| 💻 MySQL Workbench | Writing and executing SQL queries |

## 🧠 SQL Concepts Covered

### 🔹 Basic SQL
`SELECT`, `WHERE`, `ORDER BY`, `LIMIT`

### 🔹 Aggregate Functions
`COUNT()`, `AVG()`, `MAX()`, `SUM()`

### 🔹 Grouping and Filtering
`GROUP BY`, `HAVING`

### 🔹 Conditional Logic
`CASE WHEN`

### 🔹 Subqueries
Nested queries and aggregate-based comparisons.

### 🔹 Window Functions
`ROW_NUMBER()`, `RANK()`, `LAG()`, `LEAD()`

### 🔹 Stored Procedures
Parameterized procedures for state-wise and gender-wise analysis.

## 📊 Key Analysis Areas

### 1️⃣ Patient Demographics
Analyzed patient distribution by state, gender and age group.

### 2️⃣ Health Indicators
Explored cholesterol, LDL and HDL levels across different patient categories.

### 3️⃣ Heart Attack Risk Analysis
Calculated high-risk patient counts and percentages by state and gender.

### 4️⃣ Ranking Analysis
Ranked patients and states based on cholesterol levels and used window functions to compare successive patient records.

### 5️⃣ Stored Procedures
Created reusable procedures to generate health indicator summaries for a selected state or gender.

## 📂 Project Structure

```text
Heart-Attack-Risk-SQL-Analysis/
│
├── heart_attack_risk_analysis.sql
│
└── README.md
```

## 🚀 How to Run

1. Open MySQL Workbench.
2. Import the heart attack prediction dataset into MySQL.
3. Ensure the table is named `heart_attack_prediction_india`.
4. Open the SQL project file.
5. Execute the queries in the appropriate order.

**Note:** The SQL file assumes that the dataset table already exists. Dataset import and table creation are not included in this file.

## ⚠️ Disclaimer

This project is intended for educational and SQL practice purposes only. The analysis does not provide medical advice or clinically validated heart attack risk assessments.

---

<p align="center">
  💙 <b>Exploring Data. Discovering Patterns. Learning SQL.</b>
</p>
