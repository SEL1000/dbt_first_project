WITH _returns AS(
    SELECT
        sales_id,
        store_sk,
        product_sk,
        {{ multiply('returned_qty', 'refund_amount') }} AS total_refund_amount,
        return_reason,
        refund_amount
    FROM {{ ref('bronze_returns') }}
),
sales AS (
    SELECT
        sales_id,
        gross_amount,
        payment_method
    FROM {{ ref('bronze_sales') }}
),
store AS(
    SELECT
        store_sk,
        store_name,
        city,
        country,
        sq_ft
    FROM {{ ref('bronze_store') }}
),
product AS(
    SELECT
        product_sk,
        category
    FROM {{ ref('bronze_product') }}
),

joined_query AS(

    SELECT
        _returns.sales_id,
        _returns.return_reason,
        _returns.refund_amount,
        _returns.total_refund_amount,
        sales.gross_amount,
        sales.payment_method,
        store.city,
        store.store_name,
        store.country,
        store.sq_ft,
        product.category
    FROM 
        _returns
    JOIN
        sales
    ON _returns.sales_id = sales.sales_id
    JOIN
        store
    ON _returns.store_sk = store.store_sk
    JOIN
        product
    ON _returns.product_sk = product.product_sk

)


SELECT
    category,
    SUM(total_refund_amount) AS total_refunds
FROM joined_query
GROUP BY category
ORDER BY total_refunds DESC

