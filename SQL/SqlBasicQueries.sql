---Create SQLPRACTICE database
CREATE DATABASE SQLPractice

--create Employee table
create table Employee(
EmpId int IDENTITY PRIMARY KEY,
Customer_id int,
E_Name varchar(100),
Address varchar(100),
State varchar(100),
DOB Date,
Email varchar(100),
MobileNo bigint,
Gender varchar(100));

select * from Employee;

---insert values into employee table
insert into Employee values(1,'Saguna','Pune','MH','01/06/1996','saguuka123@gmail.com',9112241587,'F');
insert into Employee values(2,'Sara','Nashik','MH','06/09/1993','Sara@gmail.com',5214369874,'F');
insert into Employee values(3,'Arav','Sangli','MH','01/04/1994','Arav@gmail.com',6523987412,'M');
insert into Employee values(4,'Karishma','Pune','MH','01/03/1997','Karishma@gmail.com',7845963214,'F');
insert into Employee values(5,'Radha','Yeola','MH','01/05/1999','Radha@gmail.com',7845125874,'F');
insert into Employee values(6,'Kavita','Kolhapur','MH','08/06/1998','Kavita@gmail.com',9632587414,'F');
insert into Employee values(7,'Rani','Latur','MH','11/09/1990','Rani@gmail.com',7894565874,'F');
insert into Employee values(8,'Pallavi','Pune','MH','01/01/1992','Pallavi@gmail.com',7854961254,'F');

--add doj column
alter table Employee add DOJ int

alter table Employee add Salary int
UPDATE Employee set E_Name='Saguna' , Salary=50000 where EmpId=3;
UPDATE Employee set E_Name='Saguna' , Address='Nashik' where EmpId=2;

---drop doj coloumn
alter table Employee drop column DOJ

---create department table
CREATE TABLE Customer(
 Customer_id int,
 Customer_Name varchar(250));

 select * from Customer

--insert values into department table
INSERT INTO Customer(Customer_id,Customer_Name)
VALUES(1,'Saguna'),
(2,'Amruta'), 
(3,'Rakesh'),
(4, 'Swati '),
(5,'Vaishnavi'),
(6,'Raghav');

---INNER JOIN
SELECT Email, E_name, DOB ,Customer_Name
FROM Employee INNER JOIN Customer
ON Customer.Customer_id = Employee.Customer_id;

---LEFT JOIN 
SELECT EmpId, E_name, DOB,State,Customer_Name
FROM Employee LEFT JOIN Customer
ON Customer.Customer_id = Employee.Customer_id;

---RIGHT JOIN
SELECT Email,EmpId, E_name, DOB, Email,Customer_Name
FROM Employee RIGHT JOIN Customer
ON Customer.Customer_id = Employee.Customer_id;

---CROSS JOIN
SELECT EmpId,E_name, DOB, Customer_Name
FROM Employee CROSS JOIN Customer;

---SELF JOIN
SELECT Employee.Customer_id AS Customer_Id, Customer.Customer_Name AS Customer_Id, Employee.Customer_id
FROM Employee , Customer 
WHERE Employee.Customer_id = Customer.Customer_id
AND Employee.Customer_id= Customer.Customer_id
ORDER BY Employee.Customer_id;

--FULL OUTER JOIN
select Employee.E_Name,Employee.DOB,Employee.Gender,Customer.Customer_Name,Customer.Customer_id
from Employee
FULL OUTER JOIN
Customer on Customer.Customer_id=Employee.Customer_id

--CREATE TABLE EMPLOYEEDETAILS
Create table EmployeeDetails(
Customer_Id int Primary key,
Age int,
Address varchar(100));

SELECT * FROM EMPLOYEEDETAILS

---INSERT VALUES INTO EMPLOYEEDETAILS
insert EmployeeDetails values(1,26,'Pune')
insert EmployeeDetails values(2,21,'Chennai')
insert EmployeeDetails values(3,12,'Bhopal')
insert EmployeeDetails values(4,56,'USA')
insert EmployeeDetails values(5,19,'Kolhapur')

--JOIN THREE TABLES
select Employee.E_Name,Customer.Customer_Name,EmployeeDetails.Address,Customer.Customer_id
from Employee
INNER JOIN 
Customer on Employee.Customer_id=Customer.Customer_id
INNER JOIN 
EmployeeDetails on EmployeeDetails.Customer_Id=Employee.Customer_id

---display the record  ename and state
select E_Name,State from Employee;

---using where clause
select * from Employee WHERE E_Name='Saguna';

select * from Employee WHERE E_Name='Saguna' ORDER BY Address;

--display desc order
select Address from Employee order by E_Name desc;

---calculating length by desc
select E_Name,Email from Employee order by LEN(E_Name) desc;

---SQL TRIGGER
--DML TRIGGER
select * from Employee

--create audit table
create table EmployeeAudit
( Emp_Id int ,
inserted_by varchar(100)
)

select * from EmployeeAudit

--insert trigger
create trigger trgInsertAudit
on Employee
for insert 
as
begin
declare @ID int
select @ID = EmpId from inserted insert into EmployeeAudit (Emp_Id,inserted_by) values (@ID,ORIGINAL_LOGIN())
print 'Insert trigger in SQL'
end
go

---delete trigger
create trigger trgDeleteAudit
on Employee
for delete 
as
begin
declare @ID int
select @ID = EmpId from deleted insert into EmployeeAudit (Emp_Id,inserted_by) values (@ID,ORIGINAL_LOGIN())
print 'Delete trigger in SQL'
end
go

delete from Employee where EmpId=4
select * from Employee
Select * from EmployeeAudit

---delete trigger
create trigger trgDelete
on Employee
for delete
as
begin
rollback
print 'You cannot delete records from this table'
end 
go

delete from Employee where EmpId=2

---insted of trigger
select * from Employee
select * from Customer

create view v_Employee
as
select 
a.Customer_Id,b.E_Name
from Customer a inner join Employee b on a.Customer_id=b.Customer_id

select * from v_Employee

---DDL event Group
create trigger TrgTableUsingEvent
 on Database
 for DDL_TABLE_EVENTS                                    
 as
 begin
 print 'Use of Table Events'
 rollback
 end

 Select * from Employee

alter table Employee Drop column State

----server level trigger
 create trigger trgServer
on all server                     
for DDL_TABLE_EVENTS
as
begin
print'Cannot create table as Use of events In server Level'
rollback
end

---Audit trigger
create table trgAudit
(
 DatabaseName varchar(255),
 TableName varchar(255),
 EventType varchar(255),
 LoginName varchar(255),
 SQLCommand varchar(255),
 AuditDateTime dateTime
);

---audit trigger
create trigger trg_Audit
on All server                                      
for DDL_TABLE_EVENTS
as
begin
declare @EventData xml                             
select @EventData=EVENTDATA()                      
insert into SQLPractice.dbo.trgAudit (DatabaseName,TableName,EventType,LoginName,SQLCommand,AuditDateTime)
values 
(
  @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(250)'),
  GetDate()
)
End

--DDL trigger
create database trgdemo;
use trgdemo
go
create table t1(
id int );
go

-----disable trigger
disable trigger trgDeleteAudit on Employee
go
disable trigger trgServer on all server
go
disable trigger TrgTableUsingEvent on Employee
go
---enable trigger
enable trigger trgDeleteAudit on Employee
go

---SQL INDEX
select * from EmployeeDetails

---create index
create INDEX ix_Address on EmployeeDetails(Address);

USE SQLPractice
EXECUTE sp_helpindex EmployeeDetails

--Custom Clustered Indexes
USE SQLPractice
ALTER TABLE EmployeeDetails
DROP CONSTRAINT PK__Employee__8CB286990EE351CA
GO

---all the records in the Employee table will be stored in ascending order of the Age
use SQLPractice
CREATE CLUSTERED INDEX IX_tblEmployeeDetails_Age
ON EmployeeDetails(age ASC)

---Unique Index
CREATE UNIQUE INDEX unixemp  on EmployeeDetails (Address);

---Creating a SQL Server unique index for multiple columns 
CREATE TABLE t2 (
    a INT, 
    b INT
);

CREATE UNIQUE INDEX ix_uniq_ab 
ON t2(a, b);

--insert new row
INSERT INTO t2(a,b) VALUES(1,1);
INSERT INTO t2(a,b) VALUES(1,2);
select * from t2;

--Non-Clustered Indexes
use SQLPractice
CREATE NONCLUSTERED INDEX IX_tblEmployeeDetails_Age
ON EmployeeDetails(Age ASC)

--display Address Age based on where condition
SELECT Address,Age
FROM  EmployeeDetails
WHERE Age = 12;

---Renaming an index
EXEC sp_rename 
        @objname = N'EmployeeDetails.IX_tblEmployeeDetails_Age',
        @newname = N'IX_tblEmployeeDetails_Age' ,
        @objtype = N'INDEX';

---Disabling all indexes of a table 
ALTER INDEX ALL ON EmployeeDetails
DISABLE;

select * from EmployeeDetails

---to modify existing tables index by rebuild 
ALTER INDEX ALL ON EmployeeDetails
REBUILD;

---drop index
DROP INDEX IF EXISTS ix_EmployeeDetails_Age
ON EmployeeDetails;
