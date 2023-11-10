# Write your MySQL query statement below

With CTE as
(
select 
d.name as 'Department',
e.name as 'Employee',
e.salary as 'Salary',
dense_rank() over (PARTITION by d.name order by e.salary desc) as 'rankkk'
from
Employee e inner join Department d on e.departmentId = d.id
)

select Department,Employee,Salary from CTE
where rankkk in (1,2,3)