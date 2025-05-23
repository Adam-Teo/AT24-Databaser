-- DROP DATABASE bokhandel
-- CREATE DATABASE bokhandel
USE bokhandel

DROP TABLE IF EXISTS [Anstälda]
DROP TABLE IF EXISTS [Inköp]
DROP TABLE IF EXISTS [LagerSaldo]
DROP TABLE IF EXISTS [Butiker]
DROP TABLE IF EXISTS [Böcker]
DROP TABLE IF EXISTS [Författare]


-- !) Which varchar to use
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



-- Vad finns det fler för constrains
-- Varför ska man namnge constrains
-- ska man köra not null
CREATE TABLE [Böcker] (
    [ISBN13] NVARCHAR(17), 
    [Title] NVARCHAR(255),
    [FörfattareID] INT,
    [Pris] FLOAT,
    PRIMARY KEY (ISBN13, FörfattareID),
    FOREIGN KEY ([FörfattareID]) REFERENCES [Författare](ID)
    -- [Språk] NVARCHAR(63),
     
    -- [Utgivningsdatum] DATE,
    -- [Format] NVARCHAR(15),
    -- [AntalSidor] INT, 
    -- [Vikt] INT, 
    -- [OrginalUtgåvaID] INT,
    
)

INSERT INTO [Böcker]
VALUES 
('978-0-385-66035-6', 'A Midsummer Day', 1, 74.99),
('978-0-679-72981-7', 'Grimhaven' ,2, 74.99),
('978-0-743-27358-9','Town of Feathers' ,3, 74.99),
('978-0-061-99579-2','Ghosts of Mercury' ,4, 74.99), 
('978-0-307-47427-8', 'A Field of Cannons',5, 74.99),
('978-0-786-96635-4','Songs of Clay' ,6, 74.99),
('978-0-547-92825-8', 'The Whisper', 7, 74.99), 
('978-0-143-12870-0', 'The Giraffe and the Crane' ,8, 74.99), 
('978-1-607-83155-4', 'Small Onion',9, 74.99),
('978-0-321-76575-4', 'The Drive West', 10, 49.99), 
('978-0-525-56319-1', 'Taco Tuseday' , 11, 74.99), 
('978-0-008-15619-1', 'The Slim Man',12, 74.99),
('978-0-385-66035-1', 'A Winters Night', 1, 74.99), 
('978-0-979-72281-9', 'Gloomestate' ,2, 74.99), 
('978-0-943-27358-5','Green Street' ,2, 74.99),
('978-0-861-99279-6','Vampires of Saturn' ,4, 74.99), 
('978-0-707-47427-7', 'A Dream of Sand',10, 74.99), 
('978-0-686-96625-8', 'A Tree of Light' ,5, 74.99),
('978-0-686-96625-8', 'A Tree of Light' ,2, 74.99),
('978-0-547-91825-0', 'The Great Scramble', 5, 74.99), 
('978-0-443-13870-2', 'The Moon and The Locket' ,8, 74.99), 
('978-1-107-85155-3', 'The Man How Cried Rain',8, 74.99),
('978-0-421-76775-6', 'Medium Boats', 8, 74.99), 
('978-0-325-56389-3', 'Nightmare Friday' , 8, 74.99), 
('978-0-208-15699-2', 'The Big Smile',8, 74.99)





CREATE TABLE [Butiker] (
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [ButiksNamn] NVARCHAR(255),
    -- [Adressat] NVARCHAR(63),
    [Gatuadress] NVARCHAR(63),
    [Postnummer] INT,
    [Postort] NVARCHAR(63),
)
INSERT INTO Butiker 
VALUES 
    ('The Fox', 'Ekvägen 2' , 31242, 'Falkenberg'),
    ('The Hound', 'Bokvägen 8' , 40530, 'Göteborg'),
    ('The Goose', 'Lindvägen 3' , 11123, 'Stockholm'),
    ('The Badger', 'Alvägen 21' , 55305, 'Jönköping'),
    ('The Crane', 'Lönvägen 5' , 35227, 'Växjö')



CREATE TABLE [LagerSaldo] (
    [ButikID] INT, 
    [ISBN13] NVARCHAR(17), 
    [FörfattareID] INT, 
    [Antal] INT, 
    CONSTRAINT CHK_Antal CHECK ([Antal]>=0),
    PRIMARY KEY(ButikID, ISBN13),
    FOREIGN KEY ([ButikID]) REFERENCES [Butiker](ID),
    FOREIGN KEY ([ISBN13], [FörfattareID]) REFERENCES [Böcker](ISBN13, FörfattareID)
)
INSERT INTO LagerSaldo
VALUES
    (1,'978-0-385-66035-6',  1, 10), 
    (2,'978-0-385-66035-6',  1,  0), 
    (2,'978-0-679-72981-7',  2,  9), 
    (2,'978-0-743-27358-9',  3,  3),
    (1,'978-0-061-99579-2',  4, 12), 
    (4,'978-0-307-47427-8',  5, 21),
    (4,'978-0-321-76575-4', 10,  1),
    (2,'978-0-321-76575-4', 10,  3),
    (3,'978-0-707-47427-7', 10,  5),
    (3,'978-0-208-15699-2',  8,  4),
    (5,'978-0-208-15699-2',  8,  5),
    (2,'978-0-325-56389-3',  8,  8),
    (5,'978-0-325-56389-3',  8,  2)
   

------------------------------------

CREATE TABLE [Anstälda](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [ButikID] INT, 
    [Förnamn] NVARCHAR(63),
    [Efternamn] NVARCHAR(63),
    [Mail] VARCHAR(63),
    [Telefon] INT,
    [Roll] VARCHAR(15),
    [AnstälningsDatum] DATE,
    FOREIGN KEY ([ButikID]) REFERENCES [Butiker]([ID])
)
INSERT INTO [Anstälda]
VALUES
    (2, 'Johana','Strong', 'j_strong@hound.store', '0701352712', 'Butiksägare', '2019-03-11'),
    (1, 'Richard','Milton', 'r_milton@fox.store', '0701352712', 'Butiksbiträde', '2019-03-11'),
    (5, 'Keshav','Ahuja', 'k_ahuja@crane.store', '0701352712', 'Inköpare', '2019-03-11')


CREATE TABLE [Inköp](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [ButikID] INT,
    [ISBN13] NVARCHAR(17), 
    -- [FörfattareID] INT, 
    [Inköpare] INT, 
    [Antal] INT, 
    [BeställningTid] DATETIME2, 
    [LeveransTid] DATETIME2,
    FOREIGN KEY ([ButikID]) REFERENCES [Butiker]([ID]),
    -- FOREIGN KEY ([ISBN13],[FörfattareID]) REFERENCES [Böcker]([ISBN13],[FörfattareID]),
    FOREIGN KEY ([Inköpare]) REFERENCES [Anstälda]([ID])
)

INSERT INTO [Inköp]
VALUES 
    -- (5, '978-0-143-12870-0', 8, 3, 20, '2025-03-20 12:10', '2025-03-21 14:10'),
    -- (1, '978-0-143-12870-0', 8, 2, 20, '2025-04-01 09:50', '2025-04-05 13:50'),
    -- (1, '978-0-143-12870-0', 8, 2, 20, '2025-04-02 08:35', '2025-04-12 13:30'),
    -- (2, '978-0-143-12870-0', 8, 1, 20, '2025-04-15 09:20', '2025-04-23 15:00'),
    -- (5, '978-0-143-12870-0', 8, 3, 20, '2025-05-08 13:30', '2025-05-09 07:10'),
    -- (5, '978-0-143-12870-0', 8, 3, 20, '2025-05-19 14:45', '2025-05-26 08:15')

    (5, '978-0-385-66035-6', 3, 20, '2025-03-20 12:10', '2025-03-21 14:10'),
    (1, '978-0-143-12870-0', 2, 12, '2025-04-01 09:50', '2025-04-05 13:50'),
    (1, '978-0-679-72981-7', 2, 18, '2025-04-02 08:35', '2025-04-12 13:30'),
    (2, '978-0-743-27358-9', 1, 31, '2025-04-15 09:20', '2025-04-23 15:00'),
    (5, '978-0-307-47427-8', 3,  7, '2025-05-08 13:30', '2025-05-09 07:10'),
    (5, '978-0-707-47427-7', 3, 26, '2025-05-19 14:45', '2025-05-26 08:15')


