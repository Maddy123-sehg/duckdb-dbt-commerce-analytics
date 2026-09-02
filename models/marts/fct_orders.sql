select
    f.order_id,
    f.customer_id,
    f.order_date,
    date_trunc('month', f.order_date)::date as order_month,
    f.order_status,
    f.units,
    f.gross_revenue,
    f.cost_of_goods,
    f.gross_profit,
    case when f.order_status = 'completed' then f.gross_revenue else 0 end as recognized_revenue,
    case when f.order_status = 'completed' then f.gross_profit else 0 end as recognized_gross_profit
from {{ ref('int_order_financials') }} f

