create EXTENSION pgcrypto;


insert into "user" (username, password)
values(
	'Yang Wenli', 
	crypt('123456', gen_salt('bf') )
	);


SELECT * from "user" 
WHERE username = 'Yabuki' and 
	password = crypt('123456', password);
	

SELECT * FROM "user";
SELECT * from session_failed;



--!Procedure

create or replace PROCEDURE
user_login ( user_name VARCHAR, user_password VARCHAR)
as $$
DECLARE
	was_found BOOLEAN;
	
BEGIN
	SELECT COUNT(*) INTO was_found from "user" 
	WHERE username = user_name and 
		password = crypt(user_password, password);
	--? Sí da error
	if(was_found = FALSE) THEN
		INSERT INTO session_failed(username, "when")
		VALUES(user_name, now());
		COMMIT;
		raise EXCEPTION 'Usuario y contraseña no son correctos';	
	END IF;
	
	UPDATE "user" set last_login = now() WHERE username = user_name;
	COMMIT;
	raise notice 'Usuario encontrado %', was_found;
END;
$$ LANGUAGE plpgsql;


-- * Ejemplo de inserción
CALL user_login('Yabuki', '12345236');



