/*1127. User Purchase Platform
Table: Spending

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| spend_date  | date    |
| platform    | enum    | 
| amount      | int     |
+-------------+---------+
The table logs the history of the spending of users that make purchases from an online shopping website that has a desktop and a mobile application.
(user_id, spend_date, platform) is the primary key of this table.
The platform column is an ENUM type of ('desktop', 'mobile').

Write an SQL query to find the total number of users and the total amount spent using the mobile only, the desktop only, and both mobile and desktop together for each date.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/user-purchase-platform
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
with a as (
    select user_id,
            spend_date, 
            case when count(distinct platform) >1 then "both"
                else platform end as platform, 
            sum(amount) as total_amount , 
            count(distinct user_id) as total_users
    from Spending
    group by user_id, spend_date
),plat_list as(
    select distinct spend_date, 'mobile' as platform
    from Spending
    union
    select distinct spend_date, 'desktop' as platform
    from Spending
    union
    select distinct spend_date, 'both' as platform
    from Spending
)
select p.spend_date, p.platform, 
        ifnull(sum(total_amount),0) as total_amount,
        ifnull(sum(total_users), 0) as total_users
from plat_list p
left join a 
on p.spend_date = a.spend_date
    and p.platform = a.platform
group by p.spend_date, p.platform
order by 1,2