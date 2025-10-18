{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

SELECT
c.first_name as customer_first_name,
c.last_name as customer_last_name,
d.date_day,
st.store_name,
e.first_name as employee_first_name,
e.last_name as employee_last_name,
p.product_name,
s.quantity,
s.unit_price,
s.dollars_sold

from {{ref('fact_sales')}} s 
left join {{ref("oliver_dim_customer")}} c 
    on s.customer_key = c.customer_key
left join {{ref('oliver_dim_date')}} d 
    on s.date_key = d.date_key
left join {{ref('oliver_dim_employee')}} e 
    on s.employee_key = e.employee_key
left join {{ref('oliver_dim_product')}} p 
    on s.product_key = p.product_key
left join {{ref('oliver_dim_store')}} st 
    on s.store_key = st.store_key