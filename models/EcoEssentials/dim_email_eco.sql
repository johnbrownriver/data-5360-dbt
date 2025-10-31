{{ config(
    materialized = 'table',
    database = 'group7project',
    schema = 'dw_eco_essentials'
) }}

select
    emailid as email_key,
    emailid as email_id,
    emailname as email_name
from {{source("eco_essentials_email_marketing_landing", 'marketing_emails')}}