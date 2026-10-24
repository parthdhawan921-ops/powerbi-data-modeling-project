# Tables in the clean model

| Table | Type | Rows | Columns |
| --- | --- | --- | --- |
| `fact_sales` | Fact | 200 | line_id, order_id, quantity, unit_price, unit_cost, discount_pct, line_total, order-date, customer_id, product_key, flag_key, ship_to_city_key, bill_to_city_key |
| `fact_order_process` | Fact | 97 | order_id, customer_id, order_date, ship_date, delivery_date, invoice_date, pay_date |
| `fact_inventory` | Fact | 288 | product_key, month, units |
| `fact_campaign_spend` | Fact | 140 | campaign_key, date, impressions, clicks, Spend |
| `fact_promotion_coverage` | Fact | 30 | campaign_key, product_key |
| `fact_sales_target` | Fact | 20 | date, target_revenue |
| `dim_customer` | Dimension | 60 | customer_id, customer_name, segment, account_manager, payment_terms, contact_name, email, credit_limit, phone, street, city_name, region_name |
| `dim_product` | Dimension | 60 | product_key, product_code, product_name, brand, subcategory, category, unit_price, supplier |
| `dim_geo` | Dimension | 20 | geo_key, city, region |
| `dim_order_flag` | Dimension | 14 | flag_key, channel_name, status, priority, channel_code |
| `dim_campaign` | Dimension | 6 | campaign_key, campaign_name, channel, start_date, end_date, budget |
| `dim_date` | Dimension | 730 | date, year, month, day |
| `security` | Security | 5 | user_email, region |
