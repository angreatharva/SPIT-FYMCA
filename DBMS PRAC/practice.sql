-- DDL
create database emp;
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




