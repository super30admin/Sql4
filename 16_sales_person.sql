SELECT name from salesperson s 
WHERE name NOT IN 
(SELECT DISTINCT s.name 
FROM salesperson s JOIN company c JOIN orders o ON o.sales_id = s.sales_id 
WHERE o.com_id = c.com_id AND c.name = 'RED')