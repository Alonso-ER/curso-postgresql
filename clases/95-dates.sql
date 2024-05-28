SELECT 
	(SELECT count(*)
	FROM employees)
as nombre;

SELECT
	date_part('hours', now()) as hours,
	date_part('minutes', now()) as minutes,
	date_part('seconds', now()) as seconds,
	date_part('days', now()) as day,
	date_part('months', now()) as month,
	date_part('years', now()) as year,
	now(),
	CURRENT_DATE,
	CURRENT_TIME;
	
SELECT * from employees
WHERE hire_date > date('1998-02-05')
order by hire_date desc;

SELECT 
	max(hire_date) as mas_nuevo,
	min(hire_date) as mas_viejo
from employees;


SELECT * from employees
where hire_date BETWEEN '1999-01-01' and '2001-01-01'
ORDER BY hire_date desc;

SELECT
	max(hire_date),
	-- max(hire_date) + INTERVAL '1 days' as days,
	-- max(hire_date) + INTERVAL '1 months' as months,
	-- max(hire_date) + INTERVAL '1 years' as year,
	max(hire_date) + INTERVAL '1 years' + INTERVAL '1 day' as years,
	MAKE_INTERVAL( YEARS:= date_part('years', now())::INTEGER)
FROM
	employees;


SELECT 
	hire_date,
	MAKE_INTERVAL(YEARS := 2024 - EXTRACT( YEARS FROM hire_date )::INTEGER ) as manual,
	
	MAKE_INTERVAL(YEARS := date_part('years', CURRENT_DATE)::INTEGER - 
		EXTRACT( YEARS FROM hire_date )::INTEGER ) as computed
FROM 
	employees
ORDER BY
	hire_date DESC;
	
	
UPDATE employees
set 
	hire_date = hire_date + INTERVAL '24 years';
	
	

SELECT 
	first_name,
	last_name,
	hire_date,
	CASE
		WHEN hire_date > now() - INTERVAL '1 year'
			THEN '1 año o menos'
		WHEN hire_date > now() - INTERVAL '3 year'
			THEN '1 a 3 años'
		WHEN hire_date > now() - INTERVAL '6 years'
			THEN '3 a 6 años'
		else 'Más de 6 años'
	END as rango_antiguedad
FROM
	employees
ORDER BY
	hire_date DESC;







