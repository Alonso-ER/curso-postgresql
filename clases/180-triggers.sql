
CALL user_login('Yabuki', '123456');
SELECT * from "session";

-- ! Creación del Trigger

create or REPLACE TRIGGER 
create_session_trigger AFTER UPDATE on "user"
for EACH ROW
-- Cuando se ejecuta?
WHEN(OLD.last_login is DISTINCT FROM NEW.last_login)
EXECUTE PROCEDURE create_session_log();



--! Funcion mediante la cual funciona el trigger
create or replace FUNCTION create_session_log()
RETURNS TRIGGER as $$

BEGIN
	INSERT INTO "session" (user_id, last_login)
	VALUES (NEW.id, now());
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;






