create database Practice;

create table Student(
S_id int primary key identity,
Name varchar(100),
Class varchar(100),
City varchar(100),
State varchar(100),
Email varchar(100),
MobileNo bigint,
DOB date,
Age int);

select * from Student

insert into Student values('Saguna','BE','Pune','Maharashtra','Sagunauka123@gmail.com',5689741254,'01/09/1998',24);
insert into Student values('Amruta','ME','Nashik','Maharashtra','Amruta34@gmail.com',7845123698,'03/07/1990',45);
insert into Student values('Vaishnavi','Diploma','Kolhapur','Maharashtra','Vaishnavi11@gmail.com',2314567843,'05/03/1997',22);
insert into Student values('Rani','BSC','Yeola','Maharashtra','Rani987@gmail.com',9876543210,'07/01/1992',15);
insert into Student values('Kartiki','Pharmcy','Sangli','Maharashtra','Kartiki546@gmail.com',9809876545,'03/04/1994',98);

--Add column
alter table Student Add Address varchar(100);

---Update data in table
UPDATE Student
SET Name = 'Saguna', Address= 'Pune'
WHERE S_id = 1;

--drop column
alter table Student drop column Address;

select Name + ' ' + Email AS 'Name And Email' from Student ORDER BY Name;