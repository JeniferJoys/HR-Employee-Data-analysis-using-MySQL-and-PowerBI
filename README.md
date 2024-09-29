# HR-Employee-Data-analysis-using-MySQL-and-PowerBI

## Overview
This project involves analyzing the HR employee dataset to gather valuable insights and answer key business questions. The README file summarizes the problems addressed, the solutions found, the results, and the conclusions drawn.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [HR Dataset](https://github.com/Irene-arch/HR-Dashboard-MySQL-PowerBI/tree/main)

## Tools Used

**Data Cleaning & Analysis** - MySQL Workbench

**Data Visualization** - PowerBI

## Problem statements and Solutions

### 1. What is the gender breakdown of employees in the company?

```sql
SELECT gender, count(*) AS count
FROM HR WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;
```

**Findings:** 

