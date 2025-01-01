# Write your MySQL query statement below
with cte as 
(
select home_team_id as t, home_team_goals as goal, away_team_goals as away,
case
when home_team_goals > away_team_goals then 3
when home_team_goals < away_team_goals then 0
else 1
end as points
from Matches
union all
select away_team_id as t, away_team_goals as goal, home_team_goals as away,
case
when away_team_goals > home_team_goals then 3
when away_team_goals < home_team_goals then 0
else 1
end as points
from Matches
)
select t1.team_name, count(t1.team_id) as matches_played, sum(cte.points) as points,
sum(cte.goal) goal_for,sum(cte.away)goal_against, sum(cte.goal) - sum(cte.away) as goal_diff
from Teams t1
Join cte
on t1.team_id = cte.t
group by t1.team_id
order by points desc, goal_diff desc, team_name