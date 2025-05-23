USE everyloop
DROP TABLE #elements
SELECT Period, Number, Symbol, Name INTO #elements FROM elements WHERE Number <= 12

SELECT * FROM #elements

-- 1a) 
SELECT 
    symbol,
    [name]
FROM 
    #elements
WHERE left([name], len(symbol)) = symbol;

-- 1b) 
SELECT symbol, 
        [name]
FROM #elements
WHERE [name] LIKE '[hlb]%' OR
    [name] IN ('Carbon', 'Nitrogen', 'Oxygen');


-- 1c)
SELECT symbol,
        [name]
FROM #elements
WHERE [number] <5


-- 2) 
SELECT
    Period, 
    min(Number) as 'from', 
    max(Number) as 'to',
    string_agg(Symbol, ',') as 'Elements'
FROM
    #elements
GROUP BY
    Period; 


-- 3a)
DROP TABLE periodic_elements
CREATE TABLE periodic_elements ( 
    [Period] int,
    [from] int, 
    [to] int, 
    [Elements] NVARCHAR(max)
)

INSERT INTO  periodic_elements
SELECT
    Period, 
    min(Number) as 'from', 
    max(Number) as 'to',
    string_agg(Symbol, ',') as 'Elements'
FROM
    #elements
GROUP BY
    Period; 

SELECT * FROM periodic_elements

-- 3b) 
-- Nej för en kolumn har celler som innehåller fler
-- än ett värde, i det här fallet en komma sepparerad lista

-- 4
SELECT
--    Period, Number
    Period, Count(Number)
FROM
    #elements
GROUP BY
    Period;
-- Period, Number;    


-- 5 
-- JA 3NF 
-- 1NF Unika Kolumnnan, Rader i form av primär nycklar 
-- och entydiga celler
-- 2NF Alla kolumner i en tabell rellaterar till varandra
-- 3NF Tabbellerna som är sammankopplade är kopplade 
-- via primär och foreign keys


-- 6
-- 
DROP TABLE #course
CREATE TABLE #course (
    courseID int primary key,
    [name] nvarchar(120), 
    credits int)

INSERT INTO #course
VALUES (1, 'Math', 5), (2, 'Gym', 15), (3, 'Art', 10)
    

DROP TABLE #student
CREATE TABLE #student (
    studentID int primary key,
    [name] nvarchar(120))

INSERT INTO #student
VALUES (1, 'John'), (2, 'Lisa'), (3, 'Frank')
    

DROP TABLE #student_grade
CREATE TABLE #student_grade (
    courseID int references #course,
    studentID int references #student,
    grade nvarchar(2))

INSERT INTO #student_grade
VALUES 
    (1,1,'A'), (2,1,'F'), (3,1,'D'),
    (1,2,'B'), (2,2,'C'), (3,2,'A'),
    (1,3,'A'), (2,3,'B'), (3,3,'F')


SELECT s.name, c.name, grade
FROM #student s  
JOIN #student_grade sg ON s.studentID = sg.studentID 
JOIN #course c ON sg.courseID = c.courseID 



UPDATE #elements

UPDATE #elements
SET 
    [Period] = 5

SELECT * FROM #elements


------------------------

CREATE TABLE "zoo" (
	"id" INT PRIMARY KEY IDENTITY(1,1), 
	"djur" NVARCHAR(MAX), 
	"ålder" INT, 
	"namn" NVARCHAR(MAX),
)

INSERT INTO "zoo" ("djur", "ålder", "namn")
VALUES ('Tiger', 5, 'Nils'), ('Elefant', 3, 'Anna'), ('Elefant', 12, 'Stefan')

SELECT * FROM "zoo"

UPDATE "zoo"
SET "djur" = 'Liten Elefant' 
WHERE "ålder" Between 0-20

SELECT 
    CASE "namn" 
        WHEN 'Anna' THEN 'Linda' 
        WHEN 'Nils' THEN 'Tom'
        ELSE 'Carl'
        END
FROM "zoo"

SELECT * FROM zoo 

DELETE 
FROM "zoo"
WHERE "id" > 3


DECLARE @myDateTime2 DATETIME2(7) = '2025-05-22 20:31:42.1234567';

SELECT
    FORMAT(@myDateTime2, 'dd MMMM yyyy', 'sv-SE') AS Long_Swedish_Date,
    FORMAT(@myDateTime2, 'HH:mm') AS Time_24Hour
