with

source as(
    select * from {{source('sellerx-test', 'store') }}

),

staged as (
select 
    id,
    name,
    country,
    created_at,
    typology
from source

)

select * from staged