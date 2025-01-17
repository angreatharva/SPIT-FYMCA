create database College;
use College;
 
create table student (rollno int, name varchar(50));
select * from student;
insert into student values
(1,'Atharva'),
(2,'Adam'),
(3,'Pranita'),
(4,'Rohit');

call exceptionHandling1();
call exceptionHandling2();

create database Flipkart;
use Flipkart;

drop table SupplierProducts;
create table SupplierProducts (supplierId int , productId int, primary key(supplierId,productId));
select * from SupplierProducts;

call exceptionHandling3(1,001);
call exceptionHandling3(1,001);
call exceptionHandling3(1,002);

call exceptionHandling4(2,003);
call exceptionHandling4(2,003);
call exceptionHandling4(2,004);

drop table t1;
drop table t2;
drop table t3;

create table t3 (t1id1 int PRIMARY KEY,t2id2 int UNIQUE);
create table t1 (
id1 int, 
name varchar(255),
place varchar(255), 
constraint fk_t1 foreign key (id1) references t3(t1id1)
);

create table t2 (
id2 int,
visited varchar(255),
cost int,
CONSTRAINT fk_t2 FOREIGN KEY (id2) REFERENCES t3(t2id2)
);


