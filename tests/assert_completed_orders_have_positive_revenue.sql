select *
from {{ ref('fct_orders') }}
where order_status = 'completed'
  and recognized_revenue <= 0

