USE everyloop

GO


-- MoonMissions --
-- 1A) 
SELECT 
    Spacecraft, 
    [Launch date], 
    [Carrier rocket], 
    Operator, 
    [Mission type]
INTO SuccessfulMissions
FROM dbo.MoonMissions
WHERE Outcome LIKE 'Successful'

GO


-- 1B)
UPDATE SuccessfulMissions 
SET Operator = LTRIM(RTRIM(Operator))

GO


-- 1C) 
UPDATE SuccessfulMissions
SET Spacecraft = CASE 
    WHEN CHARINDEX('(', Spacecraft) = 0 THEN Spacecraft
    ELSE SUBSTRING(Spacecraft, 0, CHARINDEX('(', Spacecraft)-2)
END

GO


-- 1D) 
SELECT Operator, [Mission type], COUNT(Operator) AS 'Mission Count'
FROM SuccessfulMissions
GROUP BY Operator, [Mission type]
HAVING COUNT(Operator) > 1
ORDER BY Operator, [Mission type] ASC

GO 


-- Users --
-- 2A) 
SELECT 
    ID, 
    UserName, 
    Password, 
    FirstName+' '+LastName AS Name, 
    Email, 
    Phone,
    CASE CONVERT(int, SUBSTRING(ID,10,1))%2
    WHEN 0 THEN 'FEMALE'
        ELSE 'MALE'
    END AS Gender
INTO NewUsers 
FROM dbo.Users

GO


-- 2B)
-- Jag har med -1 eftersom jag tolkar 'antalet gånger de är duplicerade' som 
-- att 3 lika dana användar namn är duplicerade 2 gånger.
SELECT UserName, COUNT(UserName)-1 AS [Duplicates]
FROM NewUsers
GROUP BY UserName
HAVING COUNT(UserName)>1 

GO


-- 2C)
ALTER TABLE NewUsers
ALTER COLUMN UserName VARCHAR(MAX)

SELECT 
    CAST(ROW_NUMBER() OVER (ORDER BY ID) AS VARCHAR(3) )AS idx,
    ID 
INTO #idx 
FROM NewUsers; 

WITH CTE AS (
    SELECT UserName
    FROM NewUsers
    GROUP BY UserName
    HAVING COUNT(UserName) > 1
)
UPDATE NewUsers
SET UserName = NewUsers.UserName+#idx.idx
FROM NewUsers
JOIN CTE it ON NewUsers.UserName = it.UserName
JOIN #idx ON NewUsers.ID = #idx.ID

GO


-- 2D) 
DELETE 
FROM NewUsers
WHERE 
    CONVERT(INT, SUBSTRING(ID, 0, 3)) < 70
    AND
    Gender = 'FEMALE'

GO


-- 2E)
DECLARE @key AS VARCHAR(MAX)
SET @key = LOWER(CONVERT(VARCHAR(32), REPLACE(NEWID(), '-', '')))
INSERT INTO NewUsers
VALUES ('820307-5212','samcoo', @key,'Sam Cooper', 'sam.cooper@yahoo.com','0701-8549543','MALE' )

GO


-- 2F)
SELECT gender, AVG( (FORMAT(GETDATE(),'yyyy')-1900)-(CONVERT(INT, SUBSTRING(ID, 0, 3))) ) AS [average age]
FROM newUsers
GROUP BY gender

GO


-- COMPANY --
-- 3A) 
SELECT * INTO #products FROM company.products
SELECT * INTO #suppliers FROM company.suppliers 
SELECT * INTO #categories FROM company.categories 

SELECT 
    #products.Id, ProductName AS Product, 
    #suppliers.CompanyName AS Supplyer, 
    #categories.CategoryName AS Category
FROM #products
INNER JOIN #suppliers ON #suppliers.Id=#products.SupplierId
INNER JOIN #categories ON #categories.Id=#products.CategoryId

GO 


-- 3B) 
SELECT * INTO #regions FROM company.regions
SELECT * INTO #employees FROM company.employees
SELECT * INTO #employees_territory FROM company.employee_territory
SELECT * INTO #territories FROM company.territories

SELECT #regions.RegionDescription, COUNT(DISTINCT #employees.LastName) AS NumberOfEmployees
FROM #regions
INNER JOIN #territories ON #territories.RegionId = #regions.Id
INNER JOIN #employees_territory ON #employees_territory.TerritoryId = #territories.Id
INNER JOIN #employees ON #employees.Id = #employees_territory.EmployeeId
GROUP BY #regions.RegionDescription

GO


-- 3C) 
SELECT 
    a.Id, 
    a.TitleOfCourtesy+' '+a.FirstName+' '+a.LastName AS Name,  
    CASE 
        WHEN b.firstName IS NULL 
        THEN 'Nobody!' 
        ELSE b.TitleOfCourtesy+' '+b.FirstName+' '+b.LastName  
    END AS [Reports to]
FROM #employees a
LEFT JOIN #employees b
ON b.Id = a.ReportsTo

GO