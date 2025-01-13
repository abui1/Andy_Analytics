# World Life Expectancy (Data Cleaning)
SELECT * 
FROM world_life_expectancy_table;


SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy_table
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1;

# To remove Duplicates 
SELECT *
FROM (SELECT Row_ID, 
CONCAT(Country, Year),
ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
FROM world_life_expectancy_table
) AS Row_Table
WHERE Row_Num > 1;

# Removing Duplicates using DELETE

DELETE FROM world_life_expectancy_table
WHERE ROW_ID IN (
	SELECT ROW_ID
FROM (SELECT Row_ID, 
CONCAT(Country, Year),
ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
FROM world_life_expectancy_table
) AS Row_Table
WHERE Row_Num > 1
);
# Checking the all the options in status

SELECT *
FROM world_life_expectancy_table
WHERE Status = '';


SELECT DISTINCT(Country)
FROM world_life_expectancy_table
WHERE Status <> '';

SELECT DISTINCT(Country)
FROM world_life_expectancy_table
WHERE Status = 'Developing';


# Filling in BLANKS rows in Status column 
UPDATE world_life_expectancy_table
	SET Status = 'Developing'
    WHERE Country IN (SELECT DISTINCT(Country)
FROM world_life_expectancy_table
WHERE Status = 'Developing');


# UPDATING empty rows in STATUS using self join to 'Developing'
UPDATE world_life_expectancy_table t1
JOIN world_life_expectancy_table t2 ON
t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = '' AND t2. Status <> ''
AND t2.Status = 'Developing'
;


SELECT *
FROM world_life_expectancy_table
WHERE Country = 'United States of America';

# UPDATING empty rows in STATUS using self join to 'Developed'
UPDATE world_life_expectancy_table t1
JOIN world_life_expectancy_table t2 ON
t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = '' AND t2. Status <> ''
AND t2.Status = 'Developed'
;

SELECT * 
FROM world_life_expectancy_table
WHERE `Life expectancy` = ''
;
# Life expectancy missing datas. Approaching it by using the previous year and the year after, and avg the 2 to get the closest results.
# only missing 2 values so it won't ruin the whole dataset

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy_table
;

# Query using Self Join to after and previous year to calculate mssing values in life expectancy
SELECT 
    t1.Country,
    t1.Year,
    t1.`Life expectancy`,
    t2.Country,
    t2.Year,
    t2.`Life expectancy`,
    t3.Country,
    t3.Year,
    t3.`Life expectancy`,
    ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2,
            1) AS Missing_life_expectancy
FROM
    world_life_expectancy_table t1
        JOIN
    world_life_expectancy_table t2 ON t1.Country = t2.Country
        AND t1.Year = t2.Year - 1
        JOIN
    world_life_expectancy_table t3 ON t1.Country = t3.Country
        AND t1.Year = t3.Year + 1
WHERE
    t1.`Life expectancy` = '';

UPDATE world_life_expectancy_table t1
JOIN world_life_expectancy_table t2 
	ON t1.Country = t2.Country 
    AND t1.Year = t2.Year -1
JOIN world_life_expectancy_table t3 
	ON t1.Country = t3.Country 
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2, 1)
	WHERE t1.`Life expectancy` = ''
;

#Data Exploratory Analysis Phase

SELECT *
FROM world_life_expectancy_table;




