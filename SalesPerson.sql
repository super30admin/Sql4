SELECT name FROM salesperson WHERE sales_id NOT IN(
SELECT o.sales_id FROM orders o JOIN company C on o.com_id = c.com_id WHERE c.name='RED');