Problem 4 : Friend Requests II

# Write your MySQL query statement below
SELECT id, COUNT(id) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted 
    UNION ALL 
    SELECT accepter_id AS id FROM RequestAccepted
) AS result
GROUP BY id
order by num desc
limit 1

# Write your MySQL query statement below
with cte as (
    select requester_id as id from RequestAccepted union all
    select accepter_id as id from RequestAccepted
)
select id, count(id) as num from cte
group by id
order by num desc
limit 1

Problem 3 : Sales Person

# Write your MySQL query statement below

select name
from SalesPerson
where sales_id not in (select o.sales_id
from Orders o join Company c
on o.com_id = c.com_id
where c.name ="RED")
