-- 26/09/2025

USE ecommerce_db;

-- Total number of users
SELECT COUNT(*) AS total_users
FROM Users;

-- Total stock available across all products
SELECT SUM(stock) AS total_stock
FROM Products;

-- Average product price
SELECT AVG(price) AS avg_price
FROM Products;

-- Cheapest and costliest product overall
SELECT MIN(price) AS cheapest_product, MAX(price) AS costliest_product
FROM Products;

-- Total revenue from all payments
SELECT SUM(amount) AS total_revenue
FROM Payments;

-- Revenue per payment method with min, max, avg
SELECT method,
       SUM(amount) AS total_revenue,
       MIN(amount) AS min_payment,
       MAX(amount) AS max_payment,
       AVG(amount) AS avg_payment
FROM Payments
GROUP BY method;

-- Orders summary
SELECT COUNT(order_id) AS total_orders,
       MIN(order_date) AS first_order,
       MAX(order_date) AS last_order
FROM Orders;

-- Number of products in each category
SELECT c.category_name AS category_name, COUNT(p.product_id) AS product_count
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- Total stock per category
SELECT c.category_name AS category_name, SUM(p.stock) AS total_stock
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- Average price per category
SELECT c.category_name AS category_name, AVG(p.price) AS avg_price
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- Min and Max price per category
SELECT c.category_name AS category_name, MIN(p.price) AS min_price, MAX(p.price) AS max_price
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- Customer-wise sales summary (uses all aggregates)
SELECT u.name,
       COUNT(o.order_id) AS total_orders,
       SUM(p.amount) AS total_spent,
       MIN(p.amount) AS smallest_payment,
       MAX(p.amount) AS largest_payment,
       AVG(p.amount) AS avg_payment
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY u.name
ORDER BY total_spent DESC;

-- Categories with more than 2 products
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING COUNT(p.product_id) > 2;

-- Categories with average price greater than 1000
SELECT c.category_name, AVG(p.price) AS avg_price
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.price) > 1000;

-- Payment methods with total revenue above 50,000
SELECT method, SUM(amount) AS total_revenue
FROM Payments
GROUP BY method
HAVING SUM(amount) > 50000;

-- Customers who spent at least 10,000
SELECT u.name, SUM(p.amount) AS total_spent
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY u.name
HAVING SUM(p.amount) >= 10000;
