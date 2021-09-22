# Solution 1 Subquery
select player_id, (select a2.device_id from Activity a2 where a2.player_id = a1.player_id order by event_date limit 1) device_id
from (select distinct player_id from Activity) a1

# Solution 2 Ranking
select distinct player_id, device_id
from (select player_id, device_id, rank() over (partition by player_id order by event_date) rnk
from Activity) a
where rnk = 1