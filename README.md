# Sql4

1 Problem 1 : The Number of Seniors and Juniors to Join the Company	(https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/)

Solution:
WITH CTE AS(
SELECT employee_id , experience , SUM(salary) OVER(PARTITION BY experience ORDER BY salary ,employee_id)
 as 'rsum'FROM candidates)

 SELECT 'Senior' AS experience , COUNT(employee_id) AS 'accepted_candidates' FROM CTE WHERE experience = 'Senior'
 AND rsum <=70000
 UNION
 SELECT 'Junior' AS experience , COUNT(employee_id) AS 'accepted_candidates' FROM CTE WHERE experience = 'Junior'
 AND rsum <= (SELECT 70000 - IFNULL(MAX(rsum),0) from CTE where experience = 'Senior' AND rsum <= 70000);


2 Problem 2 : League Statistics		(https://leetcode.com/problems/league-statistics/ )

Solution:
WITH CTE AS(
SELECT home_team_id as r1 , away_team_id as r2 , home_team_goals as g1 , away_team_goals as g2 from matches
UNION ALL
Select away_team_id as r1 , home_team_id as r2 , away_team_goals as g1 , home_team_goals as g2 from matches
)

SELECT t.team_name , COUNT(c.r1) as 'matches_played' , SUM(
    CASE
        WHEN c.g1 > c.g2 THEN 3
        WHEN c.g1 = c.g2 THEN 1
        ELSE 0
    END
)AS 'points' , SUM(c.g1) AS 'goal_for',SUM(c.g2) AS 'goal_against',SUM(c.g1) - SUM(c.g2) AS 'goal_diff'
FROM teams t JOIN CTE c ON t.team_id = c.r1 GROUP BY c.r1 ORDER BY points DESC , goal_diff DESC ,
t.team_name;


3 Problem 3 : Sales Person		(https://leetcode.com/problems/sales-person/ )

Solution:
SELECT S.name 
from SalesPerson S
Where sales_id Not in (
    select o.sales_id 
    from orders o
    join company c
    on o.com_id = c.com_id
    where c.name = 'RED'
)

4 Problem 4 : Friend Requests II	(https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/ )

Solution:
WITH CTE AS(
    SELECT requester_id as r1 from RequestAccepted
    UNION ALL
    SELECT accepter_id as r1 from RequestAccepted
),

ACTE AS(
SELECT r1 as 'id' , COUNT(r1) AS 'num' from CTE GROUP BY r1
)

SELECT id , num FROM ACTE WHERE num = (SELECt MAX(num) from ACTE) LIMIT 1;


