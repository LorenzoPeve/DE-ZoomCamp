{{ config(materialized='table') }}

with trips_2001_larger_100 as (
    SELECT *
    from {{ source("ny_taxi", "ny_taxi") }}
    where tpep_pickup_datetime >= '2021-01-01'
    AND fare_amount >= 100
)

select *
from trips_2001_larger_100