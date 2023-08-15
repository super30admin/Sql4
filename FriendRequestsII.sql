# Write your MySQL query statement below

-- Interchanging columns

with CTE as(
    select requester_id as r1, accepter_id as r2 from RequestAccepted
    union
    select accepter_id as r1, requester_id as r2 from RequestAccepted
),
ACTE as (select r1 as id, count(r1) as num from CTE group by r1)
select id, num from ACTE where num = (select max(num) from ACTE);


-- Without interchanging columns

with CTE as(
        select r1.requester_id as id, (select count(requester_id) from RequestAccepted r2
        where r1.requester_id = r2.requester_id or r1.requester_id = r2.accepter_id) as num
        from RequestAccepted r1
        group by id),
    ACTE as(
        select r1.accepter_id as id, (select count(accepter_id) from RequestAccepted r2
        where r1.accepter_id = r2.requester_id or r1.accepter_id = r2.accepter_id) as num
        from RequestAccepted r1
        group by id)

select * from ACTE
union
select * from CTE
order by num desc
limit 1;