select username, activity, startdate, endDate
from (
    select *, rank() over (partition by username order by endDate desc) rnk,
    count(*) over (partition by username) cnt
    from UserActivity
) t
where cnt = 1 or rnk = 2