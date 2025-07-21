with home_away_master as 
(
    select 
        home_team_id as team_id
        , home_team_goals as for_goals
        , away_team_goals as against_goals
    from 
        Matches
    union all
    select 
        away_team_id as team_id
        , away_team_goals as for_goals
        , home_team_goals as against_goals
    from 
        Matches
)
select
    t.team_name
    , count(h.team_id) as matches_played
    , sum(case when h.for_goals > h.against_goals then 3
        when h.for_goals = h.against_goals then 1
        else 0 end) as points
    , sum(h.for_goals) as goal_for
    , sum(h.against_goals) as goal_against
    , sum(h.for_goals - h.against_goals) as goal_diff
from 
    Teams t join home_away_master h on t.team_id = h.team_id
group by h.team_id
order by 3 desc, 6 desc, 1
