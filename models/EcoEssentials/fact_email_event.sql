{{ config(
    materialized = 'table',
    database = 'group7project',
    schema = 'dw_eco_essentials'
) }}

select
    emaileventid as emailevent_key,
    e.email_key,
    cu.customer_key,
    ca.campaign_key,
    d.date_key,
    m.sendtimestamp as send_timestamp,
    m.eventtype as event_type,
    m.eventtimestamp as event_timestamp

from {{source("eco_essentials_email_marketing_landing", 'marketing_emails')}} m
inner join {{ref('dim_email_eco')}} e
    on m.emailid = e.email_id
left join {{ref('dim_customer_eco')}} cu
    on nullif(m.customerid, 'NULL')::int = cu.customer_id
inner join {{ref('dim_campaign_eco')}} ca
    on m.campaignid = ca.campaign_id
inner join {{ref('dim_date_eco')}} d
    on CAST(m.sendtimestamp AS DATE) = d.full_date
