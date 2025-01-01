# Write your MySQL query statement below
with cte as (
    select employee_id, experience, sum(salary) over (partition by experience order by salary, employee_id) as ru_sum
    from Candidates
)
Select 'Senior' as experience, count(employee_id) as accepted_candidates 
from cte where experience ='senior' and ru_sum<=70000
union
Select 'Junior' as experience, count(employee_id) as accepted_candidates 
from cte where experience ='junior' and ru_sum<=(
Select 70000 - ifnull(max(ru_sum),0)
from cte where experience ='senior' and ru_sum<=70000)