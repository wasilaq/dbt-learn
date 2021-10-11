-- Total amount for fully refunded orders, partially refunded orders, and non-refunded orders should all be >= 0
-- Return records for cases this isn't true for the test to fail

select order_id, sum(amount)
from {{ ref('stg_payments') }}
group by 1
having sum(amount) < 0