# Write your MySQL query statement below

#APPROACH 1
WITH t1 as (
   SELECT * FROM Candidates
   ORDER BY experience ASC, salary ASC
),

t2 as (SELECT *, 
   @s := @s + CASE when salary < @b and experience = "Senior" then 1 else 0 end as c1,
   @j := @j + CASE when salary < @b and experience = "Junior" then 1 else 0 end as c2,
   @b := @b - IF(salary < @b, salary, 0) as c3
FROM t1, (SELECT @b := 70000, @s := 0, @j := 0) as var
ORDER BY c1 DESC, c2 DESC
LIMIT 1
)

SELECT "Senior" as experience, c1 as accepted_candidates FROM t2
UNION
SELECT "Junior" as experience, c2 as accepted_candidates FROM t2

#APPROACH 2
# WITH CTE AS (
#  SELECT *, SUM(salary) OVER (PARTITION BY experience ORDER BY salary) AS rsum
#  FROM Candidates
# )

# SELECT 'Senior' AS experience, COUNT(employee_id) AS accepted_candidates
# FROM CTE 
# WHERE experience = 'Senior' AND rsum <= 70000
# UNION
# SELECT 'Junior' AS experience, COUNT(employee_id) AS accepted_candidates
# FROM CTE 
# WHERE experience = 'Junior' AND rsum <= (SELECT 70000 - IFNULL(MAX(rsum), 0) FROM CTE WHERE experience = 'Senior' AND rsum <= 70000)