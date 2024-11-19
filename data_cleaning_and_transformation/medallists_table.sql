/** CLEANING AND TRANSFORMING THE MEDALLISTS TABLE. **/
SELECT COUNT(*) FROM medallists;  													      -- All 2315 records have been imported.

/** Removing unnecessary columns **/
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS medal_code;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS country_code;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS country;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS nationality_code;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS nationality;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS team;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS team_gender;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS event_type;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS url_event;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS code_team;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS is_medallist;
ALTER TABLE IF EXISTS medallists DROP COLUMN IF EXISTS nationality_long;

/** CLEANING AND TRANSFORMING "MEDAL_DATE" COLUMN. **/
SELECT medal_date FROM medallists WHERE medal_date IS NULL;    							-- No Null values exist.
SELECT * FROM medallists WHERE medal_date < '2024-07-27' OR medal_date > '2024/08/11';  -- No medal dates outside of Olympic events dates.

/** CLEANING AND TRANSFORMING "MEDAL_TYPE" COLUMN. **/
SELECT medal_type FROM medallists WHERE medal_date IS NULL;                             -- No Null values exist.
UPDATE medallists SET medal_type = LEFT(medal_type, POSITION(' ' IN medal_type));       -- Removing the word "medal" from column.
SELECT DISTINCT medal_type FROM medallists;												-- Checking if there are only three types of medals.

/** CLEANING AND TRANSFORMING "NAME" COLUMN. **/
SELECT * FROM medallists WHERE name IS NULL;											-- No Null values exist.

/** CLEANING AND TRANSFORMING "GENDER" COLUMN. **/
SELECT * FROM medallists WHERE gender <> 'Male' AND gender <> 'Female';					-- All genders are either "Male" or "Female".
SELECT * FROM medallists WHERE gender IS NULL;											-- No Null values exist.

/** CLEANING AND TRANSFORMING "COUNTRY_LONG" COLUMN. **/
SELECT country_long FROM medallists WHERE country_long IS NULL;							-- No Null values exist.

/** CLEANING AND TRANSFORMING "DISCIPLINE" COLUMN. **/
SELECT * FROM medallists WHERE discipline IS NULL;					            		-- No Null values exist.
SELECT DISTINCT discipline FROM medallists ORDER BY discipline ASC;                     -- Checking for any disciplines that are not considered as Olympics sport.

/** CLEANING AND TRANSFORMING "EVENT" COLUMN. **/
SELECT * FROM medallists WHERE event IS NULL;											-- No Null values exist.
SELECT DISTINCT event FROM medallists ORDER BY event ASC;                               -- Checking for any events that are not considered as Olympics events.

/** CLEANING AND TRANSFORMING "BIRTH DATE" COLUMN. **/
SELECT * FROM medallists WHERE birth_date IS NULL;										-- No Null values exist.
SELECT MIN(birth_date), MAX(birth_date) FROM medallists; 								-- Ensuring range of Dates of Birth is reasonable.

/** CLEANING AND TRANSFORMING "CODE ATHLETE" COLUMN. **/
SELECT * FROM medallists WHERE code_athlete IS NULL;									-- No Null values exist.

CREATE TABLE IF NOT EXISTS medallists_cleaned AS TABLE medallists;