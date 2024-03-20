with 

transactions as (
    select * from {{ ref('stg_transactions') }}
),

devices as(
    select  * from {{ ref('stg_devices') }}
),

stores as(
    select * from {{ ref('stg_stores') }}
),

join_transactions as(
     select     t.id as transaction_id,
                t.device_id,
                t.product_name,
                t.product_sku,
                t.amount,
                t.status,
                t.created_at as transaction_created_at,
                t.happened_at,
                d.type as device_type,
                d.store_id,
                s.name as store_name,
                s.country,
                s.created_at as store_created_at,
                s.typology
     from transactions t
     left join devices d on t.device_id = d.id
     left join stores s on d.store_id = s.id
)

select * from join_transactions