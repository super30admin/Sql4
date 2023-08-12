/*
1. Count the number of friends are there for all persons of requester_id column. Get the one with the highest number of friends. Store the result in a cte
2. Similarly check for accepter_id column since we dont know if the person with most friends is a requester or accepter. Store the result in another cte
3. Get the one with the highest number of friends among the two.

Solved this problem in Leetcode: Yes
Problems faced when solving this problem: None
*/

with cte as(
select requester_id as id, 
    (select count(*) from RequestAccepted where id = requester_id or id = accepter_id) num
    from RequestAccepted
    order by num desc limit 1
),acte as (
  select accepter_id as id, 
    (select count(*) from RequestAccepted where id = requester_id or id = accepter_id) num
    from RequestAccepted
    order by num desc limit 1
)
select id, num from cte 
union 
select id,num from acte 
order by num desc limit 1