WITH CTE AS (
    SELECT *, sum(salary) over(
   partition by experience order by salary
) as run_sum from Candidates
)
-- SELECT * from CTE;
SELECT ifnull(experience, "Senior") as experience, count(employee_id) as accepted_candidates from CTE
Where experience = "Senior" AND run_sum <= 70000
union all
SELECT ifnull(experience, "Junior") as experience, count(employee_id) as accepted_candidates FROM CTE
WHERE experience = "Junior" AND run_sum <= ifnull((SELECT 70000 - max(run_sum) from CTE where experience = "Senior" AND run_sum <= 70000), 70000);
