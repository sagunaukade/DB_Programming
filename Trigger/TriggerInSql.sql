----DML TRIGGER
select * from Employee

INSERT INTO Employee(Employee_id,Employee_name, Employee_DOB,Department_ID)
VALUES (7,'Ganesh Ukade','1996-07-01',5)

--create audit table
create table EmployeeAudit
( ID int ,
inserted_by varchar(100)
)

select * from EmployeeAudit

--insert trigger
create trigger trgInsertAudit
on Employee
for insert 
as
begin
declare @ID int
select @ID = employee_id from inserted insert into EmployeeAudit (ID,inserted_by) values (@ID,ORIGINAL_LOGIN())
print 'Insert trigger in SQL'
end
go

---delete trigger
create trigger trgDeleteAudit
on Employee
for delete 
as
begin
declare @ID int
select @ID = employee_id from deleted insert into EmployeeAudit (ID,inserted_by) values (@ID,ORIGINAL_LOGIN())
print 'Delete trigger in SQL'
end
go

delete from Employee where employee_id=4

select * from Employee
select * from EmployeeAudit

---delete trigger
create trigger trgDelete
on Employee
for delete
as
begin
rollback
print 'You cannot delete records from this table'
end 
go

delete from Employee where employee_id=2

---insted of trigger

select * from student
select * from Student_Marks

create view v_Employees
as
select 
a.Student_id,b.Student_name
from Student a inner join Student_Marks b on a.Student_Id=b.Student_id

select * from v_Employees

---DDL event Group
 /*Instead Of Creating New Trigger for All Events
 we can use their predefined Groups to avoid Multiple triggers
 For Table We Have (DDL_TABLE_EVENTS)
 FOR Procedure We have (DDL_PROCEDURE_EVENTS)
 FORFunction We have (DDL_FUNCTIONS_EVENTS)
 */

 create trigger TrgTableUsingEvent
 on Database
 for DDL_TABLE_EVENTS                                    
 as
 begin
 print 'Use of Table Events'
 rollback
 end

 select * from Student

 alter table Student Drop column Marks

 ----server level trigger
 create trigger trgServer
on all server                     
for DDL_TABLE_EVENTS
as
begin
print'Cannot create table as Use of events In server Lavel'
rollback
end

---Audit trigger
create table trgAudit
(
 DatabaseName varchar(255),
 TableName varchar(255),
 EventType varchar(255),
 LoginName varchar(255),
 SQLCommand varchar(255),
 AuditDateTime dateTime
)

---audit trigger
alter trigger trg_Audit
on All server                                      
for DDL_TABLE_EVENTS
as
begin
declare @EventData xml                             
select @EventData=EVENTDATA()                      
insert into DB_Programming.dbo.trgAudit (DatabaseName,TableName,EventType,LoginName,SQLCommand,AuditDateTime)
values 
(
  @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(250)'),
  @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(250)'),
  GetDate()
)
End

---DDL TRIGGER
create database trgdemo;
use trgdemo
go
create table t1(
id int );
go

-----disable trigger
disable trigger trgDeleteAudit on Employee
go
disable trigger trgServer on all server
go
---enable trigger
enable trigger trgDeleteAudit on Employee
go
