WITH CTE AS(
    SELECT home_teamId as 'r1' , home_team_goal  as 'g1', away_team_goal as 'g2' FROM Matches
    UNION ALL
    SELECT away_team_id as 'r1' , away_team_goal as 'g1' , home_team_goal as 'g2' FROM Matches 
)


#SELECT Distinct  r1, COUNT(r1) FROM CTE
#GROUP BY r1

SELECT t.teamName, COUNT(c.r1) AS Matches_played , SUM(
    CASE 
        WHEN c.g1 > c.g2 THEN 3
        WHEN c.g1 = c.g2 THEN 0
        ELSE 1
    END) AS 'Points' , SUM(c.g1) AS 'goal_for' , SUM(C.g2) AS 'goal_away',
    SUM(c.g1) - SUM(C.g2) AS 'goal_diff' FROM CTE C
    INNER JOIN Teams T ON C.team_id = T.Teams 
    GROUP BY c.r1, ORDER BY     Points DESC, goal_diff DESC, t.teamName;
    
