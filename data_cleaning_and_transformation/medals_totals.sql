/** CREATING A MEDALS TABLE. **/
CREATE TABLE IF NOT EXISTS medals_table (
	country_code VARCHAR(50),
	country VARCHAR(256),
	country_long VARCHAR(256),
	gold_medal INT,
	silver_medal INT,
	bronze_medal INT,
	total INT
);


/** DATA CLEANING AND TRANSFORMATION **/
/** Verifying number of records in table. **/
SELECT COUNT(*) FROM medals_table;                       					 -- All 92 records have been imported correctly.

/** Removing unnecessary columns from table. **/
ALTER TABLE IF EXISTS medals_table DROP COLUMN IF EXISTS country_code;
ALTER TABLE IF EXISTS medals_table DROP COLUMN IF EXISTS country;
 
/** Checking if any duplicate records exist. **/
SELECT DISTINCT COUNT(*) FROM medals_table;             					 -- No duplicate records exist.

/** Checking for NULL values. **/
SELECT * FROM medals_table WHERE country_long IS NULL;  					-- No null values exist.
SELECT * FROM medals_table WHERE gold_medal IS NULL;    					-- No null values exist.
SELECT * FROM medals_table WHERE silver_medal IS NULL;						-- No null values exist.
SELECT * FROM medals_table WHERE bronze_medal IS NULL;						-- No null values exist.
SELECT * FROM medals_table WHERE total IS NULL;								-- No null values exist.

/** Cleaning and transforming the country_long column. **/
SELECT * FROM medals_table ORDER BY country_long ASC;   

/** Cleaning and transforming the gold_medal column. **/
SELECT MAX(gold_medal), MIN(gold_medal) FROM medals_table;   			   -- Minimum number of medals is 0, Maximum is 40.
SELECT DISTINCT(gold_medal) FROM medals_table ORDER BY gold_medal;  	   -- All values are numerical.

/** Cleaning and transforming the silver_medal column. **/
SELECT MAX(silver_medal), MIN(silver_medal) FROM medals_table;   		   -- Minimum number of medals is 0, Maximum is 44.
SELECT DISTINCT(silver_medal) FROM medals_table ORDER BY silver_medal;     -- All values are numerical.

/** Cleaning and transforming the bronze_medal column. **/
SELECT MAX(bronze_medal), MIN(bronze_medal) FROM medals_table;   		   -- Minimum number of medals is 0, Maximum is 42.
SELECT DISTINCT(bronze_medal) FROM medals_table ORDER BY bronze_medal;     -- All values are numerical.

/** Cleaning and transforming the total column. **/
SELECT MAX(total), MIN(total) FROM medals_table;   						   -- Minimum number of medals is 1, Maximum is 126.
SELECT DISTINCT(total) FROM medals_table ORDER BY total;  				   -- All values are numerical.

-- All values for Gold, Silver and Bronze medals correctly add up.
SELECT * FROM medals_table WHERE total <> gold_medal + silver_medal + bronze_medal; 					

CREATE TABLE IF NOT EXISTS medals_total_cleaned AS TABLE medals_table;