create database lab_4;
use lab_4;

CREATE TABLE deposit_01 (
    actno VARCHAR(5) PRIMARY KEY,
    cname VARCHAR(18),
    bname VARCHAR(18),
    amount DECIMAL(8,2),
    adate DATE,
	FOREIGN KEY (bname) REFERENCES branch_01(bname),
    FOREIGN KEY (cname) REFERENCES customer_01(cname)
);

CREATE TABLE branch_01 (
    bname VARCHAR(18) PRIMARY KEY,
    city VARCHAR(18)
);

CREATE TABLE customer_01(
    cname VARCHAR(18) PRIMARY KEY,
    city VARCHAR(18)
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

update deposit_01 set amount = amount * 1.10 where bname = 'vrce';

delete from deposit_01 where bname = 'virar' and cname = 'shivani';

delete from deposit_01 where cname in (select cname from customer_01 where city = 'mumbai');
delete from borrow_01 where cname in (select cname from customer_01 where city = 'mumbai');
delete from customer_01 where city = 'mumbai';

delete from deposit_01 where amount < 5000;

select cname ;

select * from customer_01;
select * from branch_01;
select * from deposit_01;
select * from borrow_01;

