/*
Indexes optimized for analytics and ML feature generation
*/

-- Orders
CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

CREATE INDEX idx_orders_purchase_ts
ON orders(order_purchase_timestamp);

CREATE INDEX idx_orders_status
ON orders(order_status);

-- Order Items
CREATE INDEX idx_order_items_order_id
ON order_items(order_id);

CREATE INDEX idx_order_items_product_id
ON order_items(product_id);

CREATE INDEX idx_order_items_seller_id
ON order_items(seller_id);

-- Reviews
CREATE INDEX idx_reviews_order_id
ON reviews(order_id, review_id);

CREATE INDEX idx_reviews_score
ON reviews(review_score);

-- Payments
CREATE INDEX idx_payments_order_id
ON payments(order_id);

-- Products
CREATE INDEX idx_products_category
ON products(product_category_name);

-- Customers
CREATE INDEX idx_customers_unique_id
ON customers(customer_unique_id);

CREATE INDEX idx_customers_state
ON customers(customer_state);

-- Sellers
CREATE INDEX idx_sellers_state
ON sellers(seller_state);