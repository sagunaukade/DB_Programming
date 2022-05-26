--DML COMMANDS
CREATE TABLE CUSTOMER(CID INT primary key,CNAME VARCHAR(100))

create table CustomerDetails(designation varchar(10), city varchar(10), cid int foreign key references customer(cid))

select * from CustomerDetails

SELECT * FROM CUSTOMER

INSERT INTO CUSTOMER VALUES(1,'SAGUNA'),(2,'AKRITI'),(3,'KAJAL');

INSERT INTO CUSTOMER(CNAME) VALUES('PALLAVI')

INSERT CUSTOMER VALUES(4,'RADHA')

INSERT CUSTOMER(CID,CNAME) VALUES(5,'KARISHMA')

--UPDATE COMMANDS
UPDATE CUSTOMER SET CNAME='ANJALI' WHERE CID=3

UPDATE CUSTOMER SET CID=4 WHERE CID IS NULL

UPDATE CUSTOMER SET CNAME='SAGUNA'

--DELETE 
DELETE FROM CUSTOMER WHERE CID=2

DELETE FROM CUSTOMER