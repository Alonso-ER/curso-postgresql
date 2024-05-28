

-- Tarea con countryLanguage

-- Crear la tabla de language

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;


-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);


-- Empezar con el select para confirmar lo que vamos a actualizar

SELECT 
DISTINCT 
    "language" 
from 
    countrylanguage;


INSERT INTO
	"language" (name)
SELECT DISTINCT 
	"language" 
from 
	countrylanguage;
	


SELECT 
	a.countrycode,
	a."language",
	( SELECT name FROM "language" b WHERE b."name" = "language" )
FROM 
	countrylanguage a;


-- Actualizar todos los registros

	
UPDATE
	countrylanguage a
SET 
	languagecode = ( SELECT code FROM "language" b WHERE b."name" = "language" );
	
SELECT * from "countrylanguage" WHERE countrycode = 'MEX';

SELECT * FROM "language" WHERE code = 363;



-- Cambiar tipo de dato en countrylanguage - languagecode por int4

ALTER TABLE
	countrylanguage
ALTER COLUMN 
    languagecode TYPE int4
USING 
    languagecode::INTEGER;


-- Crear el forening key y constraints de no nulo el language_code

-- HECHO A MANO

-- Revisar lo creado