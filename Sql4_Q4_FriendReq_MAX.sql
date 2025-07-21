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
, count_table as
(
select 
    id 
    , count(id) as num
from 
    acceptor_sender_master
group by 1
)
select 
    id
    , num
from 
    count_table
where num = (select max(num) from count_table)