# Pizza Outlet Sales Performance Analysis

## Overview

This project is an end-to-end **Pizza Outlet Sales Performance Analysis** built using **SQL** for data analysis and **Excel** for dashboard reporting.

The project analyzes pizza outlet sales data to measure business performance across revenue, orders, product demand, time-based trends, pizza category contribution, pizza size mix, and best- vs worst-selling products.

The analysis is based on a transaction-level dataset with fields such as `order_id`, `order_date`, `order_time`, `quantity`, `unit_price`, `total_price`, `pizza_size`, `pizza_category`, `pizza_ingredients`, and `pizza_name`.

## Project Objective

The objective of this project is to analyze pizza sales performance and generate actionable business insights using SQL queries and an interactive dashboard.

This project was designed to:
- calculate core business KPIs
- identify weekday and hourly sales trends
- measure category-wise and size-wise sales contribution
- evaluate top-performing and low-performing pizzas
- support business decision-making through dashboard-based reporting

## Dataset and Schema

The analysis is based on a sales dataset stored in a SQL table named `pizza_sales`.
### Dataset Size
- **Total Rows:** 48,620
### Main Columns Used

- `pizza_id`
- `order_id`
- `pizza_name_id`
- `quantity`
- `order_date`
- `order_time`
- `unit_price`
- `total_price`
- `pizza_size`
- `pizza_category`
- `pizza_ingredients`
- `pizza_name`

These columns support KPI analysis, trend analysis, product performance tracking, and customer ordering behavior analysis.

## Tools Used

- **SQL**
- **Excel**
- **CSV Dataset**
- **MS Word** for query documentation and output review

## Skills Demonstrated

- KPI analysis
- SQL aggregations
- grouped summaries
- date and time-based trend analysis
- sales segmentation analysis
- product performance evaluation
- dashboard creation in Excel
- business insight generation

## KPI Snapshot

| KPI | Value |
|---|---:|
| Total Revenue | 817860.05 |
| Total Orders | 21350 |
| Total Pizzas Sold | 49574 |
| Average Order Value | 38.31 |
| Average Pizzas per Order | 2.32 |

## Business Problems and SQL Solutions

### 1. Total Revenue

**Business Problem:** Calculate the total revenue generated from all pizza sales.

```sql
select round(sum(total_price),2) as Total_revenue
from pizza_sales;
```

**Output:** `817860.05`

### 2. Average Order Value

**Business Problem:** Calculate the average amount spent per order.

```sql
select round(sum(total_price)/count(distinct order_id),2) as Avg_order_val
from pizza_sales;
```

**Output:** `38.31`

### 3. Total Pizzas Sold

**Business Problem:** Calculate the total number of pizzas sold.

```sql
select sum(quantity) as Total_pizza_sold
from pizza_sales;
```

**Output:** `49574`

### 4. Total Orders

**Business Problem:** Calculate the total number of unique orders placed.

```sql
select count(distinct order_id) as Total_orders
from pizza_sales;
```

**Output:** `21350`

### 5. Average Pizzas per Order

**Business Problem:** Calculate the average number of pizzas sold per order.

```sql
select round(sum(quantity)/count(distinct order_id),2) as Avg_pizza_per_order
from pizza_sales;
```

**Output:** `2.32`

### 6. Weekday Trend for Total Orders

**Business Problem:** Identify which day of the week receives the highest number of orders.

```sql
select dayname(order_date), count(distinct order_id) as Total_orders
from pizza_sales
group by 1
order by total_orders desc;
```

**Output Summary:**
- Friday: `3538`
- Thursday: `3239`
- Saturday: `3158`
- Wednesday: `3024`
- Tuesday: `2973`
- Monday: `2794`
- Sunday: `2624`

### 7. Hourly Trend for Total Orders

**Business Problem:** Analyze order volume by hour of the day.

```sql
select hour(order_time) as hour_of_day, count(distinct order_id) as Total_orders
from pizza_sales
group by 1
order by hour_of_day;
```

**Output Summary:**
- Peak hour: `12` with `2520` orders
- Next highest hour: `13` with `2455` orders
- Strong evening volume continues at `17` and `18` with `2336` and `2399` orders

### 8. Percentage of Sales by Pizza Category

**Business Problem:** Measure how much each pizza category contributes to total sales.

```sql
select pizza_category,
       round(sum(total_price),2) as Total_cate_sales,
       round((sum(total_price)/(select sum(total_price) from pizza_sales)),2)*100 as perc_of_total_sales
from pizza_sales
group by pizza_category
order by Total_cate_sales desc;
```

**Output Insight:** Category contribution is led by **Classic**, followed by **Supreme**, **Chicken**, and **Veggie**.

### 9. Percentage of Sales by Pizza Size

**Business Problem:** Measure how much each pizza size contributes to total sales.

```sql
select pizza_size,
       round(sum(total_price),2) as Total_size_sales,
       round((sum(total_price)/(select sum(total_price) from pizza_sales)),2)*100 as perc_of_total_sales
from pizza_sales
group by pizza_size
order by Total_size_sales desc;
```

**Output Insight:** **Large** pizzas contribute the highest share of sales.

### 10. Total Pizzas Sold by Pizza Category

**Business Problem:** Compare pizza categories based on total quantity sold.

```sql
select pizza_category, sum(quantity) as Total_pizza_sold
from pizza_sales
group by 1
order by Total_pizza_sold desc;
```

**Output Insight:** **Classic** is the best-selling pizza category by quantity sold.

### 11. Top 5 Best Sellers by Total Pizzas Sold

**Business Problem:** Identify the top 5 pizzas by units sold.

```sql
select pizza_name, sum(quantity) as Total_pizza_sold
from pizza_sales
group by 1
order by Total_pizza_sold desc
limit 5;
```

**Top 5 Best Sellers:**
- The Classic Deluxe Pizza — `2453`
- The Barbecue Chicken Pizza — `2432`
- The Hawaiian Pizza — `2422`
- The Pepperoni Pizza — `2418`
- The Thai Chicken Pizza — `2371`

### 12. Bottom 5 Worst Sellers by Total Pizzas Sold

**Business Problem:** Identify the bottom 5 pizzas by units sold.

```sql
select pizza_name, sum(quantity) as Total_pizza_sold
from pizza_sales
group by 1
order by Total_pizza_sold
limit 5;
```

**Bottom 5 Sellers:**
- The Brie Carre Pizza — `490`
- The Mediterranean Pizza — `934`
- The Calabrese Pizza — `937`
- The Spinach Supreme Pizza — `950`
- The Soppressata Pizza — `961`

## Dashboard Overview

![Pizza Sales Performance Dashboard](./Pizza%20Sales%20Performance%20dashboard.png)

The Excel dashboard presents the complete business view using KPI cards, weekday order trends, hourly order trends, category-wise sales share, size-wise sales share, total pizzas sold by category, top 5 sellers, and bottom 5 sellers.

The dashboard highlights three strong business findings:
- maximum orders are fulfilled on **Friday**
- maximum orders are placed during **12:00 PM to 12:59 PM**
- the best-selling category is **Classic**, while the best-selling pizza size is **Large**

## Key Insights

- The business generated total revenue of `817860.05` from `21350` orders.
- Average order value is `38.31`, and customers order `2.32` pizzas per transaction on average.
- Friday is the strongest sales day, while Sunday records the lowest order volume among weekdays.
- Lunch hours, especially `12 PM` and `1 PM`, are the most important demand windows.
- Classic pizzas lead both in category sales and total quantity sold.
- Large pizzas are the most valuable size segment by revenue contribution.
- The Classic Deluxe Pizza is the top-selling product, while the Brie Carre Pizza is the lowest-selling product.

## Repository Structure

```text
Pizza-Outlet-Sales-Performance-Analysis/
│
├── Pizza sales dataset.csv
├── Pizza Sales Analysis doc.docx
├── Pizza Sales Performance dashboard.png
├── README.md
└── SQL-Script for Pizza-Sales-Analysis.sql
```

## Author

**Surya Prakash Singh**  
Business Analyst | Aspiring Data Analyst | SQL | Excel | Dashboarding

This project demonstrates practical SQL analysis, Excel dashboard development, KPI reporting, and business-focused sales performance analysis.
