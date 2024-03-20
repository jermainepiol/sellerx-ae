with 

all_transactions as (
    select * from {{ ref('fct_all_details') }}
),

-- getting only transactions that are accepted, meaning these are the only transactions that went through
valid_transactions as(
    select *
    from all_transactions
    where status = 'accepted'
)

select * from valid_transactions