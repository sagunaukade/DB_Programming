select * from Student;

---Create view
create view vStudent
as
select * from student;

select * from vStudent;

---Alter view
alter view vStudent
as
select FirstName,City from Student;

---drop view
drop view vStudent;

select * from student;
select * from Employee;
select * from Departments;

---create view using multitable
create view vEmpMultiTable
as
select Employee.Department_Id,Employee.Employee_name,Employee.Salary,Departments.Department_Name from Employee
join Departments on Employee.Department_id=Departments.Department_id;

select * from vEmpMultiTable;

---how to update the metadata of sql view
create view vwStudent
as
select * from Student;
select * from vwStudent;

---alter table
alter table Student Add Age int
EXEC sp_refreshview vwStudent

----create schema binding sql view
create view vwStudList
As
select * from Student;
select * from vwStudList;

----drop Age column
alter table student drop column Age;

----create another view
create view vwStudListWithSchemaBinding
with schemabinding
As
select FirstName,City,Address from dbo.Student;

---after schema binding we cannot drop and change in table
alter table student drop column City;
alter table student alter column City varchar(45);

--why to use view:-
---hide the complexity of query
--row level security
--column level security

---create row level
create view vwRowLevel
As
select * from Student where Marks>70; 

select * from vwRowLevel;

---create row level
create view vwColumnLevel
As
select FirstName,State,Address from Student ;

select * from vwColumnLevel;

---create view 
create view vwDemo
As
select * from Student;

select * from vwDemo;
---insert value in vwDemo view
insert into vwDemo(FirstName,LastName,Address,City,State,Mobile_No,Email,Marks)
values('Ganesh','Ukade','Gangapur','Nashik','Maharashtra',6789097833,'ganesh22@gmail.com',98)

select * from vwDemo;

---delete specific record in database
delete from vwDemo where Student_Id=2;
----update view
update vwDemo Set FirstName='New Name' where Student_Id=6;

/*using with check option clause to prevent the insertion of rows
 in view where conditionin where clause in create view statement is not satisfied*/
create view vwCheckOptionDemo
As
Select * from Student where City='Pune'
With check option

select * from vwCheckOptionDemo

---we can insert differnt city getting error because it can used with check option
insert into vwCheckOptionDemo(FirstName,LastName,Address,City,State,Mobile_No,Email,Marks)
values('Pallesh','Ukade','satpur','Pune','Maharashtra',9087897833,'pallesh02@gmail.com',88);
