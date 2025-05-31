# Write your MySQL query statement below
with cte as
(select requester_id as id
from requestAccepted
union all 
select accepter_id as id
from requestAccepted)

select distinct id,
count(id) as num
from cte
group by id
order by 2 desc limit 1