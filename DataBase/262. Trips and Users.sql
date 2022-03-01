/*
The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.

Return the result table in any order.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/trips-and-users
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
SELECT b.dt as "Day", 
        round(sum(if(status !="completed",1,0))/count(distinct id),2) as `Cancellation Rate`
FROM 
(select cast("2013-10-01" as date) as dt
 union all
 select (@x:= @x + interval 1 day) as dt from users, (select @x:= cast("2013-10-01" as date)) a 
) b
LEFT JOIN Trips t 
ON T.request_at = b.dt
LEFT JOIN Users c
ON c.users_id = T.client_id
LEFT JOIN Users d
ON d.users_id = T.driver_id
WHERE c.banned = "No" 
AND d.banned = "No"
GROUP BY b.dt