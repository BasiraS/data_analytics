/* 
Name: Basira Shirzad
Date: 01-21-2021
*/

/* Creating table student and storing Student_data.csv data*/
DROP TABLE IF EXISTS student;
CREATE TABLE student
(
    id SERIAL PRIMARY KEY,
    first_name CHARACTER VARYING,
    last_name CHARACTER VARYING,
    email CHARACTER VARYING,
    gender CHARACTER VARYING,
    work_phone CHARACTER VARYING,
    book_preference_hardcopy BOOLEAN 
);

COPY student (
	first_name,
	last_name,
	email,
	gender,
	work_phone,
	book_preference_hardcopy
)
FROM '/Users/basirashirzad/Downloads/Student_data.csv'
DELIMITER ',' CSV HEADER

/* Creating table student_marks and storing student_marks.csv data*/
DROP TABLE IF EXISTS student_marks;
CREATE TABLE student_marks
(
    id SERIAL PRIMARY KEY,
    student_reg_id INTEGER,
    student_id INTEGER,
	unit2 INTEGER,
	unit3 INTEGER,
	unit4 INTEGER,
	unit5 INTEGER    
);

COPY student_marks(
	student_reg_id,
	student_id,
	unit2,
	unit3,
	unit4,
	unit5
)
FROM '/Users/basirashirzad/Downloads/student_marks.csv'
DELIMITER ',' CSV HEADER

-- Sample questions:

/* 
Sample 1: Students with the highest marks in Unit 4 
*/
SELECT first_name, last_name, unit4
FROM student_marks
INNER JOIN student on student_marks.id = student.id
ORDER BY unit4 DESC
LIMIT 43	-- 43 students scored a 100

-- or 

SELECT first_name, last_name, unit4
FROM student_marks
INNER JOIN student on student_marks.id = student.id
WHERE unit4 = 100

/* 
Sample 2: Students scored between 89 and 100 unit4
*/
SELECT first_name, last_name, unit4
FROM student_marks
INNER JOIN student on student_marks.id = student.id
WHERE unit4 >= 89 AND unit4 <= 100

-- Open ended questions:
-- Take a closer look at the tables that you created and come up with 10 different scenarios/ questions and form SQL

/* 
Question 1: How many Female and Male students are there?
*/
SELECT COUNT(gender)
FROM student
WHERE gender='Female';
-- Answer: 475 female students

SELECT COUNT(gender)
FROM student
WHERE gender='Male';
-- Answer: 525 female students

/* 
Question 2: How many students preferred a hardcopy book?
*/
SELECT COUNT(book_preference_hardcopy)
FROM student
WHERE book_preference_hardcopy=True;
-- Answer: 513 students prefered a hardcopy book

SELECT COUNT(book_preference_hardcopy)
FROM student
WHERE book_preference_hardcopy=False;
-- Answer: 487 students did not prefer a hardcopy book

/* 
Question 3: What was the lowest score in each unit test?
*/
SELECT 
	MIN(unit2), 
	MIN(unit3),
	MIN(unit4),
	MIN(unit5)
FROM student_marks
-- Answer: 
-- Unit 2 Lowest Score: 85
-- Unit 3 Lowest Score: 90
-- Unit 4 Lowest Score: 82
-- Unit 5 Lowest Score: 88

/* 
Question 4: What was the highest score in each unit test?
*/
SELECT 
	MAX(unit2), 
	MAX(unit3),
	MAX(unit4),
	MAX(unit5)
FROM student_marks
-- Answer: 
-- Unit 2 Highest Score: 100
-- Unit 3 Highest Score: 100
-- Unit 4 Highest Score: 100
-- Unit 5 Highest Score: 100

/* 
Question 5: What is the class average of each unit test?
*/
SELECT 
	ROUND(AVG(unit2), 2) AS Unit2_class_avg,
	ROUND(AVG(unit3), 2) AS Unit3_class_avg,
	ROUND(AVG(unit4), 2) AS Unit4_class_avg,
	ROUND(AVG(unit5), 2) AS Unit5_class_avg
FROM student_marks
-- Answer: 
-- Unit 2 Average: 92.85
-- Unit 3: Average: 95.22
-- Unit 4: Average: 90.82
-- Unit 5: Average: 94.06

/* 
Question 6: Which gender performed better in each unit?
*/
SELECT 
	ROUND(AVG(unit2), 2) AS Unit2_class_avg,
	ROUND(AVG(unit3), 2) AS Unit3_class_avg,
	ROUND(AVG(unit4), 2) AS Unit4_class_avg,
	ROUND(AVG(unit5), 2) AS Unit5_class_avg
FROM student_marks
INNER JOIN student on student_marks.id = student.id
WHERE gender = 'Male'
-- Answer: 
-- Unit 2 Average for Male Students: 92.96
-- Unit 3 Average for Male Students: 95.17
-- Unit 4 Average for Male Students: 90.84
-- Unit 5 Average for Male Students: 93.91

SELECT 
	ROUND(AVG(unit2), 2) AS Unit2_class_avg,
	ROUND(AVG(unit3), 2) AS Unit3_class_avg,
	ROUND(AVG(unit4), 2) AS Unit4_class_avg,
	ROUND(AVG(unit5), 2) AS Unit5_class_avg
FROM student_marks
INNER JOIN student on student_marks.id = student.id
WHERE gender = 'Female'
-- Answer: 
-- Unit 2 Average for Male Students: 92.72
-- Unit 3 Average for Male Students: 95.28
-- Unit 4 Average for Male Students: 90.80
-- Unit 5 Average for Male Students: 94.17

/* 
Question 7: Did hardcopy book preference perform better than those who don't?
*/
SELECT 
	ROUND(AVG(unit2), 2) AS Unit2_class_avg,
	ROUND(AVG(unit3), 2) AS Unit3_class_avg,
	ROUND(AVG(unit4), 2) AS Unit4_class_avg,
	ROUND(AVG(unit5), 2) AS Unit5_class_avg
FROM student_marks
INNER JOIN student on student_marks.id = student.id
WHERE book_preference_hardcopy = True;
-- Answer: 
-- Unit 2 Average for Hardcopy Book Students: 92.89
-- Unit 3 Average for Hardcopy Book Students: 95.13
-- Unit 4 Average for Hardcopy Book Students: 90.74
-- Unit 5 Average for Hardcopy Book Students: 94.17

SELECT 
	ROUND(AVG(unit2), 2) AS Unit2_class_avg,
	ROUND(AVG(unit3), 2) AS Unit3_class_avg,
	ROUND(AVG(unit4), 2) AS Unit4_class_avg,
	ROUND(AVG(unit5), 2) AS Unit5_class_avg
FROM student_marks
INNER JOIN student on student_marks.id = student.id
WHERE book_preference_hardcopy = False;
-- Unit 2 Average for non-Hardcopy Book Students: 92.79
-- Unit 3 Average for non-Hardcopy Book Students: 95.31
-- Unit 4 Average for non-Hardcopy Book Students: 90.90
-- Unit 5 Average for non-Hardcopy Book Students: 93.95

/* 
Question 8: Number of students with lowest score on each unit?
*/
SELECT 
	COUNT(unit2) AS Unit2_Num_LowestScore
FROM student_marks
WHERE unit2 = 85;	
-- 59 students got the lowest score on Unit2 Test

SELECT 
	COUNT(unit3) AS Unit3_Num_LowestScore
FROM student_marks
WHERE unit3 = 90;	
-- 79 students got the lowest score on Unit3 Test

SELECT 
	COUNT(unit4) AS Unit4_Num_LowestScore
FROM student_marks
WHERE unit4 = 82;	
-- 51 students got the lowest score on Unit4 Test

SELECT 
	COUNT(unit5) AS Unit5_Num_LowestScore
FROM student_marks
WHERE unit5 = 88;	
-- 74 students got the lowest score on Unit5 Test

/* 
Question 9: Number of students who scored 100
*/
SELECT 
	COUNT(unit2) AS Unit2_Num_Score100
FROM student_marks
WHERE unit2 = 100;	
-- 63 students got a 100

SELECT 
	COUNT(unit3) AS Unit3_Num_Score100
FROM student_marks
WHERE unit3 = 100;	
-- 97 students got a 100

SELECT 
	COUNT(unit4) AS Unit4_Num_Score100
FROM student_marks
WHERE unit4 = 100;	
-- 43 students got a 100

SELECT 
	COUNT(unit5) AS Unit5_Num_Score100
FROM student_marks
WHERE unit5 = 100;	
-- 82 students got a 100

/* 
Question 10: Print unique area codes
*/
SELECT  
	DISTINCT LEFT(work_phone, 3) AS Area_Code
FROM student

/* 
Question 11: Print unique email domain 
*/
SELECT 	
	DISTINCT SUBSTRING (email, POSITION( '@' in email) + 1, LENGTH(email))
FROM student