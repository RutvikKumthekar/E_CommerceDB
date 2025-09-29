USE ecommerce_db;

-- Users and their orders
SELECT u.user_id, u.name, o.order_id, o.order_date
FROM Users u
INNER JOIN Orders o ON u.user_id = o.user_id;

-- Users and their orders (showing users with no orders too)
SELECT u.user_id, u.name, o.order_id, o.order_date
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id;

-- Orders and users (showing orders even if user info missing)
SELECT u.user_id, u.name, o.order_id, o.order_date
FROM Users u
RIGHT JOIN Orders o ON u.user_id = o.user_id;

-- Users and Orders (all users + all orders, matched or not)
SELECT u.user_id, u.name, o.order_id, o.order_date
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
UNION
SELECT u.user_id, u.name, o.order_id, o.order_date
FROM Users u
RIGHT JOIN Orders o ON u.user_id = o.user_id;

-- All possible combinations of products and categories
SELECT p.name AS product_name, c.category_name
FROM Products p
CROSS JOIN Categories c;

-- Orders with product details
SELECT o.order_id, u.name AS customer, p.name AS product, oi.quantity, oi.price
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;

-- Total spent per user
SELECT u.name, SUM(p.amount) AS total_spent
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY u.name
ORDER BY total_spent DESC;


