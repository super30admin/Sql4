with RED_sales_id as
(
    select
        o.sales_id
    from 
        Orders o join Company c on c.com_id = o.com_id
    where c.name = 'RED'
)
select 
    s.name as name 
from 
    SalesPerson s
where s.sales_id not in (select distinct sales_id from RED_sales_id)