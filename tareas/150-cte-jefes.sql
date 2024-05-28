SELECT * from employees;

SELECT * FROM employees 
WHERE 
	reports_to = 1
UNION
SELECT * FROM employees 
WHERE 
	reports_to in (2, 3)
UNION
SELECT * FROM employees 
WHERE 
	reports_to in (6,4,5);
	
	
WITH RECURSIVE bosses as (
	SELECT id, name, reports_to
		FROM employees
		WHERE id = 7
	UNION
	SELECT 
		employees.id, 
		employees.name, 
		employees.reports_to 
		from employees
		INNER JOIN 
			bosses 
		on bosses.id = employees.reports_to
		
)
SELECT * FROM bosses;



WITH RECURSIVE bosses as (
	SELECT id, name, reports_to,
		1 as depth
		FROM employees
		WHERE id = 1
	UNION
	SELECT 
		employees.id, 
		employees.name, 
		employees.reports_to,
		depth + 1
		from employees
		INNER JOIN 
			bosses 
		on bosses.id = employees.reports_to
		WHERE depth < 6 
)
SELECT
	bosses.*,
	employees.name as reports_to_name
FROM bosses
LEFT JOIN
	employees on employees.id = bosses.reports_to
ORDER BY
	depth;



