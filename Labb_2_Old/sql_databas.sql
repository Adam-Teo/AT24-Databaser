USE bokhandel

-- TOP 1
DROP VIEW IF EXISTS TitlarPerFörfattare
CREATE VIEW TitlarPerFörfattare
AS
SELECT TOP 3
    Namn,
    [Ålder],
    CONCAT( COUNT(b.[ISBN13]), ' st' ) AS Titlar,
    CONCAT( SUM(ls.[Antal]*[Pris]),' kr') AS [LagerVärde],
    SUM( ls.[Antal] ) AS LagerAntal
FROM [Författare] f
CROSS APPLY (
    SELECT CONCAT([Förnamn],' ',[Efternamn]) AS Namn, 
    CONCAT( CONVERT( NVARCHAR(3), (DATEDIFF(YEAR, [Födelsedatum], GETDATE())) ),' År' ) AS [Ålder]
    ) Alias
LEFT JOIN Författare_Böcker fb ON f.ID = fb.FörfattareID 
LEFT JOIN Böcker b ON fb.[BöckerISBN13] =  b.ISBN13
LEFT JOIN LagerSaldo ls ON b.[ISBN13] = ls.[ISBN13]
GROUP BY ID, Förnamn, Födelsedatum, Namn, Ålder
ORDER BY Titlar DESC
GO

SELECT * FROM Böcker
SELECT * FROM Författare
SELECT * FROM LagerSaldo
SELECT * FROM TitlarPerFörfattare



-- Store Proceure


-- BEGIN END 
-- Jag använce en LLM Gemini 2.0 för TRY och Catch Delen

-- I have this t-sql code and I have a CONSTRAINT on Antal, 
-- Antal can never be lower then 0. I'm using BEGIN TRANSACTION to try 
-- and prevent the first UPDATE to execute unless the second UPDATE also 
-- gets executed but it doesn't work, the second UPDATE fail and the 
-- first UPDATE stil gets executed
-- ` CODE `

DROP PROCEDURE [FlyttaBok]
GO

CREATE PROCEDURE FlyttaBok 
    @från INT, 
    @till INT,
    @isbn NVARCHAR(17),
    @antal INT = 1
AS
BEGIN TRY
    BEGIN TRANSACTION
            UPDATE [LagerSaldo]
            SET [Antal] = [Antal] + @antal
            WHERE [ButikID]=@till AND [ISBN13] = @isbn

            UPDATE [LagerSaldo]
            SET [Antal] = [Antal] - @antal
            WHERE [ButikID]=@från AND [ISBN13] = @isbn
    COMMIT TRANSACTION
    PRINT 'Transaction committed successfully'
END TRY 
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION
        PRINT 'Transaction rolled back due to error.'
    END

    DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE() 
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
    DECLARE @ErrorState INT = ERROR_STATE()
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH
--GO

EXEC FlyttaBok @från = 1, @till = 2, @isbn = '978-0-679-72981-7'

SELECT * FROM [LagerSaldo]
WHERE [ISBN13] = '978-0-679-72981-7'

------------

SELECT Title, CONCAT(Förnamn,' ',Efternamn) AS Förfatare FROM [Böcker] 
INNER JOIN [Författare] ON [ID] = [FörfattareID]

 
-----
CREATE VIEW Personalinköp
AS
SELECT [Roll], [Anstäld], SUM([Antal]) AS [Antal Bestälda Böcker], SUM([Antal]*[Pris]) AS [Totatlt Bestälnings Värde]
FROM [Anstälda]
CROSS APPLY (
    SELECT
        CONCAT([Förnamn],' ',[Efternamn]) AS [Anstäld]
    ) Alias
LEFT JOIN [Inköp] ON [Anstälda].[ID] = [Inköpare]
LEFT JOIN [Böcker] ON [Böcker].[ISBN13] = [Inköp].[ISBN13]
GROUP BY [Roll], [Anstäld]
GO

SELECT * FROM Personalinköp

---

SELECT ButiksNamn, Title, Antal
FROM [Butiker] 
JOIN [LagerSaldo] ON [Butiker].[ID] = [LagerSaldo].[ButikID]
JOIN [Böcker] ON [LagerSaldo].[ISBN13] = [Böcker].[ISBN13]
WHERE Title LIKE '% bobby';DROP TABLE LagerSaldo;-- '%'

DROP TABLE LagerSaldo;

---------
CREATE LOGIN new_user WITH PASSWORD = 'abc',
    DEFAULT_DATABASE = [bokhandel],
    CHECK_EXPIRATION = ON,
    CHECK_POLICY = ON;
GO


USE bokhandel; -- Replace with the actual database name
GO

-- You can use a different name for USER then for the LOGIN 
CREATE USER new_user FOR LOGIN new_user; -- If using SQL Server Authentication Login
GO
-- CREATE USER [DBUser] FOR LOGIN [DOMAIN\UserName]; -- If using Windows Authentication Login
-- GO

USE bokhandel
GRANT SELECT ON SCHEMA::[dbo] TO new_user; -- Grant SELECT on a specific table
GO

SELECT ButikID, Antal FROM dbo.LagerSaldo
GROUP BY ButikID, Antal



