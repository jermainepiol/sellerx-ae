with

source as(
    select * from {{source('sellerx-test', 'device') }}

),

staged as (
select 
    id,
    type,
    store_id
from source

)

select * from staged