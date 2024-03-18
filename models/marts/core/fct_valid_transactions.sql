with 

all_transactions as (
    select * from {{ ref('stg_transactions') }}
),

valid_transactions as(
    select *
    from all_transactions
    where status = 'accepted'
)

select * from valid_transactions