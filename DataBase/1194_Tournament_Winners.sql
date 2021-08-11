with cpt as(
    select player, sum(score) score
    from (
    select first_player as player, first_score as score
    from Matches m1
    union all
    select second_player as player, second_score as score
    from Matches m2) m
    group by player
), rnk as(
    select p.*, sum(c.score) score
    from Players p
    left join cpt c on p.player_id = c.player
    group by 1,2 order by 3 desc, 1 asc
)
select group_id, (select rnk.player_id from rnk where rnk.group_id = t.group_id limit 1) player_id
from (select distinct group_id from Players) t