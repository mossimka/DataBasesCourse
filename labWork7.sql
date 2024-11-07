CREATE DATABASE lab7;
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);
CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);
CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

--1 index
--SELECT * FROM countries
-- WHERE name = ‘string’;
CREATE INDEX name_index ON employees(first_name); -- WHERE first_name = 'John'

--2 index
--SELECT * FROM employees
-- WHERE name = ‘string’ AND surname = ‘string’;
CREATE INDEX full_name_index ON employees(first_name, last_name); -- WHERE first_name = 'John' AND last_name = 'Smith'

--3 unique index
--SELECT * FROM employees
-- WHERE salary < value1 AND salary > value2;
CREATE UNIQUE INDEX salary_index ON employees(salary); -- WHERE salary < value1 AND salary > value2

--4 index
--SELECT * FROM employees
--WHERE substring(name from 1 for 4) = ‘abcd’;
CREATE INDEX name_substr_index ON employees((substring(first_name FROM 1 FOR 4)));

--5 index
-- SELECT * FROM employees e JOIN departments d
-- ON d.department_id = e.department_id WHERE
-- d.budget > value2 AND e.salary < value2;
CREATE INDEX d_department_id_index ON departments(department_id);
CREATE INDEX e_department_id_index ON employees(department_id);
CREATE INDEX d_department_id_budget_index ON departments(department_id, budget);
CREATE INDEX e_salary_salary ON employees(salary);



DROP INDEX name_index;
DROP INDEX full_name_index;
DROP INDEX salary_index;
DROP INDEX name_substr_index;