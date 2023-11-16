# Write your MySQL query statement below
With CTE as (
select employee_id,experience,salary,
sum(salary) over (partition by experience order by salary asc, employee_id) as 'running_sum'
from Candidates order by experience 
)
select 'Senior' as experience, count(employee_id) as accepted_candidates 
from CTE 
where 
experience = 'Senior' and 
running_sum <= 70000
union

select 'Junior' as experience, count(employee_id) as accepted_candidates 
from CTE 
where 
experience = 'Junior' and 
running_sum <= (select 70000 - ifnull(max(running_sum),0) from CTE where experience = 'Senior' and running_sum <= 70000)


