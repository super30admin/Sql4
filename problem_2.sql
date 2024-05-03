--League Statistics
WITH CTE AS (
    SELECT home_team_id AS R1, away_team_id AS R2, home_team_goals AS G1, away_team_goals AS G2
FROM Matches
UNION ALL
SELECT away_team_id AS R1, home_team_id AS R2, away_team_goals AS G1, home_team_goals AS G2
FROM Matches)

SELECT t.team_name, 
COUNT(C.R1) AS 'matches_played', 
SUM(
    CASE
        WHEN C.G1 > C.G2 THEN 3
        WHEN C.G1 = C.G2 THEN 1
        ELSE 0
    END
) AS 'points',
SUM(C.G1) AS 'goal_for',
SUM(C.G2) AS 'goal_against',
SUM(C.G1)-SUM(C.G2) AS 'goal_diff'
FROM Teams t JOIN CTE C ON t.team_id = C.R1
GROUP BY C.R1
ORDER BY points DESC, goal_diff DESC, t.team_name;
