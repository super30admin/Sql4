
-- Using LIMIT
WITH CTE AS (SELECT r1.requester_id AS id FROM RequestAccepted r1
UNION ALL
SELECT r2.accepter_id AS id FROM RequestAccepted r2)

SELECT id, count(id) AS num FROM CTE
GROUP BY id
ORDER BY num DESC
LIMIT 1

-- clarifying question as - if id 1 send request to 2 and 2 also sends request to 1 then ?
WITH CTE AS (SELECT r1.requester_id AS id FROM RequestAccepted r1
UNION ALL
SELECT r2.accepter_id AS id FROM RequestAccepted r2),

ACTE AS (SELECT id, count(id) AS num FROM CTE
GROUP BY id)

SELECT id, num FROM ACTE WHERE num = (SELECT MAX(num) FROM ACTE)

 
-- Another way
(SELECT requester_id AS id, 
	(SELECT COUNT(*) 
    FROM RequestAccepted 
    WHERE 
    id=requester_id OR 
    id=accepter_id) AS num
FROM RequestAccepted
UNION ALL
SELECT accepter_id AS id, 
	(SELECT COUNT(*) 
    FROM RequestAccepted 
    WHERE 
    id=requester_id OR 
    id=accepter_id) AS num
FROM RequestAccepted)
ORDER BY num DESC
LIMIT 1
 


 