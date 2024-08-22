WITH CTE AS (
    SELECT O.com_id, O.sales_id, C.name From orders O
    Left Join Company C
    on C.com_id = O.com_id
    where C.name = "RED"
)


SELECT S.name from Salesperson S
WHERE S.sales_id not in (
    SELECT sales_id from CTE
)