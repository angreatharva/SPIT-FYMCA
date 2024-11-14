create database employee;
use employee;

-- Create Emp table with primary key constraint
CREATE TABLE Emp (
    eid INT PRIMARY KEY,
    ename VARCHAR(50),
    esal DECIMAL(10, 2),
    edesg VARCHAR(50)
);

 create table emp_audit
 (ename varchar(20),
  audit_desc varchar(100)
  );

-- Create Dept table with primary key constraint
CREATE TABLE Dept (
    did INT PRIMARY KEY,
    dname VARCHAR(50),
    dloc VARCHAR(50)
);

-- Create Worksfor table with primary and foreign key constraints
CREATE TABLE Worksfor (
    empid INT,
    deptid INT,
    PRIMARY KEY (empid, deptid),
    CONSTRAINT fk_emp FOREIGN KEY (empid) REFERENCES Emp(eid),
    CONSTRAINT fk_dept FOREIGN KEY (deptid) REFERENCES Dept(did)
);

insert into Emp value 
(7,'ABCdef',-200.00,'Writer')
;

update emp  set esal = 2200 where eid = 6;

select * from emp;
select * from emp_audit;

call display_emp;

call display_Data_In('Adam Ansari', 800.00);

call display_data_out(@var1);
select @var1 as average;

call display_data_in_out(2,@var2);
select @var2;

call Testing_continue();
call Testing_exit();