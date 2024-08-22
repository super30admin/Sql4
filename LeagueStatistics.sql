
WITH CTE as (
SELECT home_team_id as r1, away_team_id as r2, home_team_goals as g1, away_team_goals g2 from matches
UNION ALL
SELECT away_team_id as r1,  home_team_id as r2, away_team_goals as g1, home_team_goals g2 from matches
), CTE2 as (
SELECT * , (
    CASE
    WHEN g1> g2 then 3
    when g1= g2 then 1 
    else 0
    END
) as points 
FROM CTE 
)

SELECT DISTINCT T.team_name, 
count(C.r1) as matches_played, 
SUM(C.points) as Points, 
sum(C.g1) as goal_for, 
sum(C.g2) as goal_against, 
sum(C.g1) - sum(C.g2) as goal_diff
FROM Teams T
join CTE2 C
on  T.team_id =C.r1 
Group by C.r1
order by points DESC, goal_diff DESC, T.team_name ;

