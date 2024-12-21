#Approach 1:

With Cte as(
Select employee_id, experience, salary, sum(salary) over (partition by experience order by salary) as rsum from candidates)
Select ‘senior’ as experience, count(employee_id) as accepted_candidates from cte where experience = “senior” and rsum<=70000;
Union
Select  ‘junior’ as experience , count(employee_id) as accepted_candidates from cte c where experience = “juniors” and rsum<=(Select 70000- ifnull(max(rsum),0)) from ctc where rsum<=70000 and experience= “senior”;

#Approach 2:
With Cte as(
Select employee_id, experience, salary, sum(salary) over (partition by experience order by salary) as rsum from candidates)
acte as (select 70000-ifnull(max(rsum),0)) as “remaining” from ctc   where rsum<=7000 and experience= “senior”)
Select ‘senior’ as experience, count(employee_id) as accepted_candidates from cte where experience = “senior” and rsum<=70000;
Union
Select  ‘junior’ as experience , count(employee_id) as accepted_candidates from cte where experience = “junior” and rsum<=(Select remaining from acte);

