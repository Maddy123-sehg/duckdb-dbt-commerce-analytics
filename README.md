# DuckDB + dbt Commerce Analytics

A portfolio-sized analytics engineering project for a commerce team that needs trusted customer and order KPIs. It demonstrates layered SQL transformations, data quality tests, lineage, documentation, and a dbt Semantic Layer contract—all running locally with DuckDB.

[![dbt CI](https://github.com/Maddy123-sehg/duckdb-dbt-commerce-analytics/actions/workflows/dbt-ci.yml/badge.svg)](https://github.com/Maddy123-sehg/duckdb-dbt-commerce-analytics/actions/workflows/dbt-ci.yml)

## Business use case

Sales and finance need one consistent answer for completed revenue, gross profit, order volume, and average order value. Raw customers, order headers, and line items are cleaned in staging, joined and aggregated in an intermediate layer, and exposed as dimensional marts plus governed metrics.

## Lineage

```text
CSV seeds -> staging views -> int_order_financials -> fct_orders -> customer_performance
                         \-----------------------> dim_customers -----/
```

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
cp profiles.yml.example profiles.yml
dbt deps --profiles-dir .
dbt build --profiles-dir .
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

`dbt build` seeds the raw inputs, builds every transformation, and runs schema and business-rule tests. The generated `dev.duckdb`, `target/`, and logs are ignored by Git.

## Governed metrics

- `total_revenue`: revenue from completed orders
- `total_gross_profit`: gross profit from completed orders
- `completed_order_count`: count of completed orders
- `average_order_value`: completed revenue divided by completed orders

Semantic definitions are included for dbt environments that support the dbt Semantic Layer. The core DuckDB transformation workflow does not require a separate metrics service.

## Design notes

- Raw financial values are retained while recognized values explicitly apply the completed-order rule.
- The intermediate model is ephemeral to demonstrate modular logic without creating an extra relation.
- Marts use fact/dimension grains suitable for BI tools and ad hoc analysis.
- Tests cover keys, relationships, accepted values, nulls, and a domain rule.
- `fct_order_activity_incremental` demonstrates idempotent incremental processing.
- `customers_snapshot` preserves SCD Type 2 customer changes.
- The `safe_divide` macro centralizes defensive ratio logic.
- Pull requests run the complete project through GitHub Actions.
