/* notes:
-- recursive table
-- year() extract: year of a date
-- date(concat(year,month,date)): string to date
-- datediff()+1 to include the last/first day
*/
WITH RECURSIVE N as (
    select product_id, year(period_start) as report_year, period_end
    from Sales
    
    union all

    select product_id, report_year+1 as report_year, period_end
    from N
    where report_year+1 <= year(period_end)
)
select product_id, product_name, convert(report_year,char) report_year, 
case 
when year(t.period_end)>report_year and year(t.period_start) = report_year then (datediff(date(concat(report_year,'-12-31')),period_start)+1)*average_daily_sales
when year(t.period_end)>report_year and year(t.period_start) < report_year then (datediff(date(concat(report_year,'-12-31')),date(concat(report_year,'-01-01')))+1)*average_daily_sales
when year(t.period_end)=report_year and year(t.period_start) = report_year then (datediff(period_end, period_start)+1) *average_daily_sales
when year(t.period_end)=report_year and year(t.period_start) < report_year then (datediff(period_end, date(concat(report_year,'-01-01')))+1)*average_daily_sales
else 0 end as total_amount
from (select distinct N.product_id, product_name, report_year, s.period_start, s.period_end, s.average_daily_sales
from N
left join Sales s on s.product_id = N.product_id
left join Product p on p.product_id = N.product_id 
order by product_id) t
order by 1,3