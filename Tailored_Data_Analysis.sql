-- Tailored Data Analysis

-- 1. What is the average training score of employees in each department
SELECT 
	department,
	ROUND(AVG(avg_training_score), 0) AS avg_training_score
FROM employee_test
GROUP BY department
ORDER BY avg_training_score DESC

-- 2. What is the average previous year rating by department?
SELECT 
	department,
	ROUND(AVG(previous_year_rating), 0) AS avg_prev_year_rating
FROM employee_test
GROUP BY department
ORDER BY avg_prev_year_rating DESC

-- 3. What is the average training score of employees by education type?
SELECT
	education,
	ROUND(AVG(avg_training_score), 0) AS average_score
FROM employee_test
GROUP BY education
ORDER BY average_score DESC

-- 4. Group Average training score into grades (A,B,C,D,E,F) and what grade
-- had the highest and lowest number of employees
SELECT 
	CASE
		WHEN avg_training_score BETWEEN 0 AND 39 THEN 'F'
		WHEN avg_training_score BETWEEN 40 AND 44 THEN 'E'
		WHEN avg_training_score BETWEEN 45 AND 54 THEN 'D'
		WHEN avg_training_score BETWEEN 55 AND 59 THEN 'C'
		WHEN avg_training_score BETWEEN 60 AND 69 THEN 'B'
		ELSE 'A'
	END score_group,
	COUNT(*) AS employee_num
FROM employee_test
GROUP BY score_group
ORDER BY employee_num DESC

-- 5. Which three departments have the highest average job satisfaction
-- among employees with a Bachelor's degree?
SELECT 
	et.department,
	et.education,
	ROUND(AVG(ep.jobsatisfaction), 0) AS satisfaction
FROM employee_test et
INNER JOIN employee_perf ep ON et.employee_id = ep.employee_id
WHERE education = 'Bachelor''s'
GROUP BY department, education
LIMIT 3

-- 6. What is the average previous year rating by recruitment channel?
SELECT 
	recruitment_channel,
	ROUND(AVG(previous_year_rating), 0) as avg_previous_year_rating
FROM employee_test
GROUP BY recruitment_channel

-- 7. What is the split of gender by the previous year rating?
SELECT 
	gender,
	ROUND(AVG(previous_year_rating), 0) as avg_previous_year_rating
FROM employee_test
GROUP BY gender

-- 8. Based on the age group created what is the average previous year rating
-- and average training score.
SELECT 
	CASE
		WHEN avg_training_score BETWEEN 0 AND 39 THEN 'F'
		WHEN avg_training_score BETWEEN 40 AND 44 THEN 'E'
		WHEN avg_training_score BETWEEN 45 AND 54 THEN 'D'
		WHEN avg_training_score BETWEEN 55 AND 59 THEN 'C'
		WHEN avg_training_score BETWEEN 60 AND 69 THEN 'B'
		ELSE 'A'
	END score_group,
	ROUND(AVG(previous_year_rating),0) AS avg_previous_year_rating,
	ROUND(AVG(avg_training_score), 0) AS average_training_score
	--COUNT(*) AS employee_num--
FROM employee_test
GROUP BY score_group
ORDER BY score_group

-- 9. What is the average age of male and female employees, and how many
-- employees are there for each gender?
SELECT 
	gender,
	ROUND(AVG(age), 0) AS average_age,
	COUNT(*) AS employees
FROM employee_test
GROUP BY gender
	
-- 10. Who are the top 5 highest-earning employees with a JobLevel of 3 or
-- higher?
SELECT 
	et.employee_id,
	department,
	ep.monthlyincome,
	ep.joblevel
FROM employee_test et
INNER JOIN employee_perf ep ON et.employee_id = ep.employee_id
ORDER BY monthlyincome DESC
LIMIT 5

--11. Average training Score & avg_previous_year_rating by age_group
SELECT 
	CASE
		WHEN age BETWEEN 20 AND 29 THEN '20 - 29'
		WHEN age BETWEEN 30 AND 39 THEN '30 - 39'
		WHEN age BETWEEN 40 AND 49 THEN '40 - 49'
		WHEN age BETWEEN 50 AND 59 THEN '50 - 59'
		ELSE '>60'
	END age_group,
	ROUND(AVG(previous_year_rating),0) AS avg_previous_year_rating,
	ROUND(AVG(avg_training_score), 0) AS average_training_score
FROM employee_test
GROUP BY age_group
ORDER BY age_group
