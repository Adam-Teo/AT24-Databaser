USE bookcase
GO

DROP DATABASE bokhandel

CREATE DATABASE bokhandel

BACKUP DATABASE bokhandel
TO DISK = 'C:\Code\AT24-Databaser-Adam-Teodorsson\Databaser\bokhandel.bak'
WITH NOFORMAT, NOINIT,
NAME = 'En Bokhandels Databas'
GO

DROP DATABASE bokhandel

RESTORE DATABASE bokhandel
FROM DISK = 'C:\Code\AT24-Databaser-Adam-Teodorsson\Databaser\bokhandel.bak'
WITH
MOVE 'bokhandel' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\bokhandel.mdf',
MOVE 'bokhandel_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\bokhandel.ldf',
REPLACE;
GO

