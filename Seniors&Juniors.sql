with CTE as (
select employee_id, experience, salary, sum(salary) over(partition by experience order by salary,employee_id asc) as cum_salary from candidates
),
ACTE as (
select 70000- ifNull(max(cum_salary),0) as remaining from cte where experience = 'senior' and cum_salary <=70000
)
select 'Senior' as experience,count(employee_id) as accepted_candidates from cte where experience='senior' and cum_salary<=70000 
union
select  'Junior' as experience,count(employee_id) as accepted_candidates from cte where experience='junior' and cum_salary<=(select remaining from ACTE)