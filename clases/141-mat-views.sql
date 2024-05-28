

CREATE VIEW comments_per_week as
SELECT 
	date_trunc('week', posts.created_at) as weeks, 
	sum(claps.counter) as total_claps,
	COUNT(DISTINCT posts.post_id) as number_of_posts,
	COUNT(*) as number_of_claps
FROM 
	posts
INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY 
	weeks
order by 
	weeks desc;
	
	
SELECT * from posts WHERE post_id = 1;

SELECT * FROM comments_per_week;

DROP VIEW comments_per_week;



CREATE MATERIALIZED VIEW comments_per_week_mat as
SELECT 
	date_trunc('week', posts.created_at) as weeks, 
	sum(claps.counter) as total_claps,
	COUNT(DISTINCT posts.post_id) as number_of_posts,
	COUNT(*) as number_of_claps
FROM 
	posts
INNER JOIN claps ON claps.post_id = posts.post_id
GROUP BY 
	weeks
order by 
	weeks desc;
	
	
SELECT * FROM comments_per_week;
SELECT * FROM comments_per_week_mat;

REFRESH MATERIALIZED view comments_per_week_mat;

alter MATERIALIZED view comments_per_week_mat RENAME to posts_per_week_mat;




