1225. Report Contiguous Dates
A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.

Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.

period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. Interval of days are retrieved as start_date and end_date.

Return the result table ordered by start_date.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/report-contiguous-dates
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

with a as (
    select "failed" as period_state, fail_date as event_date
    from Failed 
    union all
    select "succeeded" as period_state, success_date as event_date
    from Succeeded 
), b as (
    select *,
            rank() over (partition by period_state order by event_date) as rnk,
            row_number() over (order by event_date) as rownum
    from a
    where event_date between "2019-01-01" and "2019-12-31"
)
select period_state, min(event_date) as start_date, max(event_date) as end_date
from b
group by period_state, rownum - rnk
order by start_date
