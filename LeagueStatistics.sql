select team_name,
sum(case when home_team_id = team_id or away_team_id = team_id then 1 else 0 end) as matches_played,
sum(case when team_id = home_team_id and home_team_goals > away_team_goals then 3 when team_id = away_team_id and home_team_goals < away_team_goals then 3 
when home_team_goals = away_team_goals then 1 else 0 end) as points,
sum(case when home_team_id = team_id then home_team_goals else away_team_goals end) as goal_for,
sum(case when home_team_id = team_id then away_team_goals else home_team_goals end) as goal_against,
sum(case when home_team_id = team_id then home_team_goals-away_team_goals else away_team_goals-home_team_goals end) as goal_diff
from matches m 
join teams t on m.home_team_id = t.team_id or m.away_team_id = t.team_id
group by team_name
order by points desc, goal_diff desc, team_name
