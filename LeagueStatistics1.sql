# Write your MySQL query statement below
WITH CTE AS (
    SELECT home_team_id as r1,
    home_team_goals as goals_home,
    away_team_goals as goals_away
    FROM Matches
    UNION ALL
    SELECT away_team_id as r1,
    away_team_goals as goals_home,
    home_team_goals as goals_away 
    FROM Matches
)

SELECT 
    t.team_name,
    COUNT(r1) AS matches_played,
    SUM(CASE
        WHEN c.goals_home > c.goals_away THEN 3
        WHEN c.goals_home = c.goals_away THEN 1
        ELSE 0
    END) AS points,
    SUM(c.goals_home) AS goal_for,
    SUM(c.goals_away) AS goal_against,
    SUM(c.goals_home) - SUM(c.goals_away) AS goal_diff
    FROM Teams t
    INNER JOIN
    CTE c
    ON t.team_id = c.r1
    GROUP BY c.r1
    ORDER BY points DESC, goal_diff DESC, t.team_name;