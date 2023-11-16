# Write your MySQL query statement below


select name from SalesPerson
where sales_id
not in 
(
select distinct sales_id
from
Orders o left join company c on o.com_id = c.com_id
where c.name = 'RED'
)


-- # select name
-- # from 
-- # SalesPerson where name not in
-- # (
-- # select
-- # s.name
-- # from
-- # SalesPerson s
-- # join Orders o on s.sales_id = o.sales_id
-- # join Company c on o.com_id = c.com_id
-- # where c.name in ('RED')
-- # )

