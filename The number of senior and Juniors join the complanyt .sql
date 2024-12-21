WITH CTE AS (
    SELECT 
        EMPLOYEE_ID, 
        EXPERIENCE, 
        SALARY,
        SUM(SALARY) OVER (PARTITION BY EXPERIENCE ORDER BY SALARY, employee_id) AS csum
    FROM CANDIDATES
)

select 'Senior' as experience , count(employee_id) as 'accepted_candidates' 
from cte  
where  experience ='senior' and csum<=70000 
union

select 'Junior' as experience , count(employee_id) as 'accepted_candidates'
 from cte 
  where csum<=(70000 - ( select IFNULL(max(csum),0) from cte  where experience ='senior' and csum<=70000))and experience ='junior';
