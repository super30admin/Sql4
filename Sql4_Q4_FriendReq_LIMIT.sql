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
    id 
    , count(id) as num
from 
    acceptor_sender_master
group by 1
order by 2 desc
limit 1