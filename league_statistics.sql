# Write your MySQL query statement below

With CTE as 
(select
home_team_id as ht, away_team_id at, home_team_goals as htg, away_team_goals as atg
from Matches
union all
select
away_team_id as ht, home_team_id at, away_team_goals as htg, home_team_goals as atg
from Matches
)

select 
t.team_name,
count(ht) as matches_played ,
sum(
case when htg>atg then 3
     when htg = atg then 1
     when htg < atg then 0
end) as points,
sum(htg) as goal_for,
sum(atg) as goal_against,
sum(htg) - sum(atg) as goal_diff 
from CTE join Teams t on CTE.ht = t.team_id 
group by 1 
order by 3 desc,
6 desc, 1