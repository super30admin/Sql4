-- # Write your MySQL query statement below
WITH CTE AS ( Select requester_id AS id FROM RequestAccepted
UNION ALL
Select accepter_id AS id FROM RequestAccepted
)

-- SELECT * FROM CTE
SELECT id, COUNT(id) AS num FROM CTE
GROUP BY id
ORDER BY num DESC 
LIMIT 1

