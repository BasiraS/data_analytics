/* 
Name: Basira Shirzad
Date: 01-22-2021
*/

/* 
Task 1: Create a database “hospital_db”
*/

/* 
Task 2: Exercise-01
- Create tables for Physician, Department
- Insert values into them
- Understand Primary and Foreign Keys and table relationships
*/

-- Physician Table
DROP TABLE IF EXISTS physician;
CREATE TABLE physician (
	employee_id INTEGER NOT NULL,
	name VARCHAR(30) NOT NULL,
	position VARCHAR(30) NOT NULL,
	ssn INTEGER NOT NULL,
	CONSTRAINT pk_physician PRIMARY KEY(employee_id)
);

-- Physician Data
INSERT INTO physician VALUES(1, 'John Dorian', 'Staff Internist', 111111111);
INSERT INTO physician VALUES(2, 'Elliot Reid', 'Attending Physician', 222222222);
INSERT INTO physician VALUES(3, 'Christopher Turk', 'Surgical Attending Physician', 333333333);
INSERT INTO physician VALUES(4, 'Percival Cox', 'Senior Attending Physician', 444444444);
INSERT INTO physician VALUES(5, 'Bob Kelso', 'Head Chief of Medicine', 555555555);
INSERT INTO physician VALUES(6, 'Todd Quinlan', 'Surgical Attending Physician', 666666666);
INSERT INTO physician VALUES(7, 'John Wen', 'Surgical Attending Physician', 777777777);
INSERT INTO physician VALUES(8, 'Keith Dudemeister', 'MD Resident', 888888888);
INSERT INTO physician VALUES(9, 'Molly Clock', 'Attending Psychiatrist', 999999999);

SELECT * FROM physician;

-- Department Table 
DROP TABLE IF EXISTS department;
CREATE TABLE department (
	department_id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    head INTEGER NOT NULL,
	CONSTRAINT pk_department PRIMARY KEY(department_id),
	CONSTRAINT fk_department_physician_employee_id FOREIGN KEY(head) REFERENCES physician(employee_id)
);

-- Department Data
INSERT INTO department VALUES(1, 'General Medicine', 4);
INSERT INTO department VALUES(2, 'Surgery', 7);
INSERT INTO department VALUES(3, 'Psychiatry', 9);

SELECT * FROM department;

/* 
Task 3: Exercise-02
- Create tables for Affiliated_With, Procedures, Trained_In, Patient
- Insert values into them
*/

-- Affiliated_With Table
DROP TABLE IF EXISTS affiliated_with;
CREATE TABLE affiliated_with (
	physician INTEGER NOT NULL,
	department INTEGER NOT NULL,
	primary_affiliation BOOLEAN NOT NULL,
	CONSTRAINT fk_affiliated_with_physician_employee_id FOREIGN KEY(physician) REFERENCES physician(employee_id),
	CONSTRAINT fk_affiliated_with_department_department_id FOREIGN KEY(department) REFERENCES department(department_id),
	PRIMARY KEY(physician, department)
);

-- Affiliated_With Data
INSERT INTO affiliated_with VALUES(1, 1, TRUE);
INSERT INTO affiliated_with VALUES(2, 1, TRUE);
INSERT INTO affiliated_with VALUES(3, 1, FALSE);
INSERT INTO affiliated_with VALUES(3, 2, TRUE);
INSERT INTO affiliated_with VALUES(4, 1, TRUE);
INSERT INTO affiliated_with VALUES(5, 1, TRUE);
INSERT INTO affiliated_with VALUES(6, 2, TRUE);
INSERT INTO affiliated_with VALUES(7, 1, FALSE);
INSERT INTO affiliated_with VALUES(7, 2, TRUE);
INSERT INTO affiliated_with VALUES(8, 1, TRUE);
INSERT INTO affiliated_with VALUES(9, 3, TRUE);

SELECT * FROM affiliated_with;

-- Procedures Table
DROP TABLE IF EXISTS procedures;
CREATE TABLE procedures (
	code INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	cost REAL NOT NULL
);

-- Procedures Data
INSERT INTO procedures VALUES(1, 'Reverse Rhinopodoplasty', 1500.0);
INSERT INTO procedures VALUES(2, 'Obtuse Pyloric Recombobulation', 3750.0);
INSERT INTO procedures VALUES(3, 'Folded Demiophtalmectomy', 4500.0);
INSERT INTO procedures VALUES(4, 'Complete Walletectomy', 10000.0);
INSERT INTO procedures VALUES(5, 'Obfuscated Dermogastrotomy', 4899.0);
INSERT INTO procedures VALUES(6, 'Reversible Pancreomyoplasty', 5600.0);
INSERT INTO procedures VALUES(7, 'Follicular Demiectomy', 25.0);

SELECT * FROM procedures;

-- Trained_In Table
DROP TABLE IF EXISTS trained_in;
CREATE TABLE trained_in (
	physician INTEGER NOT NULL,
	treatment INTEGER NOT NULL,
	certification_date DATE NOT NULL,
	certification_expires DATE NOT NULL,
	CONSTRAINT fk_trained_in_physician_employee_id FOREIGN KEY(physician) REFERENCES physician(employee_id),
	CONSTRAINT fk_trained_in_procedures_code FOREIGN KEY(treatment) REFERENCES procedures(code),
	PRIMARY KEY(physician, treatment)
);

-- Trained_In Data
INSERT INTO trained_in VALUES(3, 1, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(3, 2, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(3, 5, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(3, 6, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(3, 7, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(6, 2, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(6, 5, '2007-01-01', '2007-12-31');
INSERT INTO trained_in VALUES(6, 6, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(7, 1, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(7, 2, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(7, 3, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(7, 4, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(7, 5, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(7, 6, '2008-01-01', '2008-12-31');
INSERT INTO trained_in VALUES(7, 7, '2008-01-01', '2008-12-31');

SELECT * FROM trained_in;

-- Patient Table
DROP TABLE IF EXISTS patient;
CREATE TABLE patient (
	ssn INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	address VARCHAR(30) NOT NULL,
	phone VARCHAR(30) NOT NULL,
	insurance_id INTEGER NOT NULL,
	pcp INTEGER NOT NULL,
	CONSTRAINT fk_patient_physician_employee_id FOREIGN KEY(pcp) REFERENCES physician(employee_id)
);

-- Patient Data
INSERT INTO patient VALUES(100000001, 'John Smith', '42 Foobar Lane', '555-0256', 68476213, 1);
INSERT INTO patient VALUES(100000002, 'Grace Ritchie', '37 Snafu Drive', '555-0512', 36546321, 2);
INSERT INTO patient VALUES(100000003, 'Random J. Patient', '101 Omgbbq Street', '555-1204', 65465421, 2);
INSERT INTO patient VALUES(100000004, 'Dennis Doe', '1100 Foobaz Avenue', '555-2048', 68421879, 3);

SELECT * FROM patient;

/* 
Task 4: Exercise-03
- Create tables for Nurse, Appointment, Medication
- Insert values into them
*/

-- Nurse Table
DROP TABLE IF EXISTS nurse;
CREATE TABLE nurse (
	employee_id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	position VARCHAR(30) NOT NULL,
	registered BOOLEAN NOT NULL,
	ssn INTEGER NOT NULL
);

-- Nurse Data
INSERT INTO nurse VALUES(101, 'Carla Espinosa', 'Head Nurse', TRUE, 111111110);
INSERT INTO nurse VALUES(102, 'Laverne Roberts', 'Nurse', TRUE, 222222220);
INSERT INTO nurse VALUES(103, 'Paul Flowers', 'Nurse', FALSE, 333333330);

SELECT * FROM nurse;

-- Appointment Table
DROP TABLE IF EXISTS appointment;
CREATE TABLE appointment (
	appointment_id INTEGER PRIMARY KEY NOT NULL,
	patient INTEGER NOT NULL,
	prep_nurse INTEGER,
	physician INTEGER NOT NULL,
	start_date TIMESTAMP NOT NULL,
	end_date TIMESTAMP NOT NULL,
	examination_room TEXT NOT NULL,
	CONSTRAINT fk_appointment_patient_ssn FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_appointment_nurse_employee_id FOREIGN KEY(prep_nurse) REFERENCES nurse(employee_id),
	CONSTRAINT fk_appointment_physician_employee_id FOREIGN KEY(physician) REFERENCES physician(employee_id)
);

-- Appointment Data
INSERT INTO appointment VALUES(13216584, 100000001, 101, 1, '2008-04-24 10:00', '2008-04-24 11:00', 'A');
INSERT INTO appointment VALUES(26548913, 100000002, 101, 2, '2008-04-24 10:00', '2008-04-24 11:00', 'B');
INSERT INTO appointment VALUES(36549879, 100000001, 102, 1, '2008-04-25 10:00', '2008-04-25 11:00', 'A');
INSERT INTO appointment VALUES(46846589, 100000004, 103, 4, '2008-04-25 10:00', '2008-04-25 11:00', 'B');
INSERT INTO appointment VALUES(59871321, 100000004, NULL, 4, '2008-04-26 10:00', '2008-04-26 11:00', 'C');
INSERT INTO appointment VALUES(69879231, 100000003, 103, 2, '2008-04-26 11:00', '2008-04-26 12:00', 'C');
INSERT INTO appointment VALUES(76983231, 100000001, NULL, 3, '2008-04-26 12:00', '2008-04-26 13:00', 'C');
INSERT INTO appointment VALUES(86213939, 100000004, 102, 9, '2008-04-27 10:00', '2008-04-21 11:00', 'A');
INSERT INTO appointment VALUES(93216548, 100000002, 101, 2, '2008-04-27 10:00', '2008-04-27 11:00', 'B');

SELECT * FROM appointment;

-- Medication Table
DROP TABLE IF EXISTS medication;
CREATE TABLE medication (
	code INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	brand VARCHAR(30) NOT NULL,
	description VARCHAR(30) NOT NULL
);

-- Medication Data
INSERT INTO medication VALUES(1, 'Procrastin-X', 'X', 'N/A');
INSERT INTO medication VALUES(2, 'Thesisin', 'Foo Labs', 'N/A');
INSERT INTO medication VALUES(3, 'Awakin', 'Bar Laboratories', 'N/A');
INSERT INTO medication VALUES(4, 'Crescavitin', 'Baz Industries', 'N/A');
INSERT INTO medication VALUES(5, 'Melioraurin', 'Snafu Pharmaceuticals', 'N/A');

SELECT * FROM medication;

/* 
Task 5: Exercise-04
- Create tables for Prescribes, Block, Room, On_Call, Stay, Undergoes
- Insert values into them
*/

-- Prescribes Table
DROP TABLE IF EXISTS prescribes;
CREATE TABLE prescribes (
	physician INTEGER NOT NULL,
	patient INTEGER NOT NULL,
	medication INTEGER NOT NULL,
	date TIMESTAMP NOT NULL,
	appointment INTEGER,
	dose VARCHAR(30) NOT NULL,
	PRIMARY KEY(physician, patient, medication, date),
	CONSTRAINT fk_prescribes_physician_employee_id FOREIGN KEY(physician) REFERENCES physician(employee_id),
	CONSTRAINT fk_prescribes_patient_ssn FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_prescribes_medication_code FOREIGN KEY(medication) REFERENCES medication(code),
	CONSTRAINT fk_prescribes_appointment_appointment_id FOREIGN KEY(appointment) REFERENCES appointment(appointment_id)
);

-- Prescribes Data
INSERT INTO prescribes VALUES(1, 100000001,1, '2008-04-24 10:47', 13216584, '5');
INSERT INTO prescribes VALUES(9, 100000004,2, '2008-04-27 10:53', 86213939, '10');
INSERT INTO prescribes VALUES(9, 100000004,2, '2008-04-30 16:53', NULL, '5');

SELECT * FROM prescribes;

-- Block Table
DROP TABLE IF EXISTS block;
CREATE TABLE block (
	block_floor INTEGER NOT NULL,
	block_code INTEGER NOT NULL,
	PRIMARY KEY(block_floor, block_code)
); 

-- Block Data
INSERT INTO block VALUES(1, 1);
INSERT INTO block VALUES(1, 2);
INSERT INTO block VALUES(1, 3);
INSERT INTO block VALUES(2, 1);
INSERT INTO block VALUES(2, 2);
INSERT INTO block VALUES(2, 3);
INSERT INTO block VALUES(3, 1);
INSERT INTO block VALUES(3, 2);
INSERT INTO block VALUES(3, 3);
INSERT INTO block VALUES(4, 1);
INSERT INTO block VALUES(4, 2);
INSERT INTO block VALUES(4, 3);

SELECT * FROM block;

-- Room Table
DROP TABLE IF EXISTS room;
CREATE TABLE room (
	room_number INTEGER PRIMARY KEY NOT NULL,
	room_type VARCHAR(30) NOT NULL,
	block_floor INTEGER NOT NULL,
	block_code INTEGER NOT NULL,
	unavailable BOOLEAN NOT NULL,
	CONSTRAINT fk_room_block_pk FOREIGN KEY(block_floor, block_code) REFERENCES block(block_floor, block_code)
);

-- Room Data
INSERT INTO room VALUES(101, 'Single', 1, 1, FALSE);
INSERT INTO room VALUES(102, 'Single', 1, 1, FALSE);
INSERT INTO room VALUES(103, 'Single', 1, 1, FALSE);
INSERT INTO room VALUES(111, 'Single', 1, 2, FALSE);
INSERT INTO room VALUES(112, 'Single', 1, 2, TRUE);
INSERT INTO room VALUES(113, 'Single', 1, 2, FALSE);
INSERT INTO room VALUES(121, 'Single', 1, 3, FALSE);
INSERT INTO room VALUES(122, 'Single', 1, 3, FALSE);
INSERT INTO room VALUES(123, 'Single', 1, 3, FALSE);
INSERT INTO room VALUES(201, 'Single', 2, 1, TRUE);
INSERT INTO room VALUES(202, 'Single', 2, 1, FALSE);
INSERT INTO room VALUES(203, 'Single', 2, 1, FALSE);
INSERT INTO room VALUES(211, 'Single', 2, 2, FALSE);
INSERT INTO room VALUES(212, 'Single', 2, 2, FALSE);
INSERT INTO room VALUES(213, 'Single', 2, 2, TRUE);
INSERT INTO room VALUES(221, 'Single', 2, 3, FALSE);
INSERT INTO room VALUES(222, 'Single', 2, 3, FALSE);
INSERT INTO room VALUES(223, 'Single', 2, 3, FALSE);
INSERT INTO room VALUES(301, 'Single', 3, 1, FALSE);
INSERT INTO room VALUES(302, 'Single', 3, 1, TRUE);
INSERT INTO room VALUES(303, 'Single', 3, 1, FALSE);
INSERT INTO room VALUES(311, 'Single', 3, 2, FALSE);
INSERT INTO room VALUES(312, 'Single', 3, 2, FALSE);
INSERT INTO room VALUES(313, 'Single', 3, 2, FALSE);
INSERT INTO room VALUES(321, 'Single', 3, 3, TRUE);
INSERT INTO room VALUES(322, 'Single', 3, 3, FALSE);
INSERT INTO room VALUES(323, 'Single', 3, 3, FALSE);
INSERT INTO room VALUES(401, 'Single', 4, 1, FALSE);
INSERT INTO room VALUES(402, 'Single', 4, 1, TRUE);
INSERT INTO room VALUES(403, 'Single', 4, 1, FALSE);
INSERT INTO room VALUES(411, 'Single', 4, 2, FALSE);
INSERT INTO room VALUES(412, 'Single', 4, 2, FALSE);
INSERT INTO room VALUES(413, 'Single', 4, 2, FALSE);
INSERT INTO room VALUES(421, 'Single', 4, 3, TRUE);
INSERT INTO room VALUES(422, 'Single', 4, 3, FALSE);
INSERT INTO room VALUES(423, 'Single', 4, 3, FALSE);

SELECT * FROM room;

-- On_Call Table
DROP TABLE IF EXISTS on_call;
CREATE TABLE on_call (
	nurse INTEGER NOT NULL,
	block_floor INTEGER NOT NULL,
	block_code INTEGER NOT NULL,
	on_call_start_date TIMESTAMP NOT NULL,
	on_call_end_date TIMESTAMP NOT NULL,
	PRIMARY KEY(nurse, block_floor, block_code, on_call_start_date, on_call_end_date),
	CONSTRAINT fk_on_call_nurse_employee_id FOREIGN KEY(nurse) REFERENCES nurse(employee_id),
	CONSTRAINT fk_on_call_block_floor FOREIGN KEY(block_floor, block_code) REFERENCES block(block_floor, block_code) 
);

-- On_Call Data
INSERT INTO on_call VALUES(101, 1, 1, '2008-11-04 11:00', '2008-11-04 19:00');
INSERT INTO on_call VALUES(101, 1, 2, '2008-11-04 11:00', '2008-11-04 19:00');
INSERT INTO on_call VALUES(102, 1, 3, '2008-11-04 11:00', '2008-11-04 19:00');
INSERT INTO on_call VALUES(103, 1, 1, '2008-11-04 19:00', '2008-11-05 03:00');
INSERT INTO on_call VALUES(103, 1, 2, '2008-11-04 19:00', '2008-11-05 03:00');
INSERT INTO on_call VALUES(103, 1, 3, '2008-11-04 19:00', '2008-11-05 03:00');

SELECT * FROM on_call;

-- Stay Table
DROP TABLE IF EXISTS stay;
CREATE TABLE stay (
	stay_id INTEGER PRIMARY KEY NOT NULL,
	patient INTEGER NOT NULL,
	room INTEGER NOT NULL,
	stay_start_date DATE NOT NULL,
	stay_end_date DATE NOT NULL,
	CONSTRAINT fk_stay_patient_ssn FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_stay_room_number FOREIGN KEY(room) REFERENCES room(room_number)
);

-- Stay Data
INSERT INTO stay VALUES(3215, 100000001, 111, '2008-05-01', '2008-05-04');
INSERT INTO stay VALUES(3216, 100000003, 123, '2008-05-03', '2008-05-14');
INSERT INTO stay VALUES(3217, 100000004, 112, '2008-05-02', '2008-05-03');

SELECT * FROM stay;

-- Undergoes Table
DROP TABLE IF EXISTS undergoes;
CREATE TABLE undergoes (
	patient INTEGER NOT NULL,
	procedures INTEGER NOT NULL,
	stay INTEGER NOT NULL,
	date_undergoes DATE NOT NULL,
	physician INTEGER NOT NULL,
	assisting_nurse INTEGER,
	PRIMARY KEY(patient, procedures, stay, date_undergoes),
	CONSTRAINT fk_undergoes_patient_ssn FOREIGN KEY(patient) REFERENCES patient(ssn),
	CONSTRAINT fk_undergoes_procedures_code FOREIGN KEY(procedures) REFERENCES Procedures(code),
	CONSTRAINT fk_undergoes_stay_stay_id FOREIGN KEY(stay) REFERENCES stay(stay_id),
	CONSTRAINT fk_undergoes_physician_employee_id FOREIGN KEY(physician) REFERENCES physician(employee_id),
	CONSTRAINT fk_undergoes_nurse_employee_id FOREIGN KEY(assisting_nurse) REFERENCES nurse(employee_id)
);

-- Undergoes Data
INSERT INTO undergoes VALUES(100000001, 6,3215, '2008-05-02', 3, 101);
INSERT INTO undergoes VALUES(100000001, 2,3215, '2008-05-03', 7, 101);
INSERT INTO undergoes VALUES(100000004, 1,3217, '2008-05-07', 3, 102);
INSERT INTO undergoes VALUES(100000004, 5,3217, '2008-05-09', 6, NULL);
INSERT INTO undergoes VALUES(100000001, 7,3217, '2008-05-10', 7, 101);
INSERT INTO undergoes VALUES(100000004, 4,3217, '2008-05-13', 3, 103);

SELECT * FROM undergoes;

/* 
Task 5: Putting them together
- Create a new database hospital_database
- Create scripts from one file 
- Insert data into hospital_database from one data file
*/

/*
Task 6: Putting backup and restore:
- Take the back up of hospital_database
- Restore it as a new database hospital_database_new
*/

/*
Task 7: SQL Exercise
*/

SELECT * FROM department;
SELECT * FROM physician;
SELECT * FROM affiliated_with;
SELECT * FROM patient;
SELECT * FROM nurse;
SELECT * FROM appointment;

-- Find general medicine doctors name
SELECT 
	A.name, 
	B.department, 
	C.name 
FROM physician A
JOIN affiliated_with B 
JOIN department C
ON C.department_id= B.department
ON B.physician = A.employee_id
WHERE B.department = 2;

-- Find which patient - doctor visit
SELECT 
	A.name AS patient_name, 
	B.name AS doctor_name 
FROM patient A
JOIN physician B
ON A.pcp = B.employee_id;

-- Find room details 
SELECT * FROM room;

SELECT 
	unavailable, 
	COUNT(*) 
FROM room
GROUP BY unavailable;

-- Total patient count on blockcode = 2
SELECT count(*) 
FROM room 
WHERE block_code = 2;

-- Check procedure details
SELECT * FROM undergoes;

-- Find hospital workload such as procedure time and doctors, nurse details
SELECT 
	A.name AS doctor_name, 
	B.name AS nurse_name, 
	C.date_undergoes AS proceduretime
FROM physician A
JOIN nurse B
JOIN undergoes C
ON B.employee_id= C.assisting_nurse
ON A.employee_id = C.physician
WHERE C.physician = 3;

-- Patient mdeication and priscription details
SELECT * FROM medication;

SELECT
	A.name, 
	B.dose, 
	C.name,
	C.brand 
FROM patient A
JOIN prescribes B
JOIN medication C
ON C.code = B.medication
ON A.ssn = B.patient

-- Trained in procedures 
SELECT * FROM procedures;

SELECT * FROM trained_in;

SELECT 
	treatment, 
	count(*) 
FROM trained_in 
GROUP BY treatment;
