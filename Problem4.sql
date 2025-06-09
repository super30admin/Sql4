WITH CTE AS(
    Select requester_id as id from RequestAccepted
UNION ALL
Select accepter_id as id from RequestAccepted)
Select id, count(id) as 'num' from CTE 
group by id
order by num desc
LIMIT 1