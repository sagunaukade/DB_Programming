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

--using aliases
select Name + ' ' + Email AS 'Name And Email' from Student ORDER BY Name;

---create procedure
create procedure SelectAllStudent
as
select * from Student
go

EXEC SelectAllStudent

--store procedure with one parameter
create procedure SelectAllStudents
@city varchar(100)
as
select * from Student
where city =@city
go

EXEC SelectAllStudents @city='Pune';

--store procedure with multiple parameter
create procedure SelectAllStud
@city varchar(100) , @name varchar(100)
as
select * from Student
where
@city=city and @name=name
go

Exec SelectAllStud @city='Nashik' , @name =Amruta;

---create procedure
create procedure sp_GetStudent
as 
begin
select * from Student order by name
end 
go

exec sp_GetStudent

create procedure sp_GetStudRecord
@s_id int
as 
begin
set nocount on
select * from Student
where @s_id=s_id
end 

exec sp_GetStudRecord @s_id=3;

--update procedure
create procedure sp_UpdateStudent
@S_id int,
@Name varchar(100),
@Class varchar(100),
@Email Varchar(100),
@MobileNo bigint
as
set nocount on
if(@S_id=0)
begin
insert into student (Name,Class,Email,MobileNo) values(@Name,@Class,@Email,@MobileNo)
end
else
begin
update Student set Name=@Name,
Class=@Class,
Email=@Email,
MobileNo=@Email
where S_id=@S_id
end

sp_helptext "sp_UpdateStudent"

--drop procedure
drop procedure sp_UpdateStudent

---loop in stored procedured
create procedure sp_loop
as
begin
set nocount on
truncate table student
declare @n int =1
while @n<45
begin 
insert into student (S_id,City) values(1,'Pune')
select @n=@n+1
end
end

SELECT SERVERPROPERTY('ErrorLogFileName') AS 'Error log file location'

---create view
create view v_student
as
select s_id Name,Class,City,Age from Student
where age>30;

select * from v_student

---update view
create view V_updateStud
as
select s_id,name,class,Age from student
where name='Saguna';

select * from V_updateStud

---insert view
insert into v_student(name,class,city,age)values('Archna','Msc','Nashik',22)

delete from V_student where Age=22

--drop view
drop view v_student

---row level view
create view RowLevel
as
select * from Student where Age>40

select * from RowLevel

---column level view
create view ColumnLevel
As
select * from Student where Age<40

select * from ColumnLevel

---using with check option
create view WithCheckOption
as
select * from Student where city='Pune'
with check option

select * from WithCheckOption

select * from Student;


---CURSOR IN SQL
----create table
create table Student_Marks(
Student_id int IDENTITY(1,1) not null primary key,
Student_name varchar(100) not null,
department varchar(50) not null,
total_Marks int not null,
Age int not null,
Percentage int not null,
);

select * from Student_Marks;

---insert record in table
insert into Student_Marks(Student_name,department,total_Marks,Age,Percentage)
values('Saguna','IT',98,23,86),
      ('Amruta','CSE',95,19,76),
	  ('Vaishnavi','CIVIL',78,21,96),
	  ('Lavanya','IT',78,21,77),
	  ('Archna','Mech',79,20,70),
	  ('Arush','IT',99,19,97);

--update record
update Student_Marks set total_Marks=90 where Student_id=5;

---declare variables
declare @Student_id int,
@Student_name varchar(100),
@Total_marks int,
@Age int,
@Percentage int
declare
@Attendance int

--declare cursor
declare Student_cursor cursor for select Student_id,Student_name,Total_marks,Age,Percentage from Student_Marks

--open the cursor
open Student_cursor;

----fetch record from the cursor into the variables
fetch next from Student_cursor into @Student_id, @Student_name, @Total_marks, @Age, @Percentage

---loop until records are availables
while @@FETCH_STATUS=0
begin
	print concat('Student Name:- ', @Student_name);
	print concat('Student Id:- ', @Student_id);
	print concat('Total Marks:- ', @Total_marks);
	print concat('Age:- ', @Age);
	print concat('Percentage:- ', @Percentage);

---this statement increments the attendance variable
	set @Attendance=@Percentage*100;

	print concat ('Attendance:- ', @Attendance);
	if @Attendance > 75
	begin
	print 'Attendance: Good';
	end
	else if @Attendance > 60 and  @Attendance <75
	begin
	print 'Attendance: Average';
	end
	else 
	begin
	print 'Attendance: Below Average';
	end
	print '=======*********=======';
---this statement fetch the next record into the variables
	fetch next from Student_cursor into @Student_id, @Student_name, @Total_Marks, @Age, @Percentage
	end
---close the cursor
	close Student_cursor;
---deallocate the cursor
	deallocate Student_cursor;

---	FUNCTIONS IN SQL
--USER DEFINED FUNCTIONS
create function AddDigit (@num1 int,@Num2 int)
returns int
as
begin
declare @result int;
set @result=@num1+@Num2;
return @result
End

select dbo.AddDigit(12,7)

---SCALER FUNCTIONS
--RETURN SINGLE VALUE
select * from Student_Marks

CREATE FUNCTION Weekdays(@Day varchar) 
----in which datatype you will accept/return output  
RETURNS INT  
AS BEGIN  
        IF(@Day IS NULL)  
            RETURN 0;  
           --------Declare the veriable
            DECLARE @Output INT 
            --Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday   
            SELECT @Output =   
                CASE WHEN SUBSTRING(@Day, 1,1) = 'M' THEN  1   
                     WHEN SUBSTRING(@Day, 1,1) = 'Tu' THEN 2   
                     WHEN SUBSTRING(@Day, 1,1) = 'W' THEN  3   
                     WHEN SUBSTRING(@Day, 1,1) = 'Th' THEN  4   
                     WHEN SUBSTRING(@Day, 1,1) = 'F' THEN  5    
                     WHEN SUBSTRING(@Day, 1,1) = 'Sa' THEN  6   
                     WHEN SUBSTRING(@Day, 1,1) = 'Su' THEN  7   
                ELSE  
                    99 END  
          RETURN @Output;     
END  

PRINT dbo.Weekdays('Monday')  
PRINT dbo.Weekdays('Friday')  
PRINT dbo.Weekdays('Saguna')  
declare @datetime datetime = getdate()  
print @datetime

--Scalar valued function
Create function ConvertStudentInUppercase(@Student_Id int)   
 returns varchar(50)  
  As   
  Begin  
  ---Declare the veriable 
Declare @UpperVar varchar(100)    
Select  @UpperVar =   Upper(Student_Name) from Practice.dbo.Student_Marks  where @Student_Id = @Student_Id  
return isnull( @UpperVar , '-')  
 End   

 select dbo.ConvertStudentInUppercase(1)  
 select dbo.ConvertStudentInUppercase(3)  
 select dbo.ConvertStudentInUppercase(5)  
 select dbo.ConvertStudentInUppercase(2)  

 ---Table Value Function
 CREATE FUNCTION funStudent ( @Student_id INT)
RETURNS TABLE
AS
RETURN
SELECT Student_Name,Department,Age
FROM Student_Marks
WHERE Student_id = @Student_id;

Select * from funStudent(3)

--Modifying a table-valued function
ALTER FUNCTION funStudent ( 
@Student_id INT,
@Age INT
)
RETURNS TABLE
AS
RETURN SELECT 
        Student_Name,
        Department from
        Student_Marks
    WHERE
       Student_name BETWEEN @Student_id AND @Age

SELECT Student_Name,department
FROM funStudent(1,21)
ORDER BY department;

---SYSTEM DEFINED FUNCTIONS
---Numeric Functions
	select max(total_Marks) as total_Marks from Student_Marks 
	select min(total_Marks) as total_Marks from Student_Marks 
	select sum(total_Marks) as total_Marks from Student_Marks 

---store data using a function and display that stored data
create function funPrintNumber()  
returns decimal(7,2)  
as  
begin  
    return 1000.13  
end  

print dbo.funPrintNumber()  

---two number Addition
CREATE FUNCTION funAddition(@Num1 Decimal(7,2),  @Num2 Decimal(7,2))  
RETURNS Decimal(7,2)  
Begin  
    DECLARE @Result Decimal(7,2)  
    SET @Result = @Num1 + @Num2  
    RETURN @Result  
end   

print dbo.funAddition(12,13)
  
--STRING FUNCTIONS
--simple string concatenation
SELECT CONCAT('Hi, ', 'I AM ', 'Saguna Ukade' )
--Example of other Data type concatenation with string
SELECT CONCAT('Date : ', CAST(GETDATE() AS DATE));
--simple FORMAT string function
DECLARE @mydate DATETIME = '03/22/2022';
SELECT FORMAT ( @mydate, 'd', 'en-US' ) AS 'US Format',FORMAT ( @mydate, 'd', 'en-gb' ) AS 'GB Format'

--custom formatting string
DECLARE @mydate DATETIME = '03/22/2022';
SELECT FORMAT ( @mydate, 'dd/MM/yyyy', 'en-US' )

---using TRY_CAST
SELECT TRY_CAST('10.25' AS FLOAT)

--Simple PARSE example with Date time
SELECT PARSE('Monday, 7 March 2022' AS datetime2 USING 'en-US')

---- Using CAST Function
SELECT CAST('3/03/2022' AS DATETIME2) AS  [CAST Function Result  ]

-----Using Try_Convert Function
SELECT TRY_CONVERT(Datetime2, '3/03/2022') AS [Try_Convert Function Result] 
GO

---DATE FUNCTIONS
---returns the current date and time
SELECT CURRENT_TIMESTAMP;

---Add two months to a date, then return the date
SELECT DATEADD(month, 2, '3/03/2022') AS DateAdd;

SELECT DAY('3/03/2022') AS DayOfMonth;

SELECT SYSDATETIME() AS SysDateTime;

SELECT YEAR('3/03/2022') AS Year;
--advanced functions
SELECT ISNULL(NULL, 'Saguna Ukade');
SELECT CURRENT_USER;
SELECT SYSTEM_USER;

----Create inline function
create function funStudentMarks(@Percentage int)
returns table
as
return select * from Student_Marks where total_Marks > @Percentage;

select * from funStudentMarks(82);

create function fnStud(@Student_id int)
returns table
as
return select * from Student_marks where @Student_id = Student_id

select * from dbo.fnStud(3)

--DROP FUNCTION
drop function if exists fnStud;