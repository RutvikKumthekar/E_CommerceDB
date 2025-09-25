USE ecommerce_db;

-- Extract all data from table
SELECT * FROM Users;

SELECT * FROM Products;

SELECT * FROM Orders;

-- Extract specific columns
SELECT name, email FROM Users;

SELECT name, price, stock FROM Products;

-- Products costing more than 1000
SELECT name, price 
FROM Products
WHERE price > 1000;

-- Select users from a specific city
SELECT name, email 
FROM Users
WHERE address LIKE '%Pune%';

-- Select products that cost more than 1000
SELECT name, price 
FROM Products
WHERE price > 1000;

-- Select products with stock less than 20
SELECT name, stock 
FROM Products
WHERE stock < 20;

-- Select orders with status 'Completed'
SELECT order_id, user_id, order_date, status 
FROM Orders
WHERE status = 'Completed';

-- Select top 5 most expensive products
SELECT name, price 
FROM Products
ORDER BY price DESC
LIMIT 5;

-- Select first 3 users in alphabetical order
SELECT name, email 
FROM Users
ORDER BY name ASC
LIMIT 3;

-- Select last 5 orders by date
SELECT order_id, user_id, order_date, status 
FROM Orders
ORDER BY order_date DESC
LIMIT 5;

-- Select cheapest product in each category 
SELECT name, price, category_id 
FROM Products
ORDER BY category_id, price ASC
LIMIT 1;
