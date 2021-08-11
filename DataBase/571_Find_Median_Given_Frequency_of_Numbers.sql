/* notes:
* split into two situations, total count of numbers % 2
* 
*/
select avg(Number) as median
from (
    select n.*,
    @r_down:= (@r_up) as rank_down, 
    @r_up:=@r_up + n.Frequency as rank_up
    from Numbers n, (select @r_down:=0, @r_up:=0) t 
    order by n.Number
) f1, (
    select ceil(sum(Frequency)/2) center, if(sum(Frequency)%2 =0,1,0) as id
    from Numbers
) f2
where f1.rank_down < f2.center + id and f1.rnk >= f2.center