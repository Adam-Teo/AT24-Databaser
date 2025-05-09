use everyloop

-- Uppgift 1
-- SELECT title, "U.S. viewers(millions)"*1000000 as views 
-- FROM dbo.GameOfThrones
-- WHERE EpisodeInSeason = 1


-- Uppgfit 2 
-- SELECT *
-- FROM dbo.GameOfThrones 
-- WHERE season not in (2, 5, 7)

-- Uppgift 3
-- SELECT season as Säsong, title, episode as  Avsnitt 
-- FROM dbo.GameOfThrones
-- WHERE "U.S. viewers(millions)" BETWEEN 4 AND 5

-- Uppgift 4
-- SELECT * 
-- FROM dbo.Users
-- WHERE FirstName LIKE '[a-b]%'

-- Uppgift 5 
-- SELECT * 
-- FROM dbo.Users
-- WHERE FirstName LIKE '_[aouieyåäö]%'

-- Uppgift 6
-- SELECT *
-- FROM dbo.Users
-- WHERE LastName LIKE '%son'
-- OR FirstName LIKE '__'
