with 

valid_transactions as(
    select * from {{ ref('fct_valid_transactions') }}
),

top_stores as(
    select store_name,
        country,
        typology,
        sum(amount) as total_amount
    from valid_transactions vt
    group by 1, 2, 3
    order by 4 desc

)

select *  from top_stores limit 10