with ctc as( 
select home_team_id as “r1”, home_team_goals as “g1”, away_team_goals as "g2” from Matches
union all 	
select away_team_id as “r1”, away_team_goals as “g1”, home_team_goals as "g2” from Matches)

select t.team_name, count(c.r1) as matches_played, sum(
case
when c.g1>c.g2 then 3
when c.g1<c.g2 then 0
else 0
end)
as “points” , sum(c.g1) as goals for, sum(c.g2) as goals against, sum(c.g1)-sum(c.g2) as goals_diff from teams t join cte c on t.team_id= c.r1 group by c.r1 order by points desc, goals_diff desc, t.team_name;
