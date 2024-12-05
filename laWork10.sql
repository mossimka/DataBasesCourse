--0
CREATE DATABASE lab10;
CREATE TABLE books(
    book_id int PRIMARY KEY ,
    title varchar(100),
    author varchar(100),
    price decimal(10, 2),
    quantity integer
);
CREATE TABLE Customers (
    customer_id int PRIMARY KEY,
    name varchar(255),
    email varchar(255)
);
CREATE TABLE Orders (
    order_id int PRIMARY KEY,
    book_id int,
    customer_id int,
    order_date date,
    quantity int,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Books (book_id, title, author, price, quantity)
VALUES
    (1, 'Database 101', 'A. Smith', 40.00, 10),
    (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
    (3, 'Advanced DB', 'C. Lee', 50.00, 5);
INSERT INTO Customers (customer_id, name, email)
VALUES
    (101, 'John Doe', 'johndoe@example.com'),
    (102, 'Jane Doe', 'janedoe@example.com');
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES
    (1, 1, 101, '2024-12-01', 2),
    (2, 2, 102, '2024-12-02', 3),
    (3, 3, 101, '2024-12-03', 1);
SELECT * FROM Orders;
SELECT * FROM Books;
SELECT * FROM Customers;

--1
BEGIN;
INSERT INTO Orders VALUES (4, 1, 101, now(), 2);
UPDATE Books SET quantity = quantity - 2 WHERE book_id = 1;
COMMIT;

--2
BEGIN;
INSERT INTO Orders VALUES (5, 3, 102, now(), 10);
UPDATE Books SET quantity = quantity - 10 WHERE book_id = 3;
ROLLBACK;

--3
--FIRST SESSION
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED ;
UPDATE Books SET price = 55 WHERE book_id = 3;
--before commit price didn't change
COMMIT;

--4
BEGIN;
UPDATE Customers SET email = 'JaneDoe@gmail.con' WHERE customer_id = 102;
COMMIT;
--restarting...

/* 2
BEGIN;

DO $$
DECLARE
    book_stock INT;
BEGIN
    SELECT quantity
    INTO book_stock
    FROM Books
    WHERE book_id = 3;

    IF book_stock < 10 THEN
        RAISE NOTICE 'Not enough stock available for book_id 3. Rolling back transaction.';
        ROLLBACK;
        RETURN;
    END IF;

    INSERT INTO Orders (customer_id, book_id, quantity, order_date)
    VALUES (102, 3, 10, CURRENT_DATE);

    UPDATE Books
    SET quantity = quantity - 10
    WHERE book_id = 3;

    COMMIT;
    RAISE NOTICE 'Order successfully placed for customer_id 102.';
END;
$$;
*/