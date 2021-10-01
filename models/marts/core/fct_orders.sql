with orders as (

    select * from {{ ref('stg_orders')}}

),

payments as (

    select * from {{ ref('stg_payments')}}

),

final as (

    select 
        orders.order_id,
        orders.order_date,
        orders.customer_id,
        sum(payments.amount) as order_total

    from orders

    left join payments using (order_id)

    where payments.status = 'success'

    group by 1, 2, 3

)

select * from final