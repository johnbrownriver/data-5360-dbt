{{ config(
    materialized = 'table',
    database = 'group7project',
    schema = 'dw_eco_essentials'
    )
}}

select 
campaign_id as campaign_key,
campaign_id,
campaign_name
campaign_discount
from {{source('eco_essentials_online_purchases_landing', 'promotional_campaign')}}
