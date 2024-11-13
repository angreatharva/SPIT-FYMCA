-- DDL
create database emp;
drop database emp;
use emp;
create table emp
(
empId int,
empName varchar(30),
empDesignation varchar(20)
); 
alter table emp add column empAge int;
alter table emp rename column empName to empFullName;
alter table emp modify column empDesignation varchar(10);
alter table emp drop column empAge;
alter table emp add constraint Primary key (empId);
truncate table emp ;

-- DML
insert into emp values
(
1,
'Atharva Angre',
'Developer'
),
(
2,
'Om Shinde',
'Analyst'
),
(
3,
'Shreyash Gaikwad',
'Developer'
);

select * from emp;
update emp set empDesignation = 'HR' where empId = 3;
insert into emp values
(
4,
'Adam Ansari',
'Tester'
);
delete from emp where empId = 4;

-- DQL
select * from emp;

-- TCL
commit;
start transaction;
update emp set empDesignation = 'Team Lead' where empId = 1;
select * from emp;
savepoint one;
update emp set empDesignation = 'HR' where empId =2;
select * from emp;
savepoint two;
update emp set empDesignation = 'Manager' where empId =3;
select * from emp;
savepoint three;
rollback to two;
rollback to one;
rollback;

# Case & isnull ifnull coalesce
create database organization;
use organization;
create table employees
(
 employee_id int, 
 first_name varchar(20),
 last_name varchar(20),
 mname varchar(30),
 phone_number bigint,
 hire_date date,
 job_id varchar(20),
 salary float
 );
 
 insert into employees values 
 (1,'harsh','jain','fhdf',754745,'1999-06-08','AD_PRES',90000.00),
 (2,'raj','kadam','hdgfdh',75445,'2000-07-17','AD_VP',80000.00),
 (3,'arti','karande','fhdfdf',89893,'2021-09-12','IT_PROG',10000.00);
 
 select * from employees;
 commit;
 
 -- simple case expression example
 select *,
 case job_id
 when 'AD_PRES' then salary*0.1+salary
 when 'IT_PROG' then salary*0.2+salary
 else salary
 end as increment
 from employees; 
 
 -- searched case expression example
 select *,
 case 
    when job_id = 'AD_PRES' then salary*0.1+salary
    when employee_id=2 then salary*0.2+salary
	else salary
end as increment
from employees;
 
 
  
 create table professor
 (
 prof_id varchar(10),
 prof_name varchar(20),
 class varchar(20)
 );
  
  insert into professor values 
  ('e1','harsh','fybsc'),
  ('e2','dev',null),
  ('e3','sagar','sybcom'),
  ('e4','arti',null);
  
  commit;
  
  select * from professor;
  
  select *, isnull(class) as ans from professor;
  
  select *, ifnull(class,'fybcom') as ans from professor;
  
insert into professor values ('e5',null,null);
commit;
select * from professor;
 
 select *, coalesce(class,prof_name,prof_id) as ans from professor;
 
 SET SQL_SAFE_UPDATES = 0;

 update professor set class = ifnull(class,'fybcom');
 
 commit;
 select * from professor;
 
 
 
 
 #constraints
 
create database amazon;
use amazon;
create table customer (cust_id int, cust_name varchar(20), cust_phone bigint, cust_address varchar(30));

alter table customer modify cust_name varchar(20)  not null;

alter table customer add constraint uk1 unique(cust_phone);

alter table customer alter cust_address set default 'Andheri';

alter table customer add constraint ck1 check(cust_id>0);

insert into customer values (1,'Harsh',98192929,'Borivali');
commit;
select * from customer;
insert into customer values (2,null,65745,'Vasai');   -- NOT NULL CONstraint error
insert into customer (cust_id,cust_name,cust_phone) values (3,'Raj',45784);
delete from customer where cust_phone = 457845;
truncate table customer;

alter table customer add constraint pk1 primary key(cust_id);

create table product (p_id int, p_name varchar(20),p_price decimal(10,3));
alter table product add column cid int;
alter table product add constraint fk1 foreign key(cid) references customer(cust_id) on update cascade;

insert into customer values (1,'harsh',9920296767,'jogeshwari');
select * from customer;

insert into product values (101,'Mobile',20000,1);
insert into product values (102,'TV',50000,4);
insert into product values (102,'TV',50000,2);
select * from product;
commit;
select * from customer;
SET SQL_SAFE_UPDATES =0;
update customer set cust_id = 4 where cust_id=3;
commit;
select * from customer;
select * from product;

select * from customer;
insert into customer (cust_id,cust_name,cust_phone) values (1,'Harshil',9920297878);

insert into product values (105,'Mobilephone',670000,4);


#Joins
create database walmart;
use walmart;
create table products (product_id varchar(5), pname varchar(20));
create table pprice (product_id varchar(5), price int);
insert into products values
('a','tv'),
('b','phone'),
('c','ac'),
('d','refrigerator'),
('e','LED'),
('f','Microwave');

commit;
select * from products;

insert into pprice values
('a',500),
('b',600),
('c',700),
('d',900),
('i',1100),
('x',1200);

commit;
select * from pprice;

select  product_id,pname, price from products inner join pprice using (product_id);

select product_id,pname,price from products left join pprice using (product_id);

select product_id,pname,price from products right join pprice using (product_id);

select product_id,pname,price from products left join pprice using (product_id)
union
select product_id,pname,price from products right join pprice using (product_id);

select products.product_id,pname,price from products cross join pprice;

select pp.product_id,p.pname,pp.price from products as p right join pprice as pp on (p.product_id=pp.product_id);

select pname,price from products join pprice using (product_id) where pname like 'r%';
 
 
 #SP
 
create database organization1234;
use organization1234;

create table emp
(
 eid int,
 ename varchar(20),
 edesg varchar(30),
 esal decimal(10,3)
);

insert into emp values 
(1,'Harsh','IT_PROG',12222.00),
(2,'Raj','DEVELOPER',22222.22),
(3,'Ravi','IT_PROG',12222.33),
(4,'Akshata','HR',33333.33);
 
 commit;
 select * from emp;

call display_data();

call display_data1('IT_PROG',9000);

call display_data2(@var1);
select @var1;

call display_data3('IT_PROG',@var2);
select @var2;

set @no1 = 13000;
select @no1;
select * from emp where esal>@no1;




#Union and Subquery

create database university;
use university;
create table student
(
  sid int,
  sname varchar(20),
  class varchar(20)
);

create table professor
(pid int,
 pname varchar(20),
 qualification varchar(20)
);

alter table professor add constraint pk1 primary key(pid);

alter table student add column pid int references professor(pid);

select * from student;

select * from professor;

insert into professor values
(1,'Harsh','MTech'),
(2,'Raj','PhD'),
(3,'Rahul','ME'),
(4,'Arti','MTech');

update professor set qualification='MTech' where pid=4;
commit;

select * from professor;

insert into student values 
(101,'Akshata','FYMCA',1),
(102,'Divya','FYBA',2),
(108,'Sudhir','FYMA',3),
(110,'Rushi','SYMCA',3),
(167,'Reyansh','SYBCOM',4);

commit;
select * from student;

select sid,sname,pid,pname from student left join professor using(pid)
union
select sid,sname,pid,pname from student right join professor using(pid);

select sid,sname,pid,pname from student left join professor using(pid)
union all
select sid,sname,pid,pname from student right join professor using(pid);

select sid,sname from student where pid in (select pid from professor where pname='Rahul');
select sid,sname from student join professor using (pid) where pname='Rahul';

alter table professor add column salary decimal(10,3);
select * from professor;

update professor set salary = 10000 where pid=1;
update professor set salary = 12000 where pid=2;
update professor set salary = 13000 where pid=3;
update professor set salary=2000 where pid=4;

commit;
select * from professor;

select * from professor where salary = (select max(salary) from professor);

select * from professor where salary > (select avg(salary) from professor);



