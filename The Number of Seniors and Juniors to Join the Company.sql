
WITH CTE AS (
SELECT employee_id, experience, salary, SUM(salary) OVER (PARTITION BY experience ORDER BY salary,employee_id ) AS 'r_sum' FROM Candidates
)

-- #SELECT * FROM CTE;

SELECT 'Senior' AS Experience, COUNT(employee_id) AS 'accepted_candidates'
FROM CTE WHERE experience = 'Senior' AND  r_sum <= 70000
UNION 
SELECT 'Junior' AS experience, COUNT(employee_id) AS 'accepted_candidates'
FROM CTE WHERE experience = 'Junior' AND r_sum <= 70000 - (SELECT IFNULL(SUM(salary),0) FROM CTE WHERE experience = 'Senior' AND  r_sum <= 70000)

