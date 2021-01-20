/* 
Name: Basira Shirzad
Date: 01-20-2021
*/

/* 
Question 1: Write a select statement to return all columns and rows from the customer table.
*/
SELECT * 
FROM customer;

/* 
Question 2: Write a query to select first name, last name, and email from the customer table.
*/
SELECT first_name, last_name, email 
FROM customer;

/* 
Question 3: Write a query to return all rows and columns from the film table. 
*/
SELECT * 
FROM film;
 
/* 
Question 4: Write a query to return unique rows from the release_year column in the film table.
*/
SELECT DISTINCT release_year 
FROM film;

/* 
Question 5: Write a query to return unique rows from the rental_rate column in the film table.
*/
SELECT DISTINCT rental_rate 
FROM film;

/* 
Question 6: A customer left us some feedback about our store. 
            Write a query to find her email address – for Nancy Thomas.
*/
SELECT email 
FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

/* 
Question 7: We’re trying to find a customer located at a certain address ‘259 Ipoh Drive’ 
            Can you find their phone number?
*/
SELECT phone 
FROM address
WHERE address = '259 Ipoh Drive';

/* 
Question 8: Write a query from the customer table, where store id is 1 and address id is greater than 150.
*/
SELECT * 
FROM customer
WHERE store_id = 1 AND address_id > 150;

/* 
Question 9: Write a query from the payment table where the amount is either 4.99 or 1.99.
*/
SELECT * 
FROM customer
WHERE store_id = 1 AND address_id > 150;

/* 
Question 10: Write a query to return a list of transitions from the payment table where the amount is greater than 5.
*/
SELECT * 
FROM payment
WHERE amount > 5;
