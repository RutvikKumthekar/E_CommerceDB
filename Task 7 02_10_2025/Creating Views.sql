USE ecommerce_db;

-- 1) Create a View: User Order Summary
CREATE VIEW UserOrderSummary AS
SELECT u.user_id, u.name, COUNT(o.order_id) AS total_orders, 
       COALESCE(SUM(p.amount), 0) AS total_spent
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id
LEFT JOIN Payments p ON o.order_id = p.order_id
GROUP BY u.user_id, u.name;

-- Get all user order summaries
SELECT * FROM UserOrderSummary;

-- Get top 5 customers by spending
SELECT name, total_spent
FROM UserOrderSummary
ORDER BY total_spent DESC
LIMIT 5;


-- 2) Create a View: Product Sales Report
CREATE VIEW ProductSalesReport AS
SELECT p.product_id, p.name AS product_name, c.category_name,
       COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
       COALESCE(SUM(oi.price * oi.quantity), 0) AS total_revenue
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name, c.category_name;

-- Get all product sales
SELECT * FROM ProductSalesReport;

-- Top 3 best-selling products
SELECT product_name, total_quantity_sold
FROM ProductSalesReport
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- 3) Create a View: Order Details with Payments
CREATE VIEW OrderDetailsWithPayments AS
SELECT o.order_id, u.name AS customer, o.order_date, o.status,
       SUM(oi.price * oi.quantity) AS order_total,
       p.amount AS payment_amount, p.method AS payment_method, p.payment_date
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY o.order_id, u.name, o.order_date, o.status, p.amount, p.method, p.payment_date;

-- Get all orders with payments
SELECT * FROM OrderDetailsWithPayments;

-- Pending orders only
SELECT * FROM OrderDetailsWithPayments
WHERE status = 'Pending';


-- 4) Create View: Pending Orders
CREATE VIEW PendingOrders AS
SELECT o.order_id, u.name AS customer_name, o.order_date, o.status
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
WHERE o.status = 'Pending';


-- List all active customers
SELECT * FROM PendingOrders;


-- 5) Create View: Category Revenue
CREATE VIEW CategoryRevenue AS
SELECT c.category_name, 
       SUM(oi.price * oi.quantity) AS total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY c.category_name;

-- Highest earning categories
SELECT * FROM CategoryRevenue
ORDER BY total_revenue DESC;

-- 6) Create View: Payment Summary by Method
CREATE VIEW PaymentSummary AS
SELECT method AS payment_method,
       COUNT(payment_id) AS total_transactions,
       SUM(amount) AS total_amount
FROM Payments
GROUP BY method;

-- Show total paid by each method
SELECT * FROM PaymentSummary;

-- 7) Create View: Customer Latest Order
CREATE VIEW CustomerLatestOrder AS
SELECT u.user_id, u.name, o.order_id, o.order_date
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date) 
    FROM Orders o2 
    WHERE o2.user_id = u.user_id
);

-- Show each customer's most recent order
SELECT * FROM CustomerLatestOrder;

-- 8) Create View: High-Value Orders
CREATE VIEW HighValueOrders AS
SELECT o.order_id, u.name AS customer, SUM(oi.price * oi.quantity) AS total_order_value
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY o.order_id, u.name
HAVING total_order_value > 20000;

-- Show all high-value orders
SELECT * FROM HighValueOrders;

