drop database lab_3;
create database lab_3;
use lab_3;

CREATE TABLE branch_01 (
    bname VARCHAR(18) PRIMARY KEY,
    city VARCHAR(18)
);

CREATE TABLE customer_01(
    cname VARCHAR(18) PRIMARY KEY,
    city VARCHAR(18)
);

CREATE TABLE deposit_01 (
    actno VARCHAR(5) PRIMARY KEY,
    cname VARCHAR(18),
    bname VARCHAR(18),
    amount DECIMAL(8,2),
    adate DATE,
	FOREIGN KEY (bname) REFERENCES branch_01(bname),
    FOREIGN KEY (cname) REFERENCES customer_01(cname)
);
CREATE TABLE borrow_01(
    loan_no VARCHAR(5) PRIMARY KEY,
    cname VARCHAR(18),
    bname VARCHAR(18),
    amount DECIMAL(8,2),
    FOREIGN KEY (cname) REFERENCES customer_01(cname),
    FOREIGN KEY (bname) REFERENCES branch_01(bname)
);

insert into branch_01 values
('vrce','nagpur'),
('ajni','nagpur'),
('karolbagh','delhi'),
('chandni','delhi'),
('dharampeth','nagpur'),
('m.g.road','bangalore'),
('andheri','mumbai'),
('virar','mumbai'),
('nehru place','delhi'),
('powai','mumbai')
;

insert into customer_01 values
('anil','kolkata'),
('sunil','delhi'),
('mehul','baroda'),
('mandar','patna'),
('madhuri','nagpur'),
('pramod','nagpur'),
('sandip','surat'),
('shivani','mumbai'),
('kranti','mumbai'),
('naren','mumbai')
;


insert into deposit_01 values
('100', 'anil', 'vrce', 1001 ,'1995-03-01'),
('101', 'sunil', 'ajni', 5000 ,'1995-01-04'),
('102', 'mehul', 'karolbagh', 3500 ,'1995-11-17'),
('104', 'madhuri', 'chandni', 1200 ,'1995-12-17'),
('105', 'pramod', 'm.g.road', 3000 ,'1996-03-27'),
('106', 'sandip', 'andheri', 2000 ,'1996-03-31'),
('107', 'shivani', 'virar', 1001 ,'1995-09-05'),
('108', 'kranti', 'nehru place', 5000 ,'1995-07-02'),
('109', 'naren', 'powai', 7000 ,'1995-08-10')
;

insert into borrow_01 values
('201', 'anil', 'vrce', 1000),
('206', 'mehul', 'ajni', 5000),
('311', 'sunil', 'chandni', 3000),
('321', 'madhuri', 'andheri', 2000),
('375', 'pramod', 'virar', 8000),
('481', 'kranti', 'nehru place', 3000)
;


select * from deposit_01;

select * from borrow_01;

select * from customer_01 where city = 'nagpur';

select * from borrow_01 where loan_no = 206;

select * from deposit_01 where amount > 4000;

select customer_01.cname 
from customer_01 
join deposit_01
on customer_01.cname = deposit_01.cname
where deposit_01.adate > '1995-12-01'
;

select city from branch_01 where bname = 'karolbagh';

select sum(amount) as total_loan from borrow_01;

select count(city) as customer_cities from customer_01;

select count(cname) as total_number_of_customers from customer_01;

select max(amount) as maximum_loan from borrow_01 where bname = 'vrce';

set SQL_SAFE_UPDATES = 0;
update deposit_01 set amount = amount * 1.10;
select * from deposit_01;

update deposit_01 set amount = amount * 1.10 where bname = 'vrce';
select * from deposit_01;

delete from deposit_01 where bname = 'virar' and cname = 'shivani';
select * from deposit_01;

delete from deposit_01 where cname in (select cname from customer_01 where city = 'mumbai');
delete from borrow_01 where cname in (select cname from customer_01 where city = 'mumbai');
delete from customer_01 where city = 'mumbai';
select * from customer_01;

delete from deposit_01 where amount < 5000;
select * from deposit_01;

#1
SELECT d1.cname as depositors
FROM deposit_01 d1
JOIN (SELECT bname FROM deposit_01 WHERE cname = 'sunil') d2 
ON d1.bname = d2.bname;

#2
select b.loan_no, b.amount as loan_amount 
from borrow_01 b
join (select bname from deposit_01 where cname = 'sunil') d 
on b.bname = d.bname;

#3
SELECT d.cname
FROM deposit_01 d
JOIN (SELECT cname FROM customer_01 WHERE city = 'Nagpur') c 
ON d.cname = c.cname;

#4
SELECT d.cname
FROM deposit_01 d
JOIN (SELECT DISTINCT bname FROM deposit_01 WHERE cname = 'Sunil') s 
ON d.bname = s.bname 
group BY d.cname
HAVING COUNT(DISTINCT d.bname) = (SELECT COUNT(DISTINCT bname) FROM deposit_01 WHERE cname = 'Sunil');

#5
SELECT d.cname
FROM deposit_01 d
JOIN (SELECT MAX(amount) AS max_amount FROM deposit_01) m 
ON d.amount = m.max_amount;

#6
SELECT d.cname
FROM deposit_01 d
JOIN (SELECT MAX(d.amount) AS max_amount
FROM deposit_01 d
JOIN customer_01 c ON d.cname = c.cname
WHERE c.city = 'Nagpur') m ON d.amount = m.max_amount;

#7
SELECT b.bname
FROM deposit_01 b
JOIN (SELECT bname, COUNT(cname) AS depositor_count
FROM deposit_01
GROUP BY bname
ORDER BY depositor_count DESC
LIMIT 1) d ON b.bname = d.bname;

#8
SELECT d.amount 
FROM deposit_01 d
JOIN (
SELECT city FROM branch_01 WHERE bname = (SELECT bname FROM deposit_01 WHERE cname = 'Sunil')
) m 
ON d.amount = m.amount;

#9
SELECT d.cname 
FROM deposit_01 d
join(select bname, avg(amount) as avg_amount from deposit_01 group by bname) a
ON d.bname = a.bname
where d.amount > a.avg_amount
;

#10
SELECT DISTINCT b.bname
FROM branch_01 b
JOIN deposit_01 d ON b.bname = d.bname
WHERE b.bname NOT IN (
    SELECT bname 
    FROM deposit_01 
    GROUP BY bname 
    HAVING COUNT(cname) >= 2
);

#11
SELECT COUNT(*) AS customer_count
FROM (
    SELECT DISTINCT d.cname
    FROM deposit_01 d
    JOIN branch_01 b ON d.bname = b.bname
    WHERE b.city = (SELECT city FROM customer_01 c WHERE c.cname = d.cname)
) AS customer_in_same_city;

#12//doubt
update customer_01 set city = 'nagpur' where cname in (select cname from borrow_01 where bname = 'verce' );
select * from customer_01;

#13
UPDATE deposit_01 AS d
JOIN customer_01 AS c ON d.cname = c.cname
SET d.amount = (
    SELECT MAX(amount) 
    FROM deposit_01 
    WHERE cname IN (SELECT cname FROM customer_01 WHERE city = 'Nagpur')
)
WHERE d.cname = 'Anil' AND c.city = 'Nagpur';



select * from customer_01;
select * from branch_01;
select * from deposit_01;
select * from borrow_01;

