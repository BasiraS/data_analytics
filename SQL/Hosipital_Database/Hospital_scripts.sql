/*
Name: Basira Shirzad
Date: 01-22-2021
*/

-- Tables for Hospital Database

-- Physician Table
DROP TABLE IF EXISTS physician;
CREATE TABLE physician (
	employee_id INTEGER NOT NULL,
	name VARCHAR(30) NOT NULL,
	position VARCHAR(30) NOT NULL,
	ssn INTEGER NOT NULL,
	CONSTRAINT pk_physician PRIMARY KEY(employee_id)
);

-- Department Table 
DROP TABLE IF EXISTS department;
CREATE TABLE department (
	department_id INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    head INTEGER NOT NULL,
	CONSTRAINT pk_department PRIMARY KEY(department_id),
	CONSTRAINT fk_department_physician_employee_id FOREIGN KEY(head) REFERENCES physician(employee_id)
);

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

-- Procedures Table
DROP TABLE IF EXISTS procedures;
CREATE TABLE procedures (
	code INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	cost REAL NOT NULL
);

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

-- Nurse Table
DROP TABLE IF EXISTS nurse;
CREATE TABLE nurse (
	employee_id INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	position VARCHAR(30) NOT NULL,
	registered BOOLEAN NOT NULL,
	ssn INTEGER NOT NULL
);

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

-- Medication Table
DROP TABLE IF EXISTS medication;
CREATE TABLE medication (
	code INTEGER PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL,
	brand VARCHAR(30) NOT NULL,
	description VARCHAR(30) NOT NULL
);

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

-- Block Table
DROP TABLE IF EXISTS block;
CREATE TABLE block (
	block_floor INTEGER NOT NULL,
	block_code INTEGER NOT NULL,
	PRIMARY KEY(block_floor, block_code)
); 

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