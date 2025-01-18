SELECT * FROM superstore.orderss;

-- List all unique product categories from the “Product Sales” table.
SELECT DISTINCT Category 
FROM ProductSales;

-- Count the total number of orders in the “Order Customers” table.
SELECT COUNT(Order_ID) AS Total_Orders 
FROM OrderCustomer;

-- Find the earliest and latest order date in the “Order Customers” table.
SELECT MIN(Order_Date) AS Earliest_Order, MAX(Order_Date) AS Latest_Order 
FROM OrderCustomer;

-- Retrieve customer names and their respective segments.
SELECT Customer_Name, Segment 
FROM OrderCustomer;

-- Find the total sales for each region.
SELECT Region, SUM(Sales) AS Total_Sales 
FROM OrderCustomer
GROUP BY Region;

-- Find the top 5 customers who generated the highest sales.
SELECT Customer_Name, SUM(Sales) AS Total_Sales 
FROM OrderCustomer
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 5;

-- Retrieve all orders shipped in 2019.
SELECT * 
FROM OrderCustomer
WHERE YEAR(Ship_Date) = 2019;

-- List all products with their categories and subcategories.
SELECT Product_ID, Category, Subcategory 
FROM ProductSales;

-- Find the total number of products sold in each category.
SELECT Category, COUNT(Product_ID) AS Total_Products 
FROM ProductSales
GROUP BY Category;

-- Join the two tables to find the total sales for each product category.
SELECT PS.Category, SUM(OC.Sales) AS Total_Sales 
FROM ProductSales PS
JOIN OrderCustomer OC
ON PS.Order_ID = OC.Order_ID
GROUP BY PS.Category;

-- Find the most popular shipping mode based on the number of orders.
SELECT Ship_Mode, COUNT(Order_ID) AS Order_Count 
FROM OrderCustomer
GROUP BY Ship_Mode
ORDER BY Order_Count DESC
LIMIT 1;

-- Calculate the average sales for each segment.
SELECT Segment, AVG(Sales) AS Avg_Sales 
FROM OrderCustomer
GROUP BY Segment;

-- Identify the cities with the highest total sales in each region.
SELECT Region, City, SUM(Sales) AS Total_Sales 
FROM OrderCustomer
GROUP BY Region, City
ORDER BY Region, Total_Sales DESC;

-- Retrieve the top 3 product subcategories in terms of total sales.
SELECT PS.Subcategory, SUM(OC.Sales) AS Total_Sales 
FROM ProductSales PS
JOIN OrderCustomer OC
ON PS.Order_ID = OC.Order_ID
GROUP BY PS.Subcategory
ORDER BY Total_Sales DESC
LIMIT 3;

-- Find the total sales for orders placed in each year.
SELECT YEAR(Order_Date) AS Year, SUM(Sales) AS Total_Sales 
FROM OrderCustomer
GROUP BY YEAR(Order_Date)
ORDER BY Year;

-- Retrieve the number of orders placed for each product category.
SELECT PS.Category, COUNT(OC.Order_ID) AS Order_Count 
FROM ProductSales PS
JOIN OrderCustomer OC
ON PS.Order_ID = OC.Order_ID
GROUP BY PS.Category;

-- Find the total sales for each customer segment by region.
SELECT Region, Segment, SUM(Sales) AS Total_Sales 
FROM OrderCustomer
GROUP BY Region, Segment;

-- Retrieve the order ID and total sales for orders where sales exceeded ₹5000.
SELECT Order_ID, Sales 
FROM OrderCustomer
WHERE Sales > 5000;

-- Identify orders where the shipping took more than 7 days.
SELECT Order_ID, DATEDIFF(Ship_Date, Order_Date) AS Shipping_Days 
FROM OrderCustomer
WHERE DATEDIFF(Ship_Date, Order_Date) > 7;

-- find the total sales for each month and year(2015-2019)?
select year(order_date) as year,
month(order_date) as month from ordercustomer
group by year(order_date),month(order_date)
order by year,month;

-- calculate the avg delivery time?
select year(order_date) as year,
round(avg(datediff(ship_date,order_date)),1) as avg_d_d
from ordercustomer
group by year
order by year;

-- analyze the sales contribution  of each product sub category?
select ps.sub_category,sum(oc.sales) as sales_subcat
from ordercustomer oc
join productsales ps
on oc.order_id = ps.Order_ID
group by ps.Sub_Category
order by sales_subcat desc;

-- find the number of unique customers who ordered products in sub_category?
select ps.sub_category,
count(distinct oc.customer_id) as unique_customers
from ordercustomer oc 
inner join productsales ps
on oc.order_id = ps.order_id
group by Sub_Category
order by unique_customers desc ;

-- list all product and their associated order detailsincluding products not ordered?
select ps.product_id,ps.category,oc.order_id
from productsales ps 
right join ordercustomer oc
on ps.Order_ID = oc.Order_ID;