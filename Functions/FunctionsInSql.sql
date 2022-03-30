---FUNCTIONS IN SQL

use DB_Programming

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
Create function ConvertStudInUppercase(@Student_Id int)   
 returns varchar(50)  
  As   
  Begin  
  --–-Declare the veriable 
Declare @UpperVar varchar(100)    
Select  @UpperVar =   Upper(Student_Name) from DB_Programming.dbo.Student_Marks  where @Student_Id = @Student_Id  
return isnull( @UpperVar , '-')  
 End   

 select dbo.ConvertStudInUppercase(1)  
 select dbo.ConvertStudInUppercase(3)  
 select dbo.ConvertStudInUppercase(5)  
 select dbo.ConvertStudInUppercase(2)  

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

SELECT Student_Name,Department
FROM funStudent(1,21)
ORDER BY Student_name;

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