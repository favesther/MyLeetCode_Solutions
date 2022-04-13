/*
534. Game Play Analysis III
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write an SQL query to report for each player and date, how many games played so far by the player. That is, the total number of games played by the player until that date. Check the example for clarity.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/game-play-analysis-iii
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
select player_id, event_date,
        sum(games_played) over (partition by player_id order by event_date rows unbounded preceding) as games_played_so_far 
from Activity
order by 1,2
