# Jaffle Shop & Red Sox Hitter Performance — dbt + BigQuery
# API weather ingestion

## Overview
This repository contains three dbt projects built on Google BigQuery,
demonstrating a full analytics engineering workflow from raw data 
to mart-layer models.

---

## Project 1: Jaffle Shop
A foundational dbt project using the classic Jaffle Shop dataset 
to demonstrate core dbt concepts.

**Models:**
- `stg_jaffle_shop__customers` — staged customer data
- `stg_jaffle_shop__orders` — staged order data
- `customers` — mart model with order metrics per customer
- `order_status_summary` — distribution of orders by status

**Tools:** dbt Cloud, BigQuery, GitHub

---

## Project 2: Red Sox Hitter Performance (2016)
An original analytics project built on the MLB BigQuery public 
dataset (`bigquery-public-data.baseball.games_wide`), analyzing 
2016 Boston Red Sox hitter performance from raw pitch-by-pitch data.

**Model Layers:**
- `stg_baseball__at_bats` — filters to at-bats, derives hitter 
team from batting order columns
- `int_hitter_plate_appearances` — classifies each at-bat by hit 
type (single, double, triple, home run)
- `fct_hitter_season_stats` — aggregates counting and rate stats 
per player (BA, OBP, SLG, OPS)
- `mart_red_sox_hitters` — filters to Red Sox, ranks players by OPS

**Known Limitation:** OBP in this dataset reflects hit-based 
on-base events only. Walks are not captured in the source data.

**Tools:** dbt Cloud, BigQuery, GitHub

---

## Stack
- **Warehouse:** Google BigQuery
- **Transformation:** dbt Cloud
- **Version Control:** GitHub


## Project 3: Tampa Weather API Ingestion
A Python ingestion pipeline built in Google Colab that pulls 
7-day weather forecast data for Tampa, FL from the Open-Meteo 
API and loads it into BigQuery.

**Tools:** Python, Google Colab, BigQuery, Pandas, Open-Meteo API
