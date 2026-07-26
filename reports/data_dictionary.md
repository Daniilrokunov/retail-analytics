## 1. Customers
**Описание:** Информация о клиентах. Один `customer_unique_id` может соответствовать нескольким `customer_id`.

| Поле                       | Тип PostgreSQL | Ключ | Nullable | Описание                           | Использование       |
|----------------------------|----------------|------|----------|------------------------------------|---------------------|
| `customer_id`              | VARCHAR(32)    | PK   | ❌        | Идентификатор записи клиента       | JOIN с orders       |
| `customer_unique_id`       | VARCHAR(32)    |      | ❌        | Уникальный идентификатор покупателя | RFM, LTV, Retention |
| `customer_zip_code_prefix` | INTEGER        |      | ❌        | Почтовый индекс                    | Геоанализ           |
| `customer_city`            | VARCHAR(100)   |      | ❌        | Город                              | Анализ продаж       |
| `customer_state`           | CHAR(2)        |      | ❌        | Штат                               | Региональный анализ |

## 2. Orders
**Описание:** Основная таблица проекта.

| Поле                            | Тип PostgreSQL | Ключ | Nullable | Описание             | Использование     |
|---------------------------------|----------------|------|----------|----------------------|-------------------|
| `order_id`                      | VARCHAR(32)    | PK   | ❌        | Идентификатор заказа | Основной JOIN     |
| `customer_id`                   | VARCHAR(32)    | FK   | ❌        | Клиент               | JOIN с customers  |
| `order_status`                  | VARCHAR(30)    |      | ❌        | Статус заказа        | Анализ воронки    |
| `order_purchase_timestamp`      | TIMESTAMP      |      | ❌        | Дата покупки         | Временной анализ  |
| `order_approved_at`             | TIMESTAMP      |      | ✅        | Подтверждение заказа | Время обработки   |
| `order_delivered_carrier_date`  | TIMESTAMP      |      | ✅        | Передача перевозчику | Логистика         |
| `order_delivered_customer_date` | TIMESTAMP      |      | ✅        | Доставка клиенту     | ML-признак        |
| `order_estimated_delivery_date` | TIMESTAMP      |      | ❌        | Плановая доставка    | Расчет задержки   |

## 3. Order items
**Описание:** Товары внутри заказа. Первичный ключ — составной: (`order_id`, `order_item_id`).

| Поле                 | Тип PostgreSQL | Ключ  | Nullable | Описание           |
|----------------------|----------------|-------|----------|--------------------|
| `order_id`           | VARCHAR(32)    | PK/FK | ❌        | Заказ              |
| `order_item_id`      | SMALLINT       | PK    | ❌        | Позиция в заказе   |
| `product_id`         | VARCHAR(32)    | FK    | ❌        | Товар              |
| `seller_id`          | VARCHAR(32)    | FK    | ❌        | Продавец           |
| `shipping_limit_date`| TIMESTAMP      |       | ❌        | Срок отправки      |
| `price`              | NUMERIC(10,2)  |       | ❌        | Стоимость товара   |
| `freight_value`      | NUMERIC(10,2)  |       | ❌        | Стоимость доставки |

## 4. Payments
**Описание:** Информация об оплате заказов. Первичный ключ — составной: (`order_id`, `payment_sequential`).

| Поле                  | Тип PostgreSQL | Ключ  | Nullable | Описание      |
|-----------------------|----------------|-------|----------|---------------|
| `order_id`            | VARCHAR(32)    | PK/FK | ❌        | Заказ         |
| `payment_sequential`  | SMALLINT       | PK    | ❌        | Номер платежа |
| `payment_type`        | VARCHAR(30)    |       | ❌        | Тип оплаты    |
| `payment_installments`| SMALLINT       |       | ❌        | Рассрочка     |
| `payment_value`       | NUMERIC(10,2)  |       | ❌        | Сумма оплаты  |

## 5. Reviews
**Описание:** Отзывы клиентов. Первичный ключ — составной: (`review_id`, `order_id`).

| Поле                      | Тип PostgreSQL | Ключ  | Nullable   | Описание        |
|---------------------------|----------------|-------|------------|-----------------|
| `review_id`               | VARCHAR(32)    | PK    | ❌        | Отзыв           |
| `order_id`                | VARCHAR(32)    | PK/FK | ❌        | Заказ           |
| `review_score`            | SMALLINT       |       | ❌        | Оценка 1–5      |
| `review_comment_title`    | TEXT           |       | ✅        | Заголовок       |
| `review_comment_message`  | TEXT           |       | ✅        | Текст           |
| `review_creation_date`    | TIMESTAMP      |       | ❌        | Дата создания   |
| `review_answer_timestamp` | TIMESTAMP      |       | ❌        | Дата публикации |

## 6. Products
**Описание:** Информация о товарах.

| Поле                         | Тип PostgreSQL | Ключ | Nullable | Описание                    |
|------------------------------|----------------|------|----------|-----------------------------|
| `product_id`                 | VARCHAR(32)    | PK   | ❌        | Идентификатор товара        |
| `product_category_name`      | VARCHAR(100)   | FK   | ✅        | Название категории         |
| `product_name_lenght`        | SMALLINT       |      | ✅        | Длина названия (в символах) |
| `product_description_lenght` | SMALLINT       |      | ✅        | Длина описания (в символах) |
| `product_photos_qty`         | SMALLINT       |      | ✅        | Количество фотографий       |
| `product_weight_g`           | INTEGER        |      | ✅        | Вес (в граммах)             |
| `product_length_cm`          | NUMERIC(6,2)   |      | ✅        | Длина (в сантиметрах)       |
| `product_height_cm`          | NUMERIC(6,2)   |      | ✅        | Высота (в сантиметрах)      |
| `product_width_cm`           | NUMERIC(6,2)   |      | ✅        | Ширина (в сантиметрах)      |

## 7. Sellers
**Описание:** Информация о продавцах.

| Поле                     | Тип PostgreSQL | Ключ | Nullable | Описание                  |
|--------------------------|----------------|------|----------|---------------------------|
| `seller_id`              | VARCHAR(32)    | PK   | ❌        | Идентификатор продавца    |
| `seller_zip_code_prefix` | INTEGER        |      | ❌        | Почтовый индекс продавца  |
| `seller_city`            | VARCHAR(100)   |      | ❌        | Город продавца            |
| `seller_state`           | CHAR(2)        |      | ❌        | Штат продавца             |

## 8. Category translation
**Описание:** Перевод категорий товаров.

| Поле                            | Тип PostgreSQL | Ключ | Nullable | Описание                  |
|---------------------------------|----------------|------|----------|---------------------------|
| `product_category_name`         | VARCHAR(100)   | PK   | ❌        | Название категории (порт.)|
| `product_category_name_english` | VARCHAR(100)   |      | ❌        | Название категории (англ.)|

## 9. Geolocation
**Описание:** Данные геолокации.

| Поле                         | Тип PostgreSQL | Ключ | Nullable | Описание                   |
|------------------------------|----------------|------|----------|----------------------------|
| `geolocation_id`             | SERIAL         | PK   | ❌        | Суррогатный ключ           |
| `geolocation_zip_code_prefix`| INTEGER        |      | ❌        | Почтовый индекс геолокации |
| `geolocation_lat`            | NUMERIC(9,6)   |      | ❌        | Широта                     |
| `geolocation_lng`            | NUMERIC(9,6)   |      | ❌        | Долгота                    |
| `geolocation_city`           | VARCHAR(100)   |      | ❌        | Город                      |
| `geolocation_state`          | CHAR(2)        |      | ❌        | Штат                       |

> 📌 **Примечания:** 
- В исходном датасете нет уникального ключа для таблицы `geolocation`, поэтому добавлен суррогатный ключ `geolocation_id`.
- В связи с неуникальностью `review_id` в таблице `reviews` создан первичный составной ключ: (`review_id`, `order_id`).