/* 
Name: Basira Shirzad
Date: 01-22-2021
*/

/* 
Task 1: Create a table with the following parameters:
		- CustomerID
		- CustomerName
		- Address
		- City
		- PostalCode
		- Country
		- Email
*/
DROP TABLE IF EXISTS customer_info;
CREATE TABLE Customer_Info (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
	country VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL
);

/* 
Task 2: Insert 3 rows of data into these columns using INSERT. 
		The data you insert should make sense for the column.
*/
INSERT INTO Customer_Info (
	customer_name, 
	address, 
	city, 
	postal_code, 
	country,
	email
)
VALUES (
	'James Butt',
	'6649 N Blue Gum St',
	'New Orleans',
	'70116',
	'United States',
	'jbutt@gmail.com'
),
(
	'Josephine Darakjy',
	'4 B Blue Ridge Blvd',
	'Brighton',
	'48116',
	'United States',
	'josephine_darakjy@darakjy.org'
),
(
	'Lenna Paprocki',
	'639 Main St',
	'Anchorage',
	'99501',
	'United States',
	'lpaprocki@hotmail.com'
);

SELECT * FROM customer_info

/* 
Task 3: Use an UPDATE to modify any portion of the data
*/
UPDATE customer_info
SET address = '90991 Thorburn Ave', city = 'New York', postal_code = '10011'
WHERE customer_name = 'Josephine Darakjy';

UPDATE customer_info
SET email = 'jamesbutt@gmail.com'
WHERE customer_name = 'James Butt';

SELECT * FROM customer_info

/* 
Task 4: Finally, write a statement to delete one row of data.
*/
DELETE FROM customer_info 
WHERE customer_name = 'Lenna Paprocki';

SELECT * FROM customer_info

