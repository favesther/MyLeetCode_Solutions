select f1.follower, count(distinct f2.follower) num
from follow f1
inner join follow f2 on f1.follower = f2.followee
group by 1
order by 1;