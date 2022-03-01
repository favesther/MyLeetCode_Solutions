/*A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write an SQL query to find the employees who are high earners in each of the departments.

Return the result table in any order.
*/
select b.name as department, a.name as employee, a.salary
from(select *, dense_rank() over (partition by departmentid order by salary desc) rnk
from Employee) a
left join department b
on a.departmentid = b.id
where a.rnk <= 3