-- Problem 2 : League Statistics		


with unioned as(
select home_team_id as t1, away_team_id as t2,home_team_goals as g1, away_team_goals as g2 from Matches
Union All
select away_team_id as t1, home_team_id as t2, away_team_goals as g1, home_team_goals as g2 from matches )
select t.team_name,COUNT(u.t1) AS matches_played,sum(
    CASE
        WHEN u.g1 >u.g2 THEN 3
        WHEN u.g1=u.g2 THEN 1
        ELSE 0
    END
) AS points,SUM(u.g1) AS goal_for,SUM(u.g2) AS goal_against,SUM(u.g1)- SUM(u.g2) AS goal_diff  from unioned u join teams t on u.t1=t.team_id group by u.t1 order by Points DESC,goal_diff DESC, t.team_name;