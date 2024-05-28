SELECT * from employees;

SELECT GREATEST(1,2,30,5);

SELECT COALESCE(null, 'Hola mundo');

SELECT greet_employee('Fernando');

SELECT first_name, greet_employee(first_name) FROM employees;

SELECT 
	employee_id, first_name, salary, max_salary,
	max_salary - salary as possible_raise,
	max_raise(employee_id),
	max_raise2(employee_id)
from employees
INNER JOIN jobs on jobs.job_id = employees.job_id;


SELECT max_raise(206);

SELECT *, max_raise2(employee_id) from employees WHERE employee_id = 206;

SELECT employee_id, first_name, salary, max_raise3(employee_id)
from employees WHERE employee_id = 206;



-- ! Primera funcion simple

CREATE or REPLACE 
FUNCTION greet_employee( employee_name VARCHAR )
RETURNS VARCHAR
as $$
-- declare
BEGIN
	RETURN 'Hola ' || employee_name;

END;
$$
LANGUAGE plpgsql;

-- ! Fin



-- ! Primera funcion max_raise

CREATE or REPLACE 
FUNCTION max_raise( empl_id int )
RETURNS NUMERIC(8,2) as 
$$
DECLARE
	-- salary NUMERIC(8,2)
	-- max_salary NUMERIC(8,2)
	possible_raise NUMERIC(8,2);

BEGIN
	SELECT 
		max_salary - salary INTO possible_raise
	from employees
	INNER JOIN jobs on jobs.job_id = employees.job_id
	WHERE employee_id = empl_id;
	
	return possible_raise;
END;

$$
LANGUAGE plpgsql;

-- ! Fin



-- ! Segunda funcion max_raise

CREATE or REPLACE 
FUNCTION max_raise2( empl_id int )
RETURNS NUMERIC(8,2) as 
$$
DECLARE
	employee_job_id int;
	current_salary NUMERIC(8,2);
	job_max_salary NUMERIC(8,2);
	possible_raise NUMERIC(8,2);
	
BEGIN
	-- Tomar puesto de trabajo y salario
	SELECT
		job_id, salary
	INTO
		employee_job_id, current_salary
	FROM employees
	WHERE 
		employee_id = empl_id;
	
	-- Tomar el max salary, acorde a su trabajo
	SELECT 
		max_salary into job_max_salary
	FROM jobs
	WHERE
		job_id = employee_job_id;
	
	-- Calculos
	possible_raise = job_max_salary - current_salary;
	
	IF( possible_raise < 0 ) THEN
	raise EXCEPTION 'Persona con salario mayor a max_salary: %', empl_Id;
		-- possible_raise = 0;
	end IF;
	
	RETURN possible_raise;
	
END;

$$
LANGUAGE plpgsql;

-- ! Fin



-- ! Tercera funcion max_raise

CREATE or REPLACE 
FUNCTION max_raise3( empl_id int )
RETURNS NUMERIC(8,2) as 
$$
DECLARE
	selected_employee employees%rowtype;
	selected_job jobs%rowtype;
	
	possible_raise NUMERIC(8,2);
	
BEGIN
	-- Tomar puesto de trabajo y salario
	SELECT * FROM employees into selected_employee
	WHERE 
		employee_id = empl_id;
	
	-- Tomar el max salary, acorde a su trabajo
	SELECT * FROM jobs into selected_job
	WHERE
		job_id = selected_employee.job_id;
	
	-- Calculos
	possible_raise = selected_job.max_salary - selected_employee.salary;
	
	IF( possible_raise < 0 ) THEN
	raise EXCEPTION 'Persona con salario mayor a max_salary: id:%, %',
		selected_employee.employee_id,	selected_employee.first_name;
		-- possible_raise = 0;
	end IF;
	
	RETURN possible_raise;
	
END;

$$
LANGUAGE plpgsql;

-- ! Fin