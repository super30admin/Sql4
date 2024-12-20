# Write your MySQL query statement below
WITH CTE AS(
    SELECT m1.home_team_id AS 'id', m1.home_team_goals AS 'hg',
    m1.away_team_goals AS 'ag' FROM Matches m1
    UNION ALL
    SELECT m2.away_team_id AS 'id', m2.away_team_goals AS 'hg',
    m2.home_team_goals AS 'ag' FROM Matches m2
)

-- SELECT * FROM CTE
SELECT a.team_name, COUNT(c.id) AS 'matches_played', SUM(
    CASE
        WHEN c.hg > c.ag THEN 3
        WHEN c.hg = c.ag THEN 1
        ELSE 0
    END
) AS 'points', SUM(c.hg) AS 'goal_for', SUM(c.ag) AS 'goal_against',
SUM(c.hg) - SUM(c.ag) AS 'goal_diff' 
FROM Teams a LEFT JOIN CTE c ON a.team_id = c.id GROUP BY c.id
ORDER BY points DESC, goal_diff DESC, a.team_name