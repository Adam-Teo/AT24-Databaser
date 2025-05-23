-- SELECT CASE SERVERPROPERTY('IsIntegratedSecurityOnly')   
--           WHEN 1 THEN 'Windows Authentication Only'   
--           WHEN 0 THEN 'Windows and SQL Server Authentication'  
--        END as [Authentication Mode];


-- CREATE DATABASE publictest
USE publictest
GO
-- CREATE TABLE messages(
--     [id] INT PRIMARY KEY IDENTITY(1,1),
--     [username] nvarchar(10),
--     [subject] nvarchar(50),
--     [body] nvarchar(1000)
-- );

-- ALTER TABLE messages
--     ADD [IP] nvarchar(20);

-- CREATE LOGIN ITHS WITH password = 'ITHS';
-- CREATE USER ITHS FOR LOGIN ITHS; 

-- ALTER ROLE [db_datareader] ADD MEMBER ITHS;

CREATE PROCEDURE sendMessage @subject nvarchar(50), @message nvarchar(1000), @username nvarchar(10) = 'Anonymous' AS
BEGIN
    DECLARE @IP_Address varchar(255);
    -- Specielt för mssql du hittar connectionproerty genom att söka 
    SELECT @IP_Address = cast(CONNECTIONPROPERTY('client_net_address') as varchar)
    INSERT INTO messages VALUES (@username, @subject, @message, @IP_Address)
END; 
GO

GRANT EXECUTE ON sendMessage TO ITHS
sendMessage("Hello", "How are you")
GO


-- EXEC sendMessage "Hello", "How are your";

USE everyloop
SELECT * FROM elements



SELECT * INTO #elements FROM elements


SELECT Number, Symbol, Name INTO #e1 FROM elements WHERE number <= 4
SELECT Number, Symbol, Name INTO #e2 FROM elements WHERE number <= 4

SELECT *
FROM  #e1 
UNION ALL 
SELECT *
FROM  #e1 
