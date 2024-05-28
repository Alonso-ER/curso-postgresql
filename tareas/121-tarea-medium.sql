-- 1. Cuantos Post hay - 1050
SELECT 
	COUNT(*)
from posts;



-- 2. Cuantos Post publicados hay - 543
SELECT * from posts;

SELECT 
	COUNT(*)
from 
	posts
WHERE
	published = true;;


-- 3. Cual es el Post mas reciente
-- 544 - nisi commodo officia...2024-05-30 00:29:21.277

SELECT * FROM posts
ORDER BY created_at DESC
LIMIT 1;



-- 4. Quiero los 10 usuarios con más post, cantidad de posts, id y nombre
/*
4	1553	Jessie Sexton
3	1400	Prince Fuentes
3	1830	Hull George
3	470	Traci Wood
3	441	Livingston Davis
3	1942	Inez Dennis
3	1665	Maggie Davidson
3	524	Lidia Sparks
3	436	Mccoy Boone
3	2034	Bonita Rowe
*/

SELECT *
from users;

SELECT
	COUNT(*),
	a.user_id,
	a.name
FROM users a 
INNER JOIN
	posts b on b.created_by = a.user_id
GROUP by 
	a.user_id
ORDER by COUNT(*) DESC
LIMIT 10;


-- 5. Quiero los 5 post con más "Claps" sumando la columna "counter"
/*
692	sit excepteur ex ipsum magna fugiat laborum exercitation fugiat
646	do deserunt ea
542	do
504	ea est sunt magna consectetur tempor cupidatat
502	amet exercitation tempor laborum fugiat aliquip dolore
*/
SELECT * from posts;
SELECT * from claps;

-- Fallido
-- SELECT
-- 	COUNT(a.counter),
-- 	b.title
-- FROM 
-- 	claps a
-- INNER JOIN 
-- 	posts b on b.post_id = a.post_id
-- GROUP BY
-- 	a.counter,
-- 	b.title
-- ORDER BY
-- 	a.counter DESC
-- LIMIT 5;


SELECT
	SUM(a.counter) AS total_claps,
	b.title
FROM 
	claps a
INNER JOIN 
	posts b on b.post_id = a.post_id
GROUP BY
	b.post_id,
	b.title
ORDER BY
	total_claps DESC
LIMIT 5;



-- 6. Top 5 de personas que han dado más claps (voto único no acumulado ) *count
/*
7	Lillian Hodge
6	Dominguez Carson
6	Marva Joyner
6	Lela Cardenas
6	Rose Owen
*/
SELECT * from users;
SELECT * FROM claps;

SELECT
	COUNT(*),
	a.name
FROM
	users a 
INNER JOIN
	claps b on b.user_id = a.user_id
GROUP BY 
	a."name"
ORDER BY
	COUNT(*) DESC
LIMIT 5;





-- 7. Top 5 personas con votos acumulados (sumar counter)
/*
437	Rose Owen
394	Marva Joyner
386	Marquez Kennedy
379	Jenna Roth
364	Lillian Hodge
*/



-- 8. Cuantos usuarios NO tienen listas de favoritos creada
-- 329
SELECT * from users;
SELECT * from user_lists;

SELECT 
	COUNT(*)
FROM users a
WHERE
	a.user_id NOT in (SELECT user_id from user_lists);


-- 9. Quiero el comentario con id
-- Y en el mismo resultado, quiero sus respuestas (visibles e invisibles)
-- Tip: union
/*
1	    648	1905	elit id...
3058	583	1797	tempor mollit...
4649	51	1842	laborum mollit...
4768	835	1447	nostrud nulla...
*/
SELECT * from users;
SELECT * FROM claps;
SELECT * from "comments";

SELECT
	a.comment_id,
	a.post_id,
	a.user_id,
	a."content",
	a.comment_parent_id
FROM 
	"comments" a
WHERE
	a.comment_id = 3058;
	
	
SELECT 
	a.comment_id,
	a.post_id,
	a.user_id,
	a."content"
FROM
	"comments" a
WHERE
	comment_id = 1
UNION
	SELECT
		a.comment_id,
		a.post_id,
		a.user_id,
		a."content"
	FROM "comments" a 
	WHERE
		a.comment_parent_id = 1
ORDER BY
	comment_id ASC;

-- ** 10. Avanzado
-- Investigar sobre el json_agg y json_build_object
-- Crear una única linea de respuesta, con las respuestas
-- del comentario con id 1 (comment_parent_id = 1)
-- Mostrar el user_id y el contenido del comentario

-- Salida esperada:
/*
"[{""user"" : 1797, ""comment"" : ""tempor mollit aliqua dolore cupidatat dolor tempor""}, {""user"" : 1842, ""comment"" : ""laborum mollit amet aliqua enim eiusmod ut""}, {""user"" : 1447, ""comment"" : ""nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat""}]"
*/

	
SELECT json_agg( 
	json_build_object(
	'user', a.user_id,
	'comment', a."content"
))
FROM
	"comments" a
WHERE
	comment_parent_id=1;

SELECT json_build_object(
	'user', a.user_id,
	'comment', a."content"
)
	
FROM
	"comments" a
WHERE
	comment_parent_id=1;






-- ** 11. Avanzado
-- Listar todos los comentarios principales (no respuestas) 
-- Y crear una columna adicional "replies" con las respuestas en formato JSON

SELECT 
	a.comment_id,
	a.post_id,
	a.user_id,
	a."content",
	concat(	json_agg (
		json_build_object(
			'user', a.user_id,
			'comment', a."content"
		)
	)) as replies
from 
	"comments" a
WHERE
	a.comment_parent_id is NULL
GROUP BY
	a.comment_id;


