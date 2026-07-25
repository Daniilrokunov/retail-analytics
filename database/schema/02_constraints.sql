/*
project: retail_analysis

Description:
Add constraints to database schema
*/

--Orders
alter table orders
add constraint fk_orders_customer 
foreign key (customer_id)
references customers(customer_id);

--Order_items
alter table order_items
add constraint fk_order_items_orders 
foreign key (order_id)
references orders(order_id);

alter table order_items
add constraint fk_order_items_products
foreign key (product_id)
references products(product_id);

alter table order_items
add constraint fk_order_items_sellers
foreign key (seller_id)
references sellers(seller_id);

--Payments
alter table payments
add constraint fk_payments_orders
foreign key (order_id)
references orders(order_id);

--Reviews
alter table reviews
add constraint fk_reviews_orders
foreign key (order_id)
references orders(order_id);

--Products
alter table products
add constraint fk_products_translation
foreign key (product_category_name)
references category_translation(product_category_name);

--CHECKS

alter table reviews
add constraint chk_review_score
check (review_score between 1 and 5)

alter table order_items
add constraint chk_price
check (price >= 0);

alter table order_items
add constraint chk_freight
check (freight_value >= 0);

alter table payments
add constraint chk_payment_value
check (payment_value >= 0);

alter table payments
add constraint chk_installments
check (payment_installments >= 0);

alter table products
add constraint chk_weight
check (product_weight_g >= 0);

ALTER TABLE products
ADD CONSTRAINT chk_length
CHECK (product_length_cm >= 0);

ALTER TABLE products
ADD CONSTRAINT chk_width
CHECK (product_width_cm >= 0);

ALTER TABLE products
ADD CONSTRAINT chk_height
CHECK (product_height_cm >= 0);