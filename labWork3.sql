CREATE DATABASE lab3;--1

CREATE TABLE departments (
  code INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  budget DECIMAL NOT NULL
);
CREATE TABLE employees (
  ssn INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  lastname VARCHAR(255) NOT NULL ,
  department INTEGER NOT NULL ,
  city VARCHAR(255),
  FOREIGN KEY (department) REFERENCES departments(code)
);
CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL ,
  lastname VARCHAR(255) NOT NULL ,
  city VARCHAR(255)
);
INSERT INTO departments(code,name,budget) VALUES(14,'IT',65000);
INSERT INTO departments(code,name,budget) VALUES(37,'Accounting',15000);
INSERT INTO departments(code,name,budget) VALUES(59,'Human Resources',240000);
INSERT INTO departments(code,name,budget) VALUES(77,'Research',55000);
INSERT INTO departments(code,name,budget) VALUES(45,'Management',155000);
INSERT INTO departments(code,name,budget) VALUES(11,'Sales',85000);

INSERT INTO employees(ssn,name,lastname,department, city) VALUES('123234877','Michael','Rogers',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('152934485','Anand','Manikutty',14, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('222364883','Carol','Smith',37, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('326587417','Joe','Stevens',37, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332154719','Mary-Anne','Foster',14, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('332569843','George','ODonnell',77, 'Astana');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('546523478','John','Doe',59, 'Shymkent');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('631231482','David','Smith',77, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('654873219','Zacary','Efron',59, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('745685214','Eric','Goldsmith',59, 'Atyrau');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657245','Elizabeth','Doe',14, 'Almaty');
INSERT INTO employees(ssn,name,lastname,department, city) VALUES('845657246','Kumar','Swamy',14, 'Almaty');

INSERT INTO customers(name,lastname, city) VALUES('John','Wills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Garry','Foster', 'London');
INSERT INTO customers(name,lastname, city) VALUES('Amanda','Hills', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('George','Doe', 'Tokyo');
INSERT INTO customers(name,lastname, city) VALUES('David','Little', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Shawn','Efron', 'Astana');
INSERT INTO customers(name,lastname, city) VALUES('Eric','Gomez', 'Shymkent');
INSERT INTO customers(name,lastname, city) VALUES('Elizabeth','Tailor', 'Almaty');
INSERT INTO customers(name,lastname, city) VALUES('Julia','Adams', 'Astana');--3
DROP TABLE customers;
DROP TABLE employees;
DROP TABLE departments;

SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM departments;

SELECT lastname FROM employees;--4

SELECT DISTINCT lastname FROM employees;--5

SELECT * FROM employees
WHERE lastname = 'Smith';--6

SELECT * FROM employees
WHERE lastname = 'Smith' OR lastname = 'Doe';--7

SELECT * FROM employees
WHERE department = 14;--8

SELECT * FROM employees
WHERE department = 37 OR department = 77;--8

SELECT sum(budget) AS sum_of_burgets FROM departments;--9

SELECT department, count(department) FROM employees
GROUP BY department;--10

SELECT department, COUNT(department)
FROM employees
GROUP BY department HAVING COUNT(department) > 2;--11

SELECT name FROM departments
ORDER BY budget DESC
LIMIT 1 OFFSET 1;--12

SELECT name, lastname FROM employees
WHERE department = (SELECT code FROM departments ORDER BY budget LIMIT 1);--13

SELECT employees.name, customers.name
FROM employees
JOIN customers ON employees.city = customers.city
WHERE employees.city = 'Almaty';--14

SELECT * FROM departments
WHERE budget > 60000
ORDER BY budget, code DESC;--15

UPDATE departments SET budget = budget * 0.9
WHERE code = (SELECT code FROM departments ORDER BY budget LIMIT 1);--16

UPDATE employees SET department = 14
WHERE department = 77; --17

DELETE FROM employees WHERE department = 14;--18

DELETE FROM employees;--19