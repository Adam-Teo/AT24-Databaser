-- DROP DATABASE bokhandel
-- CREATE DATABASE bokhandel
USE bokhandel

DROP TABLE IF EXISTS Författare_Böcker
DROP TABLE IF EXISTS Genre_Böcker
DROP TABLE IF EXISTS Anstälda_Butiker
DROP TABLE IF EXISTS Roll_Anstälda

DROP TABLE IF EXISTS [Roll]
DROP TABLE IF EXISTS [Genre]
DROP TABLE IF EXISTS [Inköp]
DROP TABLE IF EXISTS [LagerSaldo]
DROP TABLE IF EXISTS [Anstälda]
DROP TABLE IF EXISTS [Butiker]
DROP TABLE IF EXISTS [Böcker]
DROP TABLE IF EXISTS [Författare]


CREATE TABLE [Roll](
    [ID] INT PRIMARY KEY IDENTITY(1,1), 
    Roll VARCHAR(15),
    )
INSERT INTO [Roll]
VALUES
    ('Butiksägare'),
    ('Inköpare'),
    ('Butiksbiträde'),
    ('Städare'), 
    ('Lageransvarig')


CREATE TABLE [Anstälda](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [Förnamn] NVARCHAR(63),
    [Efternamn] NVARCHAR(63),
    [Mail] VARCHAR(63),
    [Telefon] INT,
    [AnstälningsDatum] DATE

    )
INSERT INTO [Anstälda]
VALUES
    ('Johana','Strong', 'j_strong@hound.store', '0702654812', '2019-03-11'),
    ('Richard','Milton', 'r_milton@fox.store', '0708352719', '2011-10-04'),
    ('Keshav','Ahuja', 'k_ahuja@crane.store', '0707152532', '2012-07-21'),
    ('Maria','Andersson', 'm_andersson@bear.store', '0701122334', '2020-01-01'),
    ('Erik','Bergman', 'e_bergman@eagle.store', '0702233445', '2018-05-20'),
    ('Sophie','Dahlgren', 's_dahlgren@wolf.store', '0703344556', '2021-09-01'),
    ('Liam','Nilsson', 'l_nilsson@lion.store', '0704455667', '2017-11-15'),
    ('Fatima','Khan', 'f_khan@tiger.store', '0705566778', '2022-02-10'),
    ('David','Svensson', 'd_svensson@deer.store', '0706677889', '2019-06-25'),
    ('Lena','Olofsson', 'l_olofsson@owl.store', '0707788990', '2016-03-08'),
    ('Oscar','Lindgren', 'o_lindgren@fox.store', '0708899001', '2023-01-05'),
    ('Julia','Eriksson', 'j_eriksson@swan.store', '0709900112', '2020-10-14'),
    ('Adam','Pettersson', 'a_pettersson@cobra.store', '0700011223', '2018-07-30'),
    ('Victoria','Lundqvist', 'v_lundqvist@falcon.store', '0701122335', '2022-04-20'),
    ('Kalle','Larsson', 'k_larsson@hare.store', '0702233446', '2019-12-01'),
    ('Sara','Gustafsson', 's_gustafsson@badger.store', '0703344557', '2021-08-18'),
    ('Emil','Holmberg', 'e_holmberg@weasel.store', '0704455668', '2017-02-28'),
    ('Anna','Johansson', 'a_johansson@robin.store', '0705566779', '2023-03-10')


-- Junction
CREATE TABLE [Roll_Anstälda](
    RollID INT FOREIGN KEY REFERENCES [Roll]([ID]),
    AnstäldaID INT FOREIGN KEY REFERENCES [Anstälda]([ID])
    )
INSERT INTO [Roll_Anstälda]
VALUES
    (1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (5,4),
    (2,5),
    (4,6),
    (3,7),
    (5,8),
    (2,9),
    (4,10),
    (3,11),
    (5,12),
    (2,13),
    (4,14),
    (3,15),
    (5,16),
    (2,17),
    (4,18),
    -- Anställda med dubbla roller
    (2,1),
    (3,2),
    (2,3),
    (3,4),
    (5,5)


CREATE TABLE [Butiker] (
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [ButiksNamn] NVARCHAR(255),
    [Gatuadress] NVARCHAR(63),
    [Postnummer] INT,
    [Postort] NVARCHAR(63)
    
    )
INSERT INTO Butiker 
VALUES 
    ('The Fox', 'Ekvägen 2' , 31242, 'Falkenberg'),
    ('The Hound', 'Bokvägen 8' , 40530, 'Göteborg'),
    ('The Goose', 'Lindvägen 3' , 11123, 'Stockholm'),
    ('The Badger', 'Alvägen 21' , 55305, 'Jönköping'),
    ('The Crane', 'Lönvägen 5' , 35227, 'Växjö')

-- Junction
CREATE TABLE Anstälda_Butiker (
    ButikerID INT FOREIGN KEY REFERENCES [Butiker]([ID]),
    AnstäldaID INT FOREIGN KEY REFERENCES [Anstälda]([ID]),
    )
INSERT INTO Anstälda_Butiker
VALUES 
    (1,1),
    (2,2),
    (3,3),
    (4,4),
    (5,5),
    (5,4),
    (2,5),
    (4,6),
    (3,7),
    (5,8),
    (2,9),
    (4,10),
    (3,11),
    (5,12),
    (2,13),
    (4,14),
    (3,15),
    (5,16),
    (2,17),
    (4,18)



CREATE TABLE Genre (
    [ID] INT PRIMARY KEY IDENTITY(1,1), 
    Genre NVARCHAR(15) 
    ) 
INSERT INTO Genre
VALUES
    ('Drama'),
    ('Romantik'),
    ('Fantasy'),
    ('Skräck'),
    ('Science Fiction'),
    ('Deckare')


CREATE TABLE [Författare] (
    [ID] INT PRIMARY KEY IDENTITY(1,1), 
    [Förnamn] NVARCHAR(63),
    [Efternamn] NVARCHAR(63),
    [Födelsedatum] DATE,
    )
INSERT INTO [Författare]
VALUES
    ('Will', 'Russel', '1955-11-03'),
    ('Janet', 'West', '1992-07-15'),
    ('Charly', 'Cox', '1978-04-29'),
    ('Linus', 'Tilly', '1953-09-10'),
    ('Floyd', 'Sagreb', '1998-12-22'),
    ('Marcus', 'Twin', '1967-06-01'),
    ('Ernie', 'Oats', '1977-01-08'),
    ('Linda', 'Torwell', '1960-08-17'),
    ('Gabby', 'Addams', '1985-05-25'),
    ('Maria', 'Swiny', '1959-02-14'),
    ('James', 'Lark', '1961-10-30'),
    ('Nina', 'Slown', '1971-03-07')


CREATE TABLE [Böcker] (
    [ISBN13] NVARCHAR(17) PRIMARY KEY, 
    [Title] NVARCHAR(255),
    [Pris] FLOAT,
    [Språk] NVARCHAR(63),
    [Format] NVARCHAR(15),
    [AntalSidor] INT, 
    [Utgivningsdatum] DATE,   
    CHECK ([ISBN13] LIKE '___-_-___-_____-_')    
    )
INSERT INTO [Böcker]
VALUES 
    ('978-0-385-66035-6', 'A Midsummer Day', 55.25, 'Engelska', 'Bunden', 252, '2005-06-15'),
    ('978-0-679-72981-7', 'Grimhaven', 82.10, 'Tyska', 'Pocket', 183, '1998-03-20'),
    ('978-0-743-27358-9', 'Town of Feathers', 48.90, 'Franska', 'Bunden', 421, '2010-11-01'),
    ('978-0-707-47427-7', 'A Dream of Sand', 67.50, 'Engelska', 'Pocket', 300, '2018-09-22'),
    ('978-0-061-99579-2', 'Ghosts of Mercury', 71.30, 'Engelska', 'Bunden', 280, '2012-07-07'),
    ('978-0-307-47427-8', 'A Field of Cannons', 42.75, 'Engelska', 'Pocket', 350, '2015-04-10'),
    ('978-0-786-96635-4', 'Songs of Clay', 88.00, 'Engelska', 'Bunden', 220, '2001-01-01'),
    ('978-0-547-92825-8', 'The Whisper', 59.95, 'Engelska', 'Pocket', 190, '2009-02-28'),
    ('978-0-143-12870-0', 'The Giraffe and the Crane', 79.20, 'Engelska', 'Bunden', 270, '2016-10-05'),
    ('978-1-607-83155-4', 'Small Onion', 44.40, 'Engelska', 'Pocket', 150, '2019-08-12'),
    ('978-0-321-76575-4', 'The Drive West', 49.99, 'Engelska', 'Bunden', 310, '2007-03-03'),
    ('978-0-525-56319-1', 'Taco Tuesday', 73.80, 'Engelska', 'Pocket', 200, '2021-05-20'),
    ('978-0-008-15619-1', 'The Slim Man', 61.50, 'Engelska', 'Bunden', 240, '2014-12-01'),
    ('978-0-385-66035-1', 'A Winters Night', 85.15, 'Engelska', 'Pocket', 260, '2003-11-08'),
    ('978-0-979-72281-9', 'Gloomestate', 52.30, 'Engelska', 'Bunden', 330, '1999-07-25'),
    ('978-0-943-27358-5', 'Green Street', 76.90, 'Engelska', 'Pocket', 180, '2011-01-18'),
    ('978-0-861-99279-6', 'Vampires of Saturn', 46.10, 'Engelska', 'Bunden', 290, '2017-09-01'),
    ('978-0-686-96625-8', 'A Tree of Light', 89.40, 'Engelska', 'Pocket', 210, '2008-04-04'),
    ('978-0-547-91825-0', 'The Great Scramble', 64.70, 'Engelska', 'Bunden', 380, '2013-06-06'),
    ('978-0-443-13870-2', 'The Moon and The Locket', 70.00, 'Engelska', 'Pocket', 230, '2020-02-14'),
    ('978-1-107-85155-3', 'The Man Who Cried Rain', 41.20, 'Engelska', 'Bunden', 310, '2006-12-12'),
    ('978-0-421-76775-6', 'Medium Boats', 83.50, 'Engelska', 'Pocket', 170, '2000-08-30'),
    ('978-0-325-56389-3', 'Nightmare Friday', 57.80, 'Engelska', 'Bunden', 250, '2022-01-28'),
    ('978-0-208-15699-2', 'The Big Smile', 68.20, 'Engelska', 'Pocket', 160, '2010-04-16')


-- Junction
CREATE TABLE Författare_Böcker (
    FörfattareID INT FOREIGN KEY REFERENCES [Författare]([ID]),
    BöckerISBN13 NVARCHAR(17) FOREIGN KEY REFERENCES [Böcker]([ISBN13]),
)
INSERT INTO Författare_Böcker 
VALUES
    (5, '978-0-385-66035-6'),
    (12, '978-0-679-72981-7'),
    (9, '978-0-743-27358-9'),
    (2, '978-0-707-47427-7'),
    (7, '978-0-061-99579-2'),
    (4, '978-0-307-47427-8'),
    (11, '978-0-786-96635-4'),
    (1, '978-0-547-92825-8'),
    (8, '978-0-143-12870-0'),
    (3, '978-1-607-83155-4'),
    (10, '978-0-321-76575-4'),
    (6, '978-0-525-56319-1'),
    (1, '978-0-008-15619-1'),
    (8, '978-0-385-66035-1'),
    (3, '978-0-979-72281-9'),
    (10, '978-0-943-27358-5'),
    (5, '978-0-861-99279-6'),
    (12, '978-0-686-96625-8'),
    (7, '978-0-547-91825-0'),
    (4, '978-0-443-13870-2'),
    (11, '978-1-107-85155-3'),
    (2, '978-0-421-76775-6'),
    (9, '978-0-325-56389-3'),
    (6, '978-0-208-15699-2'),
    -- Books with more then one author
    (2, '978-0-979-72281-9'),
    (11, '978-0-943-27358-5'),
    (6, '978-0-861-99279-6'),
    (10, '978-0-686-96625-8'),
    (3, '978-0-547-91825-0'),
    (2, '978-0-443-13870-2'),
    (1, '978-1-107-85155-3'),
    (6, '978-0-421-76775-6'),
    (7, '978-0-325-56389-3'),
    (9, '978-0-208-15699-2')

-- Junction
CREATE TABLE Genre_Böcker (
    GenreID INT FOREIGN KEY REFERENCES [Genre]([ID]),
    BöckerISBN13 NVARCHAR(17) FOREIGN KEY REFERENCES [Böcker]([ISBN13]),
)
INSERT INTO Genre_Böcker
VALUES
    (5, '978-0-385-66035-6'),
    (3, '978-0-679-72981-7'),
    (6, '978-0-743-27358-9'),
    (2, '978-0-707-47427-7'),
    (1, '978-0-061-99579-2'),
    (4, '978-0-307-47427-8'),
    (5, '978-0-786-96635-4'),
    (1, '978-0-547-92825-8'),
    (2, '978-0-143-12870-0'),
    (3, '978-1-607-83155-4'),
    (4, '978-0-321-76575-4'),
    (6, '978-0-525-56319-1'),
    (1, '978-0-008-15619-1'),
    (2, '978-0-385-66035-1'),
    (3, '978-0-979-72281-9'),
    (4, '978-0-943-27358-5'),
    (5, '978-0-861-99279-6'),
    (6, '978-0-686-96625-8'),
    (1, '978-0-547-91825-0'),
    (2, '978-0-443-13870-2'),
    (3, '978-1-107-85155-3'),
    (4, '978-0-421-76775-6'),
    (5, '978-0-325-56389-3'),
    (6, '978-0-208-15699-2')


CREATE TABLE [LagerSaldo] (
    [ButikID] INT FOREIGN KEY REFERENCES [Butiker](ID), 
    [ISBN13] NVARCHAR(17) FOREIGN KEY REFERENCES [Böcker](ISBN13), 
    [Antal] INT, 
    CONSTRAINT CHK_Antal CHECK ([Antal]>=0),
    PRIMARY KEY(ButikID, ISBN13)
    )
INSERT INTO LagerSaldo
VALUES
    (4, '978-0-385-66035-6', 18),
    (1, '978-0-679-72981-7', 10),
    (2, '978-0-679-72981-7', 5),
    (5, '978-0-743-27358-9', 9),
    (2, '978-0-707-47427-7', 22),
    (3, '978-0-061-99579-2', 14),
    (1, '978-0-307-47427-8', 29),
    (5, '978-0-786-96635-4', 7),
    (2, '978-0-547-92825-8', 20),
    (4, '978-0-143-12870-0', 11),
    (3, '978-1-607-83155-4', 27),
    (1, '978-0-321-76575-4', 6),
    (5, '978-0-525-56319-1', 23),
    (2, '978-0-008-15619-1', 16),
    (4, '978-0-385-66035-1', 30),
    (3, '978-0-979-72281-9', 8),
    (1, '978-0-943-27358-5', 21),
    (5, '978-0-861-99279-6', 13),
    (2, '978-0-686-96625-8', 28),
    (4, '978-0-547-91825-0', 10),
    (3, '978-0-443-13870-2', 26),
    (1, '978-1-107-85155-3', 15),
    (5, '978-0-421-76775-6', 24),
    (2, '978-0-325-56389-3', 12),
    (4, '978-0-208-15699-2', 19),
    -- Böcker som finns i mer än en butik
    (2, '978-0-943-27358-5', 21),
    (3, '978-0-861-99279-6', 1),
    (4, '978-0-686-96625-8', 18),
    (5, '978-0-547-91825-0', 5),
    (2, '978-0-443-13870-2', 28),
    (3, '978-1-107-85155-3', 5),
    (4, '978-0-421-76775-6', 4),
    (1, '978-0-325-56389-3', 13),
    (2, '978-0-208-15699-2', 15)
   

CREATE TABLE [Inköp](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [ButikID] INT,
    [ISBN13] NVARCHAR(17),
    [Antal] INT, 
    [AnstäldaID] INT,
    [BeställningTid] DATETIME2, 
    [LeveransTid] DATETIME2,
    )
INSERT INTO [Inköp]
VALUES 
    (4, '978-0-385-66035-6', 18, 1, '2019-11-20 19:42', '2019-11-21 19:42'),
    (1, '978-0-679-72981-7', 25, 2, '2013-09-08 11:27', '2013-09-09 11:27'),
    (5, '978-0-743-27358-9', 9, 3, '2022-07-01 04:08', '2022-07-05 04:08'),
    (2, '978-0-707-47427-7', 22, 1, '2010-02-15 22:55', '2010-02-17 22:55'),
    (3, '978-0-061-99579-2', 14, 2, '2017-05-23 09:18', '2017-05-27 09:18'),
    (1, '978-0-307-47427-8', 29, 4, '2015-12-10 16:30', '2015-12-14 16:30'),
    (5, '978-0-786-96635-4', 7, 1, '2024-08-03 01:05', '2024-08-04 01:05'),
    (2, '978-0-547-92825-8', 20, 2, '2011-04-28 14:00', '2011-04-30 14:00'),
    (4, '978-0-143-12870-0', 11, 3, '2018-01-07 07:40', '2018-01-11 07:40'),
    (3, '978-1-607-83155-4', 27, 1, '2020-06-19 20:12', '2020-06-20 20:12'),
    (1, '978-0-321-76575-4', 6, 2, '2014-03-02 03:25', '2014-03-03 03:25'),
    (5, '978-0-525-56319-1', 23, 7, '2023-10-14 10:00', '2023-10-18 10:00'),
    (2, '978-0-008-15619-1', 16, 9, '2012-11-29 18:45', '2012-12-01 18:45'),
    (4, '978-0-385-66035-1', 30, 10, '2016-07-07 08:30', '2016-07-09 08:30'),
    (3, '978-0-979-72281-9', 8, 3, '2021-09-03 23:10', '2021-09-07 23:10'),
    (1, '978-0-943-27358-5', 21, 12, '2010-01-20 06:00', '2010-01-21 06:00'),
    (5, '978-0-861-99279-6', 13, 3, '2017-03-17 12:00', '2017-03-18 12:00'),
    (2, '978-0-686-96625-8', 28, 8, '2019-05-01 05:00', '2019-05-04 05:00'),
    (4, '978-0-547-91825-0', 10, 6, '2013-08-11 17:00', '2013-08-12 17:00'),
    (3, '978-0-443-13870-2', 26, 2, '2022-02-28 09:00', '2022-03-01 09:00'),
    (1, '978-1-107-85155-3', 15, 3, '2016-10-05 21:00', '2016-10-09 21:00'),
    (5, '978-0-421-76775-6', 24, 1, '2018-12-12 14:00', '2018-12-14 14:00'),
    (2, '978-0-325-56389-3', 12, 2, '2015-06-25 08:00', '2015-06-26 08:00'),
    (4, '978-0-208-15699-2', 19, 3, '2020-04-04 11:00', '2020-04-07 11:00'),
    (2, '978-0-943-27358-5', 21, 7, '2014-07-19 13:00', '2014-07-20 13:00'),
    (3, '978-0-861-99279-6', 13, 5, '2023-01-01 00:00', '2023-01-02 00:00'),
    (4, '978-0-686-96625-8', 28, 12, '2011-09-22 16:00', '2011-09-23 16:00'),
    (5, '978-0-547-91825-0', 10, 24, '2010-05-10 10:00', '2010-05-14 10:00'),
    (2, '978-0-443-13870-2', 26, 25, '2017-11-05 07:00', '2017-11-07 07:00'),
    (3, '978-1-107-85155-3', 15, 3, '2012-03-30 20:00', '2012-04-03 20:00'),
    (4, '978-0-421-76775-6', 24, 6, '2015-01-15 15:00', '2015-01-16 15:00'),
    (1, '978-0-325-56389-3', 12, 7, '2024-04-04 04:00', '2024-04-05 04:00'),
    (2, '978-0-208-15699-2', 19, 25, '2019-07-07 07:07', '2019-07-10 07:07')
GO

----------------------
----------------------

DROP VIEW IF EXISTS TitlarPerFörfattare
GO

CREATE VIEW TitlarPerFörfattare
AS
SELECT
    [Namn],
    [Ålder],
    CONCAT( COUNT(b.[ISBN13]), ' st' ) AS Titlar,
    CONCAT( SUM( ls.[Antal]), ' st' ) AS LagerAntal,
    CONCAT( SUM(ls.[Antal]*[Pris]),' kr') AS [LagerVärde]
FROM [Författare] f
CROSS APPLY (
    SELECT CONCAT([Förnamn],' ',[Efternamn]) AS Namn, 
    CONCAT( CONVERT( NVARCHAR(3), (DATEDIFF(YEAR, [Födelsedatum], GETDATE())) ),' År' ) AS [Ålder]
    ) Alias
LEFT JOIN Författare_Böcker fb ON f.ID = fb.FörfattareID 
LEFT JOIN Böcker b ON fb.[BöckerISBN13] =  b.ISBN13
LEFT JOIN LagerSaldo ls ON b.[ISBN13] = ls.[ISBN13]
GROUP BY ID, Förnamn, Födelsedatum, Namn, Ålder
GO


DROP VIEW IF EXISTS Personalinköp
GO

CREATE VIEW Personalinköp
AS
--SELECT STRING_AGG([Roll], ' & '), [Anstäld], SUM([Antal]) AS [Antal Bestälda Böcker], SUM([Antal]*[Pris]) AS [Totatlt Bestälnings Värde]
SELECT 
    [Anstäld],
    CONCAT( SUM([Antal]), ' st' ) AS [Antal Bestälda Böcker], 
    CONCAT( ROUND( SUM([Antal]*[Pris]), 0 ), ' kr' ) AS [Totatlt Bestälnings Värde] 
FROM [Anstälda] a
CROSS APPLY (
    SELECT
        CONCAT(a.[Förnamn],' ',a.[Efternamn]) AS [Anstäld]
    ) Alias
JOIN [Inköp] i ON a.[ID] = i.[AnstäldaID]
-- JOIN [Roll_Anstälda] ra ON a.[ID] = ra.[AnstäldaID] 
-- JOIN [Roll] r ON ra.[RollID] = r.[ID]
JOIN [Böcker] b ON i.[ISBN13] = b.[ISBN13]
GROUP BY [Anstäld] --[Roll], [Anstäld]
GO

-- SELECT * FROM Personalinköp


--------------------------
--------------------------


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

            IF @@ROWCOUNT = 0
            BEGIN
                THROW 50001, 'Error: Book not found in the transfer to store', 1;
            END


            UPDATE [LagerSaldo]
            SET [Antal] = [Antal] - @antal
            WHERE [ButikID]=@från AND [ISBN13] = @isbn
                 
            IF @@ROWCOUNT = 0
            BEGIN
                THROW 50001, 'Error: Book not found in the transfer from store', 1;
            END

    COMMIT TRANSACTION
    PRINT 'Transaction committed successfully'
END TRY 
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION
        PRINT 'Transaction rolled back due to error.'
    END

    -- DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE() 
    -- DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
    -- DECLARE @ErrorState INT = ERROR_STATE()
    -- RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)

END CATCH
GO

EXEC FlyttaBok @från = 1, @till = 2, @isbn = '978-0-679-72981-7'

SELECT * FROM [LagerSaldo] WHERE [ISBN13] = '978-0-679-72981-7'


------
BACKUP DATABASE bokhandel
TO DISK = 'C:\Code\AT24-Databaser-Adam-Teodorsson\Databaser\bokhandel.bak'
WITH NOFORMAT, NOINIT,
NAME = 'En Bokhandels Databas'
GO
