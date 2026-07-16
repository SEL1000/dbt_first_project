{% set fruits = ["Apple", "Banana", "Kiwi", "Orange", "Watermellon"] %}

{% for i in fruits %}

    {% if i != "Apple" %}
        {{ i }}
    {% else %}
        I hate {{ i }}
    {% endif %}
    
{% endfor %}


