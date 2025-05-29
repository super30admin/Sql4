# Write your MySQL query statement below
with cte as(
select  employee_id,experience,salary, sum(salary) over(partition by experience order by salary) as Acccandidates
from Candidates
)

select 'Senior' as experience,count(employee_id) as accepted_candidates
from cte
where experience='Senior' and Acccandidates<=70000
union
select 'Junior' as experience,count(employee_id) as accepted_candidates
from cte
where experience='Junior' and Acccandidates<= (select 70000-ifnull(max(Acccandidates),0) from cte where experience='Senior' and Acccandidates<=70000);