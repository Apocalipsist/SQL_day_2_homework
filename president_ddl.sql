-- Create a customer table
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25),
	last_name VARCHAR(25),
	email VARCHAR(25),
	address VARCHAR(100),
	city VARCHAR(30),
	state VARCHAR(2),
	zipcode VARCHAR(5)
);

SELECT *
FROM customer;


-- Create an order table
CREATE TABLE order_(
	order_id SERIAL PRIMARY KEY,
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	amount NUMERIC(5,2),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

SELECT *
FROM order_;

-- Alter customer email column to VARCHAR(50)
ALTER TABLE customer 
ALTER COLUMN email TYPE VARCHAR(50);

-- DML - Inserting data into the customer table
INSERT INTO customer(first_name, last_name, email, address, city, state, zipcode)
VALUES('George', 'Washington', 'firstpres@usa.gov', '3200 Mt. Vernon Way', 'Mt. Vernon', 'VA', '87522'),
('John', 'Adams', 'jadams@whitehouse.org', '1234 W Presidential Place', 'Quincy', 'MA', '43592'),
('Thomas', 'Jefferson', 'iwrotethedeclaration@freeamerica.org', '555 Independence Drive', 'Charleston', 'VA', '34532'),
('James', 'Madison', 'fatherofconstitution@prez.io', '8345 E Eastern Ave', 'Richmond', 'VA', '43538'),
('James', 'Monroe', 'jmonroe@usa.gov', '3682 N Monroe Parkway', 'Chicago', 'IL', '60623');

SELECT * FROM customer;


-- Insert order data

INSERT INTO order_(amount, customer_id)
VALUES (99.99, 1);

SELECT *
FROM order_;

INSERT INTO order_(amount, customer_id)
VALUES (33.54, 1);


INSERT INTO order_(amount, customer_id)
VALUES (18.45, 3);


INSERT INTO order_(amount, customer_id)
VALUES (62.38, 5);

INSERT INTO order_(amount, customer_id)
VALUES (59.21, null);

INSERT INTO order_(amount, customer_id)
VALUES (43.34, null);

INSERT INTO order_(amount, customer_id)
VALUES (15.84, 2);

SELECT *
FROM order_;



SELECT first_name, last_name, email
FROM customer 
WHERE customer_id = 1;

SELECT order_date, amount
FROM order_ 
WHERE customer_id = 1;


-- Join these tables together using a JOIN and common fields
-- SELECT column1, column2, etc (can be from either table)
-- FROM table_name_1 (will be considered the LEFT table)
-- JOIN table_name_2 (will be considered the RIGHT table)
-- ON table_name_1.column_name = table_name_2.column_name (where column_name is a foreign key to the other column_name)


-- Inner Join
SELECT first_name, last_name, email, order_date, amount, customer.customer_id, order_.customer_id
FROM customer
JOIN order_ -- JOIN and INNER JOIN ARE the same thing
ON customer.customer_id = order_.customer_id;

-- returns matching information even if it is selecting all
SELECT *
FROM customer 
JOIN order_ 
ON customer.customer_id = order_.customer_id;

-- Outer Join OR FULL JOIN
SELECT *
FROM customer 
FULL JOIN order_ 
ON customer.customer_id = order_.customer_id;   -- ALSO RETURNS null values if information is present in one but not the other 

-- Left Join
SELECT *
FROM customer;


SELECT *
FROM customer -- LEFT TABLE because it mentioned FIRST
LEFT JOIN order_ -- RIGHT TABLE
ON customer.customer_id = order_.customer_id;

--SELECT SUM(amount)
--FROM order_ 
--JOIN customer 
--ON customer.customer_id = order_.customer_id 
--WHERE state = 'VA';

-- Right Join
SELECT *
FROM customer -- LEFT TABLE because it mentioned FIRST
RIGHT JOIN order_ -- RIGHT TABLE
ON customer.customer_id = order_.customer_id;




-- A left join with table_a first will show the same data as a right join with table_a second
SELECT *
FROM customer -- LEFT TABLE because it mentioned FIRST
LEFT JOIN order_ -- RIGHT TABLE
ON customer.customer_id = order_.customer_id;

SELECT *
FROM order_ -- LEFT TABLE because it mentioned FIRST
RIGHT JOIN customer -- RIGHT TABLE
ON customer.customer_id = order_.customer_id;




-- JOINS with DQL
SELECT state, COUNT(*)
FROM customer 
JOIN order_ 
ON customer.customer_id = order_.customer_id 
WHERE amount > 15
GROUP BY state
HAVING COUNT(*) > 2;

SELECT first_name, last_name, amount, order_date
FROM customer
JOIN order_
ON customer.customer_id = order_.customer_id;



-- Alias Table Names 
SELECT c.customer_id, c.first_name, c.last_name, o.amount
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id;




