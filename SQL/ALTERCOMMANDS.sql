--DDL COMMANDS
--CREATE ,ALTER ,DROP,SP_RENAME,TRUNCATE
--ALTER COLUMN
ALTER TABLE STUDENT ALTER COLUMN STATE VARCHAR(50)

---ADD COLUMN
ALTER TABLE STUDENT ADD LASTNAME VARCHAR(20)

--RENAME COLUMN
SP_RENAME 'STUDENT.NAME','FIRSTNAME';

--DROP COLUMN
ALTER TABLE STUDENT DROP COLUMN LASTNAME

--RENAME TABLE NAME
SP_RENAME 'EMPLOYEES','EMPLOYEE'

SELECT * FROM Employee

TRUNCATE TABLE T1

SELECT * FROM T1