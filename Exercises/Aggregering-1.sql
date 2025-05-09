USE everyloop
-- 1)
-- Skriv en query som ger en kolumn med alla olika länder, 
-- samt en kolumn med antalet ordrar till vardera land, sortera på antal ordrar. 

SELECT * INTO #orders from company.orders
SELECT * FROM #orders 
SELECT COUNT(*) FROM #orders

SELECT ShipCountry, count(ShipCountry) AS Orders
FROM #orders
GROUP BY ShipCountry
ORDER BY Orders DESC


-- 2) 
-- Skriv en query som listar de olika regionerna, samt två kolumner 
-- som visar första, respektive senaste order som lagts i varje region.
SELECT ShipRegion, MIN(OrderDate) AS FirstOrder, MAX(OrderDate) AS LastOrder
FROM #orders
GROUP BY ShipRegion