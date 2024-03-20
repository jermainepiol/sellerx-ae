with

transactions as(
    select * from {{ ref('fct_all_details') }}
),

final as(
    select device_type,
        -- get transaction count per device vs all transaction count
       round(count(transaction_id) / sum(count(*)) over ()*100, 2) as pct_transactions
    from transactions
  group by 1
)

select * from final