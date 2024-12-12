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


