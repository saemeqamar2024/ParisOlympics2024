/** DATA ANALYSIS **/

/** The number of different sports. **/
-- There were 45 different sporting categories.
SELECT COUNT(DISTINCT sport) AS num_of_sporting_categories FROM events;

/** Counting the number of event types for each sporting category. **/
SELECT sport, COUNT(event_name) AS num_of_events
FROM events 
GROUP BY sport 
ORDER BY num_of_events DESC, sport ASC;

/** Top 10 countries in medals_cleaned table that have won the most number of medals in total. **/
SELECT country_long AS country, COUNT(medal_type) AS total_medals_won 
FROM medals_cleaned
GROUP BY country_long
ORDER BY total_medals_won DESC
LIMIT 10;

/** The USA is the only country that won more than 100 medals. **/
SELECT country_long AS country, COUNT(medal_type) AS total_medals_won 
FROM medals_cleaned
GROUP BY country_long
HAVING COUNT(medal_type) > 100
ORDER BY total_medals_won DESC;

/** Countries that have won the most Bronze, Silver and Gold medals. **/
-- The USA won 42 Bronze medals.
SELECT country, total_bronze_medals
FROM (SELECT country_long AS country, COUNT(medal_type) AS total_bronze_medals
	  FROM medals_cleaned
	  WHERE medal_type = 'Bronze '
	  GROUP BY country_long)
WHERE total_bronze_medals = (SELECT MAX(total_bronze_medals) 
							 FROM (SELECT country_long AS country, COUNT(medal_type) AS total_bronze_medals
	  						 FROM medals_cleaned
	  						 WHERE medal_type = 'Bronze '
	  						 GROUP BY country_long));

-- The USA won 44 Silver medals.
SELECT country, total_silver_medals
FROM (SELECT country_long AS country, COUNT(medal_type) AS total_silver_medals
	  FROM medals_cleaned
	  WHERE medal_type = 'Silver '
	  GROUP BY country_long)
WHERE total_silver_medals = (SELECT MAX(total_silver_medals)
	  					     FROM (SELECT country_long AS country, COUNT(medal_type) AS total_silver_medals
								   FROM medals_cleaned
								   WHERE medal_type = 'Silver '
								   GROUP BY country_long));
								   
-- The USA and China both won 40 Gold medals each.
SELECT country, total_gold_medals
FROM (SELECT country_long AS country, COUNT(medal_type) AS total_gold_medals
	  FROM medals_cleaned
	  WHERE medal_type = 'Gold '
	  GROUP BY country_long)
WHERE total_gold_medals = (SELECT MAX(total_gold_medals)
	  					     FROM (SELECT country_long AS country, COUNT(medal_type) AS total_gold_medals
								   FROM medals_cleaned
								   WHERE medal_type = 'Gold '
								   GROUP BY country_long));

-- /** Creating temporary tables to show the number of Gold, Silver and Bronze
-- medals won daily. **/
CREATE TEMPORARY TABLE IF NOT EXISTS daily_gold_medals AS (
	SELECT medal_date, COUNT(medal_type) AS gold_medals
	FROM medallists_cleaned 
	WHERE medal_type = 'Gold ' 
	GROUP BY medal_date 
	ORDER BY medal_date ASC);

CREATE TEMPORARY TABLE IF NOT EXISTS daily_silver_medals AS (
	SELECT medal_date, COUNT(medal_type) AS silver_medals
	FROM medallists_cleaned 
	WHERE medal_type = 'Silver ' 
	GROUP BY medal_date 
	ORDER BY medal_date ASC);
	
CREATE TEMPORARY TABLE IF NOT EXISTS daily_bronze_medals AS (
	SELECT medal_date, COUNT(medal_type) AS bronze_medals
	FROM medallists_cleaned 
	WHERE medal_type = 'Bronze ' 
	GROUP BY medal_date 
	ORDER BY medal_date ASC);

/** A table showing the total number of Gold, Silver and Bronze medals won daily. **/
-- The highest number of all medal types were won on 10/08/2024.
SELECT 
	daily_gold_medals.medal_date, 
	daily_gold_medals.gold_medals,
	daily_silver_medals.silver_medals,
	daily_bronze_medals.bronze_medals
FROM
	daily_gold_medals INNER JOIN daily_silver_medals ON daily_gold_medals.medal_date = daily_silver_medals.medal_date
	INNER JOIN daily_bronze_medals ON daily_silver_medals.medal_date = daily_bronze_medals.medal_date;

/** Oldest person to win Gold. **/
SELECT name, age(birth_date), country_long, discipline, event
FROM medallists_cleaned
WHERE birth_date = (SELECT MIN(birth_date) FROM medallists_cleaned WHERE medal_type = 'Gold ');

/** Youngest person to win Gold. **/
SELECT name, age(birth_date), country_long, discipline, event
FROM medallists_cleaned
WHERE birth_date = (SELECT MAX(birth_date) FROM medallists_cleaned WHERE medal_type = 'Gold ');

/** Oldest person to win Silver. **/
SELECT name, age(birth_date), country_long, discipline, event
FROM medallists_cleaned
WHERE birth_date = (SELECT MIN(birth_date) FROM medallists_cleaned WHERE medal_type = 'Silver ');

/** Youngest person to win Silver. **/
SELECT name, age(birth_date), country_long, discipline, event
FROM medallists_cleaned
WHERE birth_date = (SELECT MAX(birth_date) FROM medallists_cleaned WHERE medal_type = 'Silver ');

/** Oldest person to win Bronze. **/
SELECT name, age(birth_date), country_long, discipline, event
FROM medallists_cleaned
WHERE birth_date = (SELECT MIN(birth_date) FROM medallists_cleaned WHERE medal_type = 'Bronze ');

/** Youngest person to win Bronze. **/
SELECT name, age(birth_date), country_long, discipline, event
FROM medallists_cleaned
WHERE birth_date = (SELECT MAX(birth_date) FROM medallists_cleaned WHERE medal_type = 'Bronze ');

-- /** Athletes who won the most Gold, Silver and Bronze medals. **/
-- Leon Marchand won 4 Gold medals.
SELECT name, country_long, discipline, total_gold_medals
FROM (SELECT name, country_long, discipline, COUNT(medal_type) AS total_gold_medals
	  FROM medallists_cleaned
	  WHERE medal_type = 'Gold '
	  GROUP BY name, country_long, discipline)
WHERE total_gold_medals = (SELECT MAX(total_gold_medals) 
						   FROM (SELECT name, country_long, discipline, COUNT(medal_type) AS total_gold_medals
								 FROM medallists_cleaned
								 WHERE medal_type = 'Gold '
								 GROUP BY name, country_long, discipline));

-- Regan Smith won 3 Silver medals.
SELECT name, country_long, discipline, total_silver_medals
FROM (SELECT name, country_long, discipline, COUNT(medal_type) AS total_silver_medals
	  FROM medallists_cleaned
	  WHERE medal_type = 'Silver '
	  GROUP BY name, country_long, discipline)
WHERE total_silver_medals = (SELECT MAX(total_silver_medals) 
						     FROM (SELECT name, country_long, discipline, COUNT(medal_type) AS total_silver_medals
								   FROM medallists_cleaned
								   WHERE medal_type = 'Silver '
								   GROUP BY name, country_long, discipline));

-- Yufei Zhang won 5 Bronze medals.
SELECT name, country_long, discipline, total_bronze_medals
FROM (SELECT name, country_long, discipline, COUNT(medal_type) AS total_bronze_medals
	  FROM medallists_cleaned
	  WHERE medal_type = 'Bronze '
	  GROUP BY name, country_long, discipline)
WHERE total_bronze_medals = (SELECT MAX(total_bronze_medals) 
						     FROM (SELECT name, country_long, discipline, COUNT(medal_type) AS total_bronze_medals
								   FROM medallists_cleaned
								   WHERE medal_type = 'Bronze '
								   GROUP BY name, country_long, discipline));

/** Top 10 medallists who won the most medals in total. **/
SELECT name, country_long, discipline, COUNT(medal_type) AS total_medals
FROM medallists_cleaned
GROUP BY name, country_long, discipline
ORDER BY total_medals DESC
LIMIT 10;

/** The number of male and female athletes. **/
SELECT gender, COUNT(athlete_name) 
FROM athletes_cleaned 
GROUP BY gender 
ORDER BY gender DESC;

/** The number of athletes in each country. **/
SELECT country, COUNT(athlete_name) AS number_of_athletes 
FROM athletes_cleaned 
GROUP BY country 
ORDER BY number_of_athletes DESC;

/** Youngest and oldest athletes to compete. **/
SELECT athlete_name, gender, country, age(birth_date)
FROM athletes_cleaned
WHERE birth_date = (SELECT MIN(birth_date) FROM athletes_cleaned) OR
	  birth_date = (SELECT MAX(birth_date) FROM athletes_cleaned);
	  
/** Athletes that represented a country other than their country of birth. **/
-- There were 186 athletes who competed for countries that were not their birth country. **/
SELECT COUNT(athlete_name) FROM athletes_cleaned WHERE country <> nationality;

-- Countries that included athletes who were not born in them.
SELECT country, COUNT(athlete_name) as number_of_athletes
FROM athletes_cleaned
WHERE country <> nationality
GROUP BY country
ORDER BY number_of_athletes DESC;

/** Top 10 medals table.**/
SELECT * FROM medals_total_cleaned ORDER BY total DESC LIMIT 10;