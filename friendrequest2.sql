# Write your MySQL query statement below
WITH CTE AS(SELECT accepter_id        
FROM 
    RequestAccepted
UNION ALL
SELECT requester_id        
FROM 
    RequestAccepted    
),
counter_table AS (
    SELECT accepter_id as id,
    COUNT(accepter_id) as num
    FROM CTE
    GROUP BY accepter_id
    )

 SELECT id, num 
 FROM counter_table
 ORDER BY num DESC
 LIMIT 1;