--DATABASE CREATION

CREATE DATABASE NovaStoreDB;
GO

USE NovaStoreDB;
GO

CREATE TABLE Categories (
    CategoryID int IDENTITY(1,1) PRIMARY KEY,
    CategoryName varchar(50) NOT NULL
);
GO


--CUSTOMERS TABLE

CREATE TABLE Customers (
    CustomerID int IDENTITY(1,1) PRIMARY KEY,
    FullName varchar(50) NOT NULL,
    City varchar(20),
    Email varchar(100) UNIQUE
);
GO


--PRODUCTS TABLE

CREATE TABLE Products (
    ProductID int IDENTITY(1,1) PRIMARY KEY,
    ProductName varchar(100) NOT NULL,
    Price decimal(10,2),
    Stock int DEFAULT 0,
    CategoryID int FOREIGN KEY REFERENCES Categories(CategoryID)
);
GO


-- ORDERS TABLE

CREATE TABLE Orders (
    OrderID int IDENTITY(1,1) PRIMARY KEY,
    CustomerID int FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate datetime DEFAULT GETDATE(),
    TotalAmount decimal(10,2)
);
GO


-- ORDERDETAILS TABLE

CREATE TABLE OrderDetails (
    DetailID int IDENTITY(1,1) PRIMARY KEY,
    OrderID int FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID int FOREIGN KEY REFERENCES Products(ProductID),
    Quantity int
);
GO



--DATA INSERTION--

--INSERT CATEGORIES

INSERT INTO Categories (CategoryName) VALUES 
('Electronics'),
('Clothing'),
('Books'),
('Cosmetics'),
('Sports'),
('Toys'),
('Health'),
('Stationery'),
('Shoes'),
('Music');
GO


--INSERT CUSTOMERS

INSERT INTO Customers (FullName, City, Email) VALUES 
('John Doe', 'New York', 'john.doe@example.com'),
('Jane Smith', 'Los Angeles', 'jane.smith@example.com'),
('Michael Johnson', 'Chicago', 'michael.johnson@example.com'),
('Emily Davis', 'Houston', 'emily.davis@example.com'),
('David Wilson', 'Phoenix', 'david.wilson@example.com'),
('Sarah Brown', 'Philadelphia', 'sarah.brown@example.com'),
('Chris Lee', 'San Antonio', 'chris.lee@example.com'),
('Jessica Taylor', 'San Diego', 'jessica.taylor@example.com'),
('Daniel Anderson', 'Dallas', 'daniel.anderson@example.com'),
('Laura Martinez', 'San Jose', 'laura.martinez@example.com');
GO


--INSERT PRODUCTS

INSERT INTO Products (ProductName, Price, Stock, CategoryID) VALUES 
-- Electronics (1)
('Smartphone', 12000, 15, 1),
('Laptop', 15000, 10, 1),
('Tablet', 8000, 8, 1),

-- Clothing (2)
('T-Shirt', 250, 50, 2),
('Jeans', 500, 30, 2),
('Jacket', 1200, 15, 2),

-- Books (3)
('Novel', 120, 100, 3),
('Magazine', 40, 200, 3),

-- Cosmetics (4)
('Lipstick', 300, 40, 4),
('Perfume', 750, 25, 4),

-- Sports (5)
('Football', 400, 30, 5),
('Yoga Mat', 250, 40, 5),

-- Toys (6)
('Action Figure', 350, 25, 6),
('Board Game', 600, 15, 6),

-- Health (7)
('Vitamin C', 200, 50, 7),
('Face Mask', 150, 100, 7),

-- Stationery (8)
('Notebook', 50, 200, 8),
('Pen Set', 80, 150, 8),

-- Shoes (9)
('Running Shoes', 900, 20, 9),
('Sneakers', 650, 25, 9),

-- Music (10)
('Guitar', 3000, 5, 10),
('Headphones', 400, 30, 10),
('Microphone', 800, 10, 10);
GO



--INSERT ORDERS

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES 
(1, '2026-02-01', 15250),
(2, '2026-02-03', 870),
(3, '2026-02-05', 12240),
(4, '2026-02-07', 600),
(5, '2026-02-10', 1050),
(6, '2026-02-11', 8150),
(7, '2026-02-12', 400),
(8, '2026-02-13', 300),
(9, '2026-02-15', 900),
(10, '2026-02-16', 3800);
GO

--INSERT ORDERDETAILS

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES 
(1, 1, 1), (1, 2, 1),     -- Smartphone + Laptop
(2, 4, 2), (2, 5, 1),     -- 2 T-Shirt + 1 Jeans
(3, 2, 1), (3, 3, 1),     -- Laptop + Tablet
(4, 17, 1),               -- Notebook
(5, 10, 1), (5, 9, 1),    -- Perfume + Lipstick
(6, 1, 1), (6, 23, 1),    -- Smartphone + Microphone
(7, 21, 1),               -- Sneakers
(8, 7, 2),                -- 2 Novel
(9, 13, 1),               -- Action Figure
(10, 22, 1), (10, 11, 1); -- Headphones + Football
GO


--PRODUCTS WITH STOCK LESS THAN 20

SELECT ProductName, Stock 
FROM Products 
WHERE Stock < 20 
ORDER BY Stock DESC;
GO


--CUSTOMER ORDERS WITH JOIN

SELECT 
    c.FullName AS CustomerName,
    c.City,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;
GO


--PRODUCTS PURCHASED BY JOHN DOE

SELECT 
    c.FullName AS CustomerName,
    p.ProductName,
    p.Price,
    cat.CategoryName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE c.FullName = 'John Doe';
GO

--PRODUCT COUNT BY CATEGORY

SELECT 
    cat.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories cat
LEFT JOIN Products p ON cat.CategoryID = p.CategoryID
GROUP BY cat.CategoryName
ORDER BY ProductCount DESC;
GO


--CUSTOMER TOTAL SPENDING

SELECT 
    c.FullName AS CustomerName,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FullName
ORDER BY TotalSpent DESC;
GO


--DAYS SINCE ORDER

SELECT 
    OrderID,
    OrderDate,
    DATEDIFF(day, OrderDate, GETDATE()) AS DaysSinceOrder
FROM Orders;
GO


--CREATE VIEW vw_OrderSummary

CREATE VIEW vw_OrderSummary AS
SELECT 
    c.FullName AS CustomerName,
    o.OrderDate,
    p.ProductName,
    od.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;
GO