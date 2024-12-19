
WITH CTE AS (
SELECT home_team_id AS team_id, home_team_goals AS goal_for, away_team_goals AS goal_against
FROM Matches 
UNION ALL
SELECT away_team_id AS team_id, away_team_goals  AS goal_for, home_team_goals AS goal_against
FROM Matches 
)

-- #SELECT * FROM CTE

SELECT t.team_name, COUNT(c.team_id) AS matches_played, 
    SUM(  
        CASE WHEN c.goal_for > c.goal_against THEN 3
             WHEN c.goal_for = c.goal_against THEN 1
             ELSE 0
        END 
         
    ) AS points, SUM(c.goal_for) AS goal_for, SUM(c.goal_against) AS goal_against, 
    Sum(c.goal_for) - SUM(c.goal_against) AS goal_diff
    FROM CTE c LEFT JOIN Teams t ON c.team_id = t.team_id
    GROUP BY c.team_id 
    ORDER BY points DESC,goal_diff DESC,team_name;
    
