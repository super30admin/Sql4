# Write your MySQL query statement below
With CTE as(
    select  m1.home_team_id as t1,
            m1.away_team_id as t2,
            m1.home_team_goals as goal_for,
            m1.away_team_goals as goal_against
            from matches m1 join Teams t on m1.home_team_id = t.team_id
    union all
    select  m2.away_team_id as t1,
            m2.home_team_id as t2,
            m2.away_team_goals as goal_for,
            m2.home_team_goals as goal_against
            from matches m2 join Teams t on m2.home_team_id = t.team_id
)

select Teams.team_name,
count(CTE.t1) as matches_played,
sum(case    when CTE.goal_for > CTE.goal_against Then 3
            when CTE.goal_for < CTE.goal_against Then 0
            Else 1
    End) as points,
sum(CTE.goal_for) as goal_for,
sum(goal_against) as goal_against,
(sum(goal_for) - sum(goal_against)) as goal_diff
from CTE
join Teams on CTE.t1 = Teams.team_id
group by t1
order by points desc, goal_diff desc, team_name;