create database Bookstore;
CREATE TABLE Books (
    Book_ID int PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT);

CREATE TABLE Customers (
    Customer_ID int PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150) );

CREATE TABLE Orders (
    Order_ID int PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2) );
    
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books 
WHERE Genre='Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books 
WHERE Published_year>1950;

-- 3) List all customers from the United Kingdom:
SELECT * FROM Customers 
WHERE country='United Kingdom';

-- 4) Show orders placed in November 2023:

SELECT * FROM orders
WHERE Order_Date between "2023-11-01" AND "2023-11-30";

-- 5) Retrieve the total stock of books available:
select sum(Stock) as Total_stock 
from Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books order by Price desc limit 1;

-- 7) List all genres available in the Books table:
SELECT distinct genre from Books;

-- 8) Calculate the total revenue generated from all orders:
select sum(Total_Amount) as Revenue
from orders;

-- 9) Retrieve the total number of books sold for each genre in decending order:

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders as o
JOIN Books as b ON o.book_id = b.book_id
GROUP BY b.Genre
order by Total_Books_sold desc;

-- 10) Find the average price of books in the "Fantasy" genre:

select avg(Price) as Avg_price from books
where Genre = "Fantasy";

-- 11) List customers who have placed at least 4 orders arranged by decending:

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=4
order by ORDER_COUNT desc;

-- 12) Find the most frequently ordered book:

select o.Book_id, b.title, count(o.Book_id) as Order_Count
from orders o
join books b ON o.Book_ID=b.Book_ID
group by o.Book_id, b.title
order by Order_Count desc limit 5;

-- 13) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 14) Find the customer who spent the most on orders:

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;

-- 15) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id 
ORDER BY b.book_id;




