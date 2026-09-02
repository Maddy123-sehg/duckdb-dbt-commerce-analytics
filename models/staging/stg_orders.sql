select
    cast(order_id as integer) as order_id,
    cast(customer_id as integer) as customer_id,
    cast(order_date as date) as order_date,
    lower(trim(status)) as order_status,
    upper(trim(currency)) as currency,
    cast(ingested_at as timestamp) as ingested_at
from {{ source('raw', 'raw_orders') }}
