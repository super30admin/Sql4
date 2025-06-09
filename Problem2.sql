WITH CTE AS(
    Select home_team_id as r1, away_team_id as r2, home_team_goals as g1, away_team_goals as g2 
    from matches
    UNION ALL
    Select home_team_id as r2, away_team_id as r1, home_team_goals as g2, away_team_goals as g1
    from matches  
)
Select t.team_name, Count(c.r1) as 'matches_played',
SUM(
    CASE
        WHEN c.g1>c.g2 THEN 3
        WHEN c.g1 = c.g2 THEN 1
        ELSE 0
    END
) as points, SUM(c.g1) as 'goal_for', SUM(c.g2) as 'goal_against', SUM(c.g1) - SUM(c.g2) as 'goal_diff' from Teams t INNER JOIN CTE c ON
t.team_id = c.r1
GROUP BY c.r1
ORDER BY points DESC, goal_diff DESC, t.team_name;