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

