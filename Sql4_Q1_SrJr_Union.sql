with cte as (
select 
    employee_id
    , experience
    , salary
    , row_number() over(partition by experience order by salary) as rownum
    , sum(salary) over(partition by experience order by salary, employee_id) as cumsum
from Candidates
)
select 
    'Senior' as experience
    , coalesce(count(employee_id),0) as accepted_candidates
from cte
where experience = 'Senior' and cumsum <= 70000
union
select 
    'Junior' as experience
    , coalesce(count(employee_id),0) as accepted_candidates
from cte
where experience = 'Junior' and cumsum <= (select 70000 - coalesce(max(cumsum),0) from cte where experience = 'Senior'
and cumsum <= 70000)