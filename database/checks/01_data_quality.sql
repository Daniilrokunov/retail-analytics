/*
==================================================
DATA QUALITY REPORT
Project: Customer Satisfaction Prediction
Dataset: Olist Brazilian E-commerce
==================================================
*/

--1. COMMON INFO
--Tables size check
SELECT 'customers' AS table_name, COUNT(*) AS rows FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'category_translation', COUNT(*) FROM category_translation;

--2. PK CHECK
select customer_id, count(*)
from customers 
group by customer_id 
having count (*)>1

select order_id, count(*)
from orders 
group by order_id 
having count (*)>1

select products_id, count(*)
from product 
group by product_id 
having count (*)>1

select seller_id, count(*)
from sellers 
group by seller_id 
having count (*)>1

--Composite PK check
select order_id, order_item_id, count(*)
from order_items
group by order_id, order_item_id
having count(*)>1

select order_id, payment_sequential, count(*)
from payments
group by order_id, payment_sequential
having count(*)>1

select order_id, payment_sequential, count(*)
from payments
group by order_id, payment_sequential
having count(*)>1

select order_id, review_id, count(*)
from Reviews
group by review_id, order_id
having count(*)>1

--3. MISSING VALUES CHECK
SELECT
COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS approved_nulls,
COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS carrier_nulls,
COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS delivered_nulls
FROM orders;

SELECT
COUNT(*) FILTER (WHERE customer_unique_id IS NULL) AS unique_id_nulls,
COUNT(*) FILTER (WHERE customer_city IS NULL) AS city_nulls,
COUNT(*) FILTER (WHERE customer_state IS NULL) AS state_nulls
FROM customers;

--REFERENTIAL INTEGRITY
--Items without order 
SELECT oi.order_id
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

--Reviews without order
SELECT r.order_id
FROM reviews r
LEFT JOIN orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

--Payments without order    
SELECT p.order_id
FROM payments p
LEFT JOIN orders o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

--DATE LOGIC CHECK
--Purchase earlier than approved
SELECT *
FROM orders
WHERE order_approved_at < order_purchase_timestamp;

--Shipment earlier than approved 
SELECT *
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

--Estimated date earlier than purchase 
SELECT *
FROM orders
WHERE order_estimated_delivery_date < order_purchase_timestamp;

--MONEY VALUES CHECK
--Negative price
SELECT *
FROM order_items
WHERE price < 0;

--Negative shipment price
SELECT *
FROM order_items
WHERE freight_value < 0;

--Negative payment value
SELECT *
FROM payments
WHERE payment_value < 0;

--DISTRIBUTION OF THE TARGET VARIABLE
SELECT
review_score,
COUNT(*) AS reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

--CATEGORICAL FEATURES CHECK
SELECT
order_status,
COUNT(*) AS orders
FROM orders
GROUP BY order_status
ORDER BY orders DESC;

SELECT
payment_type,
COUNT(*) AS payments
FROM payments
GROUP BY payment_type
ORDER BY payments DESC;

SELECT
product_category_name,
COUNT(*) AS products
FROM products
GROUP BY product_category_name
ORDER BY products DESC;

--GEOGRAPHY 
SELECT
customer_state,
COUNT(*) AS customers
FROM customers
GROUP BY customer_state
ORDER BY customers DESC;

SELECT
seller_state,
COUNT(*) AS sellers
FROM sellers
GROUP BY seller_state
ORDER BY sellers DESC;

--ML METRICS
--Mean items quantity in orders
select avg (items_count) as mean
from (
 select order_id, count(*) as items_count
 from order_items
 group by order_id
) t

--Mean order value
select avg(order_value)
from (
    select order_id, sum(price) order_value
    from order_items
    group by order_id
)t