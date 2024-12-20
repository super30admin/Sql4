# Write your MySQL query statement below
WITH CTE AS(
    SELECT requester_id AS 'r' FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS 'r' FROM RequestAccepted
), counted AS (SELECT r, COUNT(r) AS 'cnt' FROM CTE GROUP BY r)

SELECT r AS 'id', cnt AS 'num' FROM counted WHERE cnt = (SELECT MAX(cnt) FROM counted)