# Order Delivery Reliability & Operational Improvement

## Project Overview

Why are some e-commerce orders delivered late, and where should a business focus its improvement efforts?

In this project, I used SQL and Python to analyze the Olist Brazilian E-Commerce dataset and investigate delivery performance for orders delivered to Rio de Janeiro, Brazil.

The analysis compares seller-route groups, examines estimated shipping distances, quantifies delivery-rate differences, and models hypothetical improvements to translate the findings into practical business recommendations.

## Business Questions

- Do orders involving sellers outside Rio de Janeiro have different late-delivery rates from orders involving only RJ sellers?
- How does estimated shipping distance relate to delivery performance for orders shipped from São Paulo to Rio de Janeiro?
- How could potential reductions in late deliveries inform operational planning?

## Key Findings

### 1. Delivery performance differed by seller route

| Seller group | Delivered orders | Late orders | Late-delivery rate |
|---|---:|---:|---:|
| Outside-RJ sellers only | 11,389 | 1,450 | 12.73% |
| RJ sellers only | 944 | 45 | 4.77% |


<img width="887" height="447" alt="Screenshot 2026-10-17 at 3 08 54 PM" src="https://github.com/user-attachments/assets/357b42af-b4c2-42b9-b80b-4af211345e1d" />


*Orders involving only outside-RJ sellers had a 12.73% late-delivery rate, compared with 4.77% for orders involving only RJ sellers.*


The observed difference was **7.96 percentage points**, with an approximate 95% confidence interval of 6.47 to 9.46 percentage points.

The median time from carrier handoff to customer delivery was 9.09 days for outside-RJ seller orders, compared with 2.23 days for RJ-only seller orders.

### 2. The SP-to-RJ route is worth investigating

Among 8,128 eligible delivered orders involving sellers from São Paulo and customers in Rio de Janeiro, 1,152 were late.

More distant groups tended to have longer median transit times, although late-delivery rates did not increase consistently across all distance groups.

### 3. Improvement scenarios help quantify possible outcomes

A hypothetical 20% relative reduction in the outside-RJ group's late-delivery rate would correspond to approximately **290 fewer late orders**, assuming order volume remained unchanged.

This is an illustrative scenario, not a forecast or a guarantee of improvement.

## Recommendations

- Investigate carrier performance and delivery exceptions on the SP-to-RJ route.
- Examine the delivery process after carrier handoff to identify potential delays.
- Pilot improvements such as better shipment tracking and earlier escalation of delayed shipments.
- Measure late-delivery rates, median transit times, customer review scores, and operational costs before and after an intervention.

## Methodology

1. Loaded and inspected six related order, item, payment, review, customer, and seller tables.
2. Used SQL and DuckDB common table expressions (CTEs) to aggregate related records before joining them to orders.
3. Validated row counts and unique order IDs.
4. Compared route-level late-delivery rates and applied a two-proportion statistical test.
5. Estimated straight-line distances using postal-code-prefix coordinates and the Haversine formula.
6. Modeled hypothetical improvement scenarios and translated the results into operational recommendations.

## Tools Used

- **SQL:** DuckDB, joins, aggregations, and common table expressions
- **Python:** Pandas and NumPy
- **Visualization:** Matplotlib
- **Statistics:** Confidence intervals and a two-proportion z-test
- **Environment:** Jupyter Notebook

## Dataset

Source: [Brazilian E-Commerce Public Dataset by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains anonymized Brazilian e-commerce order information from 2016–2018.

The raw dataset is not included in this repository. Download it from the original source and follow the dataset's **CC BY-NC-SA 4.0** license and attribution requirements.

## How to Run

1. Clone or download this repository.
2. Install the Python dependencies listed in `requirements.txt`.
3. Download the Olist dataset from Kaggle and extract the required CSV files.
4. Place the required CSV files alongside the notebook.
5. Open `Order_Lifecycle_Analysis.ipynb` in Jupyter and run the cells in order.

The analysis uses these files:

- `olist_orders_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_order_payments_dataset.csv`
- `olist_order_reviews_dataset.csv`
- `olist_customers_dataset.csv`
- `olist_sellers_dataset.csv`
- `olist_geolocation_dataset.csv`

## Limitations

This is an observational analysis of historical data. The results identify associations, not proof that seller location or distance causes late delivery. Carrier performance, product characteristics, and other operational factors may contribute to the differences.

Estimated distances are straight-line approximations based on postal-code-prefix coordinates, rather than actual transport routes. The improvement scenarios are hypothetical and do not establish future results, revenue gains, or cost savings.

## Acknowledgment

Dataset provided by Olist through the Brazilian E-Commerce Public Dataset on Kaggle. This is an independent portfolio analysis.
