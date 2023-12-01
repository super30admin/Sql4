# Write your MySQL query statement below
WITH total_salary AS 
(
    SELECT *,
    SUM(salary) OVER(PARTITION BY experience ORDER BY salary) AS total_salary
    FROM Candidates
),
senior AS 
(
    SELECT 'Senior' AS experience,
    COUNT(employee_id) AS accepted_candidates,
    IFNULL(MAX(total_salary), 0) AS cost
    FROM total_salary
    WHERE experience = 'Senior'
    AND total_salary <= 70000
),
junior AS 
(
    SELECT 'Junior' as experience,
    COUNT(employee_id) AS accepted_candidates,
    IFNULL(MAX(total_salary), 0) AS cost
    FROM total_salary
    WHERE experience = 'Junior'
    AND total_salary <= 70000 - (SELECT cost FROM senior)

)

SELECT experience, accepted_candidates
FROM senior
UNION ALL
SELECT experience, accepted_candidates
FROM junior         
