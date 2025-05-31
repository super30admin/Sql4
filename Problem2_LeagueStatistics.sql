# Write your MySQL query statement below
with cte as (
    select home_team_id as 'id',home_team_goals as goal_for,away_team_goals as goal_against
    from matches 
    union all
    select away_team_id as 'id',away_team_goals as goal_for,home_team_goals as goal_against
    from matches
)

#select * from cte

select  t.team_name,
count(c.id) as matches_played,
sum(case when goal_for > goal_against then 3
     when goal_for = goal_against then 1
     else 0 end) as points,
sum(c.goal_for) as goal_for,
sum(c.goal_against) as goal_against,
sum(c.goal_for)- sum(c.goal_against) as goal_diff
 from cte c
 inner join Teams t on c.id=t.team_id
 group by id
 order by points desc,goal_diff desc,t.team_name 