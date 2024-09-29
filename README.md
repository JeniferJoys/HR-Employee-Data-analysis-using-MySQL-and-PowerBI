# HR-Employee-Data-analysis-using-MySQL-and-PowerBI

## Overview
This project involves analyzing the HR employee dataset to gather valuable insights and answer key business questions. The README file summarizes the problems addressed, the solutions found, the results, and the conclusions drawn.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [HR Dataset](https://github.com/Irene-arch/HR-Dashboard-MySQL-PowerBI/tree/main)

## Tools Used

**Data Cleaning & Analysis** - MySQL Workbench

**Data Visualization** - PowerBI

## Problem Statements and Solutions

### 1. What is the gender breakdown of employees in the company?

```sql
SELECT gender, count(*) AS count
FROM HR WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;
```
### 2. What is the race/ethnicity breakdown of employees in the company?

```sql
SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18
GROUP BY race
ORDER BY count DESC
```
### 3. What is the age distribution of employees in the company?

```sql
SELECT 
  MIN(age) AS youngest,
  MAX(age) AS oldest
FROM hr
WHERE age >= 18
```
### 4. How many employees work at headquarters versus remote locations?

```sql
SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location;
```
### 5. What is the average length of employment for employees who have been terminated?

```sql
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE() AND age >= 18;
```
### 6. How does the gender distribution vary across departments?

```sql
SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY department, gender
ORDER BY department;
```
### 7. What is the distribution of job titles across the company?

```sql
SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;
```
### 8. Which department has the highest turnover rate?
### "Turnover rate" typically refers to the rate at which employees leave a company or department and need to be replaced. It can be calculated as the number of employees who leave over a given time period divided by the average number of employees in the company or department over that same time period.

```sql
SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '0000-00-00' THEN 1 ELSE 0 END) as active_count,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;
```
### 9. What is the distribution of employees across locations by state?

```sql
SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;
```
### 10. How has the company's employee count changed over time based on hire and term dates?

```sql
SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END)) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    hr
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;
```
### 11. What is the tenure distribution for each department?

```sql
SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department;
```

## Summary of Findings
1. There are more male employees than female.
2. The majority of employees are White, while Native Hawaiian and American Indian are the least represented.
3. The youngest employee is 20 years old, and the oldest is 57.
4. Five age groups were created: 18-24, 25-34, 35-44, 45-54, and 55-64. Most employees are in the 25-34 age group, followed by 35-44, with the smallest group being 55-64.
5. More employees work at headquarters compared to remote locations.
6. Terminated employees have an average length of employment of about 8 years.
7. Gender distribution across departments is relatively balanced, but there are generally more males than females.
8. The Training department has the highest turnover rate, followed by Marketing, HR, while Research and Development, Support, and Legal departments have the lowest.
9. Many employees are from Ohio.
10. The total number of employees has increased over the years.
11. The average tenure across departments is around 8 years, with Legal and Auditing having the highest, and Services, Sales, and Marketing having the lowest.
