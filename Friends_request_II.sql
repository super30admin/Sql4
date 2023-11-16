# Write your MySQL query statement below

with CTE as (
select requester_id as id1 from RequestAccepted
union all
select accepter_id as id1 from RequestAccepted
)

select id1 as id,  count(id1) as num
from CTE
group by 1
order by 2 desc
limit 1
