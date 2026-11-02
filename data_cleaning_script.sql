-- ==========================================
-- SQL DATA CLEANING PROJECT SCRIPT
-- ==========================================

-- 1. Database Setup & Initial Inspection
CREATE DATABASE Dataset;
USE Dataset;

-- Raw table ko 'emp' naam se rename karna
RENAME TABLE sql_data_cleaning_dataset TO emp;

-- Raw data ko dekhna
SELECT * FROM emp;


-- ==========================================
-- STEP 1: REMOVE DUPLICATES
-- ==========================================

-- Staging table banana (original data ko safe rakhne ke liye)
CREATE TABLE emp_staging LIKE emp;

INSERT INTO emp_staging
SELECT * FROM emp;

-- Duplicate rows ko identify karne ke liye Row Number generate karna
SELECT *,
ROW_NUMBER() OVER(PARTITION BY customer_id, first_name, last_name, age, email, country, signup_date, salary, `status`) AS Row_Num
FROM emp_staging;

-- Row_Num column ke sath final staging table banana
CREATE TABLE `emp_staging2` (
  `customer_id` text,
  `first_name` text,
  `last_name` text,
  `age` double DEFAULT NULL,
  `email` text,
  `country` text,
  `signup_date` text,
  `salary` double DEFAULT NULL,
  `status` text,
  `Row_Num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Duplicates ke sath data ko emp_staging2 mein insert karna
INSERT INTO emp_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY customer_id, first_name, last_name, age, email, country, signup_date, salary, `status`) AS Row_Num
FROM emp_staging;

-- Agar Safe Update Mode on ho, toh use temporarily disable karein delete ke liye
SET SQL_SAFE_UPDATES = 0;

-- Jin rows ka Row_Num 1 se bada hai (yani jo duplicates hain), unhe delete karna
DELETE FROM emp_staging2
WHERE Row_Num > 1;

-- Safe Update Mode ko wapas on karna
SET SQL_SAFE_UPDATES = 1;


-- ==========================================
-- STEP 2: STANDARDIZE THE DATA (Date Formatting)
-- ==========================================

-- Blank strings ko NULL mein convert karna taaki date conversion mein error na aaye
UPDATE emp_staging2
SET signup_date = NULL
WHERE signup_date = '';

-- Column ka data type TEXT se badalkar DATE karna
ALTER TABLE emp_staging2 
MODIFY COLUMN signup_date DATE;


-- ==========================================
-- STEP 3: HANDLE NULL AND BLANK VALUES
-- ==========================================

-- Text columns ki missing/blank values ko 'Not Provided' se fill karna
UPDATE emp_staging2
SET first_name = 'Not Provided'
WHERE first_name IS NULL OR first_name = '';

UPDATE emp_staging2
SET last_name = 'Not Provided'
WHERE last_name IS NULL OR last_name = '';

UPDATE emp_staging2
SET email = 'Not Provided'
WHERE email IS NULL OR email = '';

UPDATE emp_staging2
SET country = 'Not Provided'
WHERE country IS NULL OR country = '';

UPDATE emp_staging2
SET `status` = 'Not Provided'
WHERE `status` IS NULL OR `status` = '';


-- ==========================================
-- STEP 4: REMOVE UNNECESSARY COLUMNS & TABLES
-- ==========================================

-- Helper column (Row_Num) ko table se drop karna
ALTER TABLE emp_staging2
DROP COLUMN Row_Num;

-- Intermediate staging table ko delete karna (kyunki ab iski zaroorat nahi hai)
DROP TABLE emp_staging;

-- ==========================================
-- FINAL CHECK: Cleaned Data Ready!
-- ==========================================
SELECT * FROM emp_staging2;