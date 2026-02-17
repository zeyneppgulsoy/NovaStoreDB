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


-- OrderDetails Table

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



