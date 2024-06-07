WITH cte AS (
    SELECT employee_id, experience, SUM(salary) OVER(PARTITION BY experience ORDER BY salary) as 'running_sum'
    FROM Candidates
),
acte AS (
    SELECT 70000 - IFNULL(MAX(running_sum), 0) AS 'remaining' FROM cte WHERE experience = 'Senior' and running_sum <= 70000
)

SELECT 'Senior' AS experience, COUNT(employee_id) AS accepted_candidates FROM cte WHERE experience = 'Senior' and running_sum <= 70000
UNION 
SELECT 'Junior' AS experience, COUNT(employee_id) AS accepted_candidates FROM cte WHERE experience = 'Junior' and running_sum <= (SELECT remaining FROM acte)