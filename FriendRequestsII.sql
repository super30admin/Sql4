WITH CTE AS (
    SELECT requester_id AS id, 
           (SELECT COUNT(*) FROM RequestAccepted WHERE id = requester_id OR id = accepter_id) AS num
    FROM RequestAccepted

    UNION

    SELECT accepter_id AS id, 
           (SELECT COUNT(*) FROM RequestAccepted WHERE id = requester_id OR id = accepter_id) AS num
    FROM RequestAccepted
)

SELECT * 
FROM CTE 
ORDER BY num DESC 
LIMIT 1;
