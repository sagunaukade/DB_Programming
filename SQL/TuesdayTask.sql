use DB_PROGRAMMING

select * from Student

select * from StudDetails

select * from Employee

select * from Department

---Stored procedure is stored sql queries 
CREATE PROCEDURE SelectAllStudents
AS
select *from Student
GO;
--execute store procedure---
EXEC SelectAllStudents

--display all tables using stored procedure
CREATE PROCEDURE SelectAllTable
AS
select *from Student
select *from Employee
select *from Department
GO;
EXEC SelectAllTable
-----Alter Stored Procedure--
ALTER PROCEDURE SelectAllStudents
 AS
BEGIN
SELECT 
Name, 
City
FROM Student
ORDER BY City
END;
---execute store procedure
EXEC SelectAllStudents;
---Create Table--
Create table PersonDetail(   
Person_Id int IDENTITY(1,1) NOT NULL,   
Name varchar(20) NOT NULL,   
City varchar(20) NOT NULL,   
Country varchar(20) NOT NULL,   
Gender varchar(6) NOT NULL  
)
select * from PersonDetail;

-----Stored Procedure to insert a PersonDetails Record
create procedure spGetPersonDetail
(@Name VARCHAR(20),    
 @City VARCHAR(20),   
 @Country VARCHAR(20),   
 @Gender VARCHAR(6)   
)   
as    
Begin    
Insert into PersonDetail(Name,City,Country, Gender) Values (@Name,@City,@Country, @Gender)    
End
---execute stored procedure
EXEC spGetPersonDetail @Name='@Name', @City='@city', @Country='@Country', @Gender='@gender';
SELECT * FROM PersonDetail;

---Stored Procedure to view all Student Records
Create procedure spGetAllStudent   
as   
Begin   
select S_Id, Name, Email, City from Student   
End
---execute procedure
EXEC spGetAllStudent
select * from Student;

---Stored Procedure to get a single Student Records
Create procedure spGetStudentById
(    
    @Student_Id int
)    
as     
Begin     
    SELECT * FROM Student WHERE S_Id= @Student_Id
End
---execute procedure
EXEC spGetStudentById 4;

-----Stored Procedure With One Parameter
CREATE PROCEDURE AllStud @City nvarchar(30)
AS
SELECT * FROM Student WHERE City = @City
GO
---execute store procedure
EXEC AllStud @City = 'Nashik';

----Stored Procedure With Multiple Parameters
CREATE PROCEDURE AllStuds @City nvarchar(30), @state nvarchar(10)
AS
SELECT * FROM Student WHERE City = @City AND State = @state
GO
---execute store procedure
EXEC AllStuds @City = 'Pune', @State = 'Maharashtra';

-----Update Stored procedure----
Create procedure UpdateStudent     
( @Name VARCHAR(255),    
  @City VARCHAR(255)  
)     
as     
begin     
Update Student      
set Name=@Name,     
    City=@City        
	where S_Id=2
End
----Execute stored procedure
EXEC UpdateStudent @Name = 'Saguna',@city = 'Kolhapur';

----Stored Procedure to delete a Student Record---------------------
Create procedure DeleteStudent   
(     
 @S_id int     
)     
as      
begin     
Delete from Student where S_Id=@S_id     
End
----Execute stored procedure
EXEC DeleteStudent @S_Id=4;
Select * from Student;

------Rename Table Name 
EXEC sp_rename 'Employee', 'Employees'
select * from Employees;

------Variables
DECLARE @AGE int;
SET @age = 34;
SELECT Name, Email, City FROM  Student
WHERE age = @age
ORDER BY Name;

----Output Parameters
create procedure spGetStudentByCity
@City varchar (255),
---output parameter is return value
@Student_Count int output
as
begin
select @Student_Count=count(S_id) from Student
where City=@City
end

----declare variable for catch value Student_count
declare @TotalStudent int
EXEC spGetStudentByCity 'Pune' 
select @TotalStudent As StudentCity; 

---Control-of-flow statements
---BEGIN END--
----If statements
BEGIN 
SELECT Salary from Employees where Emp_id='1'
IF @@ROWCOUNT=0
   PRINT 'No Employee found with 220000 salary';
END

----IF Statement
BEGIN 
SELECT Salary from EmployeeS where Emp_id='1'
IF @@ROWCOUNT=0
   PRINT 'No Employee found with 220000 salary';
END
BEGIN
SELECT DepT_Name FROM Department WHERE DepT_Name='Hr'
IF @@TEXTSIZE != 0
	PRINT 'found departname Name'
END
SELECT * FROM Department

---IF Else----
DECLARE @Age int;
BEGIN 
select @Age =count(s_id)
from Student
END
IF @Age<20
BEGIN
	Print 'Highest Age'
END
ELSE
BEGIN
	PRINT 'Lowest Age'
END

----WHILE 
DECLARE @counter INT = 1;
WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END
----While loop
DECLARE @Age int;
BEGIN 
select @Age =count(S_Id)
from Student
END
While @Age<=32
BEGIN 
	SET @Age=@Age+20;
	PRINT @Age;
	IF(@Age = 20)
	BREAK;
END

---Break statement
DECLARE @Age int;
BEGIN 
select @Age =count(S_Id)
from Student
END
While @Age<=60
BEGIN 
	SET @Age=@Age+20;
	PRINT @Age;
	IF(@Age = 20)
	BREAK;
END

---Continue
DECLARE @Number INT = 0;
WHILE @Number < 5
BEGIN
    SET @Number = @Number + 1;
    IF @Number = 3
        CONTINUE;	
    PRINT @Number;
END
---Continue
DECLARE @Age int;
BEGIN 
select @Age =count(S_Id)
from Student
END
While @Age<=60
BEGIN 
	SET @Age=@Age+20;
	PRINT @Age;
	IF(@Age = 20)
	CONTINUE;
END

----WHILE Loop with CONTINUE and BREAK statements
DECLARE @Number INT
SET @Number = 1
WHILE (@Number <=5)
BEGIN
PRINT @Number
SET @Number = @Number + 1
CONTINUE;
--IF @Number = 4 -- This will never executed
--BREAK;
END
GO

---Handling Exceptions
---try Catch
BEGIN TRY
	SELECT 10/0 AS Result;
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS [Error Message]
	      ,ERROR_LINE() AS ErrorLine
	      ,ERROR_NUMBER() AS [Error Number]  
              ,ERROR_SEVERITY() AS [Error Severity]  
              ,ERROR_STATE() AS [Error State]  
END CATCH

----using catch
DECLARE @A int;
BEGIN 
select @A =count(Salary)
from Employees
END
BEGIN TRY
	SET @A = @A/0; 
END TRY
BEGIN CATCH
SELECT
 ERROR_MESSAGE()
END CATCH

----RAISERROR
EXEC sp_addmessage 
    @msgnum = 50001, 
    @severity = 1, 
    @msgtext = 'this is a custom error message';

SELECt * FROM sys.messages WHERE message_id = 50001;

RAISERROR ( 50001,1,1)

EXEC sp_dropmessage @msgnum = 50001;  

----Using THROW 
---Using THROW statement to raise an exception
THROW 50005, 'An error occurred', 1;
----Create table t1
 CREATE TABLE t1(
    id int primary key
);
----using THROW statement without arguments in the CATCH block to rethrow caught error
BEGIN TRY
    INSERT INTO t1(id) VALUES(1);
    --  cause error
    INSERT INTO t1(id) VALUES(1);
END TRY
BEGIN CATCH
    PRINT('Raise the caught error again');
    THROW;
END CATCH

Select * from t1;

----Indexes
Select * from Student

--Using the SQL Server CREATE INDEX statement to create a nonclustered index for one column 
SELECT S_Id, City FROM Student WHERE City = 'Pune';

--create index
CREATE INDEX ix_Student_city ON Student(City);

--Using SQL Server CREATE INDEX statement to create a nonclustered index for multiple columns 
SELECT S_id, Name
FROM  Student
WHERE Name = 'Saguna' AND Email = 'Sagunauka123@gmail.com';

--- create a nonclustered index that includes both last_name and first_name columns
CREATE INDEX ix_Student_name 
ON Student(Name, City);

--- finds Students whose last name is Ukade
SELECT S_id, Name, City
FROM  Student
WHERE Name = 'Rani';

---Renaming an index using the system stored procedure sp_rename
EXEC sp_rename 
        @objname = N'Student.ix_Student_name',
        @newname = N'ix_Stud_name' ,
        @objtype = N'INDEX';

---Creating a SQL Server unique index for one column 
SELECT
    S_Id, 
    Email 
FROM
    Student
WHERE 
    email = 'Sagunauka123@gmail.com';

--check duplicate values in the email column first
SELECT 
    email, 
    COUNT(email)
FROM 
    Student
GROUP BY 
    email
HAVING 
    COUNT(email) > 1;

---Create unique index
CREATE UNIQUE INDEX ix_Stud_email 
ON Student(email);

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

--SQL Server unique index and NULL
CREATE TABLE t3(
    a INT
);

CREATE UNIQUE INDEX a_uniq_t3
ON t3(a);

---inserts NULL into the a column of the t3 table
INSERT INTO t3(a) VALUES(NULL);

--Disabling an index 
ALTER INDEX ix_Student_name
ON Student
DISABLE;

--display firstname lastname based on where condition
SELECT Name,Email, city
FROM  Student
WHERE city = 'Nashik';

---Disabling all indexes of a table 
ALTER INDEX ALL ON Student
DISABLE;

select * from Student

---Enable indexes 
ALTER INDEX ALL ON Student
REBUILD;

---drop index
DROP INDEX IF EXISTS ix_Student_name
ON Student;

----SUB QUERIES
SELECT * FROM Student
select * from StudDetails
alter table studdetails add age int
update StudDetails set age=32 where RollNo=102
update StudDetails set age=22 where RollNo=101
update StudDetails set age=21 where RollNo=103

---SQL query returns the record of those students whose marks are greater than the average of age
SELECT * FROM Student WHERE AGE> ( SELECT AVG(AGE ) FROM Student);  

-- IN operator with the subquery
SELECT * FROM Student WHERE s_ID IN (   
SELECT s_ID FROM Student WHERE City = 'Pune' OR City = 'Kolhaour' );

--Subquery with the INSERT statement
INSERT INTO Student SELECT * FROM StudDetails WHERE Age > 22;  

--Subquery with the UPDATE statement
UPDATE Student SET Age = Age + 10 WHERE S_ID IN ( SELECT S_ID FROM Student WHERE NAME = 'VAISHNAVI' );  

--Subquery with the UPDATE statement
DELETE FROM Student WHERE S_ID IN ( SELECT S_ID FROM Student WHERE NAME = 'KARTIKI' );  