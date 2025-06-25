'''
3 Problem 3 : Sales Person (https://leetcode.com/problems/sales-person/ )
'''

SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
    SELECT sales_id
    FROM Orders
    JOIN Company ON Company.com_id = Orders.com_id
    WHERE name = 'RED'
)