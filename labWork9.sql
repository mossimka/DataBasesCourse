--0
CREATE DATABASE lab9;
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary NUMERIC(10, 2)
);

INSERT INTO employees (employee_name, department, salary)
VALUES
('John Doe',  'IT', 75000),
('Jane Smith', 'Operations', 90000),
('Alice Johnson', 'Human Resources', 60000),
('Bob Brown', 'Sales', 50000);
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10, 2)
);
INSERT INTO products (product_name, category, price)
VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('Desk Chair', 'Furniture', 150.00),
('Table', 'Furniture', 250.00),
('Coffee Mug', 'Kitchen', 15.00),
('Blender', 'Kitchen', 70.00);





--1
CREATE OR REPLACE FUNCTION increase_value(num int) RETURNS int AS $$
    BEGIN
    RETURN num + 10;
    END;$$
LANGUAGE plpgsql;
SELECT increase_value(5);

--2
CREATE OR REPLACE FUNCTION compare_numbers(a int, b int, OUT comp varchar) AS $$
BEGIN
    IF a > b THEN
        comp := 'Greater';
    ELSIF a < b THEN
        comp := 'Less';
    ELSE
        comp := 'Equal';
    END IF;
END; $$
LANGUAGE plpgsql;
SELECT compare_numbers(5, 6);

--3
CREATE OR REPLACE FUNCTION number_series(n int)
RETURNS SETOF int AS $$--TABLE (n int) don't work
BEGIN
    FOR i IN 1..n LOOP
        RETURN NEXT i;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM number_series(5);

--4
CREATE OR REPLACE FUNCTION find_employee(emp_name varchar)
RETURNS TABLE(
    employee_id int,
    employee_name varchar(100),
    department varchar(50),
    salary numeric(10, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT e.employee_id, e.employee_name, e.department, e.salary
    FROM employees e
    WHERE e.employee_name = emp_name;
END; $$
LANGUAGE plpgsql;

SELECT * FROM find_employee('John Doe');

--5
CREATE OR REPLACE FUNCTION list_products(pr_category varchar)
RETURNS TABLE(
    product_id int,
    product_name varchar(100),
    category varchar(50),
    price numeric(10, 2)
) AS $$
BEGIN
    RETURN QUERY SELECT p.product_id, p.product_name, p.category, p.price
    FROM products p
    WHERE p.category = pr_category;
END;$$
LANGUAGE plpgsql;
SELECT * FROM list_products('Electronics');

--6
CREATE OR REPLACE FUNCTION add_bonus(bonus numeric(10, 2), emp_name VARCHAR)
RETURNS void
AS $$
BEGIN
    UPDATE employees
    SET salary = salary + bonus
    WHERE employee_name = emp_name;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION calculate_bonus(num_of_overtime_hrs int, emp_name varchar)
RETURNS varchar
AS $$
DECLARE
    emp_salary numeric(10, 2);
    bonus numeric(10, 2);
BEGIN
    SELECT e.salary INTO emp_salary
    FROM employees e
    WHERE e.employee_name = emp_name;
    bonus := (emp_salary / 1200) * 0.2 * num_of_overtime_hrs;
    PERFORM add_bonus(bonus, emp_name);
    RETURN 'Bonus will be ' || bonus || ' for ' || emp_name;
END; $$
LANGUAGE plpgsql;

SELECT calculate_bonus(10, 'John Doe');

--7
CREATE OR REPLACE FUNCTION complex_calculation(
    in_str VARCHAR,
    in_num INTEGER,
    in_factor NUMERIC(10,2),
    OUT result NUMERIC(10,2)
)
AS $$
DECLARE
    processed_str VARCHAR;
    numeric_result NUMERIC(10,2);
BEGIN
    <<main_block>>
    BEGIN
        <<string_manipulation>>
        BEGIN
            processed_str := in_str || in_str;
            RAISE NOTICE 'Processed string: %', processed_str;
        END string_manipulation;
        <<numeric_computation>>
        BEGIN
            numeric_result := in_num * in_factor;
            RAISE NOTICE 'Numeric computation result: %', numeric_result;
        END numeric_computation;

        result := numeric_result + CAST(LENGTH(processed_str) AS NUMERIC);
        RAISE NOTICE 'Final result: %', result;
    END main_block;
END;
$$ LANGUAGE plpgsql;

SELECT complex_calculation('BeOrNotToBe', 10, 2.5);
