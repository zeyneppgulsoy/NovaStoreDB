CREATE DATABASE NovaStoreDB;
GO

USE NovaStoreDB;
GO

CREATE TABLE Categories (
    CategoryID int IDENTITY(1,1) PRIMARY KEY,
    CategoryName varchar(50) NOT NULL
);
GO