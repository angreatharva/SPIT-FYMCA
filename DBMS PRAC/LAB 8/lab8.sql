drop database atharva_01;
drop database angre_01;
drop database lab_8;
SELECT User, Host FROM mysql.user ;
DROP USER 'atharva_01'@'localhost';
DROP USER 'angre_01'@'localhost';


-- 1
-- Create Users
CREATE USER 'atharva_01'@'localhost' IDENTIFIED BY '0809';
CREATE USER 'angre_01'@'localhost' IDENTIFIED BY '0809';

-- Create databases for each user
CREATE DATABASE lab_8;
CREATE DATABASE atharva_01;
CREATE DATABASE angre_01;
-- Switch to the parent database (e.g., lab_8)
USE lab_8;
-- Create the employee table in the parent database
CREATE TABLE employee (
  empid INT PRIMARY KEY,
  ename VARCHAR(100),
  address VARCHAR(255),
  salary DECIMAL(10, 2),
  department VARCHAR(100)
);

-- Grant privileges to the created users for the employee table in the parent database
GRANT SELECT, INSERT, UPDATE, DELETE ON employee TO 'atharva_01'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON employee TO 'angre_01'@'localhost';

-- Now switch to the `atharva_01` database and create a new employee table
USE atharva_01;

CREATE TABLE employee (
  empid INT PRIMARY KEY,
  ename VARCHAR(100),
  department VARCHAR(100)
);

-- Switch to `angre_01` and create a different employee table
USE angre_01;

CREATE TABLE employee (
  empid INT PRIMARY KEY,
  address VARCHAR(255),
  salary DECIMAL(10, 2)
);

-- 6
USE lab_8;

DELIMITER $$

CREATE TRIGGER employee_insert_trigger
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    IF NEW.salary IS NOT NULL AND NEW.salary < 25000 THEN
        INSERT INTO atharva_01.employee (empid, ename, department)
        VALUES (NEW.empid, NEW.ename, NEW.department);
    ELSE
        INSERT INTO angre_01.employee (empid, address, salary)
        VALUES (NEW.empid, NEW.address, NEW.salary);
    END IF;
END $$

DELIMITER ;

-- 7
USE lab_8;

-- Insert records in the parent employee table
INSERT INTO employee (empid, ename, address, salary, department)
VALUES
(1, 'Atharva Angre', '123 Main St', 22000, 'IT'),
(2, 'Adam Ansari', '456 Elm St', 27000, 'HR'),
(3, 'Abhijeet Jadhav', '789 Pine St', 24000, 'Finance'),
(4, 'Abhishek Jha', '101 Oak St', 30000, 'IT'),
(5, 'Vineet Shinde', '202 Maple St', 23000, 'HR');

-- 8
-- Display records from User1's employee table
USE atharva_01;
SELECT * FROM employee;

-- Display records from User2's employee table
USE angre_01;
SELECT * FROM employee;

-- 9
USE lab_8;
SELECT * FROM employee WHERE salary > 25000;

-- 10
USE lab_8;  

CREATE TABLE movietab (
  movie_title VARCHAR(255),
  language VARCHAR(100),
  length_in_min INT,
  lead_actor VARCHAR(100),
  lead_actress VARCHAR(100)
);

-- 11
-- Grant privileges to user1 and user2 for the movietab table
GRANT SELECT, INSERT, UPDATE, DELETE ON movietab TO 'atharva_01'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON movietab TO 'angre_01'@'localhost';

-- 12
-- Switch to User1's database
USE atharva_01;

CREATE TABLE movietab (
  movie_title VARCHAR(255),
  language VARCHAR(100),
  length_in_min INT,
  lead_actor VARCHAR(100),
  lead_actress VARCHAR(100)
);

-- 13
-- Switch to User2's database
USE angre_01;

CREATE TABLE movietab (
  movie_title VARCHAR(255),
  language VARCHAR(100),
  length_in_min INT,
  lead_actor VARCHAR(100),
  lead_actress VARCHAR(100)
);

-- 14
USE lab_8;

DELIMITER $$

CREATE TRIGGER movietab_insert_trigger
AFTER INSERT ON movietab
FOR EACH ROW
BEGIN
    IF NEW.length_in_min < 60 THEN
        INSERT INTO atharva_01.movietab (movie_title, language, length_in_min, lead_actor, lead_actress)
        VALUES (NEW.movie_title, NEW.language, NEW.length_in_min, NEW.lead_actor, NEW.lead_actress);
    ELSE
        INSERT INTO angre_01.movietab (movie_title, language, length_in_min, lead_actor, lead_actress)
        VALUES (NEW.movie_title, NEW.language, NEW.length_in_min, NEW.lead_actor, NEW.lead_actress);
    END IF;
END $$

DELIMITER ;

-- Switch to the Parent Database (lab_8) and insert data
USE lab_8;
-- Insert a movie with length < 60 minutes (should go to User1's movietab)
INSERT INTO movietab (movie_title, language, length_in_min, lead_actor, lead_actress)
VALUES ('Short Movie', 'English', 45, 'Short Actor', 'Short Actress');

-- Insert a movie with length >= 60 minutes (should go to User2's movietab)
INSERT INTO movietab (movie_title, language, length_in_min, lead_actor, lead_actress)
VALUES ('Long Movie', 'English', 120, 'Long Actor', 'Long Actress');

-- 15
-- Display data from User1's movietab table
USE atharva_01;
SELECT * FROM movietab;

-- Display data from User2's movietab table
USE angre_01;
SELECT * FROM movietab;


