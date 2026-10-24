# Relationships

All relationships are many-to-one with single-direction filtering unless noted.

| From (many) | To (one) | Active |
| --- | --- | --- |
| `fact_sales[customer_id]` | `dim_customer[customer_id]` | Yes |
| `fact_sales[product_key]` | `dim_product[product_key]` | Yes |
| `fact_sales[flag_key]` | `dim_order_flag[flag_key]` | Yes |
| `fact_sales[ship_to_city_key]` | `dim_geo[geo_key]` | Yes |
| `fact_sales[bill_to_city_key]` | `dim_geo[geo_key]` | No (role-playing) |
| `fact_inventory[product_key]` | `dim_product[product_key]` | Yes |
| `fact_promotion_coverage[product_key]` | `dim_product[product_key]` | Yes |
| `fact_promotion_coverage[campaign_key]` | `dim_campaign[campaign_key]` | Yes |
| `fact_campaign_spend[campaign_key]` | `dim_campaign[campaign_key]` | Yes |
| `fact_order_process[customer_id]` | `dim_customer[customer_id]` | Yes |
| `dim_customer[region_name]` | `security[region]` | Yes |

The shared `dim_date` table is also related to the fact tables by date (see `images/after_model.png`). `fact_order_process` connects to it through several date columns (order, ship, delivery, invoice and pay dates): one active relationship, the others inactive for use with `USERELATIONSHIP`.
