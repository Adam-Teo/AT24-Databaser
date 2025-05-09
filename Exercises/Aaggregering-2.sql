USE everyloop

-- a)
-- Ta ut (select) en rad för varje (unik) period i tabellen ”Elements” med
-- följande kolumner: ”period”, ”from” med lägsta atomnumret i perioden,
-- ”to” med högsta atomnumret i perioden, ”average isotopes” med
-- genomsnittligt antal isotoper visat med 2 decimaler, ”symbols” med en
-- kommaseparerad lista av alla ämnen i perioden. 

SELECT * INTO #Elements FROM dbo.Elements

SELECT * FROM #Elements
-- (!) There should probably be something else in average isotopes
SELECT 
    period, 
    MIN(number) AS [from], 
    MAX(number) AS [to], 
    ROUND(AVG(stableisotopes), 2) AS [average isotopes],
    STRING_AGG(symbol, ',') AS symbols
FROM #Elements
GROUP BY period

-- b) 
-- För varje stad som har 2 eller fler kunder i tabellen Customers, ta ut
-- (select) följande kolumner: ”Region”, ”Country”, ”City”, samt
-- ”Customers” som anger hur många kunder som finns i staden. 
SELECT * INTO #Customers FROM company.customers

SELECT * FROM #Customers

SELECT city, country, region, COUNT(city) AS customers
FROM #Customers
GROUP BY city, country, region
HAVING COUNT(city) > 1


-- c)
-- Skapa en varchar-variabel och skriv en select-sats som sätter värdet:
-- ”Säsong 1 sändes från april till juni 2011. Totalt
-- sändes 10 avsnitt, som i genomsnitt sågs av 2.5
-- miljoner människor i USA.”, följt av radbyte/char(13), följt av
-- ”Säsong 2 sändes …” osv.
-- När du sedan skriver (print) variabeln till messages ska du alltså få en rad
-- för varje säsong enligt ovan, med data sammanställt från tabellen
-- GameOfThrones.
-- Tips: Ange ’sv’ som tredje parameter i format() för svenska månader.
-- Tips: Du kan även byta rad med CHAR(10)
-- Tips: Padd a string LEFT(@string + REPLICATE('-',7), 7) however Im not sure that it works with ' '
SELECT * INTO #got FROM dbo.gameofthrones
SELECT * FROM #got

-- CONVERT(varchar, 22)
DECLARE @var AS VARCHAR(MAX) = ''

SELECT @var += 
'Säsong '+CONVERT(varchar(1),season)+
' från '+FORMAT(MIN([Original air date]),'MMMM','sv') +
' till '+FORMAT(MAX([Original air date]),'MMMM yyyy','sv')+
'. Totalt sändes '+CONVERT(VARCHAR(2),COUNT(season))+
' avsnitt, som i genomsnitt sågs av '+CONVERT(VARCHAR(5),ROUND(AVG([U.S. viewers(millions)]),2))+
' miljoner människor i USA'+CHAR(10) 
FROM #got
GROUP BY season
PRINT @var



-- d) 
-- Ta ut (select) alla användare i tabellen ”Users” så du får tre kolumner:
-- ”Namn” som har fulla namnet; ”Ålder” som visar hur många år personen
-- är idag (ex. ’45 år’); ”Kön” som visar om det är en man eller kvinna.
-- Sortera raderna efter för- och efternamn. 
SELECT * INTO #users FROM dbo.Users
SELECT * FROM #users

SELECT 
    [FirstName]+' '+[LastName] AS Namn, 
    FORMAT(GETDATE(),'yyyy')-(CONVERT(INT, SUBSTRING(ID, 0, 3))+1900) AS [Ålder], 
    CASE 
        WHEN CONVERT(int,SUBSTRING(ID, 10,1))%2 = 0 THEN 'Kvinna'
        ELSE 'Man' 
    END AS [Kön] 
FROM #users
ORDER BY [FirstName], [LastName]


-- e)
-- Ta ut en lista över regioner i tabellen ”Countries” där det för varje region
-- framgår regionens namn, antal länder i regionen, totalt antal invånare,
-- total area, befolkningstätheten med 2 decimaler, samt
-- spädbarnsdödligheten per 100.000 födslar avrundat till heltal.
-- Tips:  SQL_VARIANT_PROPERTY([column], 'BaseType') Ger dig datatypen av variablen
-- DROP TABLE #countries
SELECT * INTO #countries FROM dbo.Countries
-- SELECT * FROM #countries

-- DROP TABLE #pop
-- SELECT [Country], [Region], CONVERT(FLOAT, REPLACE( [Pop# Density (per sq# mi#)], ',', '.' )) AS [Pop# Density (per sq# mi#)] INTO #pop FROM #countries


-- SELECT AVG([Pop# Density (per sq# mi#)]) AS POPAVG
-- FROM #pop
-- GROUP BY [Region]

-- UPDATE #countries
-- SET [Pop# Density (per sq# mi#)] = #pop.[Pop# Density (per sq# mi#)]
-- FROM #pop
-- WHERE #countries.Country = #pop.Country

-- UPDATE #countries 
-- SET [Pop# Density (per sq# mi#)] = CONVERT(FLOAT, REPLACE( [Pop# Density (per sq# mi#)], ',', '.' )) 

-- UPDATE #countries 
-- SET [Pop# Density (per sq# mi#)] = 200

-- ALTER TABLE #countries
-- ALTER COLUMN [Pop# Density (per sq# mi#)] INT

SELECT 
    [Region], 
    COUNT([Country]) AS [Antal Länder],
    SUM(CAST([Population] AS BIGINT)) AS [Antal Invånare],
    SUM(CAST([Area (sq# mi#)] AS BIGINT)) As [Total Area],
    ROUND( AVG( CONVERT(FLOAT, REPLACE( [Pop# Density (per sq# mi#)], ',', '.' ))), 2) AS [Befolkningstäthet],
    -- ROUND( AVG([Infant mortality (per 1000 births)]), 0) AS [Spädbarnsdödlighet]
    -- ROUND( AVG( CONVERT(FLOAT, [Infant mortality (per 1000 births)])), 0) AS [Spädbarnsdödlighet]
    ROUND( AVG( CONVERT(FLOAT, REPLACE( [Infant mortality (per 1000 births)], ',', '.' )))*100, 0) AS [Spädbarnsdödlighet]
FROM #countries
GROUP BY [Region]


-- f)
-- Från tabellen ”Airports”, gruppera per land och ta ut kolumner som visar:
-- land, antal flygplatser (IATA-koder), antal som saknar ICAO-kod, samt hur
-- många procent av flygplatserna i varje land som saknar ICAO-kod.

SELECT * INTO #airports FROM dbo.airports

SELECT * FROM #airports

-- CHARINDEX(',', REVERSE([Location served])
-- Istället för CASE kan du köra COUNT(*)-COUNT(kolumn_a) för att få antal NULL värden
SELECT 
    REVERSE( SUBSTRING( REVERSE([Location served]), -1,  CHARINDEX(',', REVERSE([Location served])))) AS Country,
    COUNT(IATA) AS [Number of Airports],
    SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) AS [Number of Missing ICAO-code],
    --(100/(COUNT(ICAO)+1))*SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) AS [Precentage of Missing ICAO-code]
    (CASE WHEN COUNT(ICAO)>0 THEN 100/SUM(CASE WHEN ICAO IS NULL THEN 1.0 ELSE 1.0 END)  ELSE 0 END)*SUM(CASE WHEN ICAO IS NULL THEN 1.0 ELSE 0 END) AS [Precentage of Missing ICAO-code]
FROM #airports
GROUP BY REVERSE( SUBSTRING( REVERSE([Location served]), -1,  CHARINDEX(',', REVERSE([Location served]))))
ORDER BY [Number of Missing ICAO-code] DESC


-- Uppgift 1
-- Ta ut alla l�nder med en kolumn f�r namn p� landet, en kolumn med antal st�der, och en kolumn med kommaseparerad lista med namnen p� st�derna.