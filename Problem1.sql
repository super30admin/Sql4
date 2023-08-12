/*
1. We calculate the cumulative sum of salary for each experience level. We order the result by salary and employee_id so that if two employees have same salary, the one with lower employee_id is considered first.
2. Using the cumulative costs incurred from above cte, calculate the remaining amount to be spent on Senior candidates. If the amount is less than 0, then we can't hire any Senior candidates. So we set the remaining amount to 0.
3. Number of juniors that can be hired would be the number of rows in cte where cumulative sum is less than or equal to the remaining amount.

Solved this problem in Leetcode: Yes
Problems faced when solving this problem: None
*/

with
    cte
    as
    (
        select employee_id, experience, sum(salary) over (partition by experience order by salary,employee_id) as Rn
        from Candidates
    ),
    acte
    as
    (
        select 70000 - ifnull(max(cte.Rn),0) as rm
        from cte
        where cte.experience='Senior' and cte.Rn <= 70000
    )

    select 'Senior' as experience, count(employee_id) accepted_candidates
    from cte
    where cte.Rn <= 70000
        and experience = 'Senior'
union
    select 'Junior' as experience , count(employee_id) accepted_candidates
    from cte
    where cte.Rn <= (select rm
        from acte)
        and experience = 'Junior'
