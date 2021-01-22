/* 
Name: Basira Shirzad
Date: 01-22-2021
*/

/* 
Question 1: Join the film to the film_actor table.
*/

/* Num Rows in film_actor Table */
SELECT *
FROM film_actor
-- Rows: 5462

/* Num Rows in film Table */
SELECT *
FROM film
-- Rows: 1000

SELECT *
FROM film_actor
JOIN film on film.film_id = film_actor.film_id
-- Rows: 5,462

/* Left Join - all records from film_actor table and matched records from film table */
SELECT *
FROM film_actor
LEFT JOIN film ON film_actor.film_id = film.film_id;
-- Rows: 5,462

/* Right Join - all records from film table and matched records from film_actor table */
SELECT *
FROM film_actor
RIGHT JOIN film ON film_actor.film_id = film.film_id;
-- Rows: 5,465

/* Inner Join - match from both tables */
SELECT *
FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id;
-- Rows: 5,462

/* Full Join - match in either left or right table */
SELECT *
FROM film_actor
FULL OUTER JOIN film ON film_actor.film_id = film.film_id;
-- Rows: 5,465

/* 
Question 2: Join the actor table to the film_actor table. 
*/

/* Num Rows in film_actor Table */
SELECT *
FROM film_actor
-- Rows: 5462

/* Num Rows in actor Table */
SELECT *
FROM actor
-- Rows: 200

SELECT *
FROM film_actor
JOIN actor on film_actor.actor_id = actor.actor_id;
-- Rows: 5,462

/* Left Join - all records from film_actor table and matched records from actor table */
SELECT *
FROM film_actor
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id;
-- Rows: 5,462

/* Right Join - all records from actor table and matched records from film_actor table */
SELECT *
FROM film_actor
RIGHT JOIN actor ON film_actor.actor_id = actor.actor_id;
-- Rows: 5,462

/* Inner Join - match from both tables */
SELECT *
FROM film_actor
INNER JOIN actor ON film_actor.actor_id = actor.actor_id;
-- Rows: 5,462

/* Full Join - match in either left or right table */
SELECT *
FROM film_actor
FULL OUTER JOIN actor ON film_actor.actor_id = actor.actor_id;
-- Rows: 5,462

/* 
Question 3: Try to join the actor, film_actor, and film table together (3 joins!)
*/

/* Num Rows in film_actor Table */
SELECT *
FROM film_actor
-- Rows: 5462

/* Num Rows in film Table */
SELECT *
FROM film
-- Rows: 1000

/* Num Rows in actor Table */
SELECT *
FROM actor
-- Rows: 200

SELECT *
FROM ((film_actor
JOIN film on film.film_id = film_actor.film_id)
JOIN actor ON film_actor.actor_id = actor.actor_id);
-- Rows: 5,462

/* Left Join - all records from film_actor table and matched records from film table
               then with that join get all records and match records from actor table */
SELECT *
FROM ((film_actor
LEFT JOIN film ON film_actor.film_id = film.film_id)
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id);
-- Rows: 5,462

/* Right Join - all records from film table and matched records from film_actor table
                then all records from actor table and match records with that join */
SELECT *
FROM ((film_actor
RIGHT JOIN film ON film_actor.film_id = film.film_id)
RIGHT JOIN actor ON film_actor.actor_id = actor.actor_id);
-- Rows: 5,462

/* Inner Join - match from all three tables */
SELECT *
FROM ((film_actor
INNER JOIN film ON film_actor.film_id = film.film_id)
INNER JOIN actor ON film_actor.actor_id = actor.actor_id);
-- Rows: 5,462

/* Full Join - match in either left or right table */
SELECT *
FROM ((film_actor
FULL OUTER JOIN film ON film_actor.film_id = film.film_id)
FULL OUTER JOIN actor ON film_actor.actor_id = actor.actor_id);
-- Rows: 5,465