select * from pizza_sales;
--total revenue
select sum(total_price) as 'total revenue' from pizza_sales;

--average order value =total price/count of order
select sum(total_price) / count(distinct order_id) as 'average order value' from pizza_sales;

--total pizza solid 
select sum(quantity) from pizza_sales; 

--total orders
select count(distinct order_id) as 'total orders' from pizza_sales;

--average pizaa per order
select cast (cast (sum(quantity) as decimal (10,2))/cast (count(distinct order_id) as decimal (10,2)) as  decimal( 10,2))
as' average pizaa per orders'
from pizza_sales;

-- daily trend for total orders
select datename(dw,order_date) as 'order-day',count(distinct order_id) as 'totalorders' from pizza_sales 
group by datename(dw,order_date)
order by count(distinct order_id) desc;

--hourly trend by order
select datepart(hour,order_time)as 'order_times',count(distinct order_id) as 'totalorders'
from pizza_sales
group by datepart(hour,order_time)
order by count(distinct order_id)  desc ;

-- p of sales by pizza category total price *100/sum of total price

select pizza_category,
cast(sum(total_price) as decimal (10,2)) as 'total revenue',
cast(sum(total_price) * 100/(select sum(total_price) from pizza_sales ) as decimal (10,2)) as 'pct'

from pizza_sales
group by pizza_category;

SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS 'total revenue',
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS 'pct'
FROM 
    pizza_sales
GROUP BY 
    pizza_category;

	--p of sales by pizza size
	select pizza_size,cast(sum(total_price) as decimal (10,2)) as 'total revenue',
	cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales) as decimal (10,2)) as 'pps'
	from pizza_sales
	group by pizza_size;

	--total pizza solid by pizza category
	select pizza_category,sum(quantity) as 'qty solid'
	from pizza_sales
	group by pizza_category;

	-- top5 best seller by  total pizza solid
	select top 5 pizza_name,sum(quantity) as 'totalpizzassold'
	from pizza_sales
	group by pizza_name
	order by totalpizzassold desc;

	-- top 5 buttom best seller by total pizza sold
	select top 5 pizza_name,sum(quantity) as 'total_pizza_sold'
	from pizza_sales
	group by pizza_name 
	order by total_pizza_sold asc;