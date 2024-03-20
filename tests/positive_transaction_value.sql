select
  id,
  amount
from {{ ref('stg_transactions') }}
where amount < 0