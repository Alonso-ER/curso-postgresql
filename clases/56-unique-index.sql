SELECT * FROM city;


ALTER TABLE
	city
DROP CONSTRAINT "city_id";

CREATE UNIQUE INDEX "unique_name_countrycode_distrinct" on city(
	name, countrycode, district
);

CREATE INDEX "index_distrinct" on city(
	district
);