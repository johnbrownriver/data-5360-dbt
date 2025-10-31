{{ config(
    materialized = 'table',
    database = 'group7project',
    schema = 'dw_eco_essentials'
    )
}}

with cte_date as (
{{ dbt_date.get_date_dimension("1990-01-01", "2050-12-31") }}
)

SELECT
    date_day as date_key,
    date_day as full_date,
    day_of_week,
    month_of_year as month,
    month_name,
    day_of_month,
    quarter_of_year as quarter,
    year_number as year,
    case 
        when day_of_week in (1, 7) then true
        else false
    end as is_weekend
from cte_date