WITH CTE as(
  select employee_id, experience, sum(salary) over (partition by experience
  order by salary, employee_id) as rn
  from candidates),
      ACTE as (
        select 70000 - ifnull(max(rn),0) as remaining_bal from CTE
        where experience = 'Senior' and rn <= 70000
      )

  select 'Senior' as experience, count(employee_id) as accepted_candidates
  from CTE where experience = 'Senior' and rn <= '70000'
  union
  select 'Junior' as experience, count(employee_id) as accepted_candidates
  from CTE where experience = 'Junior' and rn <= (select remaining_bal from ACTE);
