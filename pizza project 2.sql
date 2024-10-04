create database pizzahut;
use pizzahut;
select  * from pizzahut.order_details;

			-- Retrive the total no of orders placed
 
 select count(order_id) as total_orders from orders;
 
           -- total revenue genrated from pizza sales.

select
 sum(order_details.quantity*pizzas.price)
 from order_details
 join 
 pizzas on pizzas.pizza_id=order_details.pizza_id;
 
          -- highest priced pizza

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

                     -- most common pizza size ordered

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
order by order_count desc;

              -- top 5 most ordered pizza types along with their quantities

select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id= pizzas.pizza_type_id
join order_details
on order_details.pizza_id= pizzas.pizza_id
group by pizza_types.name
order by quantity desc
limit 5;


     -- find the total quantity of each pizza category ordered.
     
  SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


               -- distribution of orders by hours of the day
     
     select hour(time) as hour ,count(order_id) as order_count from orders 
     group by hour(time);
     
     -- category wise distribution of pizzas
     
     select category,count(name)from pizza_types
     group by category;
     
     -- group the order by date and calculate the avg no of pizzas ordered per day
     
   
   select avg (quantity) as avg_pizza from ( select orders.date,sum(order_details.quantity) as quantity
     from orders join order_details
     on orders.order_id=order_details.order_id
     group by  orders.date) as order_quantity;
     
     
     -- top 3 most ordered pizza types based on revenue
     
     select pizza_types.name,sum(order_details.quantity*pizzas.price) as revenue
     from pizza_types join pizzas
     on pizza_types.pizza_type_id= pizzas.pizza_type_id
     join order_details on
     order_details.pizza_id=pizzas.pizza_id
     group by pizza_types.name order by revenue desc limit 3
	;