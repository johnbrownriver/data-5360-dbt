{{ config(
    materialized = 'table',
    database = 'group7project',
    schema = 'dw_eco_essentials'
) }}

select
    ol.order_line_id as order_line_key,
    cu.customer_key,
    p.product_key,
    ca.campaign_key,
    d.date_key,
    ol.quantity,
    ol.discount,
    ol.price_after_discount,
    o.order_timestamp

from {{source('eco_essentials_online_purchases_landing', 'order')}} as o 
inner join {{source('eco_essentials_online_purchases_landing', 'order_line')}} as ol 
    on o.order_id = ol.order_id
inner join {{ref('dim_product_eco')}} as p 
    on ol.product_id = p.product_id
inner join {{ref('dim_campaign_eco')}} as ca 
    on ol.campaign_id = ca.campaign_id
inner join {{ref('dim_customer_eco')}} as cu 
    on o.customer_id = cu.customer_id
inner join {{ref('dim_date_eco')}} as d 
    on CAST(o.order_timestamp AS DATE) = d.full_date

