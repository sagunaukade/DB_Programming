--TRANSACTIONS

--CREATE PRODUCT TABLE
CREATE TABLE Product (  
 Product_id INT PRIMARY KEY,   
 Product_name VARCHAR(40),   
 Price INT,  
 Quantity INT  
)  

SELECT * FROM Product

--INSERT DATA INTO PRODUCT TABLE
INSERT INTO Product VALUES(111, 'Mobile', 10000, 10),  
(112, 'Laptop', 20000, 15),  
(113, 'Mouse', 300, 20),  
(114, 'Hard Disk', 4000, 25),  
(115, 'Speaker', 3000, 20);  

--COMMIT TRANSACTION
-- Start a new transaction    
BEGIN TRANSACTION  
-- SQL Statements  
 INSERT INTO Product VALUES(116, 'Headphone', 2000, 30)  
 UPDATE Product SET Price = 450 WHERE Product_id = 113  
 -- Commit changes   
COMMIT TRANSACTION  

--ROLLBACK TRANSACTION
-- Start a new transaction    
BEGIN TRANSACTION  
-- SQL Statements  
UPDATE Product SET Price = 5000 WHERE Product_id = 114  
DELETE FROM Product WHERE Product_id = 116  

-- Start a new transaction    
BEGIN TRANSACTION  
-- SQL Statements  
UPDATE Product SET Price = 5000 WHERE Product_id = 114  
DELETE FROM Product WHERE Product_id = 116  
--Undo Changes  
ROLLBACK TRANSACTION  

--@error variable used to check whether there is an error or not
BEGIN TRANSACTION  
INSERT INTO Product VALUES(115,'Speaker', 3000, 25)  
-- Check for error  
IF(@@ERROR > 0)  
BEGIN  
    ROLLBACK TRANSACTION  
END  
ELSE  
BEGIN  
   COMMIT TRANSACTION  
END 

--AUTO ROLLBACK TRANSACTION
BEGIN TRANSACTION  
 INSERT INTO Product VALUES(118, 'Desktop', 25000, 15)  
 UPDATE Product SET Quantity = 'ten' WHERE Product_id = 113  
 SELECT * FROM Product  
COMMIT TRANSACTION  

---SAVEPOINT IN TRANSACTION
BEGIN TRANSACTION   
INSERT INTO Product VALUES(117, 'USB Drive', 1500, 10)  
SAVE TRANSACTION InsertStatement  
DELETE FROM Product WHERE Product_id = 116  
SELECT * FROM Product   
ROLLBACK TRANSACTION InsertStatement  
COMMIT  
SELECT * FROM Product;  

--IMPLICIT TRANSACTION
SET IMPLICIT_TRANSACTIONS ON   
UPDATE Product SET Quantity = 10 WHERE Product_id = 113  
SELECT   
    IIF(@@OPTIONS & 2 = 2,   
    'Implicit Transaction Mode ON',   
    'Implicit Transaction Mode OFF'  
    ) AS 'Transaction Mode'   
SELECT @@TRANCOUNT AS OpenTrans   
COMMIT TRANSACTION  
SELECT @@TRANCOUNT AS OpenTrans  

--MARK TRANSACTION 
--ADD DECRIPTION SPECIFIC TRANSACTION
BEGIN TRANSACTION DeleteProduct WITH MARK 'Deleted Product with id = 117'   
    DELETE Product WHERE Product_id = 117  
COMMIT TRANSACTION DeleteProduct  
