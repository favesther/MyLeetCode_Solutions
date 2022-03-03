/*1651. Hopper Company Queries III
Write an SQL query to compute the average_ride_distance and average_ride_duration of every 3-month window starting from January - March 2020 to October - December 2020. Round average_ride_distance and average_ride_duration to the nearest two decimal places.

The average_ride_distance is calculated by summing up the total ride_distance values from the three months and dividing it by 3. The average_ride_duration is calculated in a similar way.

Return the result table ordered by month in ascending order, where month is the starting month's number (January is 1, February is 2, etc.).

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/hopper-company-queries-iii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
with recursive n(m) as(
    select 1
    union all
    select m + 1 from n
    where m < 12
), t as (
select n.m, 
        ifnull(sum(ride_distance),0) as m_distance, 
        ifnull(sum(ride_duration),0) as m_duration 
from n
left join Rides r 
on year(r.requested_at) = 2020 and month(r.requested_at) = n.m
left join AcceptedRides a 
on a.ride_id = r.ride_id
group by n.m
order by n.m
)
select m as month , 
        round(sum(m_distance) over w / 3 ,2) as average_ride_distance,
        round(sum(m_duration) over w / 3 ,2) as average_ride_duration 
from t
WINDOW w AS (order by m rows between current row and 2 following)
limit 10;