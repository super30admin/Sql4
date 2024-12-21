with cte as (select home_team_id as team_id, home_team_goals as g1, away_team_goals as g2 from matches
union all
select away_team_id as team_id, away_team_goals as g1, home_team_goals as g2 from matches )


select t.team_name as team_name, count(c.team_id) as matches_played , sum(
case
    when c.g1>c.g2 then 3
    when c.g1 <c.g2 then 0
    else 1
end 
) as points, sum(c.g1) as goal_for, sum(c.g2) as goal_against ,sum(c.g1)-sum(c.g2) as goal_diff 
from teams t join cte c on t.team_id=c.team_id 
group by c.team_id 
order by points desc,goal_diff desc,team_name  