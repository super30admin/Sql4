# Write your MySQL query statement below
# select
# id,
# case 
#    when p_id is null then 'Root'
#    when p_id is not null and id not in (select distinct p_id from Tree where p_id is not null)  then 'Leaf'
#    when p_id is not null and id in (select distinct p_id from Tree)  then 'Inner'
   
#    -- else 'Leaf'
   
# end as type
# from 
# Tree 

select
id,
if(p_id is null, 'Root',
if(id in (select distinct p_id from tree) and p_id is not null,'Inner','Leaf')
) as type
from tree