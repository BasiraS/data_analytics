/*
Name: Basira Shirzad
Date: 01-22-2021
*/

/* 
Task 1: Videos table. Create one table to keep track of the videos. This table should include a unique ID,
the title of the video, the length in minutes, and the URL. Populate the table with at least three
related videos from YouTube or other publicly available resources
*/

-- Video Table
DROP TABLE IF EXISTS videos;
CREATE TABLE videos (
      video_id INTEGER PRIMARY KEY NOT NULL,
      title VARCHAR(50) NOT NULL,
      length INTEGER NULL,
      url VARCHAR(100) NOT NULL
);

-- Video Data
INSERT INTO videos(video_id, title, length, url) VALUES(1, 'Vertigo', 128, 'https://www.youtube.com/watch?v=WrOKBmsOw7I');
INSERT INTO videos(video_id, title, length, url) VALUES(2, 'The Innocents', 100, 'https://www.youtube.com/watch?v=lIuEEP_4d0E');
INSERT INTO videos(video_id, title, length, url) VALUES(3, 'Amadeus', 160, 'https://www.youtube.com/watch?v=tgZhaFFNVc4');
INSERT INTO videos(video_id, title, length, url) VALUES(4, 'Titanic', 194, 'https://www.youtube.com/watch?v=kRC4e3pEIpI');
INSERT INTO videos(video_id, title, length, url) VALUES(5, 'Good Will Hunting', 126, 'https://www.youtube.com/watch?v=hIdsjNGCGz4');

SELECT * FROM videos;

/*
Task 2: Create and populate Reviewers table. Create a second table that provides at least two user
reviews for each of at least two of the videos. These should be imaginary reviews that include
columns for the user’s name (“Asher”, “John”, etc.), the rating (which could be NULL, or a
number between 0 and 5), and a short text review (“Loved it!”). There should be a column that
links back to the ID column in the table of videos.
*/

-- Reviewers Table
DROP TABLE IF EXISTS reviewers;
CREATE TABLE reviewers (
	user_name VARCHAR(50) NOT NULL,
	rating INTEGER NULL,
	review_description VARCHAR(10),
	video_id INTEGER NOT NULL,
	CONSTRAINT fk_reviewers_videos_video_id FOREIGN KEY(video_id) REFERENCES videos(video_id)
);

-- Reviewers Data
INSERT INTO reviewers(user_name, rating, review_description, video_id) VALUES('Cyd', 5, 'Loved it!', 3);
INSERT INTO reviewers(user_name, rating, review_description, video_id) VALUES('Bob', 5, 'Loved it!', 5);

SELECT * FROM reviewers

/*
Task 3: Report on Video Reviews. Write a JOIN statement that shows information from both tables.
*/

/* Inner Join - match from both tables */
SELECT *
FROM videos AS V 
INNER JOIN reviewers AS R
ON V.video_id = R.video_id

/* Left Join - all records from videos table and matched records from reviewers table */
SELECT *
FROM videos AS V 
LEFT JOIN reviewers AS R
ON V.video_id = R.video_id

/* Right Join - all records from reviewers table and matched records from videos table */
SELECT *
FROM videos AS V 
RIGHT JOIN reviewers AS R
ON V.video_id = R.video_id

/* Full Join - match in either left or right table */
SELECT *
FROM videos AS V 
FULL OUTER JOIN reviewers AS R
ON V.video_id = R.video_id
