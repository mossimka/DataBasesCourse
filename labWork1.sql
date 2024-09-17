CREATE DATABASE lab1; --1

CREATE TABLE users ( --2
    id SERIAL,
    firstname varchar(50),
    lastname varchar(50)
);

SELECT * FROM users;

ALTER TABLE users ADD COLUMN isadmin int; --3

ALTER TABLE users ALTER COLUMN isadmin TYPE boolean USING isadmin::boolean; --4

ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT false; --5

ALTER TABLE users ADD CONSTRAINT usersPK PRIMARY KEY(id); --6

CREATE TABLE tasks ( --7
    id SERIAL,
    name varchar(50),
    user_id int
);

DROP TABLE tasks; --8

DROP DATABASE lab1; --9