 --Transaction in SQL
 use DB_Programming

 ---autocommit transaction(by default)
create table PersonTransaction(
Person_Id int primary key,
Name varchar(20),
Monthly_Sal int,
Avg_Sal int,
Address varchar(20)
);

----insert row in table
insert into PersonTransaction(Person_Id,Name,Monthly_Sal,Avg_Sal,Address) values(1,'Saguna',30000,29000,'Pune');
insert into PersonTransaction(Person_Id,Name,Monthly_Sal,Avg_Sal,Address) values(2,'Pallavi',10000,21100,'Chennai');
insert into PersonTransaction(Person_Id,Name,Monthly_Sal,Avg_Sal,Address) values(3,'Amruta',4000,20000,'Nashik');
insert into PersonTransaction(Person_Id,Name,Monthly_Sal,Avg_Sal,Address) values(4,'Priyanka',20000,12000,'Mumbai');
insert into PersonTransaction(Person_Id,Name,Monthly_Sal,Avg_Sal,Address) values(5,'Gaytri',33000,21300,'Delhi');

select * from PersonTransaction;

update PersonTransaction set Name='Ganesh' where Person_Id=1;
delete from PersonTransaction where Person_Id=1;
--how much transaction in current time
select @@TRANCOUNT

--Implicit transaction
select * from PersonTransaction;

SET IMPLICIT_TRANSACTIONS ON 
UPDATE 
    PersonTransaction
SET 
    name = 'Amruta', 
   Address = 'Nashik' 
WHERE 
    Person_Id = 3
SELECT 
    IIF(@@OPTIONS & 2 = 2, 
    'Implicit Transaction Mode ON', 
    'Implicit Transaction Mode OFF'
    ) AS 'Transaction Mode' 
SELECT 
---- @@TRANCOUNT function returns the number of BEGIN TRANSACTION statements in the current session 
    @@TRANCOUNT AS OpenTransactions 
COMMIT TRAN 
SELECT 
    @@TRANCOUNT AS OpenTransactions

----Explicit Transaction in SQL Server
---change the name of a particular row in table
BEGIN TRAN
 UPDATE PersonTransaction
SET  Name = 'Raghav', 
     Address = 'Delhi' 
WHERE  Person_id =5
 
SELECT @@TRANCOUNT AS OpenTransactions

---commit transaction
--data changes to the database and the changed data will become permanent
BEGIN TRAN
UPDATE PersonTransaction
SET  Name = 'Raghav', 
     Address = 'Delhi' 
WHERE  Person_id =5
SELECT @@TRANCOUNT AS OpenTransactions 
COMMIT TRAN 
SELECT @@TRANCOUNT AS OpenTransactions

---Rollback transaction
-- all data modifications that are applied by the transaction
--change a particular row but this data modification will not persist
BEGIN TRAN
UPDATE PersonTransaction
SET  Name = 'Raghav', 
     Address = 'Delhi' 
WHERE  Person_id =5
SELECT * FROM PersonTransaction WHERE Person_Id=2
 
ROLLBACK TRAN 
 
SELECT * FROM PersonTransaction WHERE Person_Id=2

---Save Points in Transactions
/*Savepoints can be used to rollback any particular part of the 
transaction rather than the entire transaction*/
BEGIN TRANSACTION 
INSERT INTO PersonTransaction 
VALUES(1, 'Ganesh',55500 ,51000,'New Delhi')
SAVE TRANSACTION InsertStatement
DELETE PersonTransaction WHERE Person_Id=1
SELECT * FROM PersonTransaction 
-- insert statement will be committed and the delete statement will be rolled back
ROLLBACK TRANSACTION InsertStatement
COMMIT
SELECT * FROM PersonTransaction