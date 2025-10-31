{{ config(
    materialized = 'table',
    database = 'group7project',
    schema = 'dw_eco_essentials'
    )
}}

select distinct
c.customer_id as customer_key,
c.customer_id,
c.customer_first_name as first_name,
c.customer_last_name as last_name,
c.customer_phone as phone,
c.customer_address as address,
c.customer_city as city,
c.customer_state as state,
c.customer_zip as zip,
c.customer_country as country,
me.subscriberemail as email 
from {{source('eco_essentials_online_purchases_landing', 'customer')}} c
left join {{source("eco_essentials_email_marketing_landing", 'marketing_emails')}} me 
    on c.customer_id = CASE me.customerid WHEN 'NULL' THEN NULL ELSE me.customerid END