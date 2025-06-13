# Write your MySQL query statement below
WITH CTE AS(
    SELECT requester_id as 'id' FROM RequestAccepted
    UNION ALL
    SELECT accepter_id as 'id' FROM RequestAccepted
)



Select id , COUNT(id)  AS 'num' FROM CTE GROUP BY id ORDER BY num DESC limit 1;