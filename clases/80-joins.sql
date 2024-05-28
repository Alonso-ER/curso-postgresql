SELECT code, name, 'By Name' FROM continent where name like '%America%'
UNION
SELECT code, name, 'By Code' from continent WHERE code in (1, 4)
ORDER BY code;


SELECT 
	a.name as country,
	b."name" as continent
from 
	country a,
	continent b
WHERE 
	a.continent = b.code
ORDER BY 
	a."name" ASC;
	
	
SELECT 
	a.name as country,
	b.name as continent
FROM
	country a 
INNER JOIN 
	continent b on a.continent = b.code
ORDER BY
	a.name ASC;
	

-- Alterar la secuencia
-- alter SEQUENCE continent_code_seq RESTART with 10;


-- FULL OUTER JOIN
SELECT 
	a."name" as country,
	a.continent as continentCode,
	b.name as continentName
FROM country a
FULL OUTER JOIN continent b
ON a.continent = b.code
ORDER BY
	a."name" desc;
	

-- RIGHT OUTER JOIN

SELECT 
	a."name" as country,
	a.continent as continentCode,
	b.name as continentName
FROM 
	country a 
RIGHT JOIN 
	continent b 
ON a.continent = b.code
WHERE a.continent IS NULL;


(SELECT
	COUNT(*) as count,
	b.name from country a 
INNER JOIN continent b ON a.continent = b.code
GROUP by b."name")
UNION
(SELECT 
	0 as COUNT, 
	b."name"
FROM
	country a 
RIGHT JOIN continent b ON a.continent = b.code
WHERE 
	a.continent is NULL
GROUP BY b."name")
ORDER BY
	name;







