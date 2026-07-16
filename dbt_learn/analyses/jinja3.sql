{% set inc_load_flag = 1 %}
{% set last_load_date = 3 %}

{% set columns_list = ["sales_id", "date_sk", "gross_amount"] %}

SELECT 
    {% for column in columns_list %}
        {{ column }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM 
    {{ ref('bronze_sales') }}

{% if inc_load_flag == 1 %}
    WHERE date_sk > {{ last_load_date }}
{% endif %}