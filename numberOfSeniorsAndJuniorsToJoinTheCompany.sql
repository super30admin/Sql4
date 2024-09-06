with cte as(
    select employee_id, experience, sum(salary) 
    over(partition by experience order by salary) 'rsum' 
    from candidates order by experience 
)
select coalesce(experience,'Senior') experience, 
count(employee_id) as accepted_candidates 
from cte where experience = 'Senior' and rsum <= 70000 
union 
select coalesce(experience,'Junior') experience, 
count(employee_id) as accepted_candidates 
from cte where experience = 'Junior' and rsum <= 70000 - 
(
    select coalesce(max(rsum),0) from cte 
    where experience = 'Senior' and rsum <= 70000 )