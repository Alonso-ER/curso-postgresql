SELECT 
	id, 
	UPPER(name) as upper_name, 
	LOWER(name) as lower_name,
	LENGTH(name) as LENGTH,
	'20' as constante,
	'*'||id||'-'|| name||'*' as barcode,
	concat(id, ' - ', name),
	name 
FROM 
	users;