Select * from Student

--Using the SQL Server CREATE INDEX statement to create a nonclustered index for one column 
SELECT Student_Id, City FROM Student WHERE City = 'Pune';

--create index
CREATE INDEX ix_Student_city ON Student(City);

--Using SQL Server CREATE INDEX statement to create a nonclustered index for multiple columns 
SELECT Student_id, FirstName, LastName
FROM  Student
WHERE LastName = 'Ukade' AND FirstName = 'Ganesh';

--- create a nonclustered index that includes both last_name and first_name columns
CREATE INDEX ix_Student_name 
ON Student(LastName, FirstName);

--- finds Students whose last name is Ukade
SELECT Student_id, FirstName, LastName
FROM  Student
WHERE LastName = 'Ukade';

---Renaming an index using the system stored procedure sp_rename
EXEC sp_rename 
        @objname = N'Student.ix_Stud_city',
        @newname = N'ix_Stud_city' ,
        @objtype = N'INDEX';

---Creating a SQL Server unique index for one column 
SELECT
    Student_Id, 
    Email 
FROM
    Student
WHERE 
    email = 'Pallesh02@gmail.com';

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
ALTER INDEX ix_Stud_city 
ON Student
DISABLE;

--display firstname lastname based on where condition
SELECT FirstName,LastName, city
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
DROP INDEX IF EXISTS ix_Stud_email
ON Student;






