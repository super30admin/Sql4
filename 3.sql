# Write your MySQL query statement below
with cte as (Select s.sales_id, o.order_id, s.name, o.com_id from SalesPerson s
left join Orders o
on o.sales_id = s.sales_id)
select name 
from SalesPerson
where name not in (
    select cte.name from cte 
left join Company c 
on cte.com_id=c.com_id
where c.name ='RED'
)