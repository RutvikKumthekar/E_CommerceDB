USE ecommerce_db;

-- Find users who have placed at least one order
SELECT name, email
FROM Users
WHERE user_id IN (
    SELECT user_id
    FROM Orders
);

-- Find average order amount per user
SELECT u.name, t.avg_amount
FROM Users u
JOIN (
    SELECT o.user_id, AVG(p.amount) AS avg_amount
    FROM Orders o
    JOIN Payments p ON o.order_id = p.order_id
    GROUP BY o.user_id
) t ON u.user_id = t.user_id;

-- List users who have at least one Pending order
SELECT u.name, u.email
FROM Users u
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.user_id = u.user_id
      AND o.status = 'Pending'
);

-- Find products priced above the average price of their category
SELECT p.name, p.price, p.category_id
FROM Products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM Products p2
    WHERE p2.category_id = p.category_id
);

-- Find the most expensive product
SELECT name, price
FROM Products
WHERE price = (
    SELECT MAX(price)
    FROM Products
);

-- Products that have never been sold
SELECT name, price
FROM Products
WHERE product_id NOT IN (
    SELECT product_id
    FROM OrderItems
);

-- Products more expensive than the average price of their category (correlated subquery)
SELECT p.name, p.price, c.category_name
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM Products p2
    WHERE p2.category_id = p.category_id
);

-- Top 3 customers by total spending
SELECT u.name, SUM(p.amount) AS total_spent
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY u.user_id
ORDER BY total_spent DESC
LIMIT 3;

-- Users who bought the most expensive product in the store
SELECT DISTINCT u.name, u.email
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE oi.product_id = (
    SELECT product_id
    FROM Products
    ORDER BY price DESC
    LIMIT 1
);
