select
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    c.signup_date,
    min(case when f.order_status = 'completed' then f.order_date end) as first_order_date,
    max(case when f.order_status = 'completed' then f.order_date end) as latest_order_date
from {{ ref('stg_customers') }} c
left join {{ ref('int_order_financials') }} f using (customer_id)
group by 1, 2, 3, 4

