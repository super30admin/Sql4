#Approach 1:
select s.name from SalesPerson s where s.sales_id not in(select o.sales_id from Orders o left join Company c on c.com_id= o.com_id where c.name= "RED");

#Approach 2:
With cte as (select o.sales_id from Orders o left join Company c on c.com_id= o.com_id where c.name= "RED")
select s.name from SalesPerson s where s.sales_id not in(Select * from Cte c);