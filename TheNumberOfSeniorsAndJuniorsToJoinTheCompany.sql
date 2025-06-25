'''
Sql4

1 Problem 1 : The Number of Seniors and Juniors to Join the Company (https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/)
'''

WITH CTE AS (SELECT employee_id, experience, salary, 
SUM(salary) OVER (PARTITION BY experience ORDER BY salary, employee_id)
AS 'rsum' FROM Candidates)

SELECT 'Senior' AS experience, COUNT(employee_id) AS accepted_candidates
FROM CTE
WHERE experience = 'Senior' AND rsum <= 70000
UNION 
SELECT 'Junior' AS experience, COUNT(employee_id) AS accepted_candidates
FROM CTE
WHERE experience = 'Junior' AND rsum <= (SELECT 70000 - IFNULL(MAX(rsum), 0) FROM CTE WHERE experience = 'Senior' AND rsum <= 70000)

