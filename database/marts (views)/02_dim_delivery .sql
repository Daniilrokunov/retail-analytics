CREATE OR REPLACE VIEW DIM_DELIVERY AS
SELECT
	ORDER_ID,
	-- Order approvement time/Время подтверждения заказа
	ROUND(
		(
			EXTRACT(
				EPOCH
				FROM
					(ORDER_APPROVED_AT - ORDER_PURCHASE_TIMESTAMP)
			) / 3600
		),
		2
	) AS APPROVAL_TIME_HOURS,
	-- Time of handover to the courier/Время передачи курьеру
	ROUND(
		(
			EXTRACT(
				EPOCH
				FROM
					(ORDER_DELIVERED_CARRIER_DATE - ORDER_APPROVED_AT)
			) / 3600
		),
		2
	) AS CARRIER_DELIVERY_HOURS,
	-- Delivery quality/Качество доставки
	-- Estimated delivery time/Планируемое время доставки
	ROUND(
		EXTRACT(
			EPOCH
			FROM
				(
					ORDER_ESTIMATED_DELIVERY_DATE - ORDER_PURCHASE_TIMESTAMP
				)
		) / 86400,
		2
	) AS ESTIMATED_DELIVERY_DAYS,
	-- Whether the order has been delivered/Доставлен ли товар
	CASE
		WHEN ORDER_DELIVERED_CUSTOMER_DATE IS NOT NULL THEN 1
		ELSE 0
	END AS DELIVERED,
	-- Full delivery time/Полное время доставки
	ROUND(
		(
			EXTRACT(
				EPOCH
				FROM
					(
						ORDER_DELIVERED_CUSTOMER_DATE - ORDER_PURCHASE_TIMESTAMP
					)
			) / 86400
		),
		2
	) AS FULL_DELIVERY_DAYS,
	-- Whether the order was late/Опаздала ли доставка		
	CASE
		WHEN ORDER_DELIVERED_CUSTOMER_DATE > ORDER_ESTIMATED_DELIVERY_DATE THEN 1
		ELSE 0
	END AS IS_DELAYED,
	-- How many days was the delivery late/На сколько дней опоздала доставка
	GREATEST(
		ROUND(
			EXTRACT(
				EPOCH
				FROM
					(
						ORDER_DELIVERED_CUSTOMER_DATE - ORDER_ESTIMATED_DELIVERY_DATE
					)
			) / 86400,
			2
		),
		0
	) AS DELIVERY_DELAY_DAYS,
	-- Delivery just on time/Доставка точно в срок
	CASE
		WHEN DATE (ORDER_DELIVERED_CUSTOMER_DATE) = DATE (ORDER_ESTIMATED_DELIVERY_DATE) THEN 1
		ELSE 0
	END AS DELIVERED_ON_TIME,
	-- Delivery ahead of schedule/Доставка раньше срока
	CASE
		WHEN ORDER_DELIVERED_CUSTOMER_DATE < ORDER_ESTIMATED_DELIVERY_DATE THEN 1
		ELSE 0
	END AS DELIVERED_EARLY,
	-- How much earlier than the due date/На сколько раньше срока
	GREATEST(
		ROUND(
			EXTRACT(
				EPOCH
				FROM
					(
						ORDER_ESTIMATED_DELIVERY_DATE - ORDER_DELIVERED_CUSTOMER_DATE
					)
			) / 86400,
			2
		),
		0
	) AS EARLIER_THAN_ESTIMATED_DAYS
FROM
	ORDERS;