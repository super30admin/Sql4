WITH cte AS (
    SELECT home_team_id as 'team', away_team_id as 'away_id', 
    home_team_goals as 'h_goals', away_team_goals as 'a_goals' 
    FROM Matches
    UNION ALL
    SELECT away_team_id as 'team', home_team_id as 'away_id', 
    away_team_goals as 'h_goals', home_team_goals as 'a_goals' 
    FROM Matches
),
TEAM_matchup AS (
    SELECT distinct team, count(team) as matches_played, sum(
        case
            when h_goals > a_goals then 3
            when h_goals = a_goals then 1
            else 0
        end 
    ) as points, 
    sum(h_goals) as 'goal_for',
    sum(a_goals) as 'goal_against',
    (sum(h_goals) - sum(a_goals)) as goal_diff
    
     from cte group by team
)

select t.team_name as team_name, matches_played, points, 
goal_for, goal_against, goal_diff from TEAM_matchup c join teams t 
on t.team_id = c.team order by points desc, goal_diff desc, team_name