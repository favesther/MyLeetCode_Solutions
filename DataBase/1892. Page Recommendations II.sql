/*
1892. Page Recommendations II
You are implementing a page recommendation system for a social media website. Your system will recommended a page to user_id if the page is liked by at least one friend of user_id and is not liked by user_id.

Write an SQL query to find all the possible page recommendations for every user. Each recommendation should appear as a row in the result table with these columns:

user_id: The ID of the user that your system is making the recommendation to.
page_id: The ID of the page that will be recommended to user_id.
friends_likes: The number of the friends of user_id that like page_id.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/page-recommendations-ii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
with a as (
    select user1_id, user2_id
    from Friendship
    union 
    select user2_id, user1_id
    from Friendship
)
select user1_id as user_id, 
        l.page_id, 
        count(distinct user2_id) as friends_likes  
from Likes l 
left join a 
    on l.user_id = a.user2_id
left join Likes l1 
    on l1.user_id = user1_id 
    and l1.page_id = l.page_id
where l1.page_id is null
group by 1,2
