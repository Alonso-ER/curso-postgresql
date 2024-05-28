SELECT * FROM regions;


SELECT * FROM country_region();


SELECT 
	country_id, country_name, region_name
from countries
INNER JOIN 
	regions ON countries.region_id = regions.region_id;


-- * Funcion que retorna una tabla
CREATE or REPLACE FUNCTION country_region()
	RETURNS TABLE ( id CHARACTER(2),
					name VARCHAR(40),
					region VARCHAR(25))
	as $$

	BEGIN
	RETURN query
		SELECT country_id, country_name, region_name
		from countries
		INNER JOIN regions 
		ON countries.region_id = regions.region_id;
		
	END;
	$$ 
LANGUAGE plpgsql;



-- ! Procedimiento almacenado

CREATE or REPLACE PROCEDURE insert_region_proc(int, VARCHAR)
as $$
BEGIN
	INSERT INTO regions(region_id, region_name)
	VALUES($1, $2);
	
	raise notice 'Variable: %, %', $1, $2;
	
	--? ROLLBACK;- Echarse atras con los cambios
	COMMIT;
END;
$$ LANGUAGE plpgsql;



CALL insert_region_proc(5, 'Central America');

SELECT * FROM regions;



--? Nose



-- percentage: 5.2
CREATE or REPLACE PROCEDURE controlled_raise (percentage NUMERIC) as 
$$
DECLARE
	real_percentage NUMERIC(8,2);
	total_employees int;

BEGIN
	real_percentage = percentage / 100; -- 5% = 0.05;
	
	--Mantener el historico
	INSERT INTO raise_history(
		date, employee_id, base_salary, amount, percentage)
	SELECT
		CURRENT_DATE as "date",
		employee_id,
		salary,
		max_raise(employee_id) * real_percentage as amount,
		percentage
	FROM employees;
	
	-- Impactar la tabla empleados
	UPDATE employees
	set salary = (max_raise(employee_id) * real_percentage) + salary;
	COMMIT;
	
	SELECT COUNT(*) into total_employees FROM employees;
	raise notice 'Afectados: % empleados', total_employees;
END;
$$ LANGUAGE plpgsql;


CALL controlled_raise(1);

SELECT * FROM employees;
SELECT * from raise_history;



SELECT 
	max_raise(employee_id), 
	salary, 
	job_id
FROM employees;

SELECT
	CURRENT_DATE as "date",
	employee_id,
	salary,
	max_raise(employee_id),
	max_raise(employee_id) * 0.05 as amount,
	5 as percentage,
	salary + (max_raise(employee_id) * 0.05) as salary_plus_raise
from employees;