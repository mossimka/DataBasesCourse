CREATE DATABASE lab2; --1

CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY,
    country_name varchar(50),
    region_id int,
    population int
); --2
DROP TABLE countries;
DROP TABLE countries_new;
SELECT * FROM countries;
SELECT * FROM countries_new;

INSERT INTO countries(country_name, region_id, population)
VALUES ('Germany', '0', 84000000);--3

INSERT INTO countries (country_name)
VALUES ('Mexico');--4

INSERT INTO countries(region_id)
VALUES (NULL);--5

INSERT INTO countries(country_name, region_id, population)
VALUES ('USA', '1', 333000000),
       ('UK', '0', 67000000),
       ('Vatican', '3', 764);--6

ALTER TABLE countries ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';--7

INSERT INTO countries (country_name)
VALUES (DEFAULT);--8

INSERT INTO countries
VALUES (DEFAULT, DEFAULT,  DEFAULT, DEFAULT);--9

CREATE TABLE countries_new (LIKE countries INCLUDING ALL);--10

INSERT INTO countries_new
SELECT * FROM countries;--11

UPDATE countries SET region_id=1
WHERE region_id IS NULL; --12

SELECT country_name, population * 1.1 AS "New Population"
FROM countries; --13

DELETE FROM countries
WHERE population < 100000; --14

DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries); --15

DELETE FROM countries
RETURNING *;--16
