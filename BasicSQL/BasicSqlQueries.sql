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
----add record in student table
alter table student add Marks int;
update Student set Marks=89 where Student_Id=1;
update Student set Marks=84 where Student_Id=2;
update Student set Marks=99 where Student_Id=4;
update Student set Marks=77 where Student_Id=5;
update Student set Marks=95 where Student_Id=6;

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
----display the record  firstname and state
select FirstName,State from Student;

select FirstName,LastName,Email from Student;
---using where clause:filtering records 
select * from Student WHERE State='Maharashtra';
---using ORDER BY clause
---display ASC Records(BY DEFAULT)
select * from Student WHERE State='Maharashtra' ORDER BY FirstName;

----Section-2 Sorting data------
----Display Ascending order----
select * from Student order by FirstName;
----display desc
select FirstName,Address from Student order by City desc;
---calculating length by desc
select FirstName,Mobile_No from Student order by LEN(FirstName) desc;
---display 1 and 2 columns
select FirstName,LastName from Student ORDER BY 1,2;

-----Section-3 Limiting rows-----
-----offset fetch----
---OFFSET clause specifies the number of rows to skip before starting to return rows 
select FirstName,Address from Student order by Address,FirstName offset 2 rows
---FETCH clause specifies the number of rows to return after the OFFSET clause has been processed
select FirstName,Address from Student order by Address,FirstName offset 1 row fetch next 5 rows only

-----select top-----
--top specifies the number of rows to be returned
select top 2 FirstName,Address from Student order by Address desc;
---percent indicates returns the first N percentage of rows
select top 50 percent FirstName,Address from Student order by Address desc;

-----Section-4 Filtering data-----
---distinct is used to return only different values
select distinct FirstName from Student order by FirstName;
select DISTINCT City from Student ORDER BY City;

-----WHERE clause is used to filter records
select * from Student where LastName='Shelke';

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 4 ORDER BY Address DESC;

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 1 AND City = 'Pune' ORDER BY Address DESC;

select Student_Id,FirstName,LastName,State from Student WHERE Student_Id = 2 OR City = 'Pune' ORDER BY Address DESC;

---SQL AND, OR and NOT Operators
---AND-display record if all condition separated by AND-true
SELECT * FROM Student WHERE City='Pune' AND City='Pune';
---OR-display record if all condition separated by OR-true
SELECT * FROM Student WHERE City='Chennai' OR City='Pune';
---NOT-display record if the condition NOT-true
SELECT * FROM Student WHERE NOT City='Pune';

SELECT * FROM Student WHERE City='Chennai' AND (City='Pune' OR City='Chennai');

SELECT * FROM Student WHERE NOT City='Pune' AND NOT City='Nashik';

---using IN--
---IN operator allows you to specify multiple values in table
SELECT * FROM Student WHERE City IN ('Pune', 'Nashik', 'Chennai');
--NOT IN--
SELECT * FROM Student WHERE City NOT IN ('Pune', 'Nashik', 'Chennai');
----using BETWEEN
--BETWEEN operator selects values within a given range
SELECT * FROM Student WHERE Marks BETWEEN 70 AND 90;
----using LIKE
select FirstName,LastName from Student WHERE FirstName LIKE 'S%' ORDER BY LastName ;

select FirstName,LastName from Student WHERE FirstName LIKE '%a' ORDER BY LastName ;

select FirstName,LastName from Student WHERE FirstName LIKE '%na' ORDER BY LastName ;

select FirstName,LastName from Student WHERE LastName LIKE 'U%e' ORDER BY FirstName ;

------Column and Table Aliases
--Aliases used to give table or column in table temporary name
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
---Alter table--
Alter table Employees ADD Salary bigint;

---insert records in salary column-
insert into Employees(Salary) values (100000);
Update Employees set Salary=500000 where Employee_id=4;
Update Employees set Salary=300000 where Employee_id=3;
Update Employees set Salary=100000 where Employee_id=1;
Update Employees set Salary=200000 where Employee_id=2;
Update Employees set Salary=700000 where Employee_id=5;

---inner join---
--- Retrieves records that have matching values in both tables
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
---cartesian product of the two tables included in the join
SELECT Employee_id,Employee_name, Employee_DOB, Department_Name
FROM Employees CROSS JOIN Departments;

----Self Join
---its regular join but the table is joined with itself
SELECT Employees.Department_ID AS Department_ID, Departments.Department_Name AS Department_ID, Employees.Department_ID
FROM Employees , Departments 
WHERE Employees.Department_ID = Departments.Department_ID
AND Employees.Department_ID= Departments.Department_ID
ORDER BY Employees.Department_ID;

---Section-6 Grouping data
---GROUP BY :- often used with aggregate functions
select City, COUNT (*) from Student WHERE State='Maharashtra' GROUP BY City ORDER BY City;

 ---using the HAVING clause
 ---COUNT
select City, COUNT (*) from Student WHERE State='Maharashtra' GROUP BY City HAVING COUNT (*) > 1 ORDER BY City;
---MAX
SELECT FirstName, MAX(Marks) AS "HighestMarks" FROM Student GROUP BY FirstName HAVING MAX(Marks) > 77;

--Grouping Sets--
select  Marks, count(Student_Id) as 'All students Marks' from Student Group by Marks;
--Cube:-grouping sets with all combinations of the dimension columns
Select Marks, City,State from Student GROUP BY Marks, CUBE(City,State);

-----Section-8 Set Operators----
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


