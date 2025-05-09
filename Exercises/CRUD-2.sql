USE everyloop


-- a) 
-- Ta ut data (select) från tabellen GameOfThrones på sådant sätt att ni får ut
-- en kolumn ’Title’ med titeln samt en kolumn ’Episode’ som visar episoder
-- och säsonger i formatet ”S01E01”, ”S01E02”, osv.
-- Tips: kolla upp funktionen format() 
-- #temp_tabeller försvinner vid connection

SELECT * INTO #got  FROM dbo.GameOfThrones

SELECT *
FROM #got 

-- Variant A
SELECT Title, FORMAT(Season, 'S0#')+FORMAT( EpisodeInSeason, 'E##') AS Episode
FROM #got

-- Variant B
SElECt Title, concat('S', format(Season, '00'), 'E', format(EpisodeInSeason, '00')) AS Episdoes
FROM #got 

-- Variant C
SELECT Title, FORMAT( Season*100 + EpisodeInSeason, 'S0#E##') AS Episode
FROM #got 


-- b) 
-- Uppdatera (kopia på) tabellen user och sätt username för alla användare så
-- den blir de 2 första bokstäverna i förnamnet, och de 2 första i efternamnet
-- (istället för 3+3 som det är i orginalet). Hela användarnamnet ska vara i små
-- bokstäver. 

SELECT * INTO #Users FROM dbo.Users

SELECT * FROM #Users

-- Variant 1 
UPDATE #Users
SET UserName = lower(LEFT(FirstName,2) + LEFT(LastName,2))

-- Variant 2 
UPDATE #Users
SET UserName = lower(SUBSTRING(FirstName,0,3)) + lower(SUBSTRING(LastName,0,3))


-- c) 
-- Uppdatera (kopia på) tabellen airports så att alla null-värden i kolumnerna
-- Time och DST byts ut mot ’-’

SELECT * INTO #Airport FROM dbo.Airports

SELECT * FROM #Airport

SELECT * FROM #Airport WHERE Time IS NULL
SELECT * FROM #Airport WHERE DST IS NULL

-- Variant 1
UPDATE #Airport
SET Time = '-' 
WHERE Time IS NULL

UPDATE #Airport
SET DST = '-' 
WHERE DST IS NULL

-- Variant 2

update #Airports SET TIME = isnull(TIME, '-')
update #Airports SET DST = isnull(DST, '-')

-- Variant 3 Coalest
update #Airports SET DST = isnull(DST, '-')


-- d) 
-- Ta bort de rader från (kopia på) tabellen Elements där ”Name” är någon av
-- följande: 'Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium', samt alla
-- rader där ”Name” börjar på någon av bokstäverna d, k, m, o, eller u. 

SELECT * INTO #Elements FROM dbo.Elements

SELECT * FROM #Elements

SELECT * FROM #Elements
WHERE 
    Name IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
OR
    Name LIKE '[dkmou]%'

DELETE FROM #Elements
WHERE 
    Name IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
OR
    Name LIKE '[dkmou]%'


-- e)
-- Skapa en ny tabell med alla rader från tabellen Elements. Den nya tabellen
-- ska innehålla ”Symbol” och ”Name” från orginalet, samt en tredje kolumn
-- med värdet ’Yes’ för de rader där ”Name” börjar med bokstäverna i
-- ”Symbol”, och ’No’ för de rader där de inte gör det.
-- Ex: ’He’ -> ’Helium’ -> ’Yes’, ’Mg’ -> ’Magnesium’ -> ’No’. 

SELECT * INTO #Elements2 FROM dbo.Elements

SELECT * FROM #Elements2

ALTER TABLE #Elements2
DROP COLUMN Number, Period, "Group", Mass, Radius, Valenceel, Stableisotopes, Meltingpoint, Boilingpoint, Density;

ALTER TABLE #Elements2
ADD Symbol_Eqauls_Name VARCHAR(3)

UPDATE #Elements2
SET Symbol_Eqauls_Name = CASE
    WHEN Symbol LIKE SUBSTRING(Name,0,1) THEN 'Yes'
    WHEN Symbol LIKE SUBSTRING(Name,0,2) THEN 'Yes'
    ELSE 'No'
END

-- Version 2
-- CASE 
--      WHEN LEFT (name, LEN(symbol)) = symbol
--      then 'Yes'
--      else 'No'
--      end as 'Intital symbol match'


-- f) 
-- Kopiera tabellen Colors till Colors2, men skippa kolumnen ”Code”. Gör
-- sedan en select från Colors2 som ger samma resultat som du skulle fått från
-- select * from Colors; (Dvs, återskapa den saknade kolumnen från RGBvärdena i resultatet). 

SELECT * FROM dbo.Colors

SELECT Name, Red, Green, Blue INTO #colors FROM dbo.Colors

SELECT * FROM #colors

SELECT CONVERT(VARBINARY(3), Red*256*256+Green*256+Blue) as Code, Red, Green, Blue
FROM #colors
-- (!) Facit gör varje covertering som en string som kopplas ihop, mycket smartare

-- SELECT
--      *, 
--      '#' + format(Red, 'X2') + format(Red, 'X2') + format(Red, 'X2') as my_code
--  from
--      #colors
--
--  ALter TABLE #colors
--  ADD code AS '#' + format(Red, 'X2') + format(Red, 'X2') + format(Red, 'X2')    


-- g) 
-- Kopiera kolumnerna ”Integer” och ”String” från tabellen ”Types” till en ny
-- tabell. Gör sedan en select från den nya tabellen som ger samma resultat
-- som du skulle fått från select * from types; 
SELECT Integer, String INTO #Types FROM dbo.Types

SELECT * FROM dbo.Types
SELECT * FROM #Types

-- Variant 1
SELECT 
    Integer, 
    Integer*0.01 AS Float, 
    String, 
    CONVERT(VARCHAR(4), 2018+Integer)+'-10-'+REVERSE(SUBSTRING(REVERSE('0'+CONVERT(VARCHAR(2),Integer)),0,3))+' 19:01:00' AS DateTime, 
    Integer%2 AS Bool
FROM #Types

-- Variant 2
SELECT 
    *,
    Integer*0.01 AS FLOAT,
    String,
    DATEADD(minute, integer, DATEADD(day, Integer, '2018-12-31 09:00')),
    Integer%2 AS Bool
FROM #Types 


-- (!) Facit nestade dateadd(), mycket smartare
-- dateadd(minute, integer, dateadd(day, Integer, '2018-12-31 09:00'))