SELECT *
FROM film_actor;

SELECT *
FROM film;

SELECT *
FROM actor;

-- Join the film_actor and film table together
SELECT fa.film_id, fa.actor_id, f.film_id, f.title, f.description, f.release_year
FROM film f
JOIN film_actor fa 
ON f.film_id = fa.film_id
ORDER BY f.film_id;


-- Join the film_actor and actor table together
SELECT fa.actor_id, fa.film_id, a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id;


-- Join the film table to the actor table through the film_actor table
SELECT f.film_id, f.title, f.release_year, a.first_name, a.last_name
FROM film f
JOIN film_actor fa 
ON f.film_id = fa.film_id 
JOIN actor a 
ON a.actor_id = fa.actor_id
ORDER BY f.film_id;



-- SUBQUERIES!!!!!

-- Subqueries are Queries that happen within another query

-- Which films have exactly 12 actors in it


-- Step 1. Get the ids of the films that have 12 actors
SELECT film_id
FROM film_actor
GROUP BY film_id
HAVING COUNT(*) = 12;
--529
--802
--34
--892
--414
--517
-- Step 2. Get the rows from the film table that have film ids in the list of films
SELECT *
FROM film 
WHERE film_id IN (
	529,
	802,
	34,
	892,
	414,
	517
);

-- Create a Subquery: Combine the two steps into One Query. The query you want executed FIRST is the 
-- subquery. ** Subquery must return only ONE column** *unless used in a FROM
SELECT *
FROM film 
WHERE film_id IN (
	SELECT film_id
	FROM film_actor
	GROUP BY film_id
	HAVING COUNT(*) = 12
);

-- Which staff member had the highest cumulative sales
SELECT *
FROM staff 
WHERE staff_id = (
	SELECT staff_id
	FROM payment 
	GROUP BY staff_id
	ORDER BY SUM(amount) DESC 
	LIMIT 1
);


-- Use subqueries for calculations
-- List out all of the payments that are more than the average payment amount

SELECT AVG(amount)
FROM payment;

SELECT *
FROM payment 
WHERE amount > (
	SELECT AVG(amount)
	FROM payment
);


-- Subqueries with a FROM clause 
-- *Subquery in FROM must have an alias*

-- List the customers who have more rentals than the average customer

SELECT *
FROM rental;

-- Get the customer's rental counts
SELECT customer_id, COUNT(*) AS num_rentals
FROM rental 
GROUP BY customer_id;


-- Find the average rental per customer based on rental counts
SELECT AVG(num_rentals)
FROM (
	SELECT customer_id, COUNT(*) AS num_rentals
	FROM rental 
	GROUP BY customer_id
) AS customer_rental_counts;

-- Find the customers by ID who have more rentals than the average
SELECT customer_id
FROM rental 
GROUP BY customer_id 
HAVING COUNT(*) > (
	SELECT AVG(num_rentals)
	FROM (
		SELECT customer_id, COUNT(*) AS num_rentals
		FROM rental 
		GROUP BY customer_id
	) AS customer_rental_counts
);

-- List all customers whose id is in the list of ids greater than average
SELECT *
FROM customer 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id 
	HAVING COUNT(*) > (
		SELECT AVG(num_rentals)
		FROM (
			SELECT customer_id, COUNT(*) AS num_rentals
			FROM rental 
			GROUP BY customer_id
		) AS customer_rental_counts
	)
);




SELECT *
FROM customer;

-- (DDL) Add a column on the customer table for loyalty_member and set everyone to FALSE 
ALTER TABLE customer 
ADD COLUMN loyalty_member BOOLEAN DEFAULT FALSE;

-- Use subqueries in DML statements
-- Update all customers who have made 25 or more rentals to be a loyalty_member

-- Step 1. Find all of the customer_ids who have made more than 25 rentals

SELECT customer_id
FROM rental 
GROUP BY customer_id
HAVING COUNT(*) > 25;


-- Step 2. Update teh customer table to set loyalty_member = True if customer in list of IDs
UPDATE customer 
SET loyalty_member = TRUE 
WHERE customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id
	HAVING COUNT(*) > 25
);


SELECT first_name, last_name, loyalty_member
FROM customer
ORDER BY customer_id DESC;





--SELECT *
--FROM film 
--WHERE film_id IN (
--	SELECT customer_id
--	FROM rental 
--	GROUP BY customer_id
--	HAVING COUNT(*) > 25
--);


-- Joins and Subqueries
SELECT c.customer_id, first_name, last_name, rental_id, rental_date 
FROM customer c
JOIN rental r 
ON c.customer_id = r.customer_id 
WHERE c.customer_id IN (
	SELECT customer_id
	FROM rental 
	GROUP BY customer_id
	HAVING COUNT(*) > 25
)
ORDER BY c.customer_id;