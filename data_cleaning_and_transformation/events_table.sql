/** Creating an Events table. **/
CREATE TABLE IF NOT EXISTS events(
	event_name VARCHAR(256),
	tag VARCHAR(256),
	sport VARCHAR(256),	
	event_url VARCHAR(500));

SELECT COUNT(*) FROM events;  								       -- Checking if there are 329 records in table.

/** Cleaning and transforming the event_name column. **/
SELECT event_name FROM events WHERE event_name IS NULL;   				       -- No null values exist.

/** Cleaning and transforming the tag column. **/
UPDATE events SET tag = UPPER(SUBSTRING(tag from 1 for 1)) || LOWER(SUBSTRING(tag from 2));    -- Capitalising every first character in tag column.
UPDATE events SET tag = REPLACE(tag, '-', ' ');                                                -- Removing "-" from all tags.

SELECT tag FROM events WHERE tag IS NULL;               				       -- No null values exist.
SELECT DISTINCT * FROM events ORDER BY event_name ASC;  				       -- No duplicate values exist.

/** Cleaning and transforming the sport column. **/
ALTER TABLE IF EXISTS events DROP COLUMN IF EXISTS tag;  				       -- Tag column is removed.
SELECT * FROM events WHERE sport IS NULL;                				       -- No null values exist.

/** Cleaning and transforming the event_url column. **/
ALTER TABLE IF EXISTS events DROP COLUMN IF EXISTS event_url;   			       -- No need of this column. 

/** Creating a copy of the cleaned table. **/
CREATE TABLE IF NOT EXISTS events_cleaned AS TABLE events;