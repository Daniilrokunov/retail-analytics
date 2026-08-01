# Feature Store

## Целевая переменная

target_negative_review

Описание:
Получил ли заказ отрицательный отзыв.

Тип:
Бинарный

Описание:

1 = review_score ∈ {1,2}

0 = review_score ∈ {3,4,5}

---

# Customer Features

| Признак | Тип | Источник |
|----------|------|--------|
| previous_orders | Numeric | orders |
| repeat_customer | Binary | orders |
| previous_avg_review | Numeric | reviews |
| previous_negative_rate | Numeric | reviews |
| days_since_previous_order | Numeric | orders |

---

# Delivery Features

| Признак | Тип | Источник |
|----------|------|--------|
| approval_time_hours | Numeric | orders |
| delivery_time_days | Numeric | orders |
| estimated_delivery_days | Numeric | orders |
| delivery_delay_days | Numeric | orders |
| is_delayed | Binary | orders |

---

# Payment Features

| Признак | Тип | Источник |
|----------|------|--------|
| total_payment | Numeric | payments |
| payment_count | Numeric | payments |
| payment_type_count | Numeric | payments |
| max_installments | Numeric | payments |
| main_payment_type | Category | payments |

---

# Seller Features

| Признак | Тип | Источник |
|----------|------|--------|
| seller_orders | Numeric | order_items |
| seller_avg_review | Numeric | reviews |
| seller_negative_rate | Numeric | reviews |
| seller_avg_delivery | Numeric | orders |
| seller_avg_price | Numeric | order_items |

---

# Product Features

| Признак | Тип | Источник |
|----------|------|--------|
| total_items | Numeric | order_items |
| total_products | Numeric | order_items |
| total_price | Numeric | order_items |
| average_price | Numeric | order_items |
| total_weight | Numeric | products |
| average_weight | Numeric | products |
| total_volume | Numeric | products |
| category_count | Numeric | products |
| main_category | Category | products |

---

# Geographical Features

| Признак | Тип |
|----------|------|
| customer_state |
| seller_state |
| same_state |
| customer_city |
| seller_city |

---

# Time Features

| Признак | Тип |
|----------|------|
| purchase_hour |
| purchase_weekday |
| purchase_month |
| purchase_quarter |
| weekend_order |