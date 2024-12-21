CREATE database lab_9;

USE lab_9;
-- 1)
CREATE TABLE salesrange_atharva (
    salesman_id INT(5),
    salesman_name VARCHAR(20),
    sales_amount DECIMAL(10, 2),
    sales_date DATE
)
PARTITION BY RANGE (YEAR(sales_date)) (
    PARTITION sales_jan2000 VALUES LESS THAN (2000),
    PARTITION sales_feb2000 VALUES LESS THAN (2001),
    PARTITION sales_mar2000 VALUES LESS THAN (2002),
    PARTITION sales_apr2000 VALUES LESS THAN (2003),
    PARTITION sales_may2000 VALUES LESS THAN (2004)
);

INSERT INTO salesrange_atharva VALUES
(1, 'Atharva Angre', 20000, '2000-01-10'),
(2, 'Adam Ansari', 40000, '2000-02-10'),
(3, 'Abhijeet Jadhav', 80000, '2000-03-10'),
(4, 'Abhishek Jha', 60000, '2000-04-10'),
(5, 'Vineet Shinde', 50000, '2000-05-10');

CREATE TABLE salesrange_rohit (
    salesman_id INT,
    salesman_name VARCHAR(20),
    sales_amount INT,
    sales_date DATE
)
PARTITION BY RANGE (TO_DAYS(sales_date)) (
    PARTITION sales_jan2000 VALUES LESS THAN (TO_DAYS('2000-01-01')),
    PARTITION sales_feb2000 VALUES LESS THAN (TO_DAYS('2000-02-01')),
    PARTITION sales_mar2000 VALUES LESS THAN (TO_DAYS('2000-03-01')),
    PARTITION sales_apr2000 VALUES LESS THAN (TO_DAYS('2000-04-01')),
    PARTITION sales_may2000 VALUES LESS THAN (TO_DAYS('2000-05-01')),
    PARTITION sales_jun2000 VALUES LESS THAN (TO_DAYS('2000-06-01'))
);

INSERT INTO salesrange_rohit VALUES(1, 'Atharva Angre', 20000, '2000-01-10');
INSERT INTO salesrange_rohit VALUES(2, 'Adam Ansari', 40000, '2000-02-10');
INSERT INTO salesrange_rohit VALUES(3, 'Abhijeet Jadhav', 80000, '2000-03-10');
INSERT INTO salesrange_rohit VALUES(4, 'Suyash', 60000, '2000-04-10');
INSERT INTO salesrange_rohit VALUES(5, 'Ritesh', 50000, '2000-05-10');


SELECT * FROM salesrange_atharva;
SELECT * FROM salesrange_atharva PARTITION (sales_feb2000);


-- 2)
CREATE TABLE saleslist_atharva (
    salesman_id INT(5),
    salesman_name VARCHAR(20),
    sales_city VARCHAR(15),
    sales_amount DECIMAL(10,2),
    sales_date DATE
)
PARTITION BY LIST COLUMNS(sales_city) (
    PARTITION sales_west VALUES IN ('mumbai','pune'),
    PARTITION sales_east VALUES IN ('kolkata'),
    PARTITION sales_north VALUES IN ('chennai'),
    PARTITION sales_south VALUES IN ('delhi'),
    PARTITION sales_default VALUES IN ('default')
);

INSERT INTO saleslist_atharva VALUES
(1, 'Atharva Angre', 'mumbai', 20000, '2000-01-10'),
(2, 'Adam Ansari', 'delhi', 40000, '2000-02-10'),
(3, 'Abhijeet Jadhav', 'kolkata', 80000, '2000-03-10'),
(4, 'Abhishek Jha', 'chennai', 60000, '2000-04-10'),
(5, 'Vineet Shinde', 'pune', 50000, '2000-05-10');

-- To view all records
SELECT * FROM saleslist_atharva;

-- To view records from north partition
SELECT * FROM saleslist_atharva PARTITION (sales_north);
