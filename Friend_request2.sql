WITH CTE AS(
    SELECT requester_id as r1, accepter_id as a1 from RequestAccepted
    Union all 
    SELECT accepter_id as r1, requester_id as a1 from RequestAccepted
)
    
SELECT DISTINCT r1 as id, count(r1) over(partition by r1 ) as num 
from CTE
ORDER BY num desc limit 1;







