select
    cast(customer_id as integer) as customer_id,
    trim(customer_name) as customer_name,
    trim(segment) as customer_segment,
    cast(signup_date as date) as signup_date,
    cast(updated_at as timestamp) as updated_at,
    cast(ingested_at as timestamp) as ingested_at
from {{ source('raw', 'raw_customers') }}
