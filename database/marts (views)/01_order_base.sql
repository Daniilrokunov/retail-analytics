CREATE OR REPLACE VIEW order_base AS
SELECT o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    r.review_id,
    r.review_score,
    CASE
        WHEN r.review_score IN (1, 2) THEN 1
        ELSE 0
    END AS target_negative_review
FROM orders o
    LEFT JOIN customers c ON o.customer_id = c.customer_id
    LEFT JOIN reviews r ON o.order_id = r.order_id;