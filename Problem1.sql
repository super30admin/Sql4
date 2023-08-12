-- Problem 1 : The Number of Seniors and Juniors to Join the Company

WITH CTE AS (Select employee_id,experience,SUM(Salary) OVER(Partition by experience order by salary,emploYee_id) AS RN from Candidates)

SELECT 'Senior' as  experience,count(employee_id) AS accepted_candidates FROM CTE where experience ='Senior' and RN<=70000
UNION
SELECT  'Junior'  as experience,count(employee_id) AS accepted_candidates FROM CTE where experience='Junior' and RN<(Select 70000-ifnull(max(RN),0) FROM CTE where experience ='Senior' and RN<=70000)