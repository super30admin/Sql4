with cte as (
select home_team_id as t1, away_team_id as t2, home_team_goals as g1, away_team_goals as g2 from matches
union all
select away_team_id as t1, home_team_id as t2,away_team_goals as g1, home_team_goals as g2  from matches
)
select team_name, count(*) as matches_played, SUM(CASE 
    WHEN g1>g2 THEN 3 
    WHEN g1=g2 THEN 1
    ELSE 0
    END ) as points , sum(g1) as goal_for,sum(g2) as goal_against, sum(g1)-sum(g2) as goal_diff
 from cte 
join teams t 
on 
cte.t1=t.team_id
group by 1
order by points desc,goal_diff desc,team_name asc