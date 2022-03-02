/*
608. Tree Node
"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
*/
select distinct 
        a.id, 
        case when a.p_id is null then "Root"
            when b.id is null then "Leaf"
            else "Inner" end as type  
from Tree a
left join Tree b
on b.p_id <=> a.id 
order by id