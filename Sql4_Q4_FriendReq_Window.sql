with acceptor_sender_master as
(
    select 
        requester_id as id
    from RequestAccepted
    union all
    select 
        accepter_id as id
    from RequestAccepted
)
select 
    distinct id 
    , count(id) over(partition by id) as num
from 
    acceptor_sender_master
order by 2 desc
limit 1