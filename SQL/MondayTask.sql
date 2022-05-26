CREATE DATABASE DB_PROGRAMMING

---CREATE STUDENT TABLES
CREATE TABLE Student(
S_id int primary key identity,
Name varchar(100),
Class varchar(100),
City varchar(100),
State varchar(100),
Email varchar(100),
MobileNo bigint,
DOB date,
Age int);

SELECT * FROM Student

--INSERT RECORDS INTO STUDENT TABLES 
insert into Student values('Saguna','BE','Pune','Maharashtra','Sagunauka123@gmail.com',5689741254,'01/09/1998',24);
insert into Student values('Amruta','ME','Nashik','Maharashtra','Amruta34@gmail.com',7845123698,'03/07/1990',45);
insert into Student values('Vaishnavi','Diploma','Kolhapur','Maharashtra','Vaishnavi11@gmail.com',2314567843,'05/03/1997',22);
insert into Student values('Rani','BSC','Yeola','Maharashtra','Rani987@gmail.com',9876543210,'07/01/1992',15);
insert into Student values('Kartiki','Pharmcy','Sangli','Maharashtra','Kartiki546@gmail.com',9809876545,'03/04/1994',98);

--CREATE STUDDETAILS TABLE
CREATE TABLE StudDetails(
RollNo int,
AddmissionDate Datetime,
Student_Id int REFERENCES Student(S_id))

select * from StudDetails

INSERT INTO StudDetails values(101,01/09/2020,1)
INSERT INTO StudDetails values(102,09/04/2024,2)
INSERT INTO StudDetails values(103,02/02/2021,3)

--Add FK 
---alter table StudDetails add foreign key (Student_id) REFERENCES student(S_id)

-----******JOINS******------

create table Employee(
Emp_Id int identity(1,1) primary key,
Name varchar(100) not null,
Designation varchar(100) not null,
City varchar(100) not null,
DOB DATE,
Salary int);

SELECT * FROM Employee

---insert values into emp table
insert Employee values('Saguna','Software Developer','Chennai','02/02/1998',40000);
insert Employee values('Krisma','Java Developer','USA','01/12/1996',20000);
insert Employee values('Rani','Dotnet Developer','Pune','05/08/1997',50000);
insert Employee values('Riya','SQL Developer','Mumbai','01/09/1991',30000);
insert Employee values('Prachi','HR','Pune','03/08/1992',45000);
insert Employee values('Amruta','Manager','Banglore','11/06/1996',43000);
insert Employee values('Kavya','Marketing','Chennai','09/02/1993',50000);

---create dept table
create table Department(
Dept_Id int Primary key,
Emp_Id int,
Dept_Name varchar(100),
Pincode int)

SELECT * FROM Department

--insert values into dept table
insert Department values(1,2,'HR',234051)
insert Department values(2,8,'Developer',530951)
insert Department values(3,3,'HR',237865)
insert Department values(4,5,'Sales',474051)
insert Department values(5,7,'Analyst',444051)
insert Department values(6,4,'HR',434051)

---Create table EmployeeDetails
Create table EmployeeDetails(
Emp_Id int Primary key,
Age int,
Address varchar(100)) 

select * from EmployeeDetails

---insert values into EmployeeDetails
insert EmployeeDetails values(1,26,'Pune')
insert EmployeeDetails values(2,21,'Chennai')
insert EmployeeDetails values(3,12,'Bhopal')
insert EmployeeDetails values(4,56,'USA')
insert EmployeeDetails values(5,19,'Kolhapur')

--INNER JOIN
select Employee.Emp_Id, Department.Dept_Name, Employee.Designation
from Employee
INNER JOIN
Department on Employee.Emp_Id=Department.Emp_Id

select Employee.Emp_Id,Department.Pincode, Employee.DOB, Department.Dept_Name,Employee.City
from Employee
INNER JOIN
Department ON Employee.Emp_Id=Department.Emp_Id

--Join Three Tables
select Employee.Emp_Id,Department.Dept_Name,EmployeeDetails.Address,Department.Pincode
from Employee
INNER JOIN 
Department on Employee.Emp_Id=Department.Emp_Id
INNER JOIN 
EmployeeDetails on EmployeeDetails.Emp_Id=Employee.Emp_Id

--LEFT JOIN
select Employee.Emp_Id,Department.Dept_Name
from Employee
LEFT JOIN
Department on Employee.Emp_Id=Department.Emp_Id
ORDER BY Employee.Name

--RIGHT JOIN
select Employee.Emp_Id,Employee.Designation,Employee.Name,Department.Dept_Name,Department.Pincode
from Employee
RIGHT JOIN
Department on Department.Emp_Id=Employee.Emp_Id
ORDER BY Employee.Name DESC

--FULL OUTER JOIN
select Employee.City,Employee.DOB,Employee.Salary,Department.Dept_Name,Department.Pincode
from Employee
FULL OUTER JOIN
Department on Department.Emp_Id=Employee.Emp_Id

--SELF JOIN
SELECT Employee.Designation AS Emp_Id, Department.Dept_Name AS Emp_Id
FROM Employee, Department 
WHERE Employee.Emp_Id= Department.Emp_Id
AND Employee.Emp_Id= Department.Emp_Id
ORDER BY Employee.Emp_Id;

--CROSS JOIN
select Employee.City, Employee.Designation, Department.Dept_Name,Department.Pincode
from Employee
CROSS JOIN
Department;

----*****SQL CONSTRAINTS*****-------
--constraints are the rules enforced on the data columns of table
 
---use of NOT NULL
--ensure that a column can not have NULL value

create table tab
(RollNo int NOT NULL,
Name varchar(100),
Class varchar(100)
)

select * from Tab

--column does not allow null values 
insert into tab(name,class)values('Saguna','BE')

insert into tab(RollNo,name,class)values(1,'Saguna','BE')

---create table tab2
create table tab2
(RollNo int,
Name varchar(100),
Class varchar(100)
)

select * from Tab2
alter table tab2 alter column RollNo int NOT NULL

--use of UNIQUE
--all the values in the column must be unique
create table TabUnique
(RollNo int UNIQUE,
Name varchar(100),
Class varchar(100)
)

select * from TabUnique

insert into TabUnique(RollNo,name,class)values(1,'Saguna','BE')

alter table TabUnique add constraint UniqueRollNo UNIQUE(RollNo)

--use of PRIMARY KEY
--primary key is field which can uniquely identify each row in a table
--only one primary key is allowed in a table
--you may have multiple unique key in a table
--primary key does not allow any null values but UNIQUE KEY can allow NULL value

create table DemoPK
(RollNo int PRIMARY KEY,
Name varchar(100),
Class varchar(100)
)

create table DemoPK_2
(RollNo int UNIQUE,
MobileNo int UNIQUE,
Name varchar(100),
Class varchar(100))

select * from DemoPK_2
INSERT into DemoPK_2(RollNo,MobileNo,Name,Class) values(1,'879876','Saguna','BE')

create table DemoPK_3
(RollNo int PRIMARY KEY,
MobileNo int UNIQUE,
Name varchar(100),
Class varchar(100))

INSERT into DemoPK_3(RollNo,MobileNo,Name,Class) values(1,'879876','Saguna','BE')

---use of CHECK CONSTRAINTS
create table DemoCheck
(RollNo int PRIMARY KEY,
Age int NOT NULL CHECK(Age<=40),
Name varchar(100),
Class varchar(100))

select * from DemoCheck
INSERT into DemoCheck(RollNo,Age,Name,Class) values(1,34,'Saguna','BE')
INSERT into DemoCheck(RollNo,Age,Name,Class) values(1,44,'Saguna','BE')

--use of DEFAULT CONSTRAINTS
--this constraints is used to providea default value for the fields
create table DemoDefault
(RollNo int PRIMARY KEY,
Age int NOT NULL DEFAULT 22,
Name varchar(100),
Class varchar(100))

SELECT * from DemoDefault

INSERT into DemoDefault(RollNo,Age,Name,Class) values(1,'32','Saguna','BE')

--use of FOREIGN KEY 
/*
foreign key is field in table which uniquely identifies each row of another table
tht is this field points to primary key of another table
this usually create a kind of link between two tables
data type of both key must be same
*/

create table studPK
(
RollNo int Primary key
)

select * from studPK

create table studMarksFK
(RollNo int,
Math int,
Science int,
FOREIGN KEY(RollNo) REFERENCES StudPK(RollNo)
)

select * from studMarksFK

insert into studPK(RollNo) values(1)
insert into studPK(RollNo) values(2)

insert into studMarksFK(RollNo,Math,Science) values(1,45,67)
insert into studMarksFK(RollNo,Math,Science) values(2,45,67)

delete from studPK where RollNo=1
delete from studMarksFK where RollNo=1

--use of TABLE LEVEL CONSTRAINTS
--Constraints can be specified for groups of columns as part of table
create table DemoTableLevel
(RollNo int,
MobileNo int,
Name varchar(100),
Class varchar(100),
CONSTRAINT Roll_Mobile_Unique UNIQUE(RollNo,MobileNo))

INSERT into DemoTableLevel(RollNo,MobileNo,Name,Class) values(1,'879876','Saguna','BE')
INSERT into DemoTableLevel(RollNo,MobileNo,Name,Class) values(2,'879876','Saguna','BE')
INSERT into DemoTableLevel(RollNo,MobileNo,Name,Class) values(1,'999999','Saguna','BE')

select * from DemoTableLevel