# Write your MySQL query statement below
with cte as(
select home_team_id as hid, away_team_id as aid, home_team_goals as htg, away_team_goals as atg
from matches
union all
select away_team_id as hid, home_team_id as aid, away_team_goals as htg, home_team_goals as atg
from matches)


select teams.team_name,count(hid) as matches_played,
sum(case when htg > atg then '3'
        when htg = atg then '1'
        else 0
        end) points,sum(htg) as goal_for,sum(atg) as goal_against ,(sum(htg)-sum(atg)) as goal_diff
from cte
join teams on cte.hid=teams.team_id
group by hid
order by points desc,goal_diff desc,team_name;

