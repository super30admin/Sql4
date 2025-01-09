WITH CTE AS (
    SELECT home_team_id as id ,home_team_goals as hg, away_team_goals as ag from matches 
    union all
    select away_team_id as id, away_team_goals as hg, home_team_goals as ag from matches
), POINTS AS (
select id,case when hg>ag then 3
when hg=ag then 1 else 0 end as points,hg,ag from CTE)
select teams.team_name,count(id)as matches_played,sum(points) as points, sum(hg) as goal_for, sum(ag) as goal_against,sum(hg)- sum(ag) as goal_diff from points left join teams on teams.team_id = points.id group by id order by points desc, goal_diff desc, team_name;