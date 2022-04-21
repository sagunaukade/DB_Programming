---create snapshot
CREATE DATABASE PRACTICESQLQUERIES_dbss ON
(Name =PRACTICESQLQUERIES, FILENAME='F:\Snapshot\DBSnapshotCurrent.ss')
As Snapshot of PRACTICESQLQUERIES;
go


--restore database using snapshot
use master
restore database PRACTICESQLQUERIES from 
DATABASE_SNAPSHOT='PRACTICESQLQUERIES_dbss';
go

select * from sys.databases