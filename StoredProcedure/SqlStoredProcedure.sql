----existing database-----
use DB_Programming;
Select * from Student;
Select * from Employees;
Select * from Departments;
------Section-1 Create Stored Procedures----------
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
select *from Employees
select *from Departments
GO;
EXEC SelectAllTable
-----Alter Stored Procedure--
ALTER PROCEDURE SelectAllStudents
 AS
BEGIN
SELECT 
FirstName, 
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
select Student_Id, FirstName, LastName, Address, City from Student   
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
    SELECT * FROM Student WHERE Student_Id= @Student_Id
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
CREATE PROCEDURE AllStuds @City nvarchar(30), @Address nvarchar(10)
AS
SELECT * FROM Student WHERE City = @City AND @Address = @Address
GO
---execute store procedure
EXEC AllStuds @City = 'Pune', @Address = 'Shivane';

-----Update Stored procedure----
Create procedure UpdateStudent     
( @FirstName VARCHAR(255),    
  @LastName VARCHAR(255)  
)     
as     
begin     
Update Student      
set FirstName=@FirstName,     
    LastName=@LastName        
	where Student_Id=2
End
----Execute stored procedure
EXEC UpdateStudent @FirstName = 'Saguna',@LastName = 'Ukade';

----Stored Procedure to delete a Student Record---------------------
Create procedure DeleteStudent   
(     
 @Student_id int     
)     
as      
begin     
Delete from Student where Student_Id=@Student_id     
End
----Execute stored procedure
EXEC DeleteStudent @Student_Id=3;
Select * from Student;

------Rename Table Name 
EXEC sp_rename 'Employees', 'Employee'
select * from Employee;

------Variables
DECLARE @Marks bigint;
SET @Marks = 99;
SELECT FirstName, LastName, City FROM  Student
WHERE Marks = @Marks
ORDER BY FirstName;

----Output Parameters
create procedure spGetStudentByCity
@City varchar (255),
---output parameter is return value
@Student_Count int output
as
begin
select @Student_Count=count(Student_id) from Student
where City=@City
end

----declare variable for catch value Student_count
declare @TotalStudent int
EXEC spGetStudentByCity 'Pune' 
select @TotalStudent As StudentCity; 

----Section-2 Control-of-flow statements
---BEGIN END--
----If statements
BEGIN 
SELECT Salary from Employees where Employee_id='1'
IF @@ROWCOUNT=0
   PRINT 'No Employee found with 220000 salary';
END

----IF Statement
BEGIN 
SELECT Salary from Employee where Employee_id='1'
IF @@ROWCOUNT=0
   PRINT 'No Employee found with 220000 salary';
END
BEGIN
SELECT Department_Name FROM Departments WHERE Department_Name='Human Resources'
IF @@TEXTSIZE != 0
	PRINT 'found departname Name'
END

---IF Else----
DECLARE @Marks int;
BEGIN 
select @Marks =count(student_id)
from Student
END
IF @Marks<75
BEGIN
	Print 'Highest marks'
END
ELSE
BEGIN
	PRINT 'Lowest marks'
END

----WHILE 
DECLARE @counter INT = 1;
WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END
----While loop
DECLARE @Marks int;
BEGIN 
select @Marks =count(Student_Id)
from Student
END
While @Marks<=60
BEGIN 
	SET @Marks=@Marks+20;
	PRINT @Marks;
	IF(@Marks = 20)
	BREAK;
END

---Break statement
DECLARE @Marks int;
BEGIN 
select @Marks =count(Student_Id)
from Student
END
While @Marks<=60
BEGIN 
	SET @Marks=@Marks+20;
	PRINT @Marks;
	IF(@Marks = 20)
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
DECLARE @Marks int;
BEGIN 
select @Marks =count(Student_Id)
from Student
END
While @Marks<=60
BEGIN 
	SET @Marks=@Marks+20;
	PRINT @Marks;
	IF(@Marks = 20)
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

---Section-4 Handling Exceptions
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
from Employee
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



 