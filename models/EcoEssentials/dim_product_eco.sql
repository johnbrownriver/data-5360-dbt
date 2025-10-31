{{ config(
    materialized = 'table',
    database = 'group7project',
    schema = 'dw_eco_essentials'
    )
}}

select
product_id as product_key,
product_id,
product_type,
product_name,
price
from {{source('eco_essentials_online_purchases_landing', 'product')}}