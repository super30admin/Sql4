# Write your MySQL query statement below

#APPROACH 1
WITH cte AS(
  SELECT home_team_id AS id, home_team_goals AS gf, away_team_goals AS ga, IF(home_team_goals > away_team_goals, 3, IF(home_team_goals = away_team_goals, 1, 0)) AS p FROM Matches 
  UNION ALL
  SELECT away_team_id AS id, away_team_goals AS gf, home_team_goals AS ga, IF(away_team_goals > home_team_goals, 3, IF(away_team_goals = home_team_goals, 1, 0)) AS p FROM Matches
)

SELECT t.team_name, COUNT(m.id) AS matches_played, SUM(m.p) AS points, SUM(m.gf) AS goal_for, SUM(m.ga) AS goal_against, SUM(m.gf) - SUM(m.ga) AS goal_diff FROM cte m INNER JOIN Teams t ON t.team_id = m.id GROUP BY m.id ORDER BY SUM(m.p) DESC, SUM(m.gf) - SUM(m.ga) DESC, t.team_name

#APPROACH 2
WITH cte AS(
  SELECT *, 
      IF(home_team_goals > away_team_goals, 3, IF(home_team_goals = away_team_goals, 1, 0)) AS htp, 
      IF(home_team_goals < away_team_goals, 3, IF(home_team_goals = away_team_goals, 1, 0)) AS atp
  FROM Matches
), 
 cte2 AS(
  SELECT IF(htp > atp, home_team_id, IF(htp < atp, away_team_id, home_team_id))   AS team_id, 
      IF(htp > atp, htp, if(htp = atp, htp, atp)) AS Points, 
      IF(htp > atp, home_team_goals, IF(htp < atp, away_team_goals, home_team_goals)) AS goals_for, 
      IF(htp > atp, away_team_goals, IF(htp < atp, home_team_goals, away_team_goals)) AS goals_against
  FROM cte

  UNION ALL

  SELECT IF(htp > atp, away_team_id, IF(htp < atp, home_team_id, away_team_id))   AS team_id, 
      IF(htp > atp, atp, if(htp = atp, htp, htp)) AS Points, 
      IF(htp > atp, away_team_goals, IF(htp < atp, home_team_goals, away_team_goals)) AS goals_for, 
      IF(htp > atp, home_team_goals, IF(htp < atp, away_team_goals, home_team_goals)) AS goals_against
  FROM cte
)

SELECT t1.team_name, 
      COUNT(t2.team_id) AS matches_played, 
      SUM(t2.Points) AS points, 
      SUM(t2.goals_for) AS goal_for, 
      SUM(t2.goals_against) AS goal_against, 
      (SUM(t2.goals_for) - SUM(t2.goals_against)) AS goal_diff
FROM cte2 t2 INNER JOIN Teams t1 
ON t1.team_id = t2.team_id
GROUP BY t2.team_id
ORDER BY SUM(t2.Points) DESC, 
        (SUM(t2.goals_for) - SUM(t2.goals_against)) DESC, 
        t1.team_name