/*
1. From the join of Company and Orders table, get the sales_id of all the salesperson who have sold to a company named "RED"
2. Now using SalesPerson table and the result from step 1, get the name of all the salesperson who have not sold to a company named "RED"

Solved this problem in Leetcode: Yes
Problems faced when solving this problem: None
*/

select name
from
    SalesPerson s
where s.sales_id not in (
select o.sales_id
from Company c
    join Orders o
    on c.com_id = o.com_id
where c.name ="RED"
)
