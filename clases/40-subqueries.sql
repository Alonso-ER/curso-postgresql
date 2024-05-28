SELECT 
	count(*),
	country
FROM 
	users
GROUP BY 
	country
HAVING 
	count(*) >5
ORDER BY 
	COUNT(*) desc;
	


SELECT 
	DISTINCT country
FROM 
	users;
	
	
SELECT
    *
FROM(
        SELECT
            count(*),
            -- SUBSTRING(email, 0, (POSITION('@' in email))),
            SUBSTRING(email, POSITION('@' in email) + 1) as domain,
            'Fernando' as name,
            37 as USAGE
        FROM
            users
        group by
            SUBSTRING(email, POSITION('@' in email) + 1)
        HAVING
            COUNT(*) > 1
        ORDER BY
            SUBSTRING(email, POSITION('@' in email) + 1) ASC
) as email_domains;



