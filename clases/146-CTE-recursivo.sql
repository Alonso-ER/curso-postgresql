
SELECT 5;
-- Nombre de la tabla
-- campos que se van a tener
WITH RECURSIVE countdown( val ) as (
	-- Inicialización -> primer nivel o valores iniciales
	--VALUES(5)
	SELECT 1 as val
	UNION
	-- Query Recursivo
	SELECT val +1 from countdown WHERE val < 10
)
-- Select de los campos
SELECT *
FROM
	countdown;



WITH RECURSIVE contador( val ) as (
	SELECT 10 as val
	UNION
	SELECT val - 1 from contador WHERE val > 1
)
SELECT *
FROM
	contador;
	
	
	
WITH RECURSIVE mult_table(base, val, res) as (
	SELECT 
		5 as base, 
		1 as val, 
		5 as res
	UNION
	SELECT
		5 as base,
		val + 1,
		(val + 1) * base
		FROM 
			mult_table 
		WHERE val < 10
		
)
SELECT
	*
FROM
	mult_table;



