with 

valid_transactions as(
    select * from {{ ref('fct_valid_transactions') }}
),

devices as(
    select  * from {{ ref('stg_devices') }}
),

stores as(
    select * from {{ ref('stg_stores') }}
),

top_stores as(
    select s.name as store_name,
        s.country,
        s.typology,
        sum(amount) as total_amount
    from valid_transactions vt
    left join devices d on vt.device_id = d.id
    left join stores s on d.store_id = s.id
    group by 1, 2, 3
    order by 4 desc

)

select *  from top_stores limit 10