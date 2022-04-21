---Create full sql backup to disk
BACKUP DATABASE BookStore TO DISK ='D:\Backups\BookStore.bak'
go

---create full backup to multiple disk files
BACKUP DATABASE BookStore
TO DISK='C:\Backup\BookStore_1.bak',
DISK='F:\Backup\BookStore_3.bak'
go

---Restore full sql Database 
RESTORE DATABASE BookStore 
FROM DISK='F:\Backup\BookStore_3.bak' 
GO

RESTORE DATABASE BookStore FROM DISK = 'C:\Backup\BookStore_1.bak'
WITH NORECOVERY
GO