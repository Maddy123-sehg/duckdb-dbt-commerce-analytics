select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    sum(i.quantity) as units,
    sum(i.quantity * i.unit_price) as gross_revenue,
    sum(i.quantity * i.unit_cost) as cost_of_goods,
    sum(i.quantity * (i.unit_price - i.unit_cost)) as gross_profit
from {{ ref('stg_orders') }} o
join {{ ref('stg_order_items') }} i using (order_id)
group by 1, 2, 3, 4

