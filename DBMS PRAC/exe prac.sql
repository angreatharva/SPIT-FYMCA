create database CollegeDB;
use CollegeDB;

create table students (
StudentID int primary key,
Name varchar(50),
Age int,
DepartmentID int,
Email varchar(50) unique,
Phone bigint,
 foreign key (DepartmentID) references Departments(DepartmentID)
);

alter table students add constraint check (age >= 18);

create table Courses(
CourseID int primary key,
CourseName varchar(50),
Credits int,
DepartmentID int,
foreign key (DepartmentID) references Departments(DepartmentID)
);

create table Departments(
DepartmentID int primary key,
DepartmentName varchar(50),
HOD varchar(50)
);

create table Faculty(
FacultyID int primary key,
Name varchar(50),
DepartmentID int,
Specialization varchar(50),
foreign key (DepartmentID) references Departments(DepartmentID)
);


-- Insert data into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName, HOD) VALUES
(1, 'Computer Science', 'Dr. John Doe'),
(2, 'Mathematics', 'Dr. Jane Smith'),
(3, 'Physics', 'Dr. Albert Newton');

-- Insert data into Courses table
INSERT INTO Courses (CourseID, CourseName, Credits, DepartmentID) VALUES
(101, 'Data Structures', 3, 1),
(102, 'Calculus', 4, 2),
(103, 'Quantum Mechanics', 3, 3);

-- Insert data into Faculty table
INSERT INTO Faculty (FacultyID, Name, DepartmentID, Specialization) VALUES
(1, 'Prof. Alice Johnson', 1, 'Machine Learning'),
(2, 'Prof. Bob Williams', 2, 'Number Theory'),
(3, 'Prof. Carol Taylor', 3, 'Astrophysics');

-- Insert data into Students table
INSERT INTO Students (StudentID, Name, Age, DepartmentID, Email, Phone) VALUES
(1, 'David Brown', 20, 1, 'david.brown@example.com', 9876543210),
(2, 'Emily Clark', 22, 2, 'emily.clark@example.com', 9876543211),
(3, 'Frank Harris', 19, 3, 'frank.harris@example.com', 9876543212);


-- joins
select students.Name, departments.DepartmentName 
from students
inner join departments
on students.DepartmentID = departments.DepartmentID;


select courses.CourseName,Departments.DepartmentName
from courses
left join departments
on courses.DepartmentID = departments.DepartmentID;


select faculty.Name as faculty_name,faculty.Specialization,Departments.DepartmentName
from faculty
right join departments
on faculty.DepartmentID = departments.DepartmentID;

SELECT Students.Name
FROM Students
LEFT JOIN Courses ON Students.DepartmentID = Courses.DepartmentID
WHERE Courses.CourseID IS NULL

UNION

SELECT Students.Name
FROM Students
RIGHT JOIN Courses ON Students.DepartmentID = Courses.DepartmentID
WHERE Students.StudentID IS NULL;

select * from departments;
-- subquery
select name as Student_Name
from students s 
where age = (select min(age) from students where departmentID = s.departmentID);

SELECT CourseName
FROM Courses
WHERE DepartmentID = (
    SELECT DepartmentID
    FROM Students
    GROUP BY DepartmentID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

SELECT Name
FROM Students
WHERE StudentID IN (
    SELECT DISTINCT StudentID
    FROM Courses
    WHERE Credits > (SELECT AVG(Credits) FROM Courses)
);

create table StudentDeletions(DeletedStudentID int,DeletionDate datetime);

select * from students;

delete from students where StudentID =1;

call add_student(
4, 'David Brown', 20, 1, 'david.brown@example.com', 9876543210
);

select AvgAgeByDepartment(2);

-- Horizontal fragmentation of Students table
CREATE TABLE UndergraduateStudents AS
SELECT * FROM Students WHERE Age < 22;

CREATE TABLE PostgraduateStudents AS
SELECT * FROM Students WHERE Age >= 22;

-- Retrieve data from fragments
SELECT * FROM UndergraduateStudents;
SELECT * FROM PostgraduateStudents;


-- Partition Courses table by credits
CREATE TABLE Courses_Credits (
    CourseID INT NOT NULL,
    CourseName VARCHAR(50),
    Credits INT NOT NULL,
    DepartmentID INT,
    PRIMARY KEY (CourseID, Credits)
)
PARTITION BY RANGE (Credits) (
    PARTITION p1 VALUES LESS THAN (4),  -- Low credits
    PARTITION p2 VALUES LESS THAN (7),  -- Medium credits
    PARTITION p3 VALUES LESS THAN MAXVALUE  -- High credits
);


-- Insert data into partitions
INSERT INTO Courses_Credits VALUES (1, 'Mathematics', 3, 101);
INSERT INTO Courses_Credits VALUES (2, 'Physics', 5, 102);
INSERT INTO Courses_Credits VALUES (3, 'Chemistry', 7, 103);

-- Retrieve data from MediumCredits partition
SELECT * FROM Courses WHERE Credits > 3 AND Credits <= 6;




