with

source as(
    select * from {{source('sellerx-test', 'transaction') }}

),

staged as (
select 
    id,
    device_id,
    product_name || product_name_4 as product_name,
    product_sku,
    amount,
    status,
    created_at,
    happened_at
from source

)

select * from staged