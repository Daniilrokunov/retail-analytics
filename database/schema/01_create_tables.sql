create table customers (
    customer_id varchar(32) primary key,
    customer_unique_id varchar(32) not null,
    customer_zip_code_prefix integer not null,
    customer_city varchar(100) not null,
    customer_state char (2) not null
);

CREATE TABLE sellers (
    seller_id VARCHAR(32) PRIMARY KEY,
    seller_zip_code_prefix INTEGER NOT NULL,
    seller_city VARCHAR(100) NOT NULL,
    seller_state CHAR(2) NOT NULL
);

CREATE TABLE category_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id VARCHAR(32) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght SMALLINT,
    product_description_lenght SMALLINT,
    product_photos_qty SMALLINT,
    product_weight_g INTEGER,
    product_length_cm NUMERIC(6,2),
    product_height_cm NUMERIC(6,2),
    product_width_cm NUMERIC(6,2)
);

CREATE TABLE orders (
    order_id VARCHAR(32) PRIMARY KEY,
    customer_id VARCHAR(32) NOT NULL,
    order_status VARCHAR(30) NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP NOT NULL
);

CREATE TABLE order_items (
    order_id VARCHAR(32) NOT NULL,
    order_item_id SMALLINT NOT NULL,
    product_id VARCHAR(32) NOT NULL,
    seller_id VARCHAR(32) NOT NULL,
    shipping_limit_date TIMESTAMP NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    freight_value NUMERIC(10,2) NOT NULL,

    PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE payments (
    order_id VARCHAR(32) NOT NULL,
    payment_sequential SMALLINT NOT NULL,
    payment_type VARCHAR(30) NOT NULL,
    payment_installments SMALLINT NOT NULL,
    payment_value NUMERIC(10,2) NOT NULL,

    PRIMARY KEY (order_id, payment_sequential)
);

CREATE TABLE reviews (
    review_id VARCHAR(32),
    order_id VARCHAR(32) NOT NULL,
    review_score SMALLINT NOT NULL,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL,

    PRIMARY KEY (review_id, order_id);  --делаем составной первичный ключ
);

CREATE TABLE geolocation (
    geolocation_zip_code_prefix INTEGER NOT NULL,
    geolocation_lat NUMERIC(9,6) NOT NULL,
    geolocation_lng NUMERIC(9,6) NOT NULL,
    geolocation_city VARCHAR(100) NOT NULL,
    geolocation_state CHAR(2) NOT NULL
);