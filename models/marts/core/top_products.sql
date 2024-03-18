with 

valid_transactions as(
    select product_name,
            product_sku,
            sum(amount) as total_amount
    from {{ ref('fct_valid_transactions') }}
    group by 1, 2
    order by 3 desc
)

select * 
from valid_transactions
limit 25