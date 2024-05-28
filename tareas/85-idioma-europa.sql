

-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America
-- 51	  | Asia
-- 58	  | Africa


(SELECT
	COUNT(*) as total,
	b.name
from 	
	country a 
INNER JOIN continent b ON a.continent = b.code
WHERE
	b."name" not like '%America%'
GROUP by b."name")
UNION
(SELECT
	COUNT(*) as total,
	'America'
from 	
	country a 
INNER JOIN continent b ON a.continent = b.code
WHERE
	b."name" like '%America%')
ORDER BY
	total ASC;
	
-- País con mas cuidades
-- Campos: Total de cuidades y nombre del país
-- Usar Inner Join

SELECT 
	COUNT(*) as totalCitys,
	a."name" as country
from country a
INNER JOIN
	city b on a.code = b.countrycode
GROUP BY 
	a."name"
ORDER BY COUNT(*) desc
LIMIT 1;

-- ¿Cuales son los idiomas oficiales por cada continente?

SELECT DISTINCT
	d."name",
	c."name" as continent
FROM
	countrylanguage a
INNER JOIN 
	country b ON a.countrycode = b.code
INNER JOIN
	continent c on b.continent = c.code
INNER JOIN 
	"language" d on d.code = a.languagecode

WHERE
	a.isofficial = true;
	
-- ¿Cuantos idiomas oficiales se hablan por continente?

SELECT 
	COUNT(*),
	continent
FROM (
	SELECT DISTINCT
		a."language",
		c."name" as continent
	FROM
		countrylanguage a
	INNER JOIN 
		country b ON a.countrycode = b.code
	INNER JOIN
		continent c on b.continent = c.code
	WHERE
		a.isofficial = true
) 
AS totales
GROUP BY
continent;






-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?

select * from countrylanguage where isofficial = true;

select * from country;

select * from continent;

Select * from "language";

SELECT 
	count(*),
	b.languagecode,
	b."language"
FROM
	country a
INNER JOIN 
	countrylanguage b on b.countrycode = a.code
WHERE
	(a.continent = 8)
	and (b.isofficial = true)
GROUP BY
	b.languagecode,
	b."language"
ORDER BY
	COUNT(*) desc
LIMIT 1;



-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa 
-- (no hacer subquery, tomar el código anterior)

SELECT 
	b.languagecode,
	b."language",
	a."name"
FROM
	country a
INNER join 
	countrylanguage b on a.code = b.countrycode
WHERE
	a.continent = 8
	and b.languagecode = 101
	and b.isofficial = true;





