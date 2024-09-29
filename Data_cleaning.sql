create database HumanResources;
USE HumanResources;
Select * from HR;

-- Rename id column to emp_id
ALTER TABLE HR
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- Check data types of all columns
Describe HR;

SELECT birthdate FROM hr;
SET sql_safe_updates = 0;

-- Change birthdate values to date
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

--Change birthdate column datatype
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

--Convert hire_date values to date
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

--Change hire_date column data type
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

--Convert termdate values to date and remove time
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;
SET sql_mode = 'ALLOW_INVALID_DATES';

--Convert termdate column to date
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

--Add age column
ALTER TABLE hr ADD COLUMN age INT;
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());
SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;
SELECT count(*) FROM hr WHERE age < 18;

----Check Termdates in the future
SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';
SELECT location FROM hr;

