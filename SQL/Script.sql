# CREATE table

CREATE TABLE student (
	student_id INT PRIMARY KEY,
	name VARCHAR(20),
	major VARCHAR(20)
);

CREATE TABLE student (
	student_id INT AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL,
	major VARCHAR(20) UNIQUE,
	PRIMARY KEY(student_id)
);

CREATE TABLE student (
	student_id INT,
	name VARCHAR(20),
	major VARCHAR(20) DEFAULT 'undecided',
	PRIMARY KEY(student_id)
);

DESCRIBE student; # get table properties

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3,2);

ALTER TABLE student DROP COLUMN gpa;

# INSERT data & Constraints

INSERT INTO student VALUES(1, 'Samil', 'EE');
INSERT INTO student(name, major) VALUES('Samil', 'EE'); # if AUTO_INCREMENT

INSERT INTO student VALUES(2, 'Ibrahim', 'Management');

INSERT INTO student(student_id, name) VALUES(3, 'Gokhan'); # if DEFAULT is set
INSERT INTO student VALUES(3, 'Gokhan', NULL);

INSERT INTO student VALUES(4, 'Tarik', 'Philosophy');
INSERT INTO student VALUES(5, 'Samet', 'Management');

SELECT * FROM student; # select every column from student table

# UPDATE & DELETE

UPDATE student SET major = 'EE Engineering' WHERE major = 'EE';
UPDATE student SET major = 'EE Engineering' WHERE student_id = 1;
UPDATE student SET major = 'PhiloManage' WHERE major = 'Management' OR major = 'Philosophy';
UPDATE student SET name = 'Abdullah', major = 'EE' WHERE student_id = 1;
UPDATE student SET major = 'EE Engineering'; # change all majors

DELETE FROM student; # delete all of the rows
DELETE FROM student WHERE student_id = 2;
DELETE FROM student WHERE name = 'Abdullah' AND major = 'EE Engineering';

# Basic Queries

SELECT name, major FROM student;
SELECT student.name, student.major FROM student;
SELECT student.name, student.major FROM student ORDER BY name;
SELECT student.name, student.major FROM student ORDER BY name DESC; # in descending order
SELECT student.name, student.major FROM student ORDER BY name ASC; # in ascending order
SELECT * FROM student ORDER BY name, major;
SELECT * FROM student LIMIT 2;
SELECT * FROM student WHERE major = 'Management' OR name = 'Samil';
SELECT * FROM student WHERE name IN ('Samil', 'Ibrahim');

-- comparison operators : <, >, <=, >=, =, <>(not equal), AND, OR

