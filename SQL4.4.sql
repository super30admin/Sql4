# Write your MySQL query statement below

WITH cte AS (
  SELECT requester_id AS id, COUNT(requester_id) AS cnt
  FROM RequestAccepted GROUP BY requester_id
  UNION ALL
  SELECT accepter_id, COUNT(accepter_id) AS cnt
  FROM RequestAccepted GROUP BY accepter_id
) 

SELECT id, SUM(cnt) as num FROM cte
GROUP BY id
ORDER BY num DESC
LIMIT 1
