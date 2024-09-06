with cte as (
    select requester_id id from RequestAccepted
    union all
    select accepter_id id from RequestAccepted
)
select distinct id, count(id) num from cte 
group by id order by num desc limit 1;