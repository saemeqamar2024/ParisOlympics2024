/** Creating a table to contain data on Athletes. **/
CREATE TABLE IF NOT EXISTS athletes(
	code VARCHAR(256),
	athlete_name VARCHAR(256),
	gender VARCHAR(30),
	country_long VARCHAR(256),
	nationality_long VARCHAR(256),
	birth_date DATE);

/** Verifying if all records have been imported. **/
SELECT COUNT(*) FROM athletes;                    			                  -- All 11,113 records imported.


/** CLEANING AND TRANSFORMING THE ATHLETES TABLE. **/

/** Checking for null values in all columns. **/
SELECT code FROM athletes WHERE code IS NULL;     				          -- No null values exist.
SELECT athlete_name FROM athletes WHERE athlete_name IS NULL;                             -- No null values exist.
SELECT gender FROM athletes WHERE gender IS NULL;     			          	  -- No null values exist.
SELECT country_long FROM athletes WHERE country_long IS NULL;             		  -- No null values exist.
SELECT nationality_long FROM athletes WHERE nationality_long IS NULL;     		  -- 3 null values exist.
SELECT birth_date FROM athletes WHERE birth_date IS null;				  -- No null values exist.

/** Inserting the correct nationality for records with such missing data. **/
UPDATE athletes SET nationality_long = 'Czechia' WHERE athlete_name = 'GRYCZ Marek';
UPDATE athletes SET nationality_long = 'Netherlands' WHERE athlete_name = 'SANDERS Pien';
UPDATE athletes SET nationality_long = 'Italy' WHERE athlete_name = 'LIUZZI Emanuela';

/** Records containing NULL values for nationality_long. **/
SELECT * FROM athletes WHERE nationality_long IS NULL;					  -- No more records contain NULL nationality_long values.

/** Checking for duplicate values. **/
SELECT COUNT(DISTINCT code) FROM athletes;						  -- There are 11,113 distinct Code values.

/** Cleaning and transforming the "code" column. **/
SELECT LENGTH(code) FROM athletes WHERE LENGTH(code) <> 7;                                -- All codes have length of 7.

/** Cleaning and transforming the "athlete_name" column. **/
SELECT athlete_name FROM athletes ORDER BY athlete_name ASC;              		  -- One athlete is named as "671".
UPDATE athletes SET athlete_name = 'Liu Qingyi' WHERE code = '1909907';   		  -- Updating record for athlete with name "671".
SELECT * FROM athletes WHERE code = '1909907';

/** Cleaning and transforming the "gender" column. **/
SELECT * FROM athletes WHERE gender NOT IN ('Male', 'Female');            		  -- All athletes are categorised as either 'Male' or 'Female'.

/** Cleaning and transforming the "country_long" column. **/
ALTER TABLE IF EXISTS athletes RENAME COLUMN country_long TO country;     		  -- Renaming "country_long" column to "country".
SELECT DISTINCT(country) FROM athletes ORDER BY country ASC;              	          -- All countries that competed are included.

/** Cleaning and transforming the "nationality_long" column. **/
ALTER TABLE IF EXISTS athletes RENAME COLUMN nationality_long TO nationality;     	  -- Renaming "nationality_long" column to "nationality".
SELECT DISTINCT(nationality) FROM athletes ORDER BY nationality ASC;              	  -- All nationalities that competed are included.

/** Cleaning and transforming the "birth_date" column. **/
SELECT DISTINCT(birth_date) FROM athletes ORDER BY birth_date ASC;

/** Storing table in a new table. **/
CREATE TABLE IF NOT EXISTS athletes_cleaned AS TABLE athletes;