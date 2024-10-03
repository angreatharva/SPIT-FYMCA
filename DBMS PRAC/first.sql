create database sample;
use sample;
create table students
(
rollNo int,
name char(10),
class char(10),
address char(10)
);
desc students;
alter table students drop column serialNo ;
alter table students modify column phnNo bigint ;
alter table students modify name char(30);
alter table students rename column rollNo to rno;

insert into students 
values
(
2,
'Shreyas Gaikwad',
9167449721,
'FYMCA',
'Vile Parle',
'Male'
),
(
3,
'Abhishek Jha',
9167449722,
'FYMCA',
'Santacruz',
'Male'
),
(
4,
'Om Shinde',
9167449723,
'FYMCA',
'Andheri',
'Male'
);

select * from students;


commit;
start transaction;
set sql_safe_updates = 0;
update students set address = 'Goa' where rno = 2;
select * from students;
savepoint first;
update students set address = 'Ratnagiri' where rno = 2;
select * from students;
savepoint second;
rollback to first;
rollback to second;
rollback;

