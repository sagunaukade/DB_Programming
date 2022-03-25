------Section-1 Create Stored Procedures----------
CREATE PROCEDURE SelectAllStudents
AS
BEGIN
SELECT * FROM Student
END
GO

EXEC SelectAllStudents


CREATE PROCEDURE StudentInfo(
   @FirstName varchar(255),
    @LastName varchar(255),
    @Address varchar(255),
    @City varchar(255),
	@State varchar(255),
	@Email varchar(255)
)
As
Begin
Insert Into StudentInfo(FirstName,LastName,Address,City,State,Email)values
('@Saguna','@Ukade','@Shivane','@Pune','@Maharashtra','@sagu11@gmail.com'),
('@Amruta','@Jadhav','@Shivajinagar','@Pune','@Maharashtra','@amrutaj21@gmail.com'),
('@Vaishnavi','@Shelke','@Kothrud','@Pune','@Maharashtra','@vaishnavis43@gmail.com'),
('@Sukalyan','@Dash','@Salapada by pass','@Anandapur','@Andhraprdesh','@sukalyand76@gmail.com'),
('@Suraj','@Garud','@Hadpsar','@Pune','@Maharashtra','@surag2343@gmail.com'),
('@Raghav','@Kulkarni','@Chandsi','@Nashik','@Maharashtra','@raghav123@gmail.com')
End
EXEC StudentInfo;

-------Stored Procedure With One Parameter----
CREATE PROCEDURE spAllStudents @City varchar(10)
AS
SELECT * FROM Student WHERE City = @City
GO

EXEC spAllStudents @City = 'Chennai';

------Stored Procedure With Multiple Parameters-----
CREATE PROCEDURE sp_AllStudents @City varchar(30), @State varchar(10)
AS
SELECT * FROM Student WHERE City = @City AND State = @State
GO
EXEC sp_AllStudents @City = 'Pune', @State = 'Maharashtra';

Create procedure SPGetAllStudents   
as   
Begin   
 select
    FirstName ,
    LastName ,
    Address,
    City ,
	State ,
	Email
    from StudentInfo 
End

EXEC SPGetAllStudents

-----Stored Procedure to get a single Student Records---
Create procedure spSelectAllStudents
(    
    @City varchar(255)
)    
as     
Begin     
    SELECT * FROM SelectAllStudents WHERE City= @City
End
EXEC spSelectAllStudents

-----Alter Stored Procedure-----
alter proc SelectAllStudents
as
begin
select * from Student where Address='Shivane' and City in('Nashik','Pune')
end
go

EXEC spSelectAllStudents

---parameter procedure-----
alter procedure StudentInfo
@Student_Id int,
@city varchar(100)
as
begin
select * from Student where Student_Id=@Student_Id or City=@city
end
go
EXEC StudentInfo

-------Delete stored procedure---

--drop proc ParameterProcedure2

alter proc StudentInfo
@FirstName varchar(100),
@LastName varchar(100)
as
begin
select Mobile_No from Student where @FirstName=@FirstName
select * from Student where Address=@Address
order by Address 
end
go


