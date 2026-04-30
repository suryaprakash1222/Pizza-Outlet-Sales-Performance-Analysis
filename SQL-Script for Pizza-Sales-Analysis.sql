create database Pizza_Story_db;
use pizza_story_db;

-- creating table in database

create table pizza_sales (
pizza_id int primary key,	
order_id	int,
pizza_name_id	varchar(30),
quantity	int,
order_date	date,
order_time	time,
unit_price	float,
total_price	 float,
pizza_size	varchar(10),
pizza_category	varchar(30),
pizza_ingredients	varchar(150),
pizza_name varchar(50)
);

select * from pizza_sales;
-- --------------------------------------------------------------------------------------
-- 1.	Total Revenue: 
-- ----------------------
  select round(sum(total_price),2) as Total_revenue from pizza_sales;
  
  /* 2.	Average Order Value: Calculate the average amount spent per order
             by dividing total revenue by the total number of orders. */
             
	select * from pizza_sales;
    select round(sum(total_price)/count(distinct order_id),2) as Avg_order_val
      from pizza_sales;
      
-- -------------------------------------------------------------------------------
-- 3.	Total Pizzas Sold: 
  
   select sum(quantity) as Total_pizza_sold from pizza_sales;
-- -------------------------------------------------------------------------------------------

-- 4.	Total Orders: 
  select count(distinct order_id) as Total_orders from pizza_sales;
-- ---------------------------------------------------------------------
/* 5.Average Pizzas per Order: Calculate the average number of pizzas sold per order 
by dividing the total pizzas sold by the total number of orders. */
 
 select * from pizza_sales;
 
 select round(sum(quantity)/count(distinct order_id),2) as Avg_pizza_per_order 
 from pizza_sales;
 
-- ---------------------------------------------------------------------
--  1.	weekday Trend for Total Orders:

   select dayname(order_date), count(distinct order_id) as Total_orders from pizza_sales
    group by 1 order by total_orders desc;
-- ----------------------------------------------------------------------------------------
--  2.	Hourly Trend for Total Orders: 
  
   select hour(order_time) as hour_of_day, count(distinct order_id) as Total_orders from pizza_sales
    group by 1 order by hour_of_day;
-- ---------------------------------------------------------------------------------------
--  3.	Percentage of Sales by Pizza Category: 
    
     select * from pizza_sales;
     
     select pizza_category, round(sum(total_price),2) as Total_cate_sales
      ,round((sum(total_price)/(select sum(total_price) from pizza_sales)),2)*100 as
	   perc_of_total_sales from pizza_sales group by pizza_category order by Total_cate_sales desc;
 -- ------------------------------------------------------------------------------------------------
 -- 4.	Percentage of total Sales by Pizza Size:
 
    select pizza_size, round(sum(total_price),2) as Total_size_sales
      ,round((sum(total_price)/(select sum(total_price) from pizza_sales)),2)*100 as
	   perc_of_total_sales from pizza_sales group by pizza_size order by Total_size_sales desc;
-- ----------------------------------------------------------------------------------------------
--  5.	Total Pizzas Sold by Pizza Category:
     select pizza_category, sum(quantity) as Total_pizza_sold from pizza_sales
       group by 1 order by Total_pizza_sold desc;
-- --------------------------------------------------------------------------------------------

--    6.	Top 5 Best Sellers by Total Pizzas Sold:
  
  select * from pizza_sales;
   select  pizza_name, sum(quantity) as Total_pizza_sold from pizza_sales
     group by 1 order by Total_pizza_sold desc limit 5;
-- -----------------------------------------------------------------------------------------
--  7.	Bottom 5 Worst Sellers by Total Pizzas Sold: 

   select  pizza_name, sum(quantity) as Total_pizza_sold from pizza_sales
     group by 1 order by Total_pizza_sold limit 5;