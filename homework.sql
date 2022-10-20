--Question 1. List all customers who live in Texas (use JOINs)


SELECT first_name, last_name, district
FROM customer 
JOIN address 
ON customer.address_id = address.address_id
WHERE district = 'Texas';


--first_name|last_name|district|
------------+---------+--------+
--Jennifer  |Davis    |Texas   |
--Kim       |Cruz     |Texas   |
--Richard   |Mccrary  |Texas   |
--Bryan     |Hardison |Texas   |
--Ian       |Still    |Texas   |


-- Question 2. List all payments of more than $7.00 with the customer’s first and last name

SELECT c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
WHERE amount > 7.00;

--first_name|last_name   |amount|
------------+------------+------+
--Peter     |Menard      |  7.99|
--Peter     |Menard      |  7.99|
--Peter     |Menard      |  7.99|
--Douglas   |Graf        |  8.99|
--Ryan      |Salisbury   |  8.99|
--Ryan      |Salisbury   |  8.99|
--Ryan      |Salisbury   |  7.99|
--Roger     |Quintanilla |  8.99|
--Joe       |Gilliland   |  8.99|
-- ...


-- Question 3. Show all customer names who have made over $175 in payments (use subqueries)

SELECT *
FROM customer
WHERE customer_id  in (
		SELECT customer_id
		FROM payment
		GROUP BY customer_id
		HAVING sum(amount) > 175
);

--SELECT customer_id , sum(amount) AS sum_num
--FROM payment
--GROUP BY customer_id;

--customer_id|store_id|first_name|last_name|email                            |address_id|activebool|create_date|last_update            |active|
-------------+--------+----------+---------+---------------------------------+----------+----------+-----------+-----------------------+------+
--        137|       2|Rhonda    |Kennedy  |rhonda.kennedy@sakilacustomer.org|       141|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        144|       1|Clara     |Shaw     |clara.shaw@sakilacustomer.org    |       148|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        148|       1|Eleanor   |Hunt     |eleanor.hunt@sakilacustomer.org  |       152|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        178|       2|Marion    |Snyder   |marion.snyder@sakilacustomer.org |       182|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        459|       1|Tommy     |Collazo  |tommy.collazo@sakilacustomer.org |       464|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|
--        526|       2|Karl      |Seal     |karl.seal@sakilacustomer.org     |       532|true      | 2006-02-14|2013-05-26 14:49:45.738|     1|


-- Question 4. List all customers that live in Argentina (use the city table)

SELECT * 
FROM country
WHERE country = 'Argentina';


SELECT *
FROM city;

SELECT * FROM address;

SELECT * FROM customer;

SELECT c.first_name, c.last_name, a.district, ci.city, ca.country
FROM customer c
JOIN address a
ON c.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country ca
ON ci.country_id = ca.country_id
WHERE ca.country = 'Argentina';


--first_name|last_name|district    |city                |country  |
------------+---------+------------+--------------------+---------+
--Willie    |Markham  |Buenos Aires|Almirante Brown     |Argentina|
--Jordan    |Archuleta|Buenos Aires|Avellaneda          |Argentina|
--Jason     |Morrissey|Buenos Aires|Baha Blanca         |Argentina|
--Kimberly  |Lee      |Crdoba      |Crdoba              |Argentina|
--Micheal   |Forman   |Buenos Aires|Escobar             |Argentina|
--Darryl    |Ashcraft |Buenos Aires|Ezeiza              |Argentina|
--Julia     |Flores   |Buenos Aires|La Plata            |Argentina|
--Florence  |Woods    |Buenos Aires|Merlo               |Argentina|
--Perry     |Swafford |Buenos Aires|Quilmes             |Argentina|
--Lydia     |Burke    |Tucumn      |San Miguel de Tucumn|Argentina|
--Eric      |Robert   |Santa F     |Santa F             |Argentina|
--Leonard   |Schofield|Buenos Aires|Tandil              |Argentina|
--Willie    |Howell   |Buenos Aires|Vicente Lpez        |Argentina|


-- Question 5. Show all the film categories with their count in descending order

SELECT *
FROM category;

SELECT category_id, count(*) AS num_movies_in_cat
FROM film_category
GROUP BY category_id;


SELECT c.category_id, c.name, count(*) AS num_movies_in_cat
FROM category c
JOIN film_category fc
ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY num_movies_in_cat DESC;

--SELECT *
--FROM category
--WHERE category_id in (
--	SELECT category_id 
--	FROM film_category
--	GROUP BY category_id
--	HAVING (
--		SELECT num_movies_in_cat
--		FROM (
--			SELECT category_id, count(*) AS num_movies_in_cat
--			FROM film_category
--			GROUP BY category_id
--		)
--	)
--);

--SELECT category_id, count(film_id) FROM film_category GROUP BY category_id ORDER BY count(*) DESC;


--category_id|name       |num_movies_in_cat|
-------------+-----------+-----------------+
--         15|Sports     |               74|
--          9|Foreign    |               73|
--          8|Family     |               69|
--          6|Documentary|               68|
--          2|Animation  |               66|
--          1|Action     |               64|
--         13|New        |               63|
--          7|Drama      |               62|
--         14|Sci-Fi     |               61|
--         10|Games      |               61|
--          3|Children   |               60|
--          5|Comedy     |               58|
--          4|Classics   |               57|
--         16|Travel     |               57|
--         11|Horror     |               56|
--         12|Music      |               51|



-- Question 6. What film had the most actors in it (show film info)?

SELECT film_id, title
FROM film;

SELECT * 
FROM actor;

SELECT film_id, 
FROM film_actor
GROUP BY film_id;

SELECT f.film_id, f.title, count(*) AS num_actors
FROM film f
JOIN film_actor fa
ON fa.film_id  = f.film_id 
JOIN actor a
ON fa.actor_id  = a.actor_id
GROUP BY f.film_id 
ORDER BY num_actors DESC
LIMIT 1;



--film_id|title           |num_actors|
---------+----------------+----------+
--    508|Lambs Cincinatti|        15|


-- Question 7. Which actor has been in the least movies?

SELECT *
FROM actor;

SELECT a.actor_id, a.first_name, a.last_name, count(*) AS nums_in_film
FROM actor a
JOIN film_actor fa
ON fa.actor_id  = a.actor_id
JOIN film f
ON fa.film_id = f.film_id 
GROUP BY a.actor_id
ORDER BY nums_in_film
LIMIT 1;


--actor_id|first_name|last_name|num_films|
----------+----------+---------+---------+
--     148|Emily     |Dee      |       14|


-- Question 8. Which country has the most cities?

SELECT *
FROM country;

SELECT *
FROM city;

SELECT c.country_id, c.country, count(*) AS nums_cities
FROM country c
JOIN city ci
ON c.country_id = ci.country_id 
GROUP BY c.country_id
ORDER BY nums_cities DESC;



--country_id|country                              |num_cities|
------------+-------------------------------------+----------+
--        44|India                                |        60|
--        23|China                                |        53|
--       103|United States                        |        35|


-- Question 9. List the actors who have been in between 20 and 25 films.

SELECT *
FROM actor;

SELECT a.actor_id, a.first_name, a.last_name, count(*)
FROM actor a
JOIN film_actor fa
ON fa.actor_id = a.actor_id
JOIN film f
ON fa.film_id = f.film_id 
GROUP BY a.actor_id
HAVING count(*) BETWEEN 20 AND 25;


--actor_id|first_name |last_name  |count|
----------+-----------+-----------+-----+
--     114|Morgan     |Mcdormand  |   25|
--     153|Minnie     |Kilmer     |   20|
--      32|Tim        |Hackman    |   23|
--     132|Adam       |Hopper     |   22|
--      46|Parker     |Goldberg   |   24|
--     163|Christopher|West       |   21|
--...
