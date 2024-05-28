SELECT * from users;
SELECT * from followers;

SELECT b.id, leader."name" as leader,  follow."name" as follower 
from followers b 
INNER join users leader on leader.id = b.leader_id
INNER JOIN users follow on follow.id = b.follower_id;


SELECT
	follower_id
FROM
	followers
WHERE
	leader_id = 1;
	
	
SELECT * FROM followers
WHERE leader_id 
in ( SELECT
	follower_id
FROM
	followers
WHERE
	leader_id = 1);