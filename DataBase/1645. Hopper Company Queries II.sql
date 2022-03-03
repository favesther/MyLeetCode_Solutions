/*
1645. Hopper Company Queries II
Write an SQL query to report the percentage of working drivers (working_percentage) for each month of 2020 where:
percentage(month) = # drivers that accepted at least one ride during the month /
                    # available drivers during the month *100.0
Note that if the number of available drivers during a month is zero, we consider the working_percentage to be 0.
Return the result table ordered by month in ascending order, where month is the month's number (January is 1, February is 2, etc.). Round working_percentage to the nearest 2 decimal places.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/hopper-company-queries-ii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

with recursive n(m) as(
    select cast("2020-01-01" as date)
    union all
    select m + interval 1 month from n
    where m <= "2020-11-01"
), a as (
    select m, coalesce((select count(distinct driver_id) from Drivers where join_date < n.m + INTERVAL 1 MONTH),0) as active_drivers
    from n
)
, b as (
    select month(r2.requested_at) m, count(distinct r1.driver_id) as accepted
    from AcceptedRides r1
    left join Rides r2
    on r1.ride_id = r2.ride_id
    where year(r2.requested_at) = 2020
    group by month(r2.requested_at)
)
select month(a.m) as month, 
        case when active_drivers = 0 then 0.00
            else round(coalesce(accepted,0)/active_drivers * 100,2) end as working_percentage 
from a 
left join b 
on b.m = month(a.m)
