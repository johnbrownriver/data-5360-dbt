{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
    c.customer_key,
    d.date_key,
    s.store_key,
    p.product_key,
    e.employee_key,
    ol.quantity,
    (ol.quantity * ol.unit_price) as dollars_sold,
    ol.unit_price

FROM {{ source('oliver_landing', 'orders') }} o
inner join {{source("oliver_landing", 'orderline')}} ol 
    on o.order_id = ol.order_id
inner join {{ref('oliver_dim_customer')}} c
    on o.customer_id = c.customer_id
inner join {{ref('oliver_dim_date')}} d 
    on o.order_date = d.date_day
inner join {{ref('oliver_dim_employee')}} e 
    on o.employee_id = e.employee_id
inner join {{ref('oliver_dim_product')}} p 
    on ol.product_id = p.product_id
inner join {{ref('oliver_dim_store')}} s 
    on o.store_id = s.store_id