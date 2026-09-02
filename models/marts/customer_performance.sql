select
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    count(f.order_id) filter (where f.order_status = 'completed') as completed_orders,
    coalesce(sum(f.recognized_revenue), 0) as lifetime_revenue,
    coalesce(sum(f.recognized_gross_profit), 0) as lifetime_gross_profit,
    {{ safe_divide(
        "coalesce(sum(f.recognized_revenue), 0)",
        "count(f.order_id) filter (where f.order_status = 'completed')"
    ) }} as average_order_value
from {{ ref('dim_customers') }} c
left join {{ ref('fct_orders') }} f using (customer_id)
group by 1, 2, 3
