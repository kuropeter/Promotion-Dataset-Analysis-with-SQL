-- Exploratory Data Analysis

-- 1. How many employees do we have in the organization and what is the
-- maximum length of service?
SELECT 
	COUNT(*) AS employees, 
	MAX(length_of_service) AS max_year
FROM employee_test

-- 2. How many employees are there in each department?
SELECT 
	department, 
	COUNT(*) AS employee_count
FROM employee_test
GROUP BY department
ORDER BY employee_count DESC

-- 3. What is the proportion of male to female employees?
SELECT 
	DISTINCT(gender) AS gender, 
	COUNT(*) as employees 
FROM employee_test
GROUP BY gender

-- 4. Group Employee age into 5 categories (20 – 29, 30 – 39, 40-49, 50-59, >60).
-- What age group has the highest and lowest employee?
SELECT 
	CASE
		WHEN age BETWEEN 20 AND 29 THEN '20 - 29'
		WHEN age BETWEEN 30 AND 39 THEN '30 - 39'
		WHEN age BETWEEN 40 AND 49 THEN '40 - 49'
		WHEN age BETWEEN 50 AND 59 THEN '50 - 59'
		ELSE '>60'
	END age_group,
	COUNT(*) as employees
FROM employee_test
GROUP BY age_group
ORDER BY employees DESC

-- 5. Who works in the Finance department?
SELECT 
	employee_id, 
	department
FROM employee_test
WHERE department = 'Finance'

-- 6. Who has the highest average training score among all employees?
SELECT 
	employee_id, 
	MAX(avg_training_score) AS highest_avg_score
FROM employee_test
GROUP BY employee_id
ORDER BY highest_avg_score DESC
LIMIT 1;

-- 7. Which regions have the highest number of departures (employees who have
-- left), and what are the corresponding departments?
SELECT 
	et.region AS region,
	et.department AS department,
	COUNT(ep.attrition) AS attrition_num
FROM employee_test et
INNER JOIN employee_perf ep ON et.employee_id = ep.employee_id
GROUP BY region, department
ORDER BY attrition_num DESC

-- 8. Which department has the most employees, and which department has the
-- fewest employees?
SELECT 
	DISTINCT(department) AS department, 
	COUNT(department) AS most_employees
FROM employee_test
GROUP BY department
ORDER BY most_employees DESC
LIMIT 1

SELECT 
	DISTINCT(department) AS department, 
	COUNT(department) AS least_employees
FROM employee_test
GROUP BY department
ORDER BY least_employees 
LIMIT 1

-- 9. Who are the top 5 highest-earning employees in the 'Technology'
-- department?
SELECT 
	et.employee_id,
	et.department,
	ep.monthlyincome
FROM employee_test et
INNER JOIN employee_perf ep ON ep.employee_id = et.employee_id
WHERE department = 'Technology'
ORDER BY ep.monthlyincome DESC
LIMIT 5
-- 10. Who are the employees with awards in departments with more than 10
-- employees, and what are their department names?
SELECT
	employee_id,
	COUNT(awards_won), 
	department
FROM employee_test
GROUP BY department
ORDER BY awards_won DESC

-- Top 5 Highest perfroming Employee from Technology Department
SELECT 
	et.employee_id, 
	et.department, 
	ep.performancerating
FROM employee_perf ep
INNER JOIN employee_test et ON et.employee_id = ep.employee_id
WHERE department = 'Technology'
ORDER BY ep.performancerating DESC
LIMIT 5

--Employee with the highest training score
SELECT employee_id, avg_training_score AS av
FROM employee_test
GROUP BY employee_id
ORDER BY av DESC
LIMIT 1


