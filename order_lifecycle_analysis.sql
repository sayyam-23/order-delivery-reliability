WITH item_metrics AS (
    SELECT
        order_id,
        COUNT(*) AS item_lines,
        COUNT(DISTINCT seller_id) AS distinct_sellers,
        SUM(price) AS item_value,
        SUM(freight_value) AS freight_value
    FROM order_items
    GROUP BY order_id
),

payment_metrics AS (
    SELECT
        order_id,
        SUM(payment_value) AS paid_amount,
        COUNT(*) AS payment_records,
        COUNT(DISTINCT payment_type) AS distinct_payment_types
    FROM payments
    GROUP BY order_id
),

review_metrics AS (
    SELECT
        order_id,
        COUNT(*) AS review_records,
        AVG(review_score) AS avg_review_score
    FROM reviews
    GROUP BY order_id
)

SELECT
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_state,
    o.order_status,

    CAST(o.order_purchase_timestamp AS TIMESTAMP)
        AS order_purchase_timestamp,
    CAST(o.order_approved_at AS TIMESTAMP)
        AS order_approved_at,
    CAST(o.order_delivered_carrier_date AS TIMESTAMP)
        AS order_delivered_carrier_date,
    CAST(o.order_delivered_customer_date AS TIMESTAMP)
        AS order_delivered_customer_date,
    CAST(o.order_estimated_delivery_date AS TIMESTAMP)
        AS order_estimated_delivery_date,

    i.item_lines,
    i.distinct_sellers,
    i.item_value,
    i.freight_value,

    p.paid_amount,
    p.payment_records,
    p.distinct_payment_types,

    r.review_records,
    r.avg_review_score,

    CASE
        WHEN o.order_status = 'delivered'
         AND o.order_delivered_customer_date IS NOT NULL
         AND o.order_estimated_delivery_date IS NOT NULL
        THEN
            CAST(
                CAST(
                    o.order_delivered_customer_date AS TIMESTAMP
                ) AS DATE
            )
            >
            CAST(
                CAST(
                    o.order_estimated_delivery_date AS TIMESTAMP
                ) AS DATE
            )
        ELSE NULL
    END AS arrived_late_calendar

FROM orders AS o

LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id

LEFT JOIN item_metrics AS i
    ON o.order_id = i.order_id

LEFT JOIN payment_metrics AS p
    ON o.order_id = p.order_id

LEFT JOIN review_metrics AS r
    ON o.order_id = r.order_id
