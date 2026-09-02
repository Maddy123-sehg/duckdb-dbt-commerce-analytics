select date_day::date as date_day
from generate_series(
    date '2024-01-01',
    date '2026-12-31',
    interval 1 day
) as spine(date_day)

