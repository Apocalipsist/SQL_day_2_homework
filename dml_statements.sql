-- Data Manipulation Language (DML) Statements

SELECT *
FROM customer;

-- Add a row of data to the customer table

--Syntax: INSERT INTO table_name(col_1, col_2, etc.) VALUES (val_1, val_2, etc.)

INSERT INTO customer(
	first_name,
	last_name,
	email_address,
	loyalty_member,
	username
) VALUES (
	'Brian',
	'Stanton',
	'brians@codingtemple.com',
	TRUE,
	'brians'
);


SELECT *
FROM customer;


INSERT INTO customer(
	loyalty_member,
	username,
	address,
	email_address,
	first_name,
	last_name
) VALUES (
	'off',
	'mmeyers',
	'123 Scary Street',
	'idontdie@yahoo.com',
	'Michael',
	'Meyers'
);

SELECT *
FROM customer;


-- Insert without column names
INSERT INTO customer VALUES (
	3,
	'Freddie',
	'Kruger',
	'freddie@scarytown.gov',
	'321 Elm Street',
	'1',
	'freddie'
);

SELECT *
FROM customer;

INSERT INTO customer(
	first_name,
	last_name
) VALUES (
	'Jason',
	'Vorhees'
);

-- Add multiple rows of data in one command
-- Syntax: INSERT INTO table(col1, col2, ...) VALUES (val_a_1, val_a_2, ...), (val_b_1, val_b_2), ...
INSERT INTO seller(
	name,
	description,
	email,
	address
) VALUES (
	'Brians Desk Stuff',
	'All stuff that is on my desk',
	'briansdesk@stuff.com',
	'123 My Desk Ave.'
);

SELECT *
FROM seller;

INSERT INTO category(
	name,
	color
) VALUES (
	'Desk Supplies',
	'2458a6'
), (
	'Hydration Supplies',
	'52c421'
);

SELECT *
FROM category;


SELECT *
FROM product;

-- Inserting Data into a table with a Foreign Key
INSERT INTO product (
	prod_name,
	description,
	price,
	quantity,
	seller_id,
	category_id
) VALUES (
	'Water Bottle',
	'Stay hydrated while looking fly as heck',
	9.99,
	15,
	1,
	2
), (
	'Remote',
	'Change the channel without having to get up!',
	14.95,
	100,
	1,
	1
), (
	'Dry Erase Markers',
	'Take notes and then erase it away without any water!',
	4.50,
	50,
	1,
	1
);

SELECT *
FROM product;


-- CANNOT INSERT Foreign Key Values that reference non-existent data
--INSERT INTO product(
--	prod_name,
--	description,
--	price,
--	quantity,
--	seller_id,
--	category_id
--) VALUES (
--	'iPhone',
--	'A phone from Apple',
--	999.99,
--	100,
--	2, -- seller WITH an ID OF 2 does NOT exist
--	1
--);


SELECT *
FROM customer;

-- Syntax: UPDATE table_name SET col_name = value, etc. WHERE condition
UPDATE customer 
SET address = '555 Circle Drive'
WHERE customer_id = 1;

SELECT *
FROM customer;

-- A UPDATE/SET without a WHERE will update all rows
UPDATE customer 
SET loyalty_member = FALSE;

SELECT *
FROM customer;

SELECT *
FROM customer 
WHERE address LIKE '%Street';

UPDATE customer 
SET loyalty_member = TRUE
WHERE address LIKE '%Street';

SELECT *
FROM customer;

-- Query all products
SELECT *
FROM product;

-- DELETE ALL PRODUCTS THAT HAVE A PRICE LESS THAN $5.00
--Syntax - DELETE FROM table_name WHERE condition

DELETE FROM product 
WHERE price < 5.00;

SELECT *
FROM product;

-- A DELETE FROM without a WHERE will delete all rows
--DELETE FROM seller;






-- *DELETE duplicates from your table*
INSERT INTO category (
	name,
	color
) VALUES (
	'test',
	'123456'
);

SELECT * FROM category;


DELETE FROM category 
WHERE category_id NOT IN (
	SELECT MIN(category_id)
	FROM category 
	GROUP BY name
);

SELECT *
FROM category;

SELECT MIN(category_id)
FROM category 
GROUP BY name;



SELECT *
FROM category_category_id_seq;

-- Reset the category sequence back to 4
ALTER SEQUENCE category_category_id_seq
RESTART WITH 4;

INSERT INTO category (
	name,
	color
) VALUES (
	'test',
	'123456'
);

SELECT *
FROM category;