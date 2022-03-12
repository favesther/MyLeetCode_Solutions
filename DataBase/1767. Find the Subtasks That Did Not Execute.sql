/*
1767. Find the Subtasks That Did Not Execute
Table: Tasks

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| task_id        | int     |
| subtasks_count | int     |
+----------------+---------+
task_id is the primary key for this table.
Each row in this table indicates that task_id was divided into subtasks_count subtasks labeled from 1 to subtasks_count.
It is guaranteed that 2 <= subtasks_count <= 20.
 

Table: Executed

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| task_id       | int     |
| subtask_id    | int     |
+---------------+---------+
(task_id, subtask_id) is the primary key for this table.
Each row in this table indicates that for the task task_id, the subtask with ID subtask_id was executed successfully.
It is guaranteed that subtask_id <= subtasks_count for each task_id.

Write an SQL query to report the IDs of the missing subtasks for each task_id.
*/
with recursive cte(n) as (
    select 1
    union all
    select n+1
    from cte  
    where n<20
)
select t.task_id, c.n subtask_id 
from Tasks t
left join cte c
on t.subtasks_count >= c.n 
left join Executed e 
on e.task_id = t.task_id and e.subtask_id = c.n
where e.task_id is null
order by 1