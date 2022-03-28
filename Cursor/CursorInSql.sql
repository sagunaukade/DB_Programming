select * from Student;

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

---CURSOR IN SQL
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
