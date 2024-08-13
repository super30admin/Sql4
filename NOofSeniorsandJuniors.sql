with CTE as(
SELECT employee_id,experience, sum(salary) over(partition by experience order by salary) rsum 
    FROM Candidates
    )

select 'Senior' as experience, count(distinct employee_id) 'accepted_candidates' 
from CTE where experience = 'Senior' and rsum <=70000

UNION

select 'Junior' as experience, count(distinct employee_id) 'accepted_candidates' 
from CTE where experience = 'Junior' and rsum <= (select 70000 - ifnull(max(rsum),0) from CTE where experience = 'Senior' and rsum<=70000);

