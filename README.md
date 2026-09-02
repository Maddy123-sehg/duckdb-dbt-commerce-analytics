# DuckDB + dbt Commerce Analytics

A portfolio-sized analytics engineering project for a commerce team that needs trusted customer and order KPIs. It demonstrates layered SQL transformations, data quality tests, lineage, documentation, and a dbt Semantic Layer contract—all running locally with DuckDB.

## Business use case

Sales and finance need one consistent answer for completed revenue, gross profit, order volume, and average order value. Raw customers, order headers, and line items are cleaned in staging, joined and aggregated in an intermediate layer, and exposed as dimensional marts plus governed metrics.

## Project structure

- `seeds/`: small, deterministic source datasets
- `models/staging/`: renaming, typing, and source-quality checks
- `models/intermediate/`: reusable order-level financial logic
- `models/marts/`: fact, dimension, and BI-ready customer aggregate
- `models/semantic/`: semantic model and governed metrics
- `tests/`: business-rule singular tests

## Run locally

Requires Python 3.10+.

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
dbt build --profiles-dir .
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

## Governed metrics

- `total_revenue`: revenue from completed orders
- `total_gross_profit`: gross profit from completed orders
- `completed_order_count`: count of completed orders
- `average_order_value`: completed revenue divided by completed orders

Semantic definitions are included for dbt environments that support the dbt Semantic Layer.
