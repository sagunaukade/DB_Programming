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

select FirstName,LastName,Email from Student;
---using where clause
select * from Student WHERE State='Maharashtra';
---using ORDER BY clause
select * from Student WHERE State='Maharashtra' ORDER BY FirstName;
---using the GROUP BY clause
select City, COUNT (*) from Student WHERE State='Maharashtra' GROUP BY City ORDER BY City;
---using the HAVING clause
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
---distinct is used to return only different values
select distinct FirstName from Student order by FirstName;
select DISTINCT City from Student ORDER BY City;

-----WHERE clause is used to filter records
select * from Student where LastName='Shelke';

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 3 ORDER BY Address DESC;

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 1 AND City = 'Pune' ORDER BY Address DESC;

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 2 OR City = 'Pune' ORDER BY Address DESC;

---SQL AND, OR and NOT Operators
SELECT * FROM Student WHERE City='Pune' AND City='Pune';

SELECT * FROM Student WHERE City='Chennai' OR City='Pune';

SELECT * FROM Student WHERE NOT City='Pune';

SELECT * FROM Student WHERE City='Pune' AND (City='Pune' OR City='Chennai');

SELECT * FROM Student WHERE NOT City='Pune' AND NOT City='Nashik';

----using LIKE
select FirstName,LastName from Student WHERE FirstName LIKE 'S%' ORDER BY LastName ;

select FirstName,LastName from Student WHERE FirstName LIKE '%a' ORDER BY LastName ;

select FirstName,LastName from Student WHERE FirstName LIKE '%na' ORDER BY LastName ;

select FirstName,LastName from Student WHERE LastName LIKE 'j%v' ORDER BY FirstName ;

------Column and Table Aliases
select FirstName + ' ' + LastName AS 'Full Name' from Student ORDER BY FirstName;

SELECT FirstName AS Name, LastName AS [Both Name] FROM Student;

-----Section-5 Joining tables--------
----create employee table--
CREATE TABLE Employees(
Employee_id int, 
Employee_name varchar(250),
 Employee_DOB date, 
 Department_ID int);

 ----create department table
 CREATE TABLE Departments(
 Department_id int,
 Department_Name varchar(250));

 -- Insert values into departments table
INSERT INTO Departments(Department_id,Department_Name)
VALUES(1,'Human Resources'),
(2,'Development'), 
(3,'Sales'),
(4, 'Technical Support');
 
 select * from Departments;

-- Insert values into employees table
INSERT INTO Employees(Employee_id,Employee_name, Employee_DOB,Department_ID)
VALUES (1,'Saguna Ukade','1997-01-01',1),
       (2,'Amruta Jadhav','1990-01-01',1),
       (3,'Raghav Shelke','1999-01-01',2),
       (4,'Pallavi Pawar','1979-01-01',3),
       (5,'Rudra Pawar','1986-01-01',4);  

select * from Employees;

---inner join----
SELECT Employee_id,Employee_name, Employee_DOB, Department_Name
FROM Departments INNER JOIN Employees
ON Departments.Department_id = Employees.Department_ID;

----left join----
SELECT Employee_id,Employee_name, Employee_DOB, Department_Name
FROM Employees LEFT JOIN Departments
ON Departments.Department_id = Employees.Department_ID;

----right join---
SELECT Employee_id,Employee_name, Employee_DOB, Department_Name
FROM Employees RIGHT JOIN Departments
ON Departments.Department_id = Employees.Department_ID;

-----cross join---
SELECT Employee_id,Employee_name, Employee_DOB, Department_Name
FROM Employees CROSS JOIN Departments;
 
-----Set Operators----
---Union:combine the row data vertically---
SELECT Department_ID FROM Employees
UNION
SELECT Department_id FROM Departments
ORDER BY Department_ID;
----Union All---
SELECT Department_ID FROM Employees
UNION ALL
SELECT Department_id FROM Departments
ORDER BY Department_ID;
----Intersect:returns the intercetion of two queries---
SELECT Department_ID FROM Employees
INTERSECT
SELECT Department_id FROM Departments
ORDER BY Department_ID;
---Except:returns result from first table witch doesnt match ---
SELECT Department_id
FROM Departments
EXCEPT
SELECT Department_id
FROM Employees;


