SELECT s.name
FROM SalesPerson s
WHERE s.name NOT IN (
    SELECT sp.name
    FROM SalesPerson sp
    LEFT JOIN orders o ON sp.sales_id = o.sales_id
    JOIN Company c ON o.com_id = c.com_id
    WHERE c.name = 'RED'
);