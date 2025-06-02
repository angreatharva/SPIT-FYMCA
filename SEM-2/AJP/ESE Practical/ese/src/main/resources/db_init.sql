-- Create Database
CREATE DATABASE IF NOT EXISTS student_db;

USE student_db;

-- Create Table
CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    course_name VARCHAR(100),
    marks1 INT,
    marks2 INT,
    marks3 INT,
    percentage DOUBLE
);

-- Sample Data (Optional)
INSERT INTO students (name, dob, course_name, marks1, marks2, marks3, percentage)
VALUES 
    ('John Doe', '2000-01-15', 'Computer Science', 85, 90, 78, 84.33),
    ('Alice Smith', '2001-03-22', 'Information Technology', 92, 88, 95, 91.67),
    ('Bob Johnson', '1999-07-10', 'Electronics', 76, 82, 79, 79.00); 