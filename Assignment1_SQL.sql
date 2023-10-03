create database a1;
use a1;
CREATE TABLE SalesPeople(
			 snum int primary key,
			 Sname varchar(50) UNIQUE,
             city varchar(50),
             comm float);
Drop table SalesPeople; 
CREATE TABLE customers(
            cnum int primary key,
            cname varchar(50),
            city varchar(50) NOT NULL,
            snum int,
            FOREIGN KEY (snum) REFERENCES SalesPeople(snum));
            
select * from customers;         
CREATE TABLE orders(
           Onum int primary key,
           Amt float,
           Odate varchar(50),
           cnum int,
           snum int,
           FOREIGN KEY (snum) REFERENCES SalesPeople(snum),
           FOREIGN KEY (cnum) REFERENCES customers(snum));
-- Inserting data into the SalesPeople table
INSERT INTO SalesPeople (Snum, Sname, City, Comm)
VALUES
    (1001, 'Peel', 'London', 0.12),
    (1002, 'Serres', 'San Jose', 0.13),
    (1004, 'Motika', 'London', 0.11),
    (1007, 'Rifkin', 'Barcelona', 0.15),
    (1003, 'Axelrod', 'New York', 0.10);
select * from SalesPeople;
-- Inserting data into the customers table
INSERT INTO customers (cnum, cname, city, snum)
VALUES
    (2001, 'Hoffman', 'London', 1001),
    (2002, 'Giovanni', 'Rome', 1003),
    (2003, 'Liu', 'San Jose', 1002),
    (2004, 'Grass', 'Berlin', 1002),
    (2006, 'Clemens', 'London', 1001),
    (2008, 'Cisneros', 'San Jose', 1007),
    (2007, 'Pereira', 'Rome', 1004);

-- Inserting data into the orders table
INSERT INTO orders (Onum, Amt, Odate, cnum, snum)
VALUES
    (3001, 18.69, '3-10-1990', 2008, 1007),
    (3003, 767.19, '3-10-1990', 2001, 1001),
    (3002, 1900.10, '3-10-1990', 2007, 1004),
    (3005, 5160.45, '3-10-1990', 2003, 1002),
    (3006, 1098.16, '3-10-1990', 2008, 1007),
    (3009, 1713.23, '4-10-1990', 2002, 1003),
    (3007, 75.75, '4-10-1990', 2004, 1002),
    (3008, 4273.00, '5-10-1990', 2006, 1001),
    (3010, 1309.95, '6-10-1990', 2004, 1002),
    (3011, 9891.88, '6-10-1990', 2006, 1001);

-- 	Q1 Count the number of Salesperson whose name begin with ‘a’/’A’.
SELECT COUNT(snum)
FROM salespeople
WHERE snum LIKE 'A%' OR snum LIKE 'a%';

-- Q2  Display all the Salesperson whose all orders worth is more than Rs. 2000.
SELECT s.snum, s.Sname
FROM SalesPeople s
WHERE s.snum NOT IN (
    SELECT o.snum
    FROM orders o
    GROUP BY o.snum
    HAVING SUM(o.Amt) <= 2000
);

-- Q3 Count the number of Salesperson belonging to Newyork.
SELECT Count(*) as no_of_salesperson FROM SalesPeople where city='Newyork';

-- Q4  Display the number of Salespeople belonging to London and belonging to Paris.
SELECT city, COUNT(*) as num_salespeople
FROM SalesPeople
WHERE city IN ('London', 'Paris')
GROUP BY city;

-- Q5 Display the number of orders taken by each Salesperson and their date of orders.
SELECT S.snum, S.sname, O.Odate, COUNT(O.Onum) AS num_orders
FROM SalesPeople S
LEFT JOIN orders O ON S.snum = O.snum
GROUP BY S.snum, S.sname, O.Odate
ORDER BY S.snum, O.Odate;



