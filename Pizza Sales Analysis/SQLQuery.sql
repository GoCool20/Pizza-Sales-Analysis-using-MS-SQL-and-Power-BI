/*
KPI's Development
	1. Total Revenue
	2. Average Order Value
	3. Total Pizzas Sold
	4. Total Orders
	5. Average Pizzas Per Order

Charts Requirements
	Daily Trend for Total Orders
	Monthly Trend for Orders
	% of Sales by Pizza Category
	% of Sales by Pizza Size
	Total Pizzas Sold by Pizza Category
	Top 5 Pizzas by Revenue
	Bottom 5 Pizzas by Revenue
	Top 5 Pizzas by Quantity
	Bottom 5 Pizzas by Quantity
	Top 5 Pizzas by Total Orders
	Bottom 5 Pizzas by Total Orders
*/


-- KPI
-- Total Revenue

SELECT 
	ROUND(SUM(total_price),0) AS TotalRevenue
FROM pizza_sales


-- Average Order Value
SELECT 
	ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2) AS Avg_order_Value 
FROM pizza_sales


-- Total Pizzas Sold
SELECT 
	COUNT(order_id) AS TotalPizzaSold
FROM pizza_sales

-- Total Orders
SELECT
	COUNT(DISTINCT order_id) AS TotalOrders
FROM pizza_sales


-- Average Pizzas Per Order
SELECT 
	CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
	CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales



-- Charts Requirement
-- Daily Trend for Total Orders
SELECT 
	DATENAME(DW, order_date) AS order_day,
	COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)


-- Monthly Trend for Orders
SELECT
	DATENAME(MONTH,order_date) AS Month_Name,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)


-- % of Sales by Pizza Category
SELECT
	pizza_category,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)
AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category


-- % of Sales by Pizza Size
SELECT 
	pizza_size,
	CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size


-- Total Pizzas Sold by Pizza Category
SELECT 
	pizza_category,
	SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


-- Top 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC


-- Bottom 5 Pizzas by Revenue
SELECT Top 5 
	pizza_name, 
	SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC


-- Top 5 Pizzas by Quantity
SELECT TOP 5 
	pizza_name,
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC


-- Bottom 5 Pizzas by Quantity
SELECT TOP 5
	pizza_name,
	SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC


-- Top 5 Pizzas by Total Orders
SELECT TOP 5
	pizza_name,
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC


-- Bottom 5 Pizzas by Total Orders
SELECT Top 5 
	pizza_name, 
	COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC



