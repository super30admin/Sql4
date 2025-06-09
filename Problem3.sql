SELECT name from SalesPerson where sales_id NOT IN ( Select DISTINCT o.sales_id 
From Orders o
Join Company c ON o.com_id = c.com_id
where c.name = 'RED')