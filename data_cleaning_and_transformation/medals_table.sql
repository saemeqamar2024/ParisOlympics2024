/** Creating a table containing medals data. **/
CREATE TABLE IF NOT EXISTS medals (
	medal_type VARCHAR(256),
	medal_code INT,
	medal_date DATE,
	athlete_name VARCHAR(256),
	gender CHAR(1),
	discipline VARCHAR(256),
	event_name VARCHAR(256),
	event_type VARCHAR(256),
	url_event VARCHAR(500),
	code VARCHAR(256),
	country_code CHAR(10),
	country VARCHAR(256),
	country_long VARCHAR(256)
);

/** Checking if all records imported. **/
SELECT COUNT(*) FROM medals;   			                                                       -- All 1044 records correctly imported.

/** CLEANING AND TRANSFORMING MEDALS TABLE. **/
/** Removing unnecessary columns **/
ALTER TABLE IF EXISTS medals DROP COLUMN IF EXISTS medal_code;
ALTER TABLE IF EXISTS medals DROP COLUMN IF EXISTS event_type;
ALTER TABLE IF EXISTS medals DROP COLUMN IF EXISTS url_event;
ALTER TABLE IF EXISTS medals DROP COLUMN IF EXISTS code;
ALTER TABLE IF EXISTS medals DROP COLUMN IF EXISTS country_code;
ALTER TABLE IF EXISTS medals DROP COLUMN IF EXISTS country;
ALTER TABLE IF EXISTS medals DROP COLUMN IF EXISTS gender;

/** Checking for any null/empty values in all columns. **/
SELECT * FROM medals WHERE medal_type IS NULL;
SELECT * FROM medals WHERE medal_date IS NULL;
SELECT * FROM medals WHERE athlete_name IS NULL;
SELECT * FROM medals WHERE discipline IS NULL;
SELECT * FROM medals WHERE event_name IS NULL;
SELECT * FROM medals WHERE country_long IS NULL;

/** Cleaning and transforming medal_type column. **/
SELECT COUNT(DISTINCT medal_type) FROM medals;  														  -- Only three medals exist.
SELECT medal_type FROM medals WHERE medal_type NOT IN ('Gold Medal', 'Silver Medal', 'Bronze Medal');  -- All medal types are either Gold, Silver or Bronze.
UPDATE medals SET medal_type = TRIM(both 'medal' from medal_type);
UPDATE medals SET medal_type = TRIM(trailing 'M' from medal_type);                                     -- Removing the word "medal" from all medals.

/** Cleaning and transforming "medal_date" column. **/
SELECT DISTINCT(medal_date) FROM medals ORDER BY medal_date ASC;
SELECT MIN(medal_date), MAX(medal_date) FROM medals;                             -- All dates are between 27/07/2024 (inclusive) and 11/08/2024 (inclusive). 

/** Cleaning and transforming "athlete_name" column. **/
-- Some of the athlete names are country names, because they refer to team sports where 1+ athletes participated.
SELECT COUNT(athlete_name) FROM medals WHERE athlete_name IN (country_long);     

/** Cleaning and transforming "discipline" column. **/
SELECT DISTINCT(discipline) FROM medals ORDER BY discipline ASC;                 -- There are 45 disciplines altogether, which is correct.

/** Cleaning and transforming the "country_long" column. **/
SELECT DISTINCT(country_long) FROM medals ORDER BY country_long ASC;

CREATE TABLE IF NOT EXISTS medals_cleaned AS TABLE medals;