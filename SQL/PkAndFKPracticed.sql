create table emp1(
eid int primary key,
ename varchar(100),
eaddress varchar(100))

insert into emp1 values(1,'saguna','pune'),(2,'amruta','nsk'),(3,'kavya','delhi'),(4,'akriti','mumbai')

select * from emp1

create table dept1(
deptid int,
dname varchar(100),
eid int foreign key references emp1(eid))

select * from dept1

insert into dept1 values(1,'karina',1),(2,'sneha',2),(3,'raj',3),(4,'garima',4)

---WITH CASCAD
insert into dept1 values(5,'nikita',5) ---not allowed

update emp1 set ename='archna' where eid=1

delete from dept1 where eid=2

--WITHOUT CASCAD
sp_help EMP1

INSERT INTO EMP1 VALUES(5,'SANSKRUTI',5)

SELECT * FROM EMP1
select * from dept1

UPDATE EMP1 SET ENAME='jaya' where eid=5

update emp1 set eaddress='chennai' where eid=5

delete from dept1 where deptid=4

---not allowed
delete from emp1 where eid=3