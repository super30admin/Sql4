# Write your MySQL query statement below
with cte as
(select 
*,
sum(salary) over (partition by experience order by salary,employee_id) as rsum
from candidates 
)

select 
'Senior' as experience,
count(employee_id) as accepted_candidates
from cte
where experience='Senior' and rsum <= 70000
union all
select 'Junior' as experience,
count(employee_id) as accepted_candidates
from cte
where experience ='Junior' 
and rsum <= (select 70000-coalesce(max(rsum),0) from cte where experience ='Senior' and rsum <= 70000)