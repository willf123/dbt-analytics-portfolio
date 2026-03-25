with orders as (
    select
        sum(amount) as total_revenue
    from {{ ref('fct_orders') }}
),

payments as (
    select
        sum(amount) as total_payments
    from {{ ref('stg_jaffle_shop__payments') }}
)

select
    *
from orders
join payments on orders.total_revenue != payments.total_payments