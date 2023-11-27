# Write your MySQL query statement below
WITH CTE AS
(
    SELECT requester_id AS id, accepter_id
    FROM RequestAccepted
    UNION
    SELECT accepter_id AS id, requester_id
    FROM RequestAccepted
)
SELECT id, COUNT(DISTINCT accepter_id) AS NUM
FROM CTE
GROUP BY id
ORDER BY num DESC
LIMIT 1;