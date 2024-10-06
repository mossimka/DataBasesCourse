CREATE DATABASE lab4;--1

CREATE TABLE Warehouses (
    code int,
    location varchar(255),
    capacity int
);
SELECT * FROM Warehouses;
DROP TABLE Warehouses;

CREATE TABLE Boxes (
    code char(4),
    contents varchar(255),
    value real,
    warehouse int
);
DROP TABLE Boxes;
SELECT * FROM Boxes;

INSERT INTO Warehouses(code, location, capacity)
VALUES
    (1, 'Chikago', 3),
    (2, 'Chikago', 4),
    (3, 'New York', 7),
    (4, 'Los Angeles', 2),
    (5, 'San Francisco', 8);

INSERT INTO Boxes (code, contents, value, warehouse)
VALUES
    ('0MN7', 'Rocks', 180, 3),
    ('4H8P', 'Rocks', 250, 1),
    ('4RT3', 'Scissors', 190, 4),
    ('7G3H', 'Rocks', 200, 1),
    ('8JN6', 'Papers', 75, 1),
    ('8Y6U', 'Papers', 50, 3),
    ('9J6F', 'Papers', 175, 2),
    ('LL08', 'Rocks', 140, 4),
    ('P0H6', 'Scissors', 125, 1),
    ('P2T6', 'Scissors', 150, 2),
    ('TU55', 'Papers', 90, 5);--2

SELECT * FROM Warehouses;--4

SELECT * FROM Boxes WHERE value > 150;--5

SELECT MIN(code) AS code, contents, MIN(value) AS value, MIN(warehouse) AS warehouse
FROM Boxes
GROUP BY contents;--6 I use min to find distinct boxes values

SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse
ORDER BY warehouse;--7

SELECT warehouse, COUNT(*) AS box_count
FROM Boxes
GROUP BY warehouse
HAVING COUNT(*) > 2
ORDER BY warehouse;--8 'having' because filter after grouping

INSERT INTO Warehouses(code, location, capacity)
VALUES (6, 'New York', 3);--9

INSERT INTO Boxes (code, contents, value, warehouse)
VALUES ('H5RT', 'Papers', 200, 2);--10

SELECT code FROM Boxes
WHERE value = (
    SELECT DISTINCT value
    FROM Boxes
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
)
LIMIT 1;--11

DELETE FROM Boxes WHERE value < 150;--12

DELETE FROM Boxes
WHERE warehouse IN (SELECT code FROM Warehouses WHERE location = 'New York')
RETURNING *;
