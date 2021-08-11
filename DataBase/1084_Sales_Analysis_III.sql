select distinct p.product_id, p.product_name
from (select product_id, sale_date, buyer_id from Sales where sale_date between '2019-01-01' and '2019-03-31') s1
left join Sales s2 on (s2.sale_date<'2019-01-01' or s2.sale_date > '2019-03-31') and s1.product_id = s2.product_id
inner join Product p on s1.product_id = p.product_id 
where s2.buyer_id is null
order by 1