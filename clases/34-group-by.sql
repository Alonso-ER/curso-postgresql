-- Nombre, apellido e IP, donde la última conexión se dió de 221.XXX.XXX.XXX

select 
	first_name, last_name, last_connection 
from users
where last_connection like '221.%';

-- Nombre,apellido y seguidores(followers) de todos a los que lo siguen m á s de 4600 personas

select
    first_name,
    last_name,
    followers
from
    users
where
    -- followers >= 4600 AND followers <= 4700
    followers BETWEEN 4600 and 4700
order by 
	followers ASC;


	
	
SELECT 
	COUNT(*) AS total_users,
	MIN(followers) as min_followers,
	MAX(followers) as max_followers,
	AVG(followers) as avg_followers,
	ROUND(AVG(followers)) as avg_followers_ROUND,
	SUM(followers) / COUNT(*) AS avg_manual
FROM users;




SELECT COUNT(*), 
    followers
from 
    users
where   
    followers = 4 or followers = 4999
GROUP BY 
    followers
order by 
    followers ASC;



SELECT 
    COUNT(*), followers
FROM 
    users 
where   
    followers BETWEEN 4500 and 4999
GROUP by 
    followers
order by 
    followers ASC;

