select distinct  u.user_id seller_id, ifnull(if(u.favorite_brand = t.item_brand,'yes','no'),'no') 2nd_item_fav_brand
from Users u
left join 
(select seller_id, item_brand, rank() over (partition by seller_id order by order_date) rnk
from Orders o 
left join Items i on i.item_id = o.item_id) t on t.rnk = 2 and t.seller_id = u.user_id
