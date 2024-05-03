
WITH CTE AS (
    SELECT employee_id, experience, 
    SUM(salary) OVER(PARTITION BY experience
    ORDER BY salary,employee_id) AS rsum 
    FROM Candidates
)

(SELECT 'Senior' AS experience, 
COUNT(employee_id) AS accepted_candidates 
FROM CTE c
WHERE experience = 'Senior' 
AND c.rsum <= 70000)
UNION
(SELECT 'Junior' AS experience, 
COUNT(employee_id) AS accepted_candidates 
FROM CTE c
WHERE experience = 'Junior'
 AND c.rsum <= 
 (SELECT 70000 - IFNULL(max(rsum),0) FROM CTE WHERE experience='Senior' AND rsum <= 70000))
