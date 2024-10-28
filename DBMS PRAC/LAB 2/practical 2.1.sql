create database college;
use college;

create table students (student_id int, student_name varchar(20));

alter table students add column age int, add column phone_no int;

alter table students rename column student_name to sname;

alter table students add column class varchar(20) after sname;

alter table students modify sname varchar(30) ;

alter table students add constraint primary key(student_id);

alter table students add constraint unique (sname);

insert into students (student_id, sname, class, age, phone_no) 
values
(1, 'Sanjay', 'symca', 23, 242543),
(2, 'Vaidehi', 'fymca', 24, 454354),
(3, 'Akshata', 'symca', 21, 543543),
(4, 'Vidula', 'fymca', 22, 435454),
(5, 'Pratik', 'symca', 23, 345435)
;
select * from students;

update students set age = 22 where sname = 'Akshata'; 
select * from students;

delete from students where sname = 'Pratik';
select * from students;

CREATE USER XYZ@localhost IDENTIFIED BY 'abcd';
GRANT ALL PRIVILEGES ON college.* TO 'XYZ'@'localhost';
FLUSH PRIVILEGES;
