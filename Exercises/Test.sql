-- USE everyloop

-- SELECT * INTO #countries FROM dbo.Countries
-- SELECT * FROM #countries


-- SELECT population FROM #countries

-- SELECT SQL_VARIANT_PROPERTY(population, 'BaseType') 
-- FROM #countries

-- UPDATE #countries
-- SET population = CONVERT(varchar(MAX), population)

-- ALTER TABLE #countries
-- ALTER COLUMN population INT

-- SELECT CONVERT(VARCHAR(MAX), population)+' Great'
-- FROM #countries

-- DECLARE @tar INT 
-- SET @tar = 0
-- DECLARE @var VARCHAR(1) = @tar; DELETE @tar
-- SELECT SQL_VARIANT_PROPERTY(@var, 'BaseType')


-- ALTER TABLE #countries
-- ADD "tot pop" INT NULL

-- SELECT 'tot pop' FROM #countries


-- DECLARE @dog VARCHAR(4) = 'Fury' 
-- SET @dog = ' dog'
-- SELECT @dog AS Dogs

-- SELECT population INTO @pop FROM #countries

-- DECLARE @my_list TABLE (
--     Animals VARCHAR(50)
-- );

-- INSERT INTO @my_list (Animals)
-- VALUES ('Cat'), ('Dog'), ('Mouse')

-- SELECT TOP 3 country, @my_list
-- FROM #countries 


-- CREATE TABLE #temp (
--     nation varchar(50),
--     pop int
-- )

-- INSERT INTO #temp (nation, pop)
-- SELECT country, population 
-- FROM #countries

-- SELECT population/1000000 AS [pop_mill] FROM #countries 
-- CROSS JOIN #temp ON pop = population

-- SELECT * FROM #temp

-- DROP TABLE #temp


-- CREATE TABLE #cat_a(
--     id int,
--     color varchar(10), 
--     name varchar(10),
-- ) 

-- CREATE TABLE #cat_b(
--     id int, 
--     color VARCHAR(10),
--     name varchar(10),
-- )

-- INSERT INTO #cat_a (id, color, name)
-- VALUES (1,'green','mittens'),(2,'blue','spot'),(3,'purple','james')

-- INSERT INTO #cat_b (id, color, name)
-- VALUES (1,'green','mittens'),(2,'orange','spot'),(3,'white','grumpy')

-- --SET id = 1 color=('red','blue','green'), name=('mittens','bruce','snowball')
-- SELECT * FROM #cat_a
-- SELECT * FROM #cat_b



-- --SELECT #cat_a.id, #cat_b.color, #cat_a.name
-- SELECT *
-- FROM #cat_a
-- LEFT JOIN #cat_b ON #cat_a.id = #cat_b.id 

-- DROP TABLE #birthdate
-- CREATE TABLE #birthdate (date INT)

-- INSERT INTO #birthdate (date)
-- VALUES (19720313), (19810508), (19631221)

-- SELECT FORMAT( date, 'YEAR #### | MONTH ## | DAY ## ')
-- FROM #birthdate


-- CREATE TABLE teacher(
--     id INT PRIMARY KEY IDENTITY(100, 5),
--     name nvarchar(MAX),
--     birthdate datetime2
-- )

-- INSERT INTO teacher VALUES('Teacher', getdate())
-- DELETE FROM teacher WHERE id BETWEEN 99 and 101

-- SELECT * FROM teacher

-- -- Tabellen fins fortfarande men den inehåller ingenting
-- TRUNCATE TABLE teacher

-- -- Generar ett generlt column namn
-- -- tänkta att alldrig krocka men det gör dom så va lite försiktigt
-- select newid();


-- CREATE TABLE products(
--     id UNIQUEIDENTIFIER PRIMARY KEY,
--     name nvarchar(MAX)
-- )
-- -- du kan lägga till primary key i efterhand
-- -- primary key behöver inte vara INT, can vara allt som är hashable, ex sträng
-- INSERT INTO products VALUES (newid(), 'mitt produktnamn')
-- SELECT * FROM products



-- CREATE TABLE tabell (
-- 	ID INT IDENTITY(100, 5),
-- 	datum DATETIME2 
-- )
-- -- ID startar på 100 och varje ny rad får senaste_id + 5

-- INSERT INTO tabell VALUES(getdate()) 
-- INSERT INTO tabell VALUES(getdate())
-- INSERT INTO tabell VALUES(getdate())
-- DELETE FROM tabell WHERE id BETWEEN 109 and 111
-- INSERT INTO tabell VALUES(getdate())

-- SELECT * FROM tabell

-- DROP TABLE #tabell
-- CREATE TABLE #tabell (
-- 	Prime INT PRIMARY KEY,
--     Secon INT SECONDARY KEY, 
-- 	datum DATETIME2 
-- )
-- INSERT INTO #tabell VALUES(1, 5,  getdate())
-- INSERT INTO #tabell VALUES(2, 10, getdate()) 
-- INSERT INTO #tabell VALUES(2, getdate())



-- CREATE TABLE products(
--     id UNIQUEIDENTIFIER PRIMARY KEY,
--     name nvarchar(MAX)
-- )
-- -- du kan lägga till primary key i efterhand
-- -- primary key behöver inte vara INT, can vara allt som är hashable, ex sträng
-- INSERT INTO products VALUES (newid(), 'mitt produktnamn')
-- SELECT * FROM products

-- DROP TABLE #tabell
-- CREATE TABLE #tabell (
-- 	GUID UNIQUEIDENTIFIER,
-- 	datum DATETIME2 
-- )
-- INSERT INTO #tabell VALUES(newid(), getdate())
-- INSERT INTO #tabell VALUES(newid(), getdate())

-- SELECT * FROM #tabell

USE everyloop
CREATE TABLE my_countries (
    id int, 
    name nvarchar(max)
)

INSERT INTO my_countries VALUES (1, 'Sweden')
INSERT INTO my_countries VALUES (2, 'Norway')
INSERT INTO my_countries VALUES (3, 'Denmark')
INSERT INTO my_countries VALUES (4, 'Finland')

CREATE TABLE cities (
    id int,
    name varchar(max),
    countryId int, 
)

insert into cities values (1, 'Stockholm', 1)
insert into cities values (2, 'Gothenburg', 1)
insert into cities values (3, 'Malmö', 1)
insert into cities values (4, 'Oslo', 2)
insert into cities values (5, 'Bergen', 2)
insert into cities values (6, 'Copenhagen', 3)
insert into cities values (7, 'London', 5)

SELECT
    cities.id,
    my_countries.id,
    countryId,
    cities.*,
    *
FROM 
    my_countries
    CROSS JOIN cities 


SELECT
    ci.id,
    ci.name AS 'City',
    co.name AS 'Country',
    ci.countryId
FROM
    my_countries AS co
    RIGHT JOIN cities ci ON co.id = ci.countryId 



-- 

SELECT
    my_countries.name AS 'Cities',
    COUNT(cities.id) AS 'Number of cities',
    ISNULL( STRING_AGG(cities.name, ','), '-') AS 'Cities'
FROM my_countries
FULL OUTER JOIN cities ON my_countries.id = cities.countryId
GROUP BY
    my_countries.name


SELECT * FROM my_countries, cities WHERE my_countries.id = cities.countryId

--

CREATE TABLE courses (
    id INT PRIMARY KEY,
    name NVARCHAR(MAX) 
)
INSERT INTO courses VALUES (1, 'Python')
INSERT INTO courses VALUES (2, 'Databehandling')
INSERT INTO courses VALUES (3, 'Databser')
INSERT INTO courses VALUES (4, 'Linjär algebra')

CREATE TABLE students (
    id INT PRIMARY KEY, 
    name NVARCHAR(MAX)
)

INSERT INTO students VALUES (1, 'Thomas')
INSERT INTO students VALUES (2, 'Stefan')
INSERT INTO students VALUES (3, 'Camilla')
INSERT INTO students VALUES (4, 'Daniel')
INSERT INTO students VALUES (5, 'Niklas')
INSERT INTO students VALUES (6, 'Anna')
INSERT INTO students VALUES (7, 'Helena')

CREATE TABLE studentsCourses(
    studentID INT,
    courseID INT 
) 

-- Det går att skriva på rad (1,1), (3,1), (4,1)
INSERT INTO studentsCourses VALUES (1,1)
INSERT INTO studentsCourses VALUES (3,1)
INSERT INTO studentsCourses VALUES (4,1)
INSERT INTO studentsCourses VALUES (6,1)
INSERT INTO studentsCourses VALUES (1,2)
INSERT INTO studentsCourses VALUES (6,2)
INSERT INTO studentsCourses VALUES (7,2)
INSERT INTO studentsCourses VALUES (1,3)
INSERT INTO studentsCourses VALUES (2,1)
INSERT INTO studentsCourses VALUES (3,1)
INSERT INTO studentsCourses VALUES (4,1)
INSERT INTO studentsCourses VALUES (5,1)
INSERT INTO studentsCourses VALUES (6,1)

SELECT * FROM students
SELECT * FROM courses
SELECT * FROM studentsCourses

-- Many to MAny Join
SELECT
    s.name AS 'Student name',
    c.name AS 'Course'
FROM
    students s
    JOIN studentsCourses sc ON s.id = sc.studentID
    JOIN courses c ON c.id = sc.courseID


-- Many to Many
SELECT
    c.name AS 'Course Name',
    count(s.id) AS 'Number of student'
FROM
    students s
    RIGHT JOIN studentsCourses sc ON s.id =sc.studentID
    RIGHT JOIN courses c ON c.id =sc.courseID
GROUP BY
    c.name --, s.id
ORDER BY


SELECT
    students.name AS 'Student',
    COUNT(studentId) AS 'Number of Courses'
FROM
    studentsCourses 
    RIGHT JOIN students on students.id = studentsCourses.studentID
GROUP BY
    students.name




-- Övningar -- 

SELECt * From



-- (!) REMOVE
DROP TABLE #red
CREATE TABLE #red (
    alpha VARCHAR(3),
    blue_id INT
)
INSERT INTO #red 
VALUES ('ABC',1),('ABC',1),('ABC',1),('TUV',2),('TUV',2)
SELECT * FROM #red

DROP TABLE #blue
CREATE TABLE #blue ( alpha VARCHAR(3), red_id INT )
INSERT INTO #blue 
VALUES ('DEF',1),('XYZ',2)
SELECT * FROM #blue

SELECT #red.alpha, #blue.alpha
FROM #red
INNER JOIN #blue ON #blue.red_id = #red.blue_id


-- VERSION A
SELECT #regions.RegionDescription, COUNT(#employees_territory.Id) AS NumberOfEmployees
FROM #regions
INNER JOIN #territories ON #territories.RegionId = #regions.Id
INNER JOIN #employees_territory ON #employees_territory.TerritoryId = #territories.Id
GROUP BY #regions.RegionDescription

GO


-- VERSION A
SELECT 
    Id, 
    TitleOfCourtesy+' '+FirstName+' '+LastName AS Name, 
    CASE WHEN ReportsTo IS NULL THEN 'Nobody!' ELSE CONVERT(VARCHAR(1), ReportsTo) END AS [Reports to] 
FROM #employees

-- VERSION B
-- SELECT 
--     A.Id, 
--     B.TitleOfCourtesy+' '+B.FirstName+' '+B.LastName AS Name, 
--     CASE WHEN A.ReportsTo IS NULL THEN 'Nobody!' ELSE CONVERT(VARCHAR(1), A.ReportsTo) END AS [Reports to] 
-- FROM #employees A, #employees B

-- VERSION C
SELECT DISTINCT
    A.Id, 
    A.TitleOfCourtesy+' '+A.FirstName+' '+A.LastName AS Name, 
    CASE WHEN A.ReportsTo IS NULL THEN 'Nobody!' ELSE CONVERT(VARCHAR(1), A.ReportsTo) END AS [Reports to] 
FROM #employees A
INNER JOIN #employees B ON A.Id=B.ReportsTo

SELECT DISTINCT
    A.Id, 
    A.TitleOfCourtesy+' '+A.FirstName+' '+A.LastName AS Name, 
    CASE WHEN A.ReportsTo IS NULL THEN 'Nobody!' ELSE CONVERT(VARCHAR(1), A.ReportsTo) END AS [Reports to]
FROM #employees A
LEFT JOIN #employees B ON A.Id=B.ReportsTo

-- LEFT JOIN #employees B ON A.Id=B.ReportsTo
-- INNER JOIN #employees B ON A.Id=B.ReportsTo
-- LEFT OUTER JOIN #employees B ON A.Id=B.ReportsTo

SELECT 
    B.Id as employee_id,
    B.TitleOfCourtesy+' '+B.FirstName+' '+B.LastName AS employee_name,
    A.Id as boss_id ,
    A.TitleOfCourtesy+' '+A.FirstName+' '+A.LastName AS boss_name
FROM
    #employees A,
    #employees B
WHERE
    B.ReportsTo = A.id




SELECT 
    B.Id as employee_id,
    B.TitleOfCourtesy+' '+B.FirstName+' '+B.LastName AS employee_name,
    A.Id as boss_id ,
    A.TitleOfCourtesy+' '+A.FirstName+' '+A.LastName AS boss_name
FROM
    #employees A,
    #employees B
WHERE
    B.ReportsTo = A.id



SELECT DISTINCT
    A.Id, 
    A.TitleOfCourtesy+' '+A.FirstName+' '+A.LastName AS Name, 
    CASE WHEN A.ReportsTo IS NULL THEN 'Nobody!' ELSE CONVERT(VARCHAR(1), A.ReportsTo) END AS [Reports to]
FROM #employees A
LEFT JOIN #employees B ON A.Id=B.ReportsTo


DECLARE @key AS VARCHAR(MAX)
SET @key = LOWER(CONVERT(VARCHAR(32), REPLACE(NEWID(), '-', '')))
PRINT LEN('1bf3fa859c48593f5f2606ccbaf2f30e')
newid()