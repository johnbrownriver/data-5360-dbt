{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
store_id as store_key,
store_id,
city,
state,
street,
store_name
FROM {{ source('oliver_landing', 'store') }}