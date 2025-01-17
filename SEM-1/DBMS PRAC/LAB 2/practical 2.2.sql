use college;

create table Marks(sid int , subject1 int , subject2 int , subject3 int);

alter table Marks add foreign key (sid) references students(student_id) ;

alter table Marks add check (subject1 > 0);

insert into Marks values
(1,89,78,89),
(3,99,67,56),
(4,90,66,45),
(2,89,88,88)
;