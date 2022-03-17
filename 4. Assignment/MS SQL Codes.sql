with T1 as(
select distinct a.product_id,b.discount,
	   count(c.order_id) over (partition by a.product_id,b.discount order by b.discount) order_count
from product.product a, sale.order_item b, sale.orders c
where a.product_id=b.product_id and
	  b.order_id=c.order_id
	  ),
	  T2 as
	  (
	  select product_id, discount, order_count,
	  lag(order_count) over(partition by product_id order by discount) pre_order_count,
	  			CASE
				WHEN order_count >  lag(order_count) over(partition by product_id order by discount) THEN  1
				WHEN order_count <  lag(order_count) over(partition by product_id order by discount) THEN -1
				WHEN order_count = 	lag(order_count) over(partition by product_id order by discount) THEN  0	
				ELSE null
				END Comparing
	  from T1
	  ),
	  T3 as
	  (
	  select  product_id,
	  	  		CASE
				WHEN sum(Comparing) over(partition by product_id )=0 THEN  'Neutral'
				WHEN sum(Comparing) over(partition by product_id )>0 THEN  'Positive'
				WHEN sum(Comparing) over(partition by product_id )<0 THEN  'Negative'
				ELSE null
				END Comparing
	  from  T2
	  )
	  select distinct A.product_id, (ISNULL (CONVERT (VARCHAR(20), B.Comparing), 'Insufficient data')) Discount_Effect
	  from 	  product.product A	  	 
	  LEFT JOIN T3 B on A.product_id=B.product_id
	  order by product_id