/*
1412. Find the Quiet Students in All Exams
A quiet student is the one who took at least one exam and did not score the high or the low score.

Write an SQL query to report the students (student_id, student_name) being quiet in all exams. Do not return the student who has never taken any exam.

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/find-the-quiet-students-in-all-exams
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/
with cte as (
    select *,
        rank() over (partition by exam_id order by score) as rnk_low,
        rank() over (partition by exam_id order by score desc) as rnk_high
    from Exam
), cte2 as (
    select student_id, min(rnk_low) rnk_low, min(rnk_high) rnk_high
    from cte
    group by student_id
)
select distinct s.student_id, s.student_name
from cte2
left join Student s 
on cte2.student_id = s.student_id
where coalesce(rnk_low,0) != 1 and coalesce(rnk_high,0) != 1
order by 1