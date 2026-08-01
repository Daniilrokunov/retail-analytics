CREATE OR REPLACE VIEW dim_payments AS
WITH analyzed_payments AS (
    SELECT 
        order_id,
        payment_type,
        -- Total amount for the order and the payment type to determine the main type
        -- Считаем общую сумму по заказу и типу оплаты для определения основного типа
        SUM(payment_value) OVER(PARTITION BY order_id, payment_type) AS type_total,
        -- Basic payment metrics
        -- Базовые метрики для каждого платежа
        payment_value,
        payment_installments
    FROM payments
),
ranked_payments AS (
    SELECT 
        order_id,
        payment_type,
        payment_value,
        payment_installments,
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY type_total DESC) AS rn
    FROM analyzed_payments
)
SELECT 
    order_id,
    SUM(payment_value) AS total_payment,
    COUNT(*) AS payment_count,
    MAX(payment_installments) AS max_installments,
    round(AVG(payment_installments), 0) AS avg_installments,
    COUNT(DISTINCT payment_type) AS payment_type_count,
    MAX(CASE WHEN rn = 1 THEN payment_type END) AS main_payment_type
FROM ranked_payments
GROUP BY order_id;
