/*
Name: Basira Shirzad
Date: 01-25-2021
*/

/* 
Task 1: Create Insurance tables
- Please follow the sample tables to create a table with appropriate columns and data types.
- Identify primary and foreign keys in each table and establish relationship between them
- Bonus -  ER diagram in power point
*/

-- Claim Table
DROP TABLE IF EXISTS claim;
CREATE TABLE claim (
	claim_id VARCHAR(15) PRIMARY KEY NOT NULL,
	claim_receipt_date DATE NOT NULL,
	claim_description VARCHAR(50) NOT NULL,
	claimant_birth_date DATE NOT NULL,
	law_suit_indicator BOOLEAN NOT NULL,
	claimant_first_name VARCHAR(30) NOT NULL,
	claimant_last_name VARCHAR(30) NOT NULL,
	policy_number VARCHAR(15) NOT NULL,
	claimant_occupation VARCHAR(30) NOT NULL,
	loss_date DATE NOT NULL, 
	claim_amount REAL NOT NULL,
	claim_paid_amount REAL,
	claim_paid_date DATE
);

-- Customer Table
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
	customer_id INTEGER PRIMARY KEY NOT NULL,
	customer_first_name VARCHAR(30) NOT NULL,
	customer_last_name VARCHAR(30) NOT NULL,
	customer_type VARCHAR(50) NOT NULL,
	business_name VARCHAR(50) NULL,
	address_street_name_line_one VARCHAR(255) NOT NULL,
	address_street_name_line_two VARCHAR(50) NULL,
	address_city VARCHAR(50) NOT NULL,
	address_state VARCHAR(50) NOT NULL,
	address_postal_code VARCHAR(10) NOT NULL,
	address_type VARCHAR(30) NOT NULL,
	customer_birth_date DATE NULL,
	risk_score INTEGER NOT NULL
);

-- Policy Detail Table
DROP TABLE IF EXISTS policy_detail;
CREATE TABLE policy_detail (
	customer_id INTEGER NOT NULL,
	policy_number VARCHAR(15) NOT NULL,
	policy_effective_date DATE NOT NULL,
	policy_expiration_date DATE NOT NULL,
	policy_limit REAL NOT NULL,
	policy_type VARCHAR(50) NOT NULL,
	currency_type VARCHAR(5) NOT NULL,
	premium_cost REAL NOT NULL,
	CONSTRAINT fk_policy_detail_customer_customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

-- Reserves Detail Table
DROP TABLE IF EXISTS reserves;
CREATE TABLE reserves (
	customer_id INTEGER NOT NULL,
	policy_number VARCHAR(15) NOT NULL,
	reserved_amount REAL NOT NULL,
	reserved_date DATE NOT NULL,
	CONSTRAINT fk_reserves_customer_customer_id FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

/*
Task 2: Populate Insurance tables with sample data which you created in above step
- Insert script for each table
- Populate each table with sample data (provided)
- Feel free to add more sample data wherever applicable
*/

-- Claim Data
INSERT INTO claim VALUES('C123450000', '12/5/20', 'Automobile accident', '8/1/75', FALSE, 'Joe', 'Smith', 'P987654321', 'Physician', '12/4/20', 5000.00, NULL, NULL);
INSERT INTO claim VALUES('C123441000', '8/5/19', 'Automobile accident', '8/1/75', FALSE, 'Joe', 'Smith', 'P987654321', 'Physician', '8/2/19', 7600.00, 7100.00, '9/5/19');
INSERT INTO claim VALUES('C123440000', '10/15/20', 'Robbery', '3/20/86', FALSE, 'Mary', 'Roberts', 'P987654111', 'Not provided', '10/1/20', 25000.00, 20000.00, '11/5/20');
INSERT INTO claim VALUES('C345478900', '7/13/20', 'Property', '5/27/90', FALSE, 'Aditya', 'Reddy', 'P987654222', 'Business Owner', '7/12/20', 10000.00, 8000.00, '8/12/20');

SELECT * FROM claim;

-- Customer Data
INSERT INTO customer VALUES(777543325, 'Mary', 'Roberts', 'Individual', NULL, '123 Main Street', NULL, 'Chicago', 'Illinois', '60007', 'Residential', '3/20/86', 75);
INSERT INTO customer VALUES(777543800, 'Joe', 'Smith', 'Individual', NULL, '123 Park Avenue', NULL, 'New York', 'New York', '10017', 'Residential', '2/27/63', 70);
INSERT INTO customer VALUES(776983401, 'Aditya', 'Reddy', 'Business', 'ABC Systems', '222 Hyde Street', 'Floor 2', 'San Francisco', 'California', '94123', 'Business', NULL, 50);

SELECT * FROM customer;

-- Policy Detail Data
INSERT INTO policy_detail VALUES(777543800, 'P987654321', '2/11/20', '2/11/21', 500000.00, 'Automobile', 'USD', 2600.00);
INSERT INTO policy_detail VALUES(777543800, 'P987654321', '2/11/19', '2/11/20', 500000.00, 'Automobile', 'USD', 2300.00);
INSERT INTO policy_detail VALUES(777543800, 'P987654321', '2/11/18', '2/11/19', 500000.00, 'Automobile', 'USD', 2150.00);
INSERT INTO policy_detail VALUES(777543800, 'P987654321', '2/11/17', '2/11/18', 500000.00, 'Automobile', 'USD', 2100.00);
INSERT INTO policy_detail VALUES(777543325, 'P987654111', '3/15/20', '3/15/21', 5000000.00, 'Excess/Umbrella', 'USD', 5500.00);
INSERT INTO policy_detail VALUES(776983401, 'P987654222', '6/15/20', '6/15/20', 3000000.00, 'Property', 'USD', 10000.00);

SELECT * FROM policy_detail;

-- Reserves Data
INSERT INTO reserves VALUES(777543325, 'P987654111', 5000.00, '3/15/20');
INSERT INTO reserves VALUES(776983401, 'P987654222', 7000.00, '6/15/20');
INSERT INTO reserves VALUES(777543800, 'P987654321', 1500.00, '2/11/17');
INSERT INTO reserves VALUES(777543800, 'P987654321', 1500.00, '2/11/18');
INSERT INTO reserves VALUES(777543800, 'P987654321', 1500.00, '2/11/19');

SELECT * FROM reserves;

/*
Task 3: Form any 5 SQL to extract information from tables
- Use Join, Where, and Other conditional operators
*/

/* 
Question 1: List of customers in New York City
*/
SELECT customer_id, customer_first_name, customer_last_name
FROM customer
WHERE address_city = 'New York';

/* 
Question 2: List of unique claimant occupation 
*/
SELECT DISTINCT claimant_occupation 
FROM claim

/* 
Question 3: Which customer has the most claims logged?
*/
SELECT claimant_first_name, claimant_last_name, COUNT(claim_id) AS num_of_claims
FROM claim
GROUP BY (claimant_first_name, claimant_last_name)
ORDER BY num_of_claims DESC;

/* 
Question 4: Policy Detail for Robery Claim
*/
SELECT 
	P.customer_id,
	C.claimant_first_name,
	C.claimant_last_name,
	P.policy_number,
	P.policy_effective_date,
	P.policy_expiration_date,
	P.policy_limit, 
	P.policy_type,
	P.currency_type, 
	P.premium_cost
FROM policy_detail AS P
INNER JOIN claim AS C
ON P.policy_number = C.policy_number
WHERE claim_description LIKE '%Robbery%';

/* 
Question 5: Reserved Amount for Robbery Claim
*/
SELECT 
	C.claimant_first_name,
	C.claimant_last_name,
	R.policy_number,
	R.reserved_amount,
	R.reserved_date
FROM reserves AS R
INNER JOIN claim AS C
ON R.policy_number = C.policy_number
WHERE claim_description LIKE '%Robbery%';
