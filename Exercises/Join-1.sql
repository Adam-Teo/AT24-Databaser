USE everyloop


-- COMPANY -- 
-- 1) 
-- Företagets totala produktkatalog består av 77 unika produkter. 
-- Om vi kollar bland våra ordrar, hur stor andel av dessa produkter 
-- har vi någon gång leverarat till London?
SELECT * INTO #products FROM company.products
SELECT * INTO #order_details FROM company.order_details
SELECT * INTO #orders FROM company.orders

SELECT * FROM #products
SELECT * FROM #order_details
SELECT * FROM #orders

SELECT 
    #orders.ShipCity,
    COUNT(DISTINCT #products.ProductName) AS [Antal Unika Produkter],
    ROUND( CAST( COUNT(DISTINCT #products.ProductName) AS FLOAT)/0.77, 2) AS [Andel av Unika Producter]
FROM #products
INNER JOIN #order_details ON #products.Id = #order_details.ProductId
INNER JOIN #orders ON #order_details.OrderId = #orders.Id
GROUP BY #orders.ShipCity 
HAVING #orders.ShipCity LIKE 'London'


-- Byt ut 0.77
-- cast((select count(*) from company.product) as float)


-- 2)
-- Till vilken stad har vi levererat flest unika produkter?

SELECT TOP 1
    #orders.ShipCity,
    COUNT(DISTINCT #products.ProductName) AS [Antal Unika Produkter],
    ROUND( CAST( COUNT(DISTINCT #products.ProductName) AS FLOAT)/0.77, 2) AS [Andel av Unika Producter]
FROM #products
INNER JOIN #order_details ON #products.Id = #order_details.ProductId
INNER JOIN #orders ON #order_details.OrderId = #orders.Id
GROUP BY #orders.ShipCity 
ORDER BY [Andel av Unika Producter] DESC

-- 3)
-- Av de produkter som inte längre finns I vårat sortiment,
-- hur mycket har vi sålt för totalt till Tyskland?
-- (!) Kunde inte hitta UnitsSold så multiplicerade Freight med UnitPrice
SELECT TOP 1 
    #orders.ShipCountry AS [Country], 
    ROUND( SUM(CASE WHEN #products.Discontinued = 1 THEN #order_details.Quantity*#products.UnitPrice ELSE 0 END), 0) AS [Sold For]
FROM #products
INNER JOIN #order_details ON #products.Id = #order_details.ProductId
INNER JOIN #orders ON #order_details.OrderId = #orders.Id
GROUP BY #orders.ShipCountry
HAVING #orders.ShipCountry LIKE 'Germany'

-- SUM(.UnitPrice * Quantity)
-- *discount
-- WHERE ShipCountry='Germany' AND #products.Distcontinued = 1
-- Tror jag fick för högt värde så dubbelkolla att du inte får alla 

-- 4)
-- För vilken produktkategori har vi högst lagervärde?
SELECT * INTO #categories FROM company.categories 

SELECT * FROM #categories

SELECT TOP 1
    #categories.CategoryName, 
    SUM(#products.UnitsInStock) AS [UnitsInStock],
    ROUND(SUM(#products.UnitsInStock*#products.UnitPrice), 0) AS [ValueInStock]
    --SUM(CASE WHEN #products.Discontinued = 1 THEN #orders.Freight ELSE 0 END) AS Freight
FROM #order_details
INNER JOIN #products ON #products.Id = #order_details.ProductId
INNER JOIN #orders ON #orders.Id = #order_details.OrderId 
INNER JOIN #categories ON #categories.Id = #products.CategoryId 
GROUP BY #categories.CategoryName
ORDER BY [UnitsInStock]

-- Rapahael fick ut seafod som högst lagervärde
-- Du kan även skriva din sum i order by vilkoret

-- 5) 
-- Från vilken leverantör har vi sålt flest 
-- produkter totalt under sommaren 2013?
SELECT * INTO #suppliers FROM company.suppliers

SELECT TOP 1
    #categories.CategoryName, 
    SUM(#products.UnitsInStock) AS [UnitsInStock],
    ROUND(SUM(#products.UnitsInStock*#products.UnitPrice), 0) AS [ValueInStock]
    --SUM(CASE WHEN #products.Discontinued = 1 THEN #orders.Freight ELSE 0 END) AS Freight
FROM #order_details
INNER JOIN #products ON #products.Id = #order_details.ProductId
INNER JOIN #orders ON #orders.Id = #order_details.OrderId 
INNER JOIN #categories ON #categories.Id = #products.CategoryId 
GROUP BY #categories.CategoryName
ORDER BY [UnitsInStock]

-- Rapahaels version
SELECT 
    #supliers.CompanyName,
    SUM(order_details.Quantity)
FROM #orders
    JOIN #order_details ON #order_details.OrderID = #orders.id
    JOIN #products ON #orders.OrderId = #products.Id
    JOIN #supliers ON #products.SupplierId = #supliers.Id
WHERE orders.OrderDate >= '2013-06-01' and orders.OrderDate <= '2013-09-91'
-- WHERE CAST(orders.OrrderDate)
GROUP BY
    #supliers.CompanyName
ORDER BY 
    'Sales' desc

SELECT * FROM company.suppliers
SELECT * FROM company.employees
SELECT * FROM #orders
-- MUSIC --

-- 0)
-- Använd dig av tabellerna från schema "music", och utgå från:

SELECT * FROM music.genres; 
DECLARE @playlist nvarchar(max) = 'Heavy metal Classic'

SELECT
    g.Name as 'Genre',
    ar.Name as 'Artist',
    ab.Title as 'Album',
    mt.Name as 'Track',
    format(dateadd(MILLISECOND, mt.Milliseconds, 0), 'mm:ss') as 'Duration',
    format(mt.Bytes / power(1024, 2), 'N1') + 'MB',
    isnull(Composer, 'N/A') as 'Composer'

FROM
    music.tracks mt
    JOIN music.genres g ON mt.Genreid = g.GenreId 
    JOIN music.albums ab ON ab.AlbumId = mt.AlbumId
    JOIN music.artists ar ON ab.ArtistId = ar.ArtistId 

-- JOIN music.playlist_track pt on pt.TrackId = mt.TrackId
-- JOIN music.playlists p on p.PlaylistId = pt.PlaylistId
-- WHERE
-- p.Name = @playlist
-- ORDER BY 
-- g.Name, ar.Name, ab.Title


-- 1)
-- Av alla audiospår, vilken artist har längst total speltid? 
SELECT * INTO #artists FROM music.artists
SELECT * INTO #albums FROM music.albums
SELECT * INTO #tracks FROM music.tracks

SELECT * FROM #artists
SELECT * FROM #albums
SELECT * FROM #tracks

SELECT #artists.Name, #albums.Title, #tracks.Milliseconds
FROM #artists
INNER JOIN #albums ON #artists.ArtistId = #albums.ArtistId
INNER JOIN #tracks ON #albums.AlbumId = #tracks.AlbumID

SELECT TOP 1 #artists.Name, SUM(#tracks.Milliseconds) AS [Total Track Time]
FROM #artists
INNER JOIN #albums ON #artists.ArtistId = #albums.ArtistId
INNER JOIN #tracks ON #albums.AlbumId = #tracks.AlbumID
GROUP BY #artists.Name
ORDER BY SUM(#tracks.Milliseconds) DESC



-- 2) 
-- Vad är den genomsnittliga speltiden på den artistens låtar?
SELECT TOP 1 
    #artists.Name,
    SUM(#tracks.Milliseconds) AS [Total Track Time], 
    AVG(#tracks.Milliseconds) AS [Average Track Time]
FROM #artists
INNER JOIN #albums ON #artists.ArtistId = #albums.ArtistId
INNER JOIN #tracks ON #albums.AlbumId = #tracks.AlbumID
GROUP BY #artists.Name
ORDER BY SUM(#tracks.Milliseconds) DESC


-- 3) 
-- Vad är den sammanlagda filstorleken för all video?
SELECT * INTO #media_types FROM music.media_types

SELECT * FROM #tracks
SELECT * FROM #media_types

-- SELECT #tracks.Name, #media_types.Name
-- FROM #tracks
-- INNER JOIN #media_types ON #tracks.MediaTypeId=#media_types.mediaTypeId
-- WHERE #media_types.Name LIKE '%video%'

SELECT TOP 1 #media_types.Name, SUM(CONVERT(BIGINT, #tracks.Bytes))/1000000000 AS GB
FROM #tracks 
INNER JOIN #media_types ON #tracks.MediaTypeId=#media_types.mediaTypeId
--- WHERE #media_types.Name LIKE '%video%'
GROUP BY #media_types.Name 
ORDER BY SUM(CONVERT(BIGINT, #tracks.Bytes)) DESC

-- GROUP BY #artists.Name
-- ORDER BY SUM(#tracks.Milliseconds) DESC


-- 4)
-- Vilket är det högsta antal artister som finns på en enskild spellista?
SELECT * INTO #playlist FROM music.playlists
SELECT * INTO #playlist_track FROM music.playlist_track

SELECT * FROM #playlist
SELECT * FROM #playlist_track
SELECT * FROM #tracks
SELECT * FROM #albums
SELECT * FROM #artists


-- CONNECTIONS 
SELECT 
    #playlist.Name, 
    #playlist_track.TrackId,
    #tracks.Name,
    #albums.Title,
    #artists.Name
FROM #playlist
INNER JOIN #playlist_track ON #playlist.PlaylistId = #playlist_track.PlaylistId
INNER JOIN #tracks ON #playlist_track.TrackId = #tracks.TrackId
INNER JOIN #albums ON #tracks.AlbumId = #albums.AlbumId
INNER JOIN #artists ON #albums.ArtistId = #artists.ArtistId

-- FINAL - I Dont Know if This is Correct
SELECT 
    #playlist.Name,
    COUNT(DISTINCT #artists.Name) AS [Number of Artists],
    COUNT(#artists.Name) AS [Number of Artist Songs] 
FROM #playlist
INNER JOIN #playlist_track ON #playlist.PlaylistId = #playlist_track.PlaylistId
INNER JOIN #tracks ON #playlist_track.TrackId = #tracks.TrackId
INNER JOIN #albums ON #tracks.AlbumId = #albums.AlbumId
INNER JOIN #artists ON #albums.ArtistId = #artists.ArtistId
GROUP BY #playlist.Name

-- 5) 
-- Vilket är det genomsnittliga antalet artister per spellista?
SELECT 
    #playlist.Name,
    COUNT(DISTINCT #artists.Name) AS [Number of Artists],
    COUNT(#artists.Name) AS [Number of Artist Songs] 
FROM #playlist
INNER JOIN #playlist_track ON #playlist.PlaylistId = #playlist_track.PlaylistId
INNER JOIN #tracks ON #playlist_track.TrackId = #tracks.TrackId
INNER JOIN #albums ON #tracks.AlbumId = #albums.AlbumId
INNER JOIN #artists ON #albums.ArtistId = #artists.ArtistId
GROUP BY #playlist.Name
