-- ==========================================
-- EXPLORATORY DATA ANALYSIS (EDA) SCRIPT
-- ==========================================

-- 1. Poora Clean Data Dekhna
SELECT * 
FROM emp_staging2;


-- 2. Basic Summary & Aggregate Metrics
-- (Total employees, average age, aur average salary nikalna)
SELECT 
    COUNT(customer_id) AS Total_Emp, 
    ROUND(AVG(age), 2) AS Avg_Age, 
    ROUND(AVG(salary), 2) AS Avg_Salary
FROM emp_staging2;


-- 3. Country-wise Employee Distribution
-- (Har country mein kitne employees hain, descending order mein)
SELECT 
    country, 
    COUNT(customer_id) AS Employee_Count
FROM emp_staging2 
GROUP BY country
ORDER BY Employee_Count DESC;


-- 4. Filtering & Multiple Conditions
-- (Active status aur 70,000 se zyada salary wale employees)
SELECT 
    customer_id, 
    salary, 
    `status`
FROM emp_staging2
WHERE salary > 70000 
  AND `status` = 'Active';


-- 5. Extreme Values (Highest & Lowest Salary)
-- (UNION aur Parentheses ka use karke max aur min salary wale employees ek sath nikalna)
(
    SELECT customer_id, first_name, salary
    FROM emp_staging2
    ORDER BY salary DESC
    LIMIT 1
) 
UNION 
(
    SELECT customer_id, first_name, salary
    FROM emp_staging2
    ORDER BY salary ASC
    LIMIT 1
);


-- 6. Date Filtering / Time-based Analysis
-- (Sirf saal 2024 ke andar signup karne wale employees ki list)
SELECT 
    customer_id, 
    signup_date 
FROM emp_staging2
WHERE signup_date >= '2024-01-01' 
  AND signup_date <= '2024-12-31';