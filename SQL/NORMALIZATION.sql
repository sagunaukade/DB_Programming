---NORMALIZATION

SELECT * FROM Employees

--ANOMALY:- NOT PROPERLY WORKING ON INSERT, UPDATE, DELETE

CREATE TABLE EMP(EID INT,
ENAME VARCHAR(10),
DEPTNAME VARCHAR(10))

SELECT * FROM EMP

INSERT INTO EMP VALUES(101,'SAGUNA','DEVELOPER')
INSERT INTO EMP VALUES(101,'PALLAVI','TESTER')
INSERT INTO EMP VALUES(102,'SANIKA','MANAGER')
INSERT INTO EMP VALUES(103,'SAGUNA','HR')

--INSERT
INSERT INTO EMP VALUES(104,'KAJAL')
--DEPTNAME IS DOES NOT ALLOW NULL VALE

--UPDATE
UPDATE EMP SET ENAME='PALLAVI' WHERE EID=103

--DELETE
DELETE Emp WHERE EId=101

--NORMALIZATION TYPES
--FIRST NORMAL FORM :-CANNOT HOLD MULTIPLE VALUES,EACH RECORD B UNIQUE

--SECOND NORMAL FORM:-IT SHOULD B 1NM ALL NON KEY ATTRUBUTE ARE FULLY FUNCTIONAL DEPENDENT ON THE PRIMARY KEY

--THIRD NORMAL FORM:-NO TRANSITIVE FUNCTIONAL DEPENDENCY

--BOYCE-CODD NF:-NO DEPENDENCY ,NO MULTIPLE VALUES

--4NF:-NO MULTIPLE VALUES


---BATCH PROCESSING
