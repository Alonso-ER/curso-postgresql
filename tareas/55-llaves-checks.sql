-- SELECT * FROM country WHERE continent = 'Africa';

-- create INDEX "country_continent" on country(
--	  continent
--);

SELECT * from city;

SELECT * from countrylanguage;

-- 1. Crear una llave primaria en city (id)
ALTER table city add PRIMARY KEY (id);


-- 2. Crear un check en population, para que no soporte negativos
ALTER TABLE city
ADD CHECK(population >= 0);



-- 3. Crear una llave primaria compuesta en "countrylanguage"
-- los campos a usar como llave compuesta son countrycode y language
ALTER table countrylanguage add PRIMARY KEY (
	countrycode, language
);



-- 4. Crear check en percentage, 
-- Para que no permita negativos ni números superiores a 100
ALTER TABLE countrylanguage
add CHECK(
	(percentage >=0) AND (percentage <=100)
);
	


