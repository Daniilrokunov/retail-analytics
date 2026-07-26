select 
from orders o 
left join customers c   
on o.customer_id = c.customer_id 

left join reviews r 
on o.order_id = r.order_id 
and o.review_id = r.review_id