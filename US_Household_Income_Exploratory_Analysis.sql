SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;


SELECT * 
FROM us_household_income h
INNER JOIN us_household_income_statistics s
ON h.id = s.id
WHERE Mean <> 0;

SELECT h.State_Name, ROUND(AVG(Mean),1) Mean, ROUND(AVG(Median),1) Median
FROM us_household_income h
INNER JOIN us_household_income_statistics s
ON h.id = s.id
WHERE Mean <> 0
GROUP BY h.State_Name
ORDER BY 3 DESC
LIMIT 10
;

SELECT Type,  ROUND(AVG(Mean),1) Mean, ROUND(AVG(Median),1) Median
FROM us_household_income h
INNER JOIN us_household_income_statistics s
ON h.id = s.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY 1
;

SELECT Type, COUNT(Type), ROUND(AVG(Mean),1) Mean, ROUND(AVG(Median),1) Median
FROM us_household_income h
INNER JOIN us_household_income_statistics s
ON h.id = s.id
WHERE Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
;
# After exploring data, I found Type Community was super low in both Average Mean and Average Median 
# It was super low because theyre tied to Pueto Rico 
SELECT 
    *
FROM
    us_household_income
WHERE
    Type = 'Community';

#Query on the highest and lowest Mean income in City and State
SELECT 
    h.State_Name, h.City, ROUND(AVG(Mean), 1) AS Mean
FROM
    us_household_income h
        INNER JOIN
    us_household_income_statistics s ON h.id = s.id
GROUP BY h.State_Name , h.City
ORDER BY Mean DESC;

