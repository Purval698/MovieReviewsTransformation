{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

with src_ratings as(
    select * from {{ ref('src_ratings') }}
)

select 
        user_id,
        movie_id,
        rating,
        rating_timestamp
from 
    src_ratings 
where rating is not null

{% if is_incremental() %}
  and rating_timestamp > (select max(rating_timestamp) from {{ this }})
{% endif %}

/*
for incremental in base src_rating table  max current_timestamp is 5 pm today
and new record is added or updated at 6 pm today
as in logic we have rating_timestamp is grater than current_timestamp then it will add or update
value in table This is how incremental model works
and 'this' means current model which is 'fct_ratings'

*/