/*
1. To easily calculate all the required values, we first create a cte which has the home_team details joined with the away_team details.
2. Grouping on first column of cte, we can calculate the number of matches played by each team by using count function. Handle the points to be allocated using case statement.
3. Sum the goals scored by each team to get goals_for in first column, goals_against in second. Subtract the goals from both the columns to get the goal difference. Order the result as required

Solved this problem in Leetcode: Yes
Problems faced when solving this problem: None
*/

with
    cte
    as
    (
        select home_team_id t1, away_team_id t2, home_team_goals g1, away_team_goals g2
            from
                Matches
        union all
            select away_team_id t1, home_team_id t2, away_team_goals g1, home_team_goals g2
            from
                Matches
    )
select t.team_name, count(t1) 'matches_played', sum(case 
  when cte.g1 > cte.g2 then 3
  when cte.g1 = cte.g2 then 1
  else 0
  end) 'points', sum(g1) 'goal_for', sum(g2) 'goal_against', sum(g1) - sum(g2) as 'goal_diff'
from cte join Teams t on cte.t1 = t.team_id
group by t1
order by points desc, goal_diff desc, t.team_name asc