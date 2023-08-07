CREATE DATABASE Task
USE Task
CREATE TABLE Categories (
	Id int PRIMARY KEY IDENTITY,
	[Name] nvarchar(30) NOT NULL
)
CREATE TABLE Products (
	Id int PRIMARY KEY IDENTITY,
	[Name] nvarchar(50) NOT NULL,
	[Count] int NOT NULL CHECK([Count] >= 0),
	Price decimal(7,2) NOT NULL CHECK(Price > 0),
	CategoryId int FOREIGN KEY REFERENCES Categories(Id)
)
INSERT INTO Categories VALUES
	('Clothing'), ('Electronics'), ('Food'), ('Furniture')
INSERT INTO Products VALUES
	('T-shirt', 345, 79.99, 1),
	('Dress', 122, 119.99, 1),
	('Pyjamas', 41, 39.99, 1),
	('Shorts', 3, 19.99, 1),
	('MacBook Pro', 54, 3000, 2),
	('Xiaomi Mi Play', 400, 400, 2),
	('Alpen Gold Almond', 2.32, 890, 3),
	('Table', 499.99, 12, 4),
	('Chair', 499.99, 12, 4),
	('Drawer', 499.99, 12, 4)

CREATE FUNCTION GetAveragePrice(@CategoryName nvarchar(30))
RETURNS decimal(7,2)
AS
BEGIN
	DECLARE @avg decimal(7,2)
	SELECT @avg=AVG(Price) FROM Products P
	JOIN Categories C ON CategoryId = C.Id
	WHERE C.[Name] = @CategoryName
	RETURN @avg
END

SELECT dbo.GetAveragePrice('Clothing') AS 'Average Price'