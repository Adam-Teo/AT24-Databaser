-- -----------------------------------------

-- CREATE TABLE [LagerStatus](
--     [ISBN] INT PRIMARY KEY, 
--     [LagerSaldoID]
--     [LagerStatus] VARCHAR(15)
-- )

-- Junction
CREATE TABLE [GenrerJunction](
    BöckerID INT, 
    BookGenre INT ,
)

CREATE TABLE [BookGenrer](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [Genrer] nvarchar(15),
    [ISBN13] NVARCHAR(17), 
)

CREATE TABLE [OrginalUtgåva](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [ISBN13] NVARCHAR(17), 
)

-- Order with many product IDs
-- En tabell med bara produkter som är kopplat till en order
CREATE TABLE [Inköp](
    [InköpID] INT PRIMARY KEY IDENTITY(1,1),
    [ButikerID] INT,
    [ISBN13] NVARCHAR(17), 
    [Antal] INT, 
    [Pris] FLOAT, 
    [BeställningTid] DATETIME2, 
    [LeveransTid] DATETIME2
)
-- CREATE TABLE [Anstälda](
--     [ID] INT PRIMARY KEY IDENTITY(1,1),
--     [FörNamn] VARCHAR(63),
--     [EfterNamn] VARCHAR(63),
--     [Mail] VARCHAR(63),
--     [Telefon] INT,
--     [Roll] VARCHAR(15),
-- )

-- CREATE TABLE [Omkostnader](
--     [Datum] DATETIME2 PRIMARY KEY, 
--     [Hyra] INT,
--     [Lön] INT, 
--     [Inköp] INT, 
--     [Övrigt] INT, 
--     [Reklam] INT, 
-- )

CREATE TABLE [Anstälda](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [ButiksID] INT, 
    [Förnamn] NVARCHAR(63),
    [Efternamn] NVARCHAR(63),
    [Mail] VARCHAR(63),
    [Telefon] INT,
    [Roll] VARCHAR(15),
    [AnstälningsDatum] DATE,
)

CREATE TABLE [Uppgifter](
    [ID] INT PRIMARY KEY IDENTITY(1,1),
    [Beskrivning] NVARCHAR(MAX),
    [AnstäldaID] INT, 
    [InlagtTid] DATETIME2,
    [UtförtTid] DATETIME2,
)

-- 

SELECT * FROM [Författare]
INNER JOIN [Böcker] ON ID = [FörfattareID]
