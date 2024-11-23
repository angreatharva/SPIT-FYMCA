drop database lab_3;
create database lab_3;
use lab_3;

create table branch_01 (
    bname varchar(18) primary key,
    city varchar(18)
);

create table customer_01(
    cname varchar(18) primary key,
    city varchar(18)
);

create table deposit_01 (
    actno varchar(5) primary key,
    cname varchar(18),
    bname varchar(18),
    amount decimal(8,2),
    adate date,
	foreign key (bname) references branch_01(bname),
    foreign key (cname) references customer_01(cname)
);
create table borrow_01(
    loan_no varchar(5) primary key,
    cname varchar(18),
    bname varchar(18),
    amount decimal(8,2),
    foreign key (cname) references customer_01(cname),
    foreign key (bname) references branch_01(bname)
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

set sql_safe_updates = 0;
update deposit_01 set amount = amount * 1.10;
select * from deposit_01;

update deposit_01 set amount = amount * 1.10 where bname = 'vrce';
select * from deposit_01;

delete from deposit_01 where bname = 'virar' and cname = 'shivani';
select * from deposit_01;

delete from deposit_01 where cname in (select cname from customer_01 where city = 'mumbai');
delete from borrow_01 where cname in (select cname from customer_01 where city = 'mumbai');
delete from customer_01 where city = 'mumbai';
select * from customer_01;

delete from deposit_01 where amount < 5000;
select * from deposit_01;

#1
select d1.cname as depositors
from deposit_01 d1
join (select bname from deposit_01 where cname = 'sunil') d2 
on d1.bname = d2.bname;

#2
select b.loan_no, b.amount as loan_amount 
from borrow_01 b
join (select bname from deposit_01 where cname = 'sunil') d 
on b.bname = d.bname;

#3
select d.cname
from deposit_01 d
join (select cname from customer_01 where city = 'nagpur') c 
on d.cname = c.cname;

#4
select d.cname
from deposit_01 d
join (select distinct bname from deposit_01 where cname = 'sunil') s 
on d.bname = s.bname 
group by d.cname
having count(distinct d.bname) = (select count(distinct bname) from deposit_01 where cname = 'sunil');

#5
select d.cname
from deposit_01 d
join (select max(amount) as max_amount from deposit_01) m 
on d.amount = m.max_amount;

#6
select d.cname
from deposit_01 d
join (select max(d.amount) as max_amount
from deposit_01 d
join customer_01 c on d.cname = c.cname
where c.city = 'nagpur') m on d.amount = m.max_amount;

#7
select b.bname
from deposit_01 b
join (select bname, count(cname) as depositor_count
from deposit_01
group by bname
order by depositor_count desc
limit 1) d on b.bname = d.bname;

#8
select max(d.amount) as highest_deposit
from deposit_01 d
join branch_01 b on d.bname = b.bname
where b.city = (select city from branch_01 where bname = (select bname from deposit_01 where cname = 'sunil'));


#9
select d.cname 
from deposit_01 d
join(select bname, avg(amount) as avg_amount from deposit_01 group by bname) a
on d.bname = a.bname
where d.amount > a.avg_amount
;

#10
select distinct b.bname
from branch_01 b
join deposit_01 d on b.bname = d.bname
where b.bname not in (
    select bname 
    from deposit_01 
    group by bname 
    having count(cname) >= 2
);

#11
select count(*) as customer_count
from (
    select distinct d.cname
    from deposit_01 d
    join branch_01 b on d.bname = b.bname
    where b.city = (select city from customer_01 c where c.cname = d.cname)
) as customer_in_same_city;

#12
update customer_01
set city = 'nagpur'
where cname in (
    select b.cname
    from borrow_01 b
    join branch_01 br on b.bname = br.bname
    where br.bname = 'vrce'
); 


#13
update deposit_01
set amount = (
    select max_amount
    from (select max(amount) as max_amount 
          from deposit_01 d 
          join customer_01 c on d.cname = c.cname 
          where c.city = 'nagpur') as derived_table
)
where cname = 'anil';


#14
update deposit_01 a 
join deposit_01 s on a.bname = s.bname
set a.amount = a.amount - 100,s.amount = s.amount +100
where a.cname = 'anil' and s.cname = 'sunil';

update deposit_01
set amount = 
    case 
        when cname = 'anil' then amount - 100
        when cname = 'sunil' then amount + 100
    end
where cname in ('anil', 'sunil')
and bname = (
    select bname 
    from (select bname from deposit_01 where cname = 'anil') as temp_anil
)
and bname = (
    select bname 
    from (select bname from deposit_01 where cname = 'sunil') as temp_sunil
);



#15
update deposit_01 d
join (select bname, max(amount) as max_amount from deposit_01 group by bname) m on d.bname = m.bname and d.amount = m.max_amount
set d.amount = d.amount + 100;

#16
delete from branch_01
where bname in (
select bname 
from deposit_01 d 
join customer_01 c on d.cname = c.cname 
where c.city = 'nagpur'
);

#17
delete d
from deposit_01 d
join customer_01 c1 on d.cname = c1.cname
where d.cname in ('anil', 'sunil')
and (
    select count(distinct c2.city)
    from customer_01 c2
    where c2.cname in ('anil', 'sunil')
) = 1;



#18
delete b
from borrow_01 b
join (
    select d.bname
    from deposit_01 d
    group by d.bname
    having count(d.cname) = (
        select min(depositor_count)
        from (
            select count(cname) as depositor_count
            from deposit_01
            group by bname
        ) as counts
    )
) as branches_with_min on b.bname = branches_with_min.bname;


#19
select distinct d.cname
from deposit_01 d
join borrow_01 b on d.cname = b.cname
where d.cname in (
    select cname
    from borrow_01
);



#20
select d.cname
from deposit_01 d
left join borrow_01 b on d.cname = b.cname
where b.cname is null
and d.cname not in (
    select cname
    from borrow_01
);

#21
select d.cname from deposit_01 d
join customer_01 c on d.cname = c.cname
join branch_01 b on d.bname = b.bname
where c.city = (select city from customer_01 where cname = 'sunil')
and b.city = (select city from branch_01 where bname = (select bname from deposit_01 where cname = 'anil'))
;

#22
select d.cname
from deposit_01 d
join customer_01 c on d.cname = c.cname
where d.amount < 5000 and c.city = (select city from customer_01 where cname = 'shivani');

#23
select distinct d.cname
from deposit_01 d
join customer_01 c on d.cname = c.cname
join branch_01 b on d.bname = b.bname
where c.city = 'mumbai' and b.city = (select city from branch_01 where bname = (select bname from deposit_01 where cname = 'sandip'));

#24
select br.bname, 
       (select sum(d.amount) 
        from deposit_01 d 
        where d.bname = br.bname) as total_deposit
from branch_01 br
join deposit_01 d on br.bname = d.bname
group by br.bname;



#25
update deposit_01 d
join (select bname, avg(amount) as avg_amount from deposit_01 group by bname) a on d.bname = a.bname
set d.amount = d.amount + 100
where d.amount > a.avg_amount;

#26

select distinct d1.cname, d1.amount 
from deposit_01 d1 
join deposit_01 d2 
on (d1.amount < d2.amount) or 
   (d1.amount = d2.amount and d1.cname < d2.cname)
group by d1.cname, d1.amount
having count(*) = 2
order by d1.amount desc;

#sq
SELECT cname
FROM deposit_01 d1
WHERE (
    SELECT COUNT(*)
    FROM deposit_01 d2
    WHERE d2.amount > d1.amount 
    OR (d2.amount = d1.amount AND d2.cname > d1.cname)
) = 2;



#27

select d.*
from deposit_01 d
join (
    select cname 
    from customer_01 
    order by cname asc
) as sorted_customers on d.cname = sorted_customers.cname;






select * from customer_01;
select * from branch_01;
select * from deposit_01 order by amount desc;
select * from borrow_01;

