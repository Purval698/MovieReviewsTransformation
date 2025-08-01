{{ config(materialized = 'table') }}

with raw_ratings as
(
    select * from {{ source('netflix', 'r_ratings')}}
)
select 
        userid as user_id,
        movieid as movie_id,
        rating,
        to_timestamp_ltz(timestamp) as rating_timestamp
from 
    raw_ratings