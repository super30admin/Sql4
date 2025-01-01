with cte as (select requester_id as r1
from RequestAccepted
union all
select accepter_id as r1
from RequestAccepted
)

select r1 as id, count(r1) as num
from cte
group by r1
order by num desc
limit 1