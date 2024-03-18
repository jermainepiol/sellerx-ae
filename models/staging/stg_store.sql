with

source as(
    select * from {{source('sellerx-test', 'store') }}

),

staged as (
select 
    id,
    name,
    country,
    typology
from source

)

select * from staged