WITH CTE AS (
    SELECT employee_id, experience, salary, SUM(salary) OVER(PARTITION BY experience ORDER BY salary, employee_id) as 'rsum' from Candidates
)
SELECT 'Senior' as experience, COUNT(employee_id) as 'accepted_candidates' from CTE where experience = 'Senior' and rsum <= 70000
UNION
SELECT 'Junior' as experience, COUNT(employee_id) as 'accepted_candidates' from CTE where experience = 'Junior' and rsum <= (SELECT 70000 - IFNULL(MAX(rsum),0) from CTE where experience = 'Senior' and rsum <= 70000)