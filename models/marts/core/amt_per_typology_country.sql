with 

transactions as (
    select * from {{ ref('fct_valid_transactions') }} -- we will only consider valid transactions for sold products
),

valid_transactions as(
    select typology,
           country,
           round(avg(amount), 2) as avg_amount
    from transactions
    group by 1, 2
    order by 1, 2
)

select * from valid_transactions