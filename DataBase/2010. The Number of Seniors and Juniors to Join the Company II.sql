/*
2010. The Number of Seniors and Juniors to Join the Company II
A company wants to hire new employees. The budget of the company for the salaries is $70000. The company's criteria for hiring are:

Keep hiring the senior with the smallest salary until you cannot hire any more seniors.
Use the remaining budget to hire the junior with the smallest salary.
Keep hiring the junior with the smallest salary until you cannot hire any more juniors.

*/
with a as (
    select *,
            sum(salary) over (partition by experience order by salary rows unbounded preceding) as sum_salary
    from Candidates
)
select employee_id
from a 
where experience = 'Senior' and sum_salary < 70000
union
select employee_id
from a 
where experience = 'Junior' and sum_salary < (
    select 70000 - ifnull(max(sum_salary),0) as budget
    from a
    where experience = 'Senior' and sum_salary <70000
)
