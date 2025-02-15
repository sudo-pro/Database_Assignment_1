\echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Task:1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Create the Customers table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL CHECK (Email LIKE '%@%.%'),
    CustomerAddress VARCHAR(150),
    EmailRegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Products table
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0)
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    OrderDate DATE DEFAULT CURRENT_DATE,
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0),
    ShippingAddress VARCHAR(150) NOT NULL
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID) ON DELETE CASCADE,
    ProductID INT REFERENCES Products(ProductID) ON DELETE CASCADE,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    SubTotal DECIMAL(10, 2) NOT NULL CHECK (SubTotal >= 0)
);


\echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Task:2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Insert data into Product table
INSERT INTO
    Products (ProductName, Category, Price, Stock)
VALUES
    ('Laptop', 'Electronics', 75000, 50), 
    ('Headphones', 'Electronics', 5000, 100),
    ('T-shirt', 'Clothing', 1500, 200),
    ('Coffee Maker', 'Home Appliances', 5000, 40),
    ('Gaming Chair', 'Furniture', 12000, 20);

-- Insert data into Customer table
INSERT INTO Customers (CustomerName, Phone, Email, CustomerAddress, EmailRegistrationDate)
VALUES
('Archie Bhatt', '1234567890', 'archie-bhatt@email.com', '12, MG Road, Bangalore, Karnataka','2024-02-10'),
('Ishita Patel', '2345678901', 'ishita-patel@email.com', '45, Nehru Street, Chennai, Tamil Nadu', '2024-02-10'),
('Firoja Parveen', '3456789012', 'firoja-parveen@email.com', '78, Rajpath Avenue, Delhi', '2024-02-11'),
('Sanket Walunj', '4567890123', 'sanket-walunj@email.com', '23, Juhu Beach, Mumbai, Maharashtra', '2024-02-15'),
('Jagadish Sau', '5678901234', 'jagadish-sau@email.com', '56, Banjara Hills, Hyderabad, Telangana', '2024-02-21');


-- Insert data into Order table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, ShippingAddress)
VALUES
    (1, '2024-05-01', 100500, '12, MG Road, Bangalore, Karnataka'),  -- Archie Bhatt
    (2, '2024-05-05', 7500, '45, Nehru Street, Chennai, Tamil Nadu'),    -- Ishita Patel
    (3, '2024-07-10', 12000, '78, Rajpath Avenue, Delhi'),   -- Firoja Parveen
    (4, '2024-09-15', 3500, '23, Juhu Beach, Mumbai, Maharashtra'),    -- Sanket Walunj
    (5, '2024-10-20', 27000, '56, Banjara Hills, Hyderabad, Telangana'),   -- Jagadish Sau
    (1, '2024-11-01', 5000, '12, MG Road, Bangalore, Karnataka'),    -- Archie Bhatt
    (2, '2024-11-25', 10000, '45, Nehru Street, Chennai, Tamil Nadu'),   -- Ishita Patel
    (3, '2024-12-10', 15000, '78, Rajpath Avenue, Delhi'),   -- Firoja Parveen
    (4, '2025-01-05', 18000, '23, Juhu Beach, Mumbai, Maharashtra'),   -- Sanket Walunj
    (5, '2025-02-12', 40000, '56, Banjara Hills, Hyderabad, Telangana');   -- Jagadish Sau

-- Insert data into OrderDetails table (with corrected Subtotal values)
INSERT INTO
    OrderDetails (OrderID, ProductID, Quantity, Subtotal)
VALUES
    -- Archie Bhatt: Order 1 (Total = 100500 INR)
    (1, 1, 1, 75000),  -- 1 Laptop (1 * 75000)
    (1, 2, 1, 5000),   -- 1 Headphone (1 * 5000)
    (1, 3, 5, 7500),   -- 5 T-shirts (5 * 1500)
    (1, 4, 1, 5000),   -- 1 Coffee Maker (1 * 5000)
    (1, 5, 1, 12000),  -- 1 Gaming Chair (1 * 12000)

    -- Ishita Patel: Order 2 (Total = 7500 INR)
    (2, 2, 1, 5000),   -- 1 Headphone (1 * 5000)
    (2, 3, 1, 1500),   -- 1 T-shirt (1 * 1500)
    (2, 4, 1, 5000),   -- 1 Coffee Maker (1 * 5000)

    -- Firoja Parveen: Order 3 (Total = 12000 INR)
    (3, 1, 1, 75000),  -- 1 Laptop (1 * 75000)
    (3, 3, 1, 1500),   -- 1 T-shirt (1 * 1500)
    (3, 4, 1, 5000),   -- 1 Coffee Maker (1 * 5000)
    (3, 5, 1, 12000),  -- 1 Gaming Chair (1 * 12000)

    -- Sanket Walunj: Order 4 (Total = 3500 INR)
    (4, 2, 1, 5000),   -- 1 Headphone (1 * 5000)
    (4, 3, 1, 1500),   -- 1 T-shirt (1 * 1500)

    -- Jagadish Sau: Order 5 (Total = 27000 INR)
    (5, 1, 2, 150000), -- 2 Laptops (2 * 75000)
    (5, 2, 1, 5000),   -- 1 Headphone (1 * 5000)
    (5, 4, 1, 5000),   -- 1 Coffee Maker (1 * 5000)
    (5, 5, 1, 12000),  -- 1 Gaming Chair (1 * 12000)

    -- Archie Bhatt: Order 6 (Total = 5000 INR)
    (6, 4, 1, 5000),   -- 1 Coffee Maker (1 * 5000)

    -- Ishita Patel: Order 7 (Total = 10000 INR)
    (7, 3, 3, 4500),   -- 3 T-shirts (3 * 1500)
    (7, 5, 1, 12000),  -- 1 Gaming Chair (1 * 12000)

    -- Firoja Parveen: Order 8 (Total = 15000 INR)
    (8, 2, 2, 10000),  -- 2 Headphones (2 * 5000)
    (8, 3, 1, 1500),   -- 1 T-shirt (1 * 1500)
    (8, 4, 1, 5000),   -- 1 Coffee Maker (1 * 5000)

    -- Sanket Walunj: Order 9 (Total = 18000 INR)
    (9, 1, 1, 75000),  -- 1 Laptop (1 * 75000)
    (9, 2, 1, 5000),   -- 1 Headphone (1 * 5000)
    (9, 5, 1, 12000),  -- 1 Gaming Chair (1 * 12000)

    -- Jagadish Sau: Order 10 (Total = 40000 INR)
    (10, 3, 5, 7500),  -- 5 T-shirts (5 * 1500)
    (10, 4, 2, 10000), -- 2 Coffee Makers (2 * 5000)
    (10, 5, 1, 12000); -- 1 Gaming Chair (1 * 12000)

\echo Customers Table:
SELECT * FROM Customers;
\echo Orders Table:
SELECT * FROM Orders;
\echo OrderDetails Table:
SELECT * FROM OrderDetails;
\echo Products Table:
SELECT * FROM Products;

\echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Task:3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Retrieve Orders for a Specific Customer (Use JOIN to display the customer’s name, product name, order date, and quantity).
SELECT c.CustomerName, p.ProductName, o.OrderDate, od.Quantity
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE c.CustomerID = 1;


\echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Task:4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Find the Most Purchased Product using aggregation functions.
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC
LIMIT 1;

\echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Task:5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Create a stored procedure to update the stock quantity after an order is placed
-- Create a trigger function to update stock when a new order is placed
CREATE OR REPLACE FUNCTION update_stock_after_order()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update the stock quantity of the product after the order is placed
    UPDATE Products
    SET Stock = Stock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;

    RETURN NEW;
END;
$$;

-- Create the trigger on the OrderDetails table to update the stock after an order is placed
CREATE TRIGGER after_order_placed
AFTER INSERT ON OrderDetails
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_order();

-- When a new OrderDetail record is inserted the trigger activates automatically the insertion
INSERT INTO
    Orders (CustomerID, OrderDate, TotalAmount, ShippingAddress)
VALUES
    (4, '2025-02-15',5000, '23, Juhu Beach, Mumbai, Maharashtra');

INSERT INTO
    OrderDetails (OrderID, ProductID, Quantity, Subtotal)
VALUES
    (11, 2, 1, 5000);

\echo Customers Table:
SELECT * FROM Customers;
\echo Products Table:
SELECT * FROM Products;
\echo Orders Table:
SELECT * FROM Orders;
\echo OrderDetails Table:
SELECT * FROM OrderDetails;

\echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Task:6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Delete a Customer’s Record (Ensure referential integrity is maintained e.g., customer_id = 1)
DELETE
    FROM Customers
WHERE
    CustomerID = 1;
