USE ecommerce_db;

-- Insert into Users
INSERT INTO Users (name, email, phone, address)
VALUES 
('Aditya Patil', 'aditya@gmail.com', '9876543210', 'Pune, India'),
('Bhushan Chavan', 'chavanb@gmail.com', '9988776655', 'Mumbai, India'),
('Chetan Salunkhe', 'chetan@gmail.com', '9876501234', 'Delhi, India'),
('Dinesh Jadhav', 'jdinesh@gmail.com', '9123456780', 'Bangalore, India'),
('Ganesh Kadam', 'gkadam@gmail.com', '9988007766', 'Hyderabad, India'),
('Tushar Patil', 'tushar@gmail.com', '9112233445', 'Chennai, India'),
('Akshay Jadhav', 'jadhavaksahy@gmail.com', '9876544210', 'Dhanori, India'),
('Ashutosh Bankar', 'bankara@gmail.com', '9988777755', 'Dombivli, India'),
('Vijay Sawant', 'sawantv@gmail.com', '9876501342', 'Thane, India'),
('Pratik Pakhale', 'pratikp@gmail.com', '9123455748', 'Gujarat, India'),
('Rushi Kale', 'rushikale@gmail.com', '9988006688', 'Satara, India'),
('Roshan Punekar', 'roshan@gmail.com', '9112233344', 'Kolhapur, India');

SELECT * FROM users;

-- Insert into Categories
INSERT INTO Categories (category_name)
VALUES 
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances'),
('Sports'),
('Toys'),
('Beauty & Health');

SELECT * FROM categories;

-- Insert into Products
INSERT INTO Products (name, description, price, stock, category_id)
VALUES 
('Laptop', '15-inch gaming laptop', 55000.00, 10, 1),
('T-shirt', 'Cotton round neck T-shirt', 499.00, 50, 2),
('Novel', 'Best-selling novel', 299.00, 30, 3),
('Smartphone', 'Android 5G phone with 128GB storage', 25000.00, 25, 1),   -- Electronics
('Headphones', 'Wireless Bluetooth headphones', 1999.00, 40, 1),
('Jeans', 'Denim blue jeans', 1299.00, 60, 2),                             -- Clothing
('Cricket Bat', 'Professional grade cricket bat', 4999.00, 20, 5),         -- Sports
('Microwave Oven', '20L Convection Microwave', 8500.00, 15, 4),             -- Home Appliances
('Doll', 'Barbie doll with accessories', 899.00, 35, 6),                   -- Toys
('Face Cream', 'Moisturizing cream 100ml', 499.00, 50, 7);

SELECT * FROM products;

-- Insert into Orders
INSERT INTO Orders (user_id, status)
VALUES 
(1, 'Pending'),
(2, 'Pending'),
(3, 'Pending'),   
(4, 'Pending'),   
(5, 'Pending'),   
(6, 'Pending');   

SELECT * FROM orders;

-- Insert into orderItems
INSERT INTO OrderItems (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 55000.00),   -- Aditya bought 1 Laptop
(1, 3, 2, 299.00),     -- Aditya bought 2 Novels
(2, 2, 3, 499.00),     -- Bhushan bought 3 T-shirts
(3, 4, 1, 4999.00),      -- Chetan bought 1 Cricket Bat
(3, 2, 1, 1999.00),      -- Chetan bought Headphones
(4, 7, 2, 499.00),       -- Dinesh bought 2 Face Creams
(5, 5, 1, 8500.00),      -- Ganesh bought Microwave Oven
(5, 6, 3, 899.00),       -- Ganesh bought 3 Dolls
(6, 3, 2, 1299.00),      -- Tushar bought 2 Jeans
(6, 1, 1, 25000.00);     -- Tushar bought 1 Smartphone

SELECT * FROM orderitems;

-- Insert into payments
INSERT INTO Payments (order_id, amount, method)
VALUES 
(1, 55598.00, 'Credit Card'),
(2, 1497.00, 'UPI'),
(3, 6998.00, 'Debit Card'),
(4, 998.00, 'Cash on Delivery'),
(5, 11297.00, 'UPI'),
(6, 27598.00, 'Credit Card');

SELECT * FROM Payments;


-- Update stock after an order
UPDATE Products
SET stock = stock - 1
WHERE product_id = 1;  -- Laptop sold
SELECT * FROM products;

-- Update order status
UPDATE Orders
SET status = 'Shipped'
WHERE order_id = 3;
SELECT * FROM Orders;

-- Update user’s phone number
UPDATE Users
SET phone = '9123456789'
WHERE user_id = 2;
SELECT * FROM users;

-- Update user phone number
UPDATE Users
SET phone = '9000001111'
WHERE user_id = 1;
SELECT * FROM users;

-- Rename category
UPDATE Categories
SET category_name = 'Fashion & Clothing'
WHERE category_id = 2;
SELECT * FROM Categories;

-- Update stock after restocking
UPDATE Products
SET stock = stock + 20
WHERE product_id = 3; -- Novel
SELECT * FROM Products;

-- Change order status
UPDATE Orders
SET status = 'Delivered'
WHERE order_id = 1;
SELECT * FROM Orders;

-- Assign order to a different user
UPDATE Orders
SET user_id = 2
WHERE order_id = 3;
SELECT * FROM Orders;

-- Increase quantity of a product in an order
UPDATE OrderItems
SET quantity = quantity + 1, price = price * (quantity + 1)
WHERE order_item_id = 2;
SELECT * FROM OrderItems;

-- Change payment method
UPDATE Payments
SET method = 'Net Banking'
WHERE payment_id = 1;
SELECT * FROM Payments;

-- Correct payment amount
UPDATE Payments
SET amount = 56000.00
WHERE order_id = 1;
SELECT * FROM Payments;


-- Delete a specific order item
DELETE FROM OrderItems
WHERE order_item_id = 3;
SELECT * FROM OrderItems;

-- Remove payment record (maybe duplicate entry)
DELETE FROM Payments
WHERE payment_id = 2;
SELECT * FROM Payments;

-- Delete a cancelled order
DELETE FROM Orders
WHERE order_id = 2;
SELECT * FROM Orders;

-- Delete a users
DELETE FROM users
WHERE user_id = 11 and user_id = 12;
SELECT * FROM users;



