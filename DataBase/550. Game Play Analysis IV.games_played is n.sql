select round(sum(if(a2.games_played is not null,1,0))/count(a1.player_id),2) fraction
from (select player_id, min(event_date) first_log
from Activity
group by player_id) a1
left join Activity a2 on adddate(first_log, interval 1 day) = a2.event_date and a1.player_id = a2.player_id