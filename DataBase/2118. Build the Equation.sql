/*
2118. Build the Equation
You have a very powerful program that can solve any equation of one variable in the world. The equation passed to the program must be formatted as follows:

The left-hand side (LHS) should contain all the terms.
The right-hand side (RHS) should be zero.
Each term of the LHS should follow the format "<sign><fact>X^<pow>" where:
<sign> is either "+" or "-".
<fact> is the absolute value of the factor.
<pow> is the value of the power.
If the power is 1, do not add "^<pow>".
For example, if power = 1 and factor = 3, the term will be "+3X".
If the power is 0, add neither "X" nor "^<pow>".
For example, if power = 0 and factor = -3, the term will be "-3".
The powers in the LHS should be sorted in descending order.

来源：力扣（LeetCode）
链接：https://leetcode.cn/problems/build-the-equation
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

with a as(
    select -1 as power, '=0' as element
    union 
    select power,
            concat(case when factor > 0 then '+' else '' end,
                    case when power = 1  then concat(factor,'X')
                        when power = 0 then cast(factor as char)
                        else concat(factor,'X^',power) end) as element
    from Terms
    order by power desc

)
select group_concat(element separator '') as equation
from a 
group by 'all'
