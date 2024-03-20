with 

transactions as(
    -- getting all transactions regardless of status
    select * from {{ ref('fct_all_details') }}
),

join_transactions as(
     select t.store_name,
            t.country,
            t.typology,
            t.store_created_at,
            t.transaction_created_at,
            -- labeling rownum in order to get first 5 transactions by store 
            row_number() over (partition by t.store_name order by t.transaction_created_at) as rownum
     from transactions t
     where t.transaction_created_at >= t.store_created_at
),

staged as(
    select store_name,
            country,
            typology,
            round(avg(timestamp_diff(transaction_created_at, store_created_at, day)), 2) as avg_duration_days
    from join_transactions
    where rownum <=5
    group by 1, 2, 3
    order by 1, 2, 3
)

select * from staged