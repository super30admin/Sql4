WITH CTE AS(
SELECT requester_id AS 'id' FROM RequestAccepted
UNION ALL
SELECT accepter_id AS 'id' FROM RequestAccepted
),
ACTE AS(
    SELECT id, COUNT(id) AS 'num' FROM CTE GROUP BY id
)
SELECT id, num FROM ACTE WHERE num = (SELECT MAX(num) FROM ACTE)