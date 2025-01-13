#Data Exploratory Analysis Phase

SELECT *
FROM world_life_expectancy_table;


#Query of MAX life expectancy and Min life expectancy and the life increase after 15 years
SELECT 
    Country, MIN(`Life expectancy`), 
    MAX(`Life expectancy`),
    ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_increase_15_years
FROM
    world_life_expectancy_table
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
    AND MAX(`Life expectancy`) <> 0
ORDER BY Life_increase_15_years ASC;

# AVG life expectancy based on year
SELECT 
    Year, ROUND(AVG(`Life expectancy`), 2)
FROM
    world_life_expectancy_table
WHERE
    `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;


#Query to see the avg life expectancy and avg GDP based on countries
SELECT Country, ROUND(AVG(`Life expectancy`),2) AS avg_life_expectancy, ROUND(AVG(GDP), 2) AS avg_GDP
FROM world_life_expectancy_table
GROUP BY Country
HAVING avg_life_expectancy > 0
AND avg_GDP > 0
ORDER BY avg_GDP DESC;

# Query in AVG Life Expectancy of countries that have High GDP and LOW GDP 
SELECT 
SUM(CASE 
	WHEN GDP >= 1500 THEN 1 ELSE 0
    END) High_GDP_COUNT,
AVG(CASE 
	WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL
    END) High_GDP_LIfe_Expectancy,
    SUM(CASE 
	WHEN GDP <= 1500 THEN 1 ELSE 0
    END) LOW_GDP_COUNT,
AVG(CASE 
	WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL
    END) Low_GDP_LIfe_Expectancy
FROM world_life_expectancy_table
;

SELECT Status, ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy_table
GROUP BY Status
;
# Query to see the avg life expectancy of developed and non developed countries 
SELECT Status, COUNT(DISTINCT(Country)), ROUND(AVG(`Life expectancy`), 1)
FROM world_life_expectancy_table
GROUP BY Status;

#Query on Country avg life expectancy compared to BMI, data finds that countries with high life exp also has high BMI
# Possibly due to having alot of food and resources

SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_exp, ROUND(AVG(BMI), 1) AS BMI
FROM world_life_expectancy_table
GROUP BY Country
HAVING Life_exp > 0 
AND BMI > 0
ORDER BY BMI DESC
;

# Query on how many people ahve died in the past 15 years based on country
SELECT Country, 
Year, 
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy_table
WHERE Country LIkE '%United%';








