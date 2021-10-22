{%- set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] -%}

with orders as (

    select * from {{ ref('stg_payments') }}

),

pivoted as (

    select 
      created_at

      {% for method in payment_methods %}
      , sum(case when payment_method = '{{ method }}' then 1 else 0 end) as {{ method }}_orders
      {%- endfor %}

    from orders
    where status = 'success'
    group by 1

)

select * from pivoted