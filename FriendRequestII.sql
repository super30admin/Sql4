#Approach 1:
with cte as (select requester_id as id from RequestAccepted
union all
select accepter_id as id from RequestAccepted)

select c.id,count(id) as num from cte c group by id order by num desc limit 1; 

#Approach 2:
WITH CTE AS (
    SELECT requester_id AS id,
           (SELECT COUNT(*) FROM RequestAccepted WHERE id = requester_id OR id = accepter_id) AS num 
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id,
           (SELECT COUNT(*) FROM RequestAccepted WHERE id = requester_id OR id = accepter_id) AS num
    FROM RequestAccepted
)
SELECT * FROM CTE ORDER BY num DESC LIMIT 1;