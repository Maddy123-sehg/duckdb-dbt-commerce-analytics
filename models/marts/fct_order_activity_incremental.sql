{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='delete+insert'
) }}

select
    order_id,
    customer_id,
    order_date,
    order_status,
    recognized_revenue,
    recognized_gross_profit,
    current_timestamp as dbt_loaded_at
from {{ ref('fct_orders') }}

{% if is_incremental() %}
where order_date >= (select coalesce(max(order_date), date '1900-01-01') from {{ this }})
{% endif %}

