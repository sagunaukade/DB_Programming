select * from employees

alter table employee add state varchar(1000)

update employee set state='maharashtra' where Emp_Id=1

delete from employee where Emp_Id=1

alter table employee drop column state

sp_rename 'employee.Name','Firstname'

sp_rename 'employee','Employees'

create procedure sp_emp (@city varchar(100),
@Firstname varchar(100))
as 
begin
insert into employees(city,Firstname) values(@City,@Firstname)
end

exec sp_emp city='pune', firstname='saguna'

create procedure sp_allemp
as 
select * from Employees
select * from Department
go

exec sp_allemp