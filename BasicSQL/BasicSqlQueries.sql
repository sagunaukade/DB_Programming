--------Create Database-------
Create Database DB_Programming;

--------Read Operation--------
Use DB_Programming;

--------Create table----------
Create Table Student (
Student_Id int IDENTITY (1,1) PRIMARY KEY,
    FirstName varchar(255),
    LastName varchar(255),
    Address varchar(255),
    City varchar(255),
	State varchar(255),
	Mobile_No Bigint,
	Email varchar(255)
);
select * from Student;

--------Insert Record in Table----
insert into Student(FirstName,LastName,Address,City,State,Mobile_No,Email)values
('Saguna','Ukade','Shivane','Pune','Maharashtra',9123456511,'sagu11@gmail.com'),
('Amruta','Jadhav','Shivajinagar','Pune','Maharashtra',8976543212,'amrutaj21@gmail.com'),
('Vaishnavi','Shelke','Kothrud','Pune','Maharashtra',9876675445,'vaishnavis43@gmail.com'),
('Sukalyan','Dash','Salapada by pass','Anandapur','Andhraprdesh',7869574839,'sukalyand76@gmail.com'),
('Suraj','Garud','Hadpsar','Pune','Maharashtra',9867435223,'surag2343@gmail.com'),
('Raghav','Kulkarni','Chandsi','Nashik','Maharashtra',8976341123,'raghav123@gmail.com');

-------Alter Table------
ALTER TABLE Student
ADD Gender varchar(255);

------Drop Column-------
ALTER TABLE Student
DROP COLUMN Gender;

-----Update data in table------
UPDATE Student
SET FirstName = 'Suraj', City= 'Chennai'
WHERE Student_Id = 5;

----Section-1 Quering data----
----retrieve data from a single table----
select * from Student;
select FirstName,State from Student;
---SQL Server SELECT – retrieve some columns of a table example
select FirstName,LastName,Email from Student;
---sort the result using where clause
select * from Student WHERE State='Maharashtra';
---sort the result set based on one or more columns using ORDER BY clause
select * from Student WHERE State='Maharashtra' ORDER BY FirstName;
---group rows into groups using the GROUP BY clause
select City, COUNT (*) from Student WHERE State='Maharashtra' GROUP BY City ORDER BY City;
--- filter groups based on one or more conditions using the HAVING clause
select City, COUNT (*) from Student WHERE State='Maharashtra' GROUP BY City HAVING COUNT (*) > 1 ORDER BY City;

----Section-2 Sorting data------
----Display Ascending order----
select * from Student order by FirstName;

select FirstName,Address from Student order by City desc;

select FirstName,Mobile_No from Student order by LEN(FirstName) desc;

select FirstName,LastName from Student ORDER BY 1,2;

-----Section-3 Limiting rows-----
-----offset fetch----
select FirstName,Address from Student order by Address,FirstName offset 2 rows
select FirstName,Address from Student order by Address,FirstName offset 1 row fetch next 5 rows only

-----select top-----
select top 5 FirstName,Address from Student order by Address desc;

select top 20 percent FirstName,Address from Student order by Address desc;


-----Section-4 Filtering data-----
---distinct is used to return only distinct (different) values
select distinct FirstName from Student order by FirstName;
select DISTINCT City from Student ORDER BY City;

-----WHERE clause is used to filter records
select * from Student where LastName='Shelke';

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 3 ORDER BY Address DESC;

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 1 AND City = 'Pune' ORDER BY Address DESC;

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 2 OR City = 'Pune' ORDER BY Address DESC;

