drop database lab_5;
create database lab_5;
use lab_5;

create table emp(Name varchar(50),Occupation varchar(50),Working_Date date,Working_hours int);

insert into emp value
('Harsh','Scientist','2020-10-21',12),
('Raj','Engineer','2020-08-11',10),
('Ravi','Actor',' 2020-10-22',10),
('Rahul','Doctor','2020-10-04',11)
;

select * from emp;

create table emp_audit(Name varchar(50),audit_description varchar(500));

insert into emp value
('Adam','Tester','2020-10-15',-20);





insert into emp value
('Om','Manager','2020-08-15',15);

select * from emp_audit;

update emp set Working_Date = '2025-12-2' where Name = 'Om';

create table EmpChanges(Name varchar(50), New_Occupation varchar(100), Old_Occupation varchar(100), Updatedat varchar(100));

update emp set Occupation = 'Developer' where Name = 'Adam';

select * from  EmpChanges;

create table Emp_archeives(Name varchar(50),Occupation varchar(50),Working_Date date,Working_hours int);

set SQL_SAFE_UPDATES = 0;
delete from emp where Name = 'Adam';
select * from  Emp_archeives;

drop table Total_working_hours_table;
create table Total_working_hours_table (Total int);

insert into Total_working_hours_table values (43);
select * from Total_working_hours_table;

delete from emp where Name = 'Harsh';



