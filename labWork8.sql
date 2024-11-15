--1
CREATE DATABASE lab8;

--2
CREATE TABLE salesman(
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'Rome', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760.0, '2012-09-10', 3002, 5001);

--3
CREATE ROLE junior_dev LOGIN;

--4
CREATE VIEW salesmen_new_york AS
    SELECT * FROM salesman
    WHERE city = 'New York';
SELECT * FROM salesmen_new_york;
--CREATE VIEW sales_new_york AS
--    SELECT * FROM orders o
--    INNER JOIN salesman s ON o.salesman_id = s.salesman_id
--    WHERE s.salesman_id IN (SELECT salesman_id FROM salesman WHERE city = 'New York');

--5
CREATE VIEW order_with_names AS
    SELECT o.*, c.cust_name, s.name FROM orders o
    INNER JOIN customer c ON o.customer_id = c.customer_id
    INNER JOIN salesman s ON c.salesman_id = s.salesman_id;
SELECT * FROM order_with_names;

ALTER ROLE junior_dev SUPERUSER LOGIN;

--6
CREATE VIEW max_grade_customer AS
    SELECT * FROM customer
    WHERE grade IN (SELECT MAX(grade) FROM customer);
SELECT * FROM max_grade_customer;

ALTER ROLE junior_dev NOSUPERUSER;
GRANT SELECT ON TABLE salesman TO junior_dev;
GRANT SELECT ON TABLE orders TO junior_dev;
GRANT SELECT ON TABLE customer TO junior_dev;

--7
CREATE VIEW num_of_salesman_each_city AS
    SELECT city, COUNT(*) FROM  salesman
    GROUP BY city;
SELECT * FROM num_of_salesman_each_city;

--8
CREATE VIEW effective_salesman AS
    SELECT DISTINCT s.* FROM salesman s
    INNER JOIN customer c ON s.salesman_id = c.salesman_id;
SELECT * FROM effective_salesman;

--9
CREATE ROLE intern;--INHERIT
GRANT junior_dev TO intern;